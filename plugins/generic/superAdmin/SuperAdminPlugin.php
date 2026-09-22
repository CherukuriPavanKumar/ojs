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

            // Hook listeners for legacy PKP hooks
            Hook::add('ReviewAssignment::add', [$this, 'handleReviewAssignmentAdd']);
            Hook::add('ReviewerAction::confirmReview', [$this, 'handleReviewerConfirm']);
            Hook::add('SubmissionFile::add', [$this, 'handleSubmissionFileAdd']);
        }
        return $success;
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

        DB::table('super_admin_activity_log')->insert([
            'user_id' => $userId,
            'journal_id' => $journalId,
            'event_type' => $eventType,
            'event_detail' => json_encode($eventDetail),
            'ip_address' => $ip,
        ]);
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
        $this->logActivity(
            $event->editor?->getId(),
            $event->context?->getId(),
            'decision_added',
            [
                'submission_id' => $event->submission->getId(),
                'decision' => method_exists($event->decisionType, 'getDecision') ? $event->decisionType->getDecision() : (property_exists($event->decisionType, 'decision') ? $event->decisionType->decision : get_class($event->decisionType)),
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
}

if (!PKP_STRICT_MODE) {
    class_alias('\APP\plugins\generic\superAdmin\SuperAdminPlugin', '\SuperAdminPlugin');
}
