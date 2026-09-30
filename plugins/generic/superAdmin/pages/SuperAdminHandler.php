<?php

/**
 * @file SuperAdminHandler.php
 *
 * Copyright (c) 2014-2022 Simon Fraser University
 * Copyright (c) 2003-2022 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @class SuperAdminHandler
 *
 * @brief Handle Super Admin Panel page requests and API endpoints.
 */

namespace APP\plugins\generic\superAdmin\pages;

use APP\core\Application;
use APP\handler\Handler;
use APP\template\TemplateManager;
use Illuminate\Support\Facades\DB;
use PKP\core\JSONMessage;
use PKP\security\authorization\PKPSiteAccessPolicy;
use PKP\security\authorization\PolicySet;
use PKP\security\authorization\RoleBasedHandlerOperationPolicy;
use PKP\security\Role;

class SuperAdminHandler extends Handler
{
    /** @var \APP\plugins\generic\superAdmin\SuperAdminPlugin */
    public $plugin;

    public function __construct($plugin = null)
    {
        parent::__construct();
        $this->plugin = $plugin;

        $this->addRoleAssignment(
            [Role::ROLE_ID_SITE_ADMIN],
            [
                'index',
                'getStats',
                'getActivityLogs',
                'getUsers',
                'toggleUserStatus',
                'exportCSV'
            ]
        );
    }

    /**
     * Authorize request - only Site Admin allowed
     */
    public function authorize($request, &$args, $roleAssignments)
    {
        $this->addPolicy(new PKPSiteAccessPolicy($request, $args, $roleAssignments));

        $rolePolicy = new PolicySet(PolicySet::COMBINING_PERMIT_OVERRIDES);
        foreach ($roleAssignments as $role => $operations) {
            $rolePolicy->addPolicy(new RoleBasedHandlerOperationPolicy($request, $role, $operations));
        }
        $this->addPolicy($rolePolicy);

        return parent::authorize($request, $args, $roleAssignments);
    }

    /**
     * Main dashboard view
     */
    public function index($args, $request)
    {
        $templateMgr = TemplateManager::getManager($request);
        $this->setupTemplate($request);

        // Fetch hosted journals for filter dropdown
        $journals = DB::table('journals')
            ->join('journal_settings', function ($join) {
                $join->on('journals.journal_id', '=', 'journal_settings.journal_id')
                    ->where('journal_settings.setting_name', '=', 'name');
            })
            ->select('journals.journal_id', 'journals.path', 'journal_settings.setting_value as name')
            ->distinct()
            ->get();

        $templateMgr->assign([
            'journals' => $journals,
            'pluginUrl' => $request->getBaseUrl() . '/' . $this->plugin->getPluginPath(),
            'superAdminUrl' => $request->getDispatcher()->url($request, Application::ROUTE_PAGE, null, 'superadmin')
        ]);

        return $templateMgr->display($this->plugin->getTemplateResource('dashboard.tpl'));
    }

    /**
     * API: Get platform metrics
     */
    public function getStats($args, $request)
    {
        $totalUsers = DB::table('users')->count();
        $totalSubmissions = DB::table('submissions')->count();
        $activeReviews = DB::table('review_assignments')->whereNull('date_completed')->where('declined', 0)->where('cancelled', 0)->count();
        $totalJournals = DB::table('journals')->where('enabled', 1)->count();

        header('Content-Type: application/json');
        echo json_encode([
            'status' => true,
            'content' => [
                'totalUsers' => $totalUsers,
                'totalSubmissions' => $totalSubmissions,
                'activeReviews' => $activeReviews,
                'totalJournals' => $totalJournals,
            ]
        ]);
        exit;
    }

    /**
     * API: Get activity logs (with pagination & filters)
     */
    public function getActivityLogs($args, $request)
    {
        $journalId = (int)$request->getUserVar('journal_id');
        $eventType = trim($request->getUserVar('event_type') ?? '');
        $userQuery = trim($request->getUserVar('user_query') ?? '');
        $dateStart = trim($request->getUserVar('date_start') ?? '');
        $dateEnd = trim($request->getUserVar('date_end') ?? '');
        $page = max(1, (int)($request->getUserVar('page') ?? 1));
        $perPage = min(100, max(10, (int)($request->getUserVar('per_page') ?? 20)));

        $query = DB::table('super_admin_activity_log as log')
            ->leftJoin('users as u', 'log.user_id', '=', 'u.user_id')
            ->leftJoin('user_settings as us_gn', function ($join) {
                $join->on('u.user_id', '=', 'us_gn.user_id')
                    ->where('us_gn.setting_name', '=', 'givenName');
            })
            ->leftJoin('user_settings as us_fn', function ($join) {
                $join->on('u.user_id', '=', 'us_fn.user_id')
                    ->where('us_fn.setting_name', '=', 'familyName');
            })
            ->leftJoin('journals as j', 'log.journal_id', '=', 'j.journal_id')
            ->leftJoin('journal_settings as js', function ($join) {
                $join->on('j.journal_id', '=', 'js.journal_id')
                    ->where('js.setting_name', '=', 'name');
            })
            ->select(
                'log.log_id',
                'log.created_at',
                'log.user_id',
                'log.journal_id',
                'log.event_type',
                'log.event_detail',
                'log.ip_address',
                'u.username',
                'u.email',
                'us_gn.setting_value as first_name',
                'us_fn.setting_value as last_name',
                'js.setting_value as journal_name',
                'j.path as journal_path'
            );

        if ($journalId > 0) {
            $query->where('log.journal_id', $journalId);
        }

        if (!empty($eventType)) {
            $query->where('log.event_type', $eventType);
        }

        if (!empty($userQuery)) {
            $query->where(function ($q) use ($userQuery) {
                $q->where('u.username', 'like', "%{$userQuery}%")
                  ->orWhere('u.email', 'like', "%{$userQuery}%")
                  ->orWhere('us_gn.setting_value', 'like', "%{$userQuery}%")
                  ->orWhere('us_fn.setting_value', 'like', "%{$userQuery}%")
                  ->orWhere('log.ip_address', 'like', "%{$userQuery}%");
            });
        }

        if (!empty($dateStart)) {
            $query->where('log.created_at', '>=', $dateStart . ' 00:00:00');
        }

        if (!empty($dateEnd)) {
            $query->where('log.created_at', '<=', $dateEnd . ' 23:59:59');
        }

        $totalCount = $query->count();
        $logs = $query->orderBy('log.log_id', 'desc')
            ->offset(($page - 1) * $perPage)
            ->limit($perPage)
            ->get();

        header('Content-Type: application/json');
        echo json_encode([
            'status' => true,
            'content' => [
                'logs' => $logs,
                'totalCount' => $totalCount,
                'page' => $page,
                'perPage' => $perPage,
                'totalPages' => ceil($totalCount / $perPage),
            ]
        ]);
        exit;
    }

    /**
     * API: Get cross-journal user directory
     */
    public function getUsers($args, $request)
    {
        $search = trim($request->getUserVar('search') ?? '');
        $page = max(1, (int)($request->getUserVar('page') ?? 1));
        $perPage = min(100, max(10, (int)($request->getUserVar('per_page') ?? 20)));

        $query = DB::table('users as u')
            ->leftJoin('user_settings as us_gn', function ($join) {
                $join->on('u.user_id', '=', 'us_gn.user_id')
                    ->where('us_gn.setting_name', '=', 'givenName');
            })
            ->leftJoin('user_settings as us_fn', function ($join) {
                $join->on('u.user_id', '=', 'us_fn.user_id')
                    ->where('us_fn.setting_name', '=', 'familyName');
            })
            ->select(
                'u.user_id',
                'u.username',
                'u.email',
                'u.date_registered',
                'u.disabled',
                'us_gn.setting_value as first_name',
                'us_fn.setting_value as last_name'
            );

        if (!empty($search)) {
            $query->where(function ($q) use ($search) {
                $q->where('u.username', 'like', "%{$search}%")
                  ->orWhere('u.email', 'like', "%{$search}%")
                  ->orWhere('us_gn.setting_value', 'like', "%{$search}%")
                  ->orWhere('us_fn.setting_value', 'like', "%{$search}%");
            });
        }

        $totalCount = $query->count();
        $users = $query->orderBy('u.user_id', 'desc')
            ->offset(($page - 1) * $perPage)
            ->limit($perPage)
            ->get();

        foreach ($users as &$user) {
            $roles = DB::table('user_user_groups as uug')
                ->join('user_groups as ug', 'uug.user_group_id', '=', 'ug.user_group_id')
                ->leftJoin('user_group_settings as ugs', function ($join) {
                    $join->on('ug.user_group_id', '=', 'ugs.user_group_id')
                        ->where('ugs.setting_name', '=', 'name');
                })
                ->leftJoin('journals as j', 'ug.context_id', '=', 'j.journal_id')
                ->leftJoin('journal_settings as js', function ($join) {
                    $join->on('j.journal_id', '=', 'js.journal_id')
                        ->where('js.setting_name', '=', 'name');
                })
                ->where('uug.user_id', $user->user_id)
                ->select(
                    'ug.role_id',
                    'ugs.setting_value as role_name',
                    'ug.context_id',
                    'js.setting_value as journal_name'
                )
                ->get();

            $user->roles = $roles;
        }

        header('Content-Type: application/json');
        echo json_encode([
            'status' => true,
            'content' => [
                'users' => $users,
                'totalCount' => $totalCount,
                'page' => $page,
                'perPage' => $perPage,
                'totalPages' => ceil($totalCount / $perPage),
            ]
        ]);
        exit;
    }

    /**
     * API: Toggle user account status (suspend / reinstate)
     */
    public function toggleUserStatus($args, $request)
    {
        $targetUserId = (int)$request->getUserVar('target_user_id');
        $action = trim($request->getUserVar('action') ?? '');
        $adminUser = $request->getUser();

        header('Content-Type: application/json');

        if ($targetUserId <= 0 || !in_array($action, ['suspend', 'reinstate'])) {
            echo json_encode(['status' => false, 'content' => 'Invalid arguments.']);
            exit;
        }

        if ($targetUserId === $adminUser->getId() && $action === 'suspend') {
            echo json_encode(['status' => false, 'content' => 'You cannot suspend your own account.']);
            exit;
        }

        $disabled = ($action === 'suspend') ? 1 : 0;
        DB::table('users')->where('user_id', $targetUserId)->update(['disabled' => $disabled]);

        if ($this->plugin) {
            $this->plugin->logAdminAction(
                $adminUser->getId(),
                $targetUserId,
                "user_{$action}ed",
                ['target_user_id' => $targetUserId, 'action' => $action]
            );
        }

        $actionPast = ($action === 'suspend') ? 'suspended' : 'reinstated';
        echo json_encode([
            'status' => true,
            'content' => [
                'message' => "User account has been successfully {$actionPast}.",
                'targetUserId' => $targetUserId,
                'disabled' => $disabled
            ]
        ]);
        exit;
    }

    /**
     * CSV Export of activity logs
     */
    public function exportCSV($args, $request)
    {
        $journalId = (int)$request->getUserVar('journal_id');
        $eventType = trim($request->getUserVar('event_type') ?? '');
        $userQuery = trim($request->getUserVar('user_query') ?? '');
        $dateStart = trim($request->getUserVar('date_start') ?? '');
        $dateEnd = trim($request->getUserVar('date_end') ?? '');

        $query = DB::table('super_admin_activity_log as log')
            ->leftJoin('users as u', 'log.user_id', '=', 'u.user_id')
            ->leftJoin('journals as j', 'log.journal_id', '=', 'j.journal_id')
            ->leftJoin('journal_settings as js', function ($join) {
                $join->on('j.journal_id', '=', 'js.journal_id')
                    ->where('js.setting_name', '=', 'name');
            })
            ->select(
                'log.log_id',
                'log.created_at',
                'log.user_id',
                'u.username',
                'u.email',
                'log.journal_id',
                'js.setting_value as journal_name',
                'log.event_type',
                'log.ip_address',
                'log.event_detail'
            );

        if ($journalId > 0) {
            $query->where('log.journal_id', $journalId);
        }
        if (!empty($eventType)) {
            $query->where('log.event_type', $eventType);
        }
        if (!empty($userQuery)) {
            $query->where(function ($q) use ($userQuery) {
                $q->where('u.username', 'like', "%{$userQuery}%")
                  ->orWhere('u.email', 'like', "%{$userQuery}%")
                  ->orWhere('log.ip_address', 'like', "%{$userQuery}%");
            });
        }
        if (!empty($dateStart)) {
            $query->where('log.created_at', '>=', $dateStart . ' 00:00:00');
        }
        if (!empty($dateEnd)) {
            $query->where('log.created_at', '<=', $dateEnd . ' 23:59:59');
        }

        $logs = $query->orderBy('log.log_id', 'desc')->get();

        header('Content-Type: text/csv; charset=utf-8');
        header('Content-Disposition: attachment; filename="super_admin_activity_log_' . date('Y-m-d_H-i-s') . '.csv"');

        $output = fopen('php://output', 'w');
        fputcsv($output, ['Log ID', 'Timestamp', 'User ID', 'Username', 'Email', 'Journal ID', 'Journal Name', 'Event Type', 'IP Address', 'Event Details']);

        foreach ($logs as $log) {
            fputcsv($output, [
                $log->log_id,
                $log->created_at,
                $log->user_id ?? 'N/A',
                $log->username ?? 'Guest/System',
                $log->email ?? 'N/A',
                $log->journal_id ?? 'Global',
                $log->journal_name ?? 'Global/Site',
                $log->event_type,
                $log->ip_address,
                $log->event_detail
            ]);
        }

        fclose($output);
        exit;
    }
}
