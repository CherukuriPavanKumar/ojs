<?php
require(dirname(__FILE__) . '/bootstrap.php');

import('classes.journal.Journal');
import('classes.journal.JournalDAO');

use PKP\db\DAORegistry;
use APP\journal\Journal;
use APP\journal\JournalDAO;
use APP\core\Application;
use PKP\security\Role;
use PKP\userGroup\UserGroupDAO;

$journalDao = DAORegistry::getDAO('JournalDAO');
$existing = $journalDao->getByPath('vjar');

if ($existing) {
    echo "Journal 'vjar' already exists! ID: " . $existing->getId() . "\n";
    exit(0);
}

echo "Creating journal 'Veridica Journal of Advanced Research' (vjar)...\n";

$journal = $journalDao->newDataObject();
$journal->setPath('vjar');
$journal->setEnabled(true);

$journalId = $journalDao->insertObject($journal);

echo "Inserted journal ID: " . $journalId . "\n";

// Add Journal Settings
$journalDao->updateSetting($journalId, 'name', ['en' => 'Veridica Journal of Advanced Research'], 'string', true);
$journalDao->updateSetting($journalId, 'acronym', ['en' => 'VJAR'], 'string', true);
$journalDao->updateSetting($journalId, 'abbreviation', ['en' => 'Veridica J. Adv. Res.'], 'string', true);
$journalDao->updateSetting($journalId, 'description', ['en' => 'Official multidisciplinary research journal powered by Veridica Academic Network.'], 'string', true);
$journalDao->updateSetting($journalId, 'contactName', 'Super Admin', 'string', false);
$journalDao->updateSetting($journalId, 'contactEmail', 'admin@veridica.com', 'string', false);

// Enable user self registration
$journalDao->updateSetting($journalId, 'disableUserReg', false, 'bool', false);

// Install default user groups for this journal
$userGroupDao = DAORegistry::getDAO('UserGroupDAO');
$userGroupDao->installDefaultTypes($journalId);

// Assign superadmin (user_id 1) as Journal Manager and Editor
$userGroupDao->assignUserToGroup(1, 1); // 1 = Journal Manager in default types

echo "SUCCESS: Journal 'vjar' created with ID " . $journalId . "!\n";
