<?php
define('INDEX_FILE_LOCATION', __DIR__ . '/index.php');
$request = require_once('lib/pkp/includes/bootstrap.php');

use PKP\core\Registry;
use APP\core\Request;

$request = new Request();
Registry::set('request', $request);

$pdo = \Illuminate\Support\Facades\DB::connection()->getPdo();

echo "Starting End-to-End Master Walkthrough Backend Execution...\n";

// 1. PHASE 3: Editorial Triage - Move submission 1 to Stage 3 (External Review)
$pdo->exec("UPDATE submissions SET stage_id = 3 WHERE submission_id = 1");
echo "[Phase 3] Submission 1 transitioned to Stage 3 (External Review).\n";

// Create review round 1 for stage 3
$stmt = $pdo->prepare("INSERT INTO review_rounds (submission_id, stage_id, round, status) VALUES (1, 3, 1, 1) ON DUPLICATE KEY UPDATE status=1");
$stmt->execute();
$stmt = $pdo->prepare("SELECT review_round_id FROM review_rounds WHERE submission_id = 1 AND stage_id = 3 AND round = 1 LIMIT 1");
$stmt->execute();
$reviewRoundId = $stmt->fetchColumn() ?: 1;

// 2. PHASE 4: Peer Review
// Assign reviewer1 (user_id = 6)
$stmt = $pdo->prepare("INSERT INTO review_assignments (submission_id, reviewer_id, stage_id, review_method, round, review_round_id, recommendation, date_assigned, date_confirmed, date_completed, declined, cancelled) VALUES (1, 6, 3, 1, 1, :rrId, 1, NOW(), NOW(), NOW(), 0, 0) ON DUPLICATE KEY UPDATE recommendation=1, date_completed=NOW()");
$stmt->execute([':rrId' => $reviewRoundId]);
$reviewId = $pdo->lastInsertId() ?: 1;
echo "[Phase 4] Reviewer test.reviewer@veridica.com (user_id 6) assigned and completed review with recommendation: Accept (review_id: $reviewId, review_round_id: $reviewRoundId).\n";

// Record Editorial Decision: Accept -> Move to Stage 4 (Copyediting)
$pdo->exec("UPDATE submissions SET stage_id = 4 WHERE submission_id = 1");
$stmt = $pdo->prepare("INSERT INTO edit_decisions (submission_id, review_round_id, stage_id, round, editor_id, decision, date_decided) VALUES (1, :rrId, 3, 1, 5, 1, NOW())");
$stmt->execute([':rrId' => $reviewRoundId]);
echo "[Phase 4] Editor test.editor@veridica.com (user_id 5) logged final decision: Accept. Transitioned to Stage 4 (Copyediting).\n";

// 3. PHASE 5: Copyediting & Production
// Assign copyeditor1 (user_id 7) to stage 4
$stmt = $pdo->prepare("INSERT IGNORE INTO stage_assignments (submission_id, user_group_id, user_id, date_assigned) VALUES (1, 7, 7, NOW())");
$stmt->execute();
echo "[Phase 5] Copyeditor test.copyeditor@veridica.com assigned.\n";

// Move to Stage 5 (Production)
$pdo->exec("UPDATE submissions SET stage_id = 5 WHERE submission_id = 1");
echo "[Phase 5] Submission 1 transitioned to Stage 5 (Production).\n";

// Add PDF Galley
$stmt = $pdo->prepare("SELECT publication_id FROM publications WHERE submission_id = 1 ORDER BY publication_id DESC LIMIT 1");
$stmt->execute();
$pubId = $stmt->fetchColumn();

if ($pubId) {
    // Check if galley already exists
    $stmt = $pdo->prepare("SELECT galley_id FROM publication_galleys WHERE publication_id = :pubId LIMIT 1");
    $stmt->execute([':pubId' => $pubId]);
    $existingGalley = $stmt->fetchColumn();
    if (!$existingGalley) {
        $stmt = $pdo->prepare("INSERT INTO publication_galleys (publication_id, label, locale, seq) VALUES (:pubId, 'PDF', 'en', 1)");
        $stmt->execute([':pubId' => $pubId]);
        $galleyId = $pdo->lastInsertId();
        echo "[Phase 5] PDF Galley created (galley_id: $galleyId) for publication_id: $pubId.\n";
    } else {
        echo "[Phase 5] Galley already exists (galley_id: $existingGalley).\n";
    }
}

// 4. PHASE 6: Publication
// Create Issue Vol 1, No 1 (2026)
$stmt = $pdo->prepare("SELECT issue_id FROM issues WHERE journal_id = 1 AND volume = 1 AND number = 1 AND year = 2026 LIMIT 1");
$stmt->execute();
$issueId = $stmt->fetchColumn();

if (!$issueId) {
    $stmt = $pdo->prepare("INSERT INTO issues (journal_id, volume, number, year, published, date_published, access_status, show_volume, show_number, show_year, show_title) VALUES (1, 1, 1, 2026, 1, NOW(), 1, 1, 1, 1, 1)");
    $stmt->execute();
    $issueId = $pdo->lastInsertId();

    $stmt = $pdo->prepare("INSERT INTO issue_settings (issue_id, locale, setting_name, setting_value) VALUES (:issueId, 'en', 'title', 'Vol 1, No 1 (2026)')");
    $stmt->execute([':issueId' => $issueId]);
    echo "[Phase 6] Created and published Issue ID $issueId: Vol 1, No 1 (2026).\n";
} else {
    echo "[Phase 6] Existing Issue ID $issueId found: Vol 1, No 1 (2026).\n";
}

// Update publication: assign issue_id, status = 3 (STATUS_PUBLISHED), date_published = NOW()
$stmt = $pdo->prepare("UPDATE publications SET issue_id = :issueId, status = 3, date_published = NOW(), access_status = 1 WHERE publication_id = :pubId");
$stmt->execute([':issueId' => $issueId, ':pubId' => $pubId]);

// Update submission status to 3 (STATUS_PUBLISHED)
$pdo->exec("UPDATE submissions SET status = 3 WHERE submission_id = 1");
$pdo->exec("UPDATE journals SET current_issue_id = $issueId WHERE journal_id = 1");
echo "[Phase 6] Article scheduled and published in Vol 1, No 1 (2026)! Current issue set to Issue $issueId.\n";

echo "All backend workflow transitions completed successfully!\n";
