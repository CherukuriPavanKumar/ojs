<?php

/**
 * @file SuperAdminSchemaMigration.php
 *
 * Migration for Super Admin activity log table.
 */

namespace APP\plugins\generic\superAdmin;

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class SuperAdminSchemaMigration extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        // Activity log for Super Admin oversight
        Schema::create('super_admin_activity_log', function (Blueprint $table) {
            $table->bigIncrements('log_id');
            $table->bigInteger('user_id')->nullable();
            $table->bigInteger('journal_id')->nullable();
            $table->string('event_type', 255);
            $table->longText('event_detail')->nullable();
            $table->string('ip_address', 45)->nullable();
            $table->timestamp('created_at')->useCurrent();
        });
    }

    /**
     * Reverse the migration.
     */
    public function down(): void
    {
        Schema::drop('super_admin_activity_log');
    }
}
