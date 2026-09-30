<?php

require(dirname(__FILE__) . '/bootstrap.php');

use PKP\cliTool\CommandLineTool;
use PKP\db\DAORegistry;
use APP\journal\Journal;
use APP\journal\JournalDAO;
use APP\core\Application;
use PKP\userGroup\UserGroupDAO;
use APP\section\SectionDAO;
use APP\section\Section;

class CreateJournalTool extends CommandLineTool
{
    public function execute()
    {
        $journalDao = DAORegistry::getDAO('JournalDAO');
        $existing = $journalDao->getByPath('vjar');

        if ($existing) {
            echo "Journal 'vjar' already exists! ID: " . $existing->getId() . "\n";
            return;
        }

        echo "Creating journal 'Veridica Journal of Advanced Research' (path: vjar)...\n";

        $journal = $journalDao->newDataObject();
        $journal->setPath('vjar');
        $journal->setEnabled(true);
        $journal->setData('primaryLocale', 'en');

        $journalId = $journalDao->insertObject($journal);

        echo "Inserted journal ID: " . $journalId . "\n";

        // Add Journal Settings
        $journalDao->updateSetting($journalId, 'name', ['en' => 'Veridica Journal of Advanced Research'], 'string', true);
        $journalDao->updateSetting($journalId, 'acronym', ['en' => 'VJAR'], 'string', true);
        $journalDao->updateSetting($journalId, 'abbreviation', ['en' => 'Veridica J. Adv. Res.'], 'string', true);
        $journalDao->updateSetting($journalId, 'description', ['en' => 'Official multidisciplinary research journal powered by Veridica Academic Network.'], 'string', true);
        $journalDao->updateSetting($journalId, 'contactName', 'Super Admin', 'string', false);
        $journalDao->updateSetting($journalId, 'contactEmail', 'admin@veridica.com', 'string', false);
        $journalDao->updateSetting($journalId, 'disableUserReg', false, 'bool', false);

        // Install default user groups for this journal
        $userGroupDao = DAORegistry::getDAO('UserGroupDAO');
        $userGroupDao->installDefaultTypes($journalId);

        // Create default section (Articles)
        $sectionDao = DAORegistry::getDAO('SectionDAO');
        $section = $sectionDao->newDataObject();
        $section->setJournalId($journalId);
        $section->setSequence(1);
        $section->setEditorRestricted(false);
        $section->setMetaIndexed(true);
        $section->setMetaReviewed(true);
        $section->setAbstractsNotRequired(false);
        $section->setHideTitle(false);
        $section->setHideAuthor(false);
        
        $sectionId = $sectionDao->insertObject($section);
        $sectionDao->updateSetting($sectionId, 'title', ['en' => 'Articles'], 'string', true);
        $sectionDao->updateSetting($sectionId, 'abbrev', ['en' => 'ART'], 'string', true);

        // Assign superadmin (user_id 1) to user groups
        $userGroups = $userGroupDao->getByContextId($journalId)->toArray();
        foreach ($userGroups as $group) {
            $userGroupDao->assignUserToGroup(1, $group->getId());
        }

        echo "SUCCESS: Journal 'vjar' created with Section ID " . $sectionId . " and user groups assigned!\n";
    }
}

$tool = new CreateJournalTool($argv ?? []);
$tool->execute();
