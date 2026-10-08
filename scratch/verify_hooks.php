<?php
define('INDEX_FILE_LOCATION', dirname(__DIR__) . '/index.php');
chdir(dirname(__DIR__));
require_once('lib/pkp/includes/bootstrap.php');

use PKP\core\Registry;
use APP\core\Request;
use Illuminate\Support\Facades\Event;
use Illuminate\Auth\Events\Login;
use PKP\plugins\Hook;
use PKP\observers\events\SubmissionSubmitted;
use PKP\observers\events\DecisionAdded;

$request = new Request();
Registry::set('request', $request);

$contextDao = \APP\core\Application::get()->getContextDAO();
$context = $contextDao->getById(1);

$router = new class extends \PKP\core\PKPPageRouter {
    public $context;
    public function getContext(\PKP\core\PKPRequest $request, bool $forceReload = false): ?\PKP\context\Context {
        return $this->context;
    }
};
$router->context = $context;
$request->setRouter($router);

\PKP\plugins\PluginRegistry::loadCategory('generic', true);

$authorUser = \APP\facades\Repo::user()->getByUsername('author1');
$editorUser = \APP\facades\Repo::user()->getByUsername('editor1');
$reviewerUser = \APP\facades\Repo::user()->getByUsername('reviewer1');

echo "1. Firing login event for author1 (user_id: " . $authorUser->getId() . ")...\n";
Registry::set('user', $authorUser);
\PKP\security\Validation::registerUserSession($authorUser, $reason);
Event::dispatch(new Login('web', $authorUser, false));

echo "2. Firing file_uploaded event for author1...\n";
$submissionFile = \APP\facades\Repo::submissionFile()->newDataObject();
$submissionFile->setData('submissionId', 1);
$submissionFile->setData('fileId', 101);
$submissionFile->setData('name', ['en' => 'manuscript_v1.pdf']);
$submissionFile->setId(101);
Hook::call('SubmissionFile::add', [$submissionFile]);

echo "3. Firing submission_submitted event for author1...\n";
$submission = \APP\facades\Repo::submission()->get(1);
Event::dispatch(new SubmissionSubmitted($submission, $context));

echo "4. Firing review_assigned event for editor1 (user_id: " . $editorUser->getId() . ")...\n";
Registry::set('user', $editorUser);
\PKP\security\Validation::registerUserSession($editorUser, $reason);
$reviewAssignment = \APP\facades\Repo::reviewAssignment()->newDataObject();
$reviewAssignment->setSubmissionId(1);
$reviewAssignment->setReviewerId($reviewerUser->getId());
Hook::call('ReviewAssignment::add', [$reviewAssignment]);

echo "5. Firing review_accepted event for reviewer1 (user_id: " . $reviewerUser->getId() . ")...\n";
Registry::set('user', $reviewerUser);
\PKP\security\Validation::registerUserSession($reviewerUser, $reason);
Hook::call('ReviewerAction::confirmReview', [$request, $submission, $reviewAssignment, false]);

echo "6. Firing decision_added event for editor1 (user_id: " . $editorUser->getId() . ")...\n";
Registry::set('user', $editorUser);
\PKP\security\Validation::registerUserSession($editorUser, $reason);
$decisionObj = \APP\facades\Repo::decision()->newDataObject();
$decisionObj->setData('decision', 1);

$decisionTypeObj = new \APP\decision\types\Accept();

Event::dispatch(new DecisionAdded($decisionObj, $decisionTypeObj, $submission, $editorUser, $context, []));

echo "Done triggering all 6 events.\n";
