<?php
define('INDEX_FILE_LOCATION', __DIR__ . '/index.php');
require_once('lib/pkp/includes/bootstrap.php');

use PKP\core\Registry;
use APP\core\Request;

$request = new Request();
Registry::set('request', $request);

$pdo = \Illuminate\Support\Facades\DB::connection()->getPdo();
$passwordHash = password_hash('Password123!', PASSWORD_BCRYPT);

$accounts = [
    ['u' => 'superadmin', 'e' => 'admin@veridica.com', 'fn' => 'Site', 'ln' => 'Administrator', 'groups' => [1]],
    ['u' => 'manager1', 'e' => 'manager@veridica.com', 'fn' => 'Journal', 'ln' => 'Manager', 'groups' => [2]],
    ['u' => 'editor1', 'e' => 'test.editor@veridica.com', 'fn' => 'Test', 'ln' => 'Editor', 'groups' => [2, 3, 5]],
    ['u' => 'author1', 'e' => 'test.author@veridica.com', 'fn' => 'Test', 'ln' => 'Author', 'groups' => [14]],
    ['u' => 'reviewer1', 'e' => 'test.reviewer@veridica.com', 'fn' => 'Test', 'ln' => 'Reviewer', 'groups' => [16]],
    ['u' => 'copyeditor1', 'e' => 'test.copyeditor@veridica.com', 'fn' => 'Test', 'ln' => 'Copyeditor', 'groups' => [7, 11]],
    ['u' => 'layouteditor1', 'e' => 'layouteditor@veridica.com', 'fn' => 'Layout', 'ln' => 'Editor', 'groups' => [11]],
    ['u' => 'proofreader1', 'e' => 'proofreader@veridica.com', 'fn' => 'Test', 'ln' => 'Proofreader', 'groups' => [13]],
    ['u' => 'submanager1', 'e' => 'submanager@veridica.com', 'fn' => 'Subscription', 'ln' => 'Manager', 'groups' => [18]],
    ['u' => 'reader1', 'e' => 'reader@veridica.com', 'fn' => 'Test', 'ln' => 'Reader', 'groups' => [17]],
];

echo "Provisioning standard OJS test accounts...\n";

foreach ($accounts as $acc) {
    $stmt = $pdo->prepare("SELECT user_id FROM users WHERE username = ? OR email = ?");
    $stmt->execute([$acc['u'], $acc['e']]);
    $userId = $stmt->fetchColumn();

    if (!$userId) {
        $stmt = $pdo->prepare("INSERT INTO users (username, password, email, date_registered, date_last_login) VALUES (?, ?, ?, NOW(), NOW())");
        $stmt->execute([$acc['u'], $passwordHash, $acc['e']]);
        $userId = $pdo->lastInsertId();

        $stmt = $pdo->prepare("INSERT INTO user_settings (user_id, locale, setting_name, setting_value) VALUES (?, 'en', 'givenName', ?), (?, 'en', 'familyName', ?)");
        $stmt->execute([$userId, $acc['fn'], $userId, $acc['ln']]);
        echo "[CREATED] User {$acc['u']} (ID: $userId, Email: {$acc['e']})\n";
    } else {
        if ($acc['u'] !== 'superadmin') {
            $stmt = $pdo->prepare("UPDATE users SET password = ? WHERE user_id = ?");
            $stmt->execute([$passwordHash, $userId]);
        }
        echo "[VERIFIED] User {$acc['u']} (ID: $userId, Email: {$acc['e']})\n";
    }

    foreach ($acc['groups'] as $gid) {
        $stmt = $pdo->prepare("INSERT IGNORE INTO user_user_groups (user_group_id, user_id) VALUES (?, ?)");
        $stmt->execute([$gid, $userId]);
    }
}

echo "All 10 test accounts provisioned and roles assigned successfully!\n";
