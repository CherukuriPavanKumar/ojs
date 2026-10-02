<?php

require(dirname(__FILE__) . '/bootstrap.php');

use PKP\cliTool\CommandLineTool;
use Illuminate\Support\Facades\DB;

class PurgeOldIpsTool extends CommandLineTool
{
    public function execute()
    {
        // GDPR requirement: Retain IPs for maximum 30 days
        $days = 30;
        $thresholdDate = date('Y-m-d H:i:s', strtotime("-$days days"));

        echo "Purging IP addresses from super_admin_activity_log older than $thresholdDate...\n";

        try {
            $affected = DB::table('super_admin_activity_log')
                ->whereNotNull('ip_address')
                ->where('created_at', '<', $thresholdDate)
                ->update(['ip_address' => null]);

            echo "SUCCESS: Purged $affected IP addresses to comply with GDPR data retention policies.\n";
        } catch (\Exception $e) {
            echo "ERROR: Failed to purge IP addresses: " . $e->getMessage() . "\n";
        }
    }
}

$tool = new PurgeOldIpsTool($argv ?? []);
$tool->execute();
