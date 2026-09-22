<?php
require(dirname(__FILE__) . '/bootstrap.php');

$journalDao = \APP\core\Application::get()->getContextDAO();
$journal = $journalDao->getById(1);

import('lib.pkp.classes.file.PublicFileManager');
$publicFileManager = new \PKP\file\PublicFileManager();
$publicFileManager->copyFile('/home/pavankumar/ojs-3.5.0-5/public/journals/1/styleSheet.css', $publicFileManager->getContextFilesPath(1) . '/styleSheet.css');

$journalSettingsDao = \APP\core\Application::get()->getSettingsDAO();
$setting = [
    'name' => 'styleSheet.css',
    'uploadName' => 'styleSheet.css',
    'dateUploaded' => date('Y-m-d H:i:s')
];
$journalSettingsDao->updateSetting(1, 'styleSheet', $setting, 'object', false);

echo "CSS uploaded successfully.\n";
