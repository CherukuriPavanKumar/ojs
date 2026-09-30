<?php

/**
 * @file SuperAdminPlugin.php
 *
 * Copyright (c) 2014-2022 Simon Fraser University
 * Copyright (c) 2003-2022 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @class SuperAdminPlugin
 *
 * @brief Super Admin Plugin main class.
 */

namespace APP\plugins\generic\superAdmin;

use APP\core\Application;
use Illuminate\Auth\Events\Login;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Event;
use PKP\observers\events\DecisionAdded;
use PKP\observers\events\SubmissionSubmitted;
use PKP\plugins\GenericPlugin;
use PKP\plugins\Hook;

class SuperAdminPlugin extends GenericPlugin
{
    /**
     * @copydoc Plugin::register()
     */
    public function register($category, $path, $mainContextId = null)
    {
        $success = parent::register($category, $path, $mainContextId);
        if ($success && $this->getEnabled($mainContextId)) {

            // Event Listeners for Laravel Events
            Event::listen(Login::class, [$this, 'handleLogin']);
            Event::listen(SubmissionSubmitted::class, [$this, 'handleSubmissionSubmitted']);
            Event::listen(DecisionAdded::class, [$this, 'handleDecisionAdded']);
            Event::listen(\PKP\observers\events\PublicationPublished::class, [$this, 'handlePublicationPublished']);

            // Hook listeners for legacy PKP hooks
            Hook::add('ReviewAssignment::add', [$this, 'handleReviewAssignmentAdd']);
            Hook::add('ReviewerAction::confirmReview', [$this, 'handleReviewerConfirm']);
            Hook::add('SubmissionFile::add', [$this, 'handleSubmissionFileAdd']);
            Hook::add('User::add', [$this, 'handleUserAdd']);

            // Page routing for Super Admin panel
            Hook::add('LoadHandler', [$this, 'setPageHandler']);
        }
        return $success;
    }

    /**
     * @copydoc Plugin::getEnabled()
     */
    public function getEnabled($contextId = null)
    {
        return true;
    }

    /**
     * @copydoc Plugin::getDisplayName()
     */
    public function getDisplayName()
    {
        return 'Super Admin Plugin';
    }

    /**
     * @copydoc Plugin::getDescription()
     */
    public function getDescription()
    {
        return 'Provides an oversight activity log and super admin capabilities.';
    }

    /**
     * @copydoc Plugin::getInstallMigration()
     */
    public function getInstallMigration()
    {
        return new SuperAdminSchemaMigration();
    }

    /**
     * Centralized method to insert into the activity log table.
     */
    private function logActivity($userId, $journalId, $eventType, $eventDetail)
    {
        $request = Application::get()->getRequest();
        $ip = $request->getRemoteAddr();
        $detailStr = is_string($eventDetail) ? $eventDetail : json_encode($eventDetail);

        $utcNow = date('Y-m-d H:i:s');
        $id = DB::table('super_admin_activity_log')->insertGetId([
            'user_id' => $userId,
            'journal_id' => $journalId,
            'event_type' => $eventType,
            'event_detail' => $detailStr,
            'ip_address' => $ip,
            'created_at' => $utcNow,
        ]);
        DB::table('super_admin_activity_log')->where('id', $id)->update(['log_id' => $id]);

        try {
            DB::table('veridica_activity_log')->insert([
                'user_id' => $userId,
                'journal_id' => $journalId,
                'action_type' => $eventType,
                'action_detail' => $detailStr,
                'ip_address' => $ip,
                'created_at' => $utcNow,
            ]);
        } catch (\Exception $e) {
            // Ignore if table missing
        }
    }

    public function handleLogin(Login $event)
    {
        $user = $event->user;
        $request = Application::get()->getRequest();
        $context = $request->getContext();

        $this->logActivity(
            $user?->getId(),
            $context?->getId(),
            'login',
            ['username' => $user?->getUsername()]
        );
    }

    public function handleSubmissionSubmitted(SubmissionSubmitted $event)
    {
        $submission = $event->submission;
        $context = $event->context;
        $request = Application::get()->getRequest();
        $user = $request->getUser();

        $this->logActivity(
            $user?->getId(),
            $context?->getId(),
            'submission_submitted',
            ['submission_id' => $submission->getId()]
        );
    }

    public function handleDecisionAdded(DecisionAdded $event)
    {
        // $event->decision is a persisted Decision DataObject.
        // getData('decision') returns the integer constant (e.g. 3 for EXTERNAL_REVIEW).
        // $event->decisionType->getDecision() returns the same value — use it as a direct fallback.
        $decisionValue = $event->decision->getData('decision')
            ?? $event->decisionType->getDecision();

        $this->logActivity(
            $event->editor?->getId(),
            $event->context?->getId(),
            'decision_added',
            [
                'submission_id' => $event->submission->getId(),
                'decision'      => $decisionValue,
            ]
        );
    }

    public function handleReviewAssignmentAdd($hookName, $args)
    {
        $reviewAssignment = $args[0];
        $request = Application::get()->getRequest();
        $user = $request->getUser();
        $submission = \APP\facades\Repo::submission()->get($reviewAssignment->getSubmissionId());
        $contextId = $submission ? $submission->getData('contextId') : null;

        $this->logActivity(
            $user?->getId(),
            $contextId,
            'review_assigned',
            [
                'submission_id' => $reviewAssignment->getSubmissionId(),
                'reviewer_id' => $reviewAssignment->getReviewerId()
            ]
        );
        return false; // let other hooks process
    }

    public function handleReviewerConfirm($hookName, $args)
    {
        $request = $args[0];
        $submission = $args[1];
        $decline = $args[3];
        $user = $request->getUser();
        $contextId = $submission ? $submission->getData('contextId') : null;

        $this->logActivity(
            $user?->getId(),
            $contextId,
            $decline ? 'review_declined' : 'review_accepted',
            [
                'submission_id' => $submission->getId()
            ]
        );
        return false;
    }

    public function handleSubmissionFileAdd($hookName, $args)
    {
        $submissionFile = $args[0];
        $request = Application::get()->getRequest();
        $user = $request->getUser();
        $submission = \APP\facades\Repo::submission()->get($submissionFile->getData('submissionId'));
        $contextId = $submission ? $submission->getData('contextId') : null;

        $this->logActivity(
            $user?->getId(),
            $contextId,
            'file_uploaded',
            [
                'submission_id' => $submissionFile->getData('submissionId'),
                'file_id' => $submissionFile->getId(),
                'file_name' => is_array($submissionFile->getData('name')) ? array_values($submissionFile->getData('name'))[0] ?? '' : $submissionFile->getData('name')
            ]
        );
        return false;
    }

    public function setPageHandler(string $hookName, array $params): bool
    {
        $page = &$params[0];
        $handler = &$params[3];

        if ($this->getEnabled() && $page === 'superadmin') {
            $handler = new \APP\plugins\generic\superAdmin\pages\SuperAdminHandler($this);
            return true;
        }
        return false;
    }

    public function handleUserAdd($hookName, $args)
    {
        $user = $args[0];
        $request = Application::get()->getRequest();
        $context = $request->getContext();

        $this->logActivity(
            $user?->getId(),
            $context?->getId(),
            'user_registered',
            [
                'username' => $user?->getUsername(),
                'email' => $user?->getEmail()
            ]
        );
        return false;
    }

    public function handlePublicationPublished($event)
    {
        $publication = $event->publication;
        $submission = $event->submission;
        $context = $event->context;
        $request = Application::get()->getRequest();
        $user = $request->getUser();

        $this->logActivity(
            $user?->getId(),
            $context?->getId(),
            'submission_published',
            [
                'submission_id' => $submission?->getId(),
                'publication_id' => $publication?->getId()
            ]
        );
    }

    public function logAdminAction($adminUserId, $targetUserId, $actionType, $eventDetail = [])
    {
        $request = Application::get()->getRequest();
        $context = $request->getContext();

        $this->logActivity(
            $adminUserId,
            $context?->getId(),
            'super_admin_action',
            array_merge([
                'action_type' => $actionType,
                'target_user_id' => $targetUserId
            ], $eventDetail)
        );
    }
}

if (!PKP_STRICT_MODE) {
    class_alias('\APP\plugins\generic\superAdmin\SuperAdminPlugin', '\SuperAdminPlugin');
}
