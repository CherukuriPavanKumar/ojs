<?php
define('INDEX_FILE_LOCATION', __DIR__ . '/index.php');
require_once('lib/pkp/includes/bootstrap.php');

use APP\facades\Repo;

echo "OJS Bootstrapped successfully!\n";

$submission = Repo::submission()->get(1);

if ($submission) {
    echo "Submission 1 Title: " . $submission->getCurrentPublication()->getLocalizedData('title') . "\n";
    echo "Current Stage ID: " . $submission->getData('stageId') . "\n";
    echo "Status: " . $submission->getData('status') . "\n";
} else {
    echo "Submission 1 not found\n";
}
