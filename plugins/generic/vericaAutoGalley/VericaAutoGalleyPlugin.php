<?php

/**
 * @file plugins/generic/vericaAutoGalley/VericaAutoGalleyPlugin.php
 *
 * Veridica Publication Platform
 * Auto-Galley Generator Plugin
 *
 * Automatically generates a branded PDF and interactive HTML galley
 * whenever an article is published, eliminating all manual typesetting.
 *
 * Hook: Publication::publish
 */

namespace APP\plugins\generic\vericaAutoGalley;

use APP\core\Application;
use APP\submission\Submission;
use PKP\db\DAORegistry;
use PKP\plugins\GenericPlugin;
use PKP\plugins\Hook;
use Mpdf\Mpdf;

class VericaAutoGalleyPlugin extends GenericPlugin
{
    /**
     * Register the plugin and attach to the publish hook.
     */
    public function register($category, $path, $mainContextId = null)
    {
        $success = parent::register($category, $path, $mainContextId);
        if (Application::isUnderMaintenance()) {
            return true;
        }
        if ($success && $this->getEnabled($mainContextId)) {
            Hook::add('Publication::publish', $this->onPublicationPublish(...));
        }
        return $success;
    }

    public function getDisplayName()
    {
        return 'Veridica Auto-Galley Generator';
    }

    public function getDescription()
    {
        return 'Automatically generates a branded Veridica PDF and interactive HTML galley whenever an article is published. No manual typesetting required.';
    }

    /**
     * Hook callback: Publication::publish
     * Called with: [&$newPublication, $oldPublication, $submission]
     */
    public function onPublicationPublish(string $hookName, array $args): bool
    {
        $publication = &$args[0];
        $submission  = $args[2];

        // Only fire for published status
        if ($publication->getData('status') !== Submission::STATUS_PUBLISHED) {
            return false;
        }

        $subId = $submission->getId();
        $pubId = $publication->getId();

        // Check if galleys already exist for this publication to avoid duplicates
        $pdo = $this->getPdo();
        $stmtCheck = $pdo->prepare("SELECT COUNT(*) FROM publication_galleys WHERE publication_id = ? AND label IN ('PDF','HTML')");
        $stmtCheck->execute([$pubId]);
        if ((int)$stmtCheck->fetchColumn() >= 2) {
            // Already has branded galleys; skip
            return false;
        }

        try {
            $this->generateGalleys($publication, $submission, $pdo);
        } catch (\Throwable $e) {
            error_log("[VericaAutoGalley] Error generating galleys for submission $subId: " . $e->getMessage());
        }

        return false; // false = allow hook chain to continue
    }

    /**
     * Core generation: builds branded PDF + HTML and registers them as galleys.
     */
    private function generateGalleys($publication, $submission, \PDO $pdo): void
    {
        $subId = $submission->getId();
        $pubId = $publication->getId();

        // ── Collect metadata ──────────────────────────────────────────────────
        $title    = $publication->getLocalizedTitle() ?? 'Research Article';
        $abstract = strip_tags($publication->getLocalizedData('abstract') ?? '');
        $keywords = $publication->getLocalizedData('keywords') ?? [];

        // Authors
        $authors = $publication->getData('authors') ?? [];
        $authorNames  = [];
        $affilLines   = [];
        $idx = 1;
        foreach ($authors as $author) {
            $fullName = $author->getFullName();
            $authorNames[] = $fullName . "<sup>$idx</sup>";
            $affil = $author->getLocalizedAffiliationNamesAsString(null, ', ');
            if ($affil) {
                $affilLines[] = "<sup>$idx</sup> " . htmlspecialchars($affil, ENT_QUOTES);
            }
            $idx++;
        }
        $authorsHtml = implode(', ', $authorNames);
        $affilHtml   = implode('<br>', $affilLines);

        // Issue metadata
        $issueId = $publication->getData('issueId');
        $volume = 1; $number = 1; $year = date('Y'); $pages = '';
        if ($issueId) {
            $row = $pdo->prepare("SELECT volume, number, year FROM issues WHERE issue_id = ?");
            $row->execute([$issueId]);
            $issueRow = $row->fetch(\PDO::FETCH_ASSOC);
            if ($issueRow) {
                $volume = $issueRow['volume'] ?? 1;
                $number = $issueRow['number'] ?? 1;
                $year   = $issueRow['year']   ?? date('Y');
            }
        }
        $pagesRow = $pdo->prepare("SELECT setting_value FROM publication_settings WHERE publication_id = ? AND setting_name = 'pages'");
        $pagesRow->execute([$pubId]);
        $pages = $pagesRow->fetchColumn() ?? '';

        $datePublished = $publication->getData('datePublished') ?? date('Y-m-d');
        $doi = $publication->getStoredPubId('doi') ?? "10.5555/veridica.{$year}.{$volume}.{$pubId}";

        // Keyword pills for HTML
        $kwHtml = '';
        foreach ($keywords as $kw) {
            $name = is_array($kw) ? ($kw['name'] ?? $kw) : $kw;
            $kwHtml .= '<span class="kw-tag">' . htmlspecialchars($name, ENT_QUOTES) . '</span>';
        }

        // ── Ensure article directory ──────────────────────────────────────────
        $baseFilesDir = '/home/pavankumar/.local/share/ojs-files/journals/1/articles/' . $subId;
        if (!is_dir($baseFilesDir)) {
            mkdir($baseFilesDir, 0775, true);
        }

        // ── 1. Generate Branded PDF ───────────────────────────────────────────
        $pdfHtml = $this->buildPdfHtml($title, $authorsHtml, $affilHtml, $abstract, $doi, $datePublished, $volume, $number, $year, $pages);

        $mpdf = new Mpdf([
            'mode'          => 'utf-8',
            'format'        => 'A4',
            'margin_left'   => 20,
            'margin_right'  => 20,
            'margin_top'    => 18,
            'margin_bottom' => 18,
        ]);
        $mpdf->SetFooter('Veridica | Vol. ' . $volume . ', No. ' . $number . ' (' . $year . ') | Page {PAGENO} of {nb}');
        $mpdf->WriteHTML($pdfHtml);

        $pdfFileName = "veridica_article_{$subId}.pdf";
        $pdfFullPath = "$baseFilesDir/$pdfFileName";
        $mpdf->Output($pdfFullPath, 'F');

        $relPdfPath = "journals/1/articles/$subId/$pdfFileName";
        $pdfFileId  = $this->registerFile($pdo, $relPdfPath, 'application/pdf');
        $pdfSubFileId = $this->registerSubmissionFile($pdo, $subId, $pdfFileId, 'application/pdf', $pdfFileName);
        $this->createGalley($pdo, $pubId, $pdfSubFileId, 'PDF', 1, null);

        // ── 2. Generate Interactive HTML Galley ───────────────────────────────
        $webHtml = $this->buildWebHtml($title, $authorsHtml, $affilHtml, $abstract, $doi, $datePublished, $kwHtml);
        $htmlFileName = "veridica_article_{$subId}.html";
        $htmlFullPath = "$baseFilesDir/$htmlFileName";
        file_put_contents($htmlFullPath, $webHtml);

        $relHtmlPath = "journals/1/articles/$subId/$htmlFileName";
        $htmlFileId  = $this->registerFile($pdo, $relHtmlPath, 'text/html');
        $htmlSubFileId = $this->registerSubmissionFile($pdo, $subId, $htmlFileId, 'text/html', $htmlFileName);
        $this->createGalley($pdo, $pubId, $htmlSubFileId, 'HTML', 2, 'html');

        error_log("[VericaAutoGalley] ✅ Branded PDF + HTML galleys generated for submission $subId (publication $pubId)");
    }

    // ── HTML Builders ─────────────────────────────────────────────────────────

    private function buildPdfHtml(
        string $title, string $authorsHtml, string $affilHtml, string $abstract,
        string $doi, string $datePublished, $volume, $number, $year, string $pages
    ): string {
        $escapedTitle    = htmlspecialchars($title, ENT_QUOTES);
        $escapedAbstract = htmlspecialchars($abstract, ENT_QUOTES);
        $pagesLabel = $pages ? "pp. $pages" : '';

        return <<<HTML
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
body { font-family: 'Helvetica', 'Arial', sans-serif; font-size: 10pt; line-height: 1.55; color: #1e293b; margin: 0; padding: 0; }
.header { border-bottom: 2.5px solid #C99A46; padding-bottom: 10px; margin-bottom: 22px; }
.journal-title { font-size: 14pt; font-weight: bold; color: #18233C; letter-spacing: 0.8px; }
.journal-meta { font-size: 8pt; color: #64748b; margin-top: 4px; }
.oa-badge { background: #ECFDF5; color: #059669; border: 1px solid #A7F3D0; font-size: 7.5pt; font-weight: bold; padding: 2px 8px; border-radius: 4px; display: inline-block; }
h1.article-title { font-size: 17pt; font-weight: bold; color: #18233C; line-height: 1.3; margin: 16px 0 10px 0; }
.authors { font-size: 10.5pt; font-weight: bold; color: #0F172A; margin-bottom: 6px; }
.affiliations { font-size: 8.5pt; color: #475569; font-style: italic; margin-bottom: 18px; line-height: 1.5; }
.meta-box { background: #F8FAFC; border: 1px solid #E2E8F0; padding: 8px 14px; margin-bottom: 22px; font-size: 8pt; color: #475569; border-radius: 4px; }
.abstract-box { background: #F8FAFC; border-left: 4px solid #C99A46; padding: 14px 16px; margin-bottom: 26px; border-radius: 0 4px 4px 0; }
.abstract-title { font-size: 9.5pt; font-weight: bold; color: #18233C; text-transform: uppercase; letter-spacing: 0.6px; margin-bottom: 8px; }
.abstract-text { font-size: 9.5pt; color: #334155; line-height: 1.6; text-align: justify; }
h2.section-title { font-size: 11.5pt; font-weight: bold; color: #18233C; border-bottom: 1px solid #E2E8F0; padding-bottom: 4px; margin-top: 22px; margin-bottom: 10px; text-transform: uppercase; letter-spacing: 0.5px; }
p { margin: 0 0 12px 0; text-align: justify; font-size: 10pt; }
.notice { background: #FFF7ED; border-left: 4px solid #F59E0B; padding: 10px 14px; border-radius: 0 4px 4px 0; font-size: 8.5pt; color: #92400E; margin-top: 20px; }
</style>
</head>
<body>
    <div class="header">
        <table width="100%"><tr>
            <td align="left">
                <span class="journal-title">VERIDICA</span><br>
                <span class="journal-meta">Journal of Multidisciplinary Research &bull; Vol. {$volume}, No. {$number} ({$year}) {$pagesLabel}</span>
            </td>
            <td align="right" valign="top">
                <span class="oa-badge">DIAMOND OPEN ACCESS</span><br>
                <span style="font-size:7.5pt;color:#64748b;">CC-BY 4.0 &bull; Peer Reviewed</span>
            </td>
        </tr></table>
    </div>

    <h1 class="article-title">{$escapedTitle}</h1>
    <div class="authors">{$authorsHtml}</div>
    <div class="affiliations">{$affilHtml}</div>

    <div class="meta-box">
        <strong>Published:</strong> {$datePublished} &nbsp;|&nbsp;
        <strong>License:</strong> CC BY 4.0 &nbsp;|&nbsp;
        <strong>DOI:</strong> {$doi}
    </div>

    <div class="abstract-box">
        <div class="abstract-title">Abstract</div>
        <div class="abstract-text">{$escapedAbstract}</div>
    </div>

    <div class="notice">
        <strong>Full Text:</strong> The complete manuscript is available in the author's uploaded file. This branded galley was auto-generated by the Veridica Publication Platform.
    </div>
</body>
</html>
HTML;
    }

    private function buildWebHtml(
        string $title, string $authorsHtml, string $affilHtml, string $abstract,
        string $doi, string $datePublished, string $kwHtml
    ): string {
        $escapedTitle    = htmlspecialchars($title, ENT_QUOTES);
        $escapedAbstract = htmlspecialchars($abstract, ENT_QUOTES);

        return <<<HTML
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>{$escapedTitle} | Veridica Publication</title>
<link href="https://fonts.googleapis.com/css2?family=Lora:ital,wght@0,400;0,600;0,700;1,400&family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
:root{--navy:#0A2342;--gold:#C47F2C;--text:#1E293B;--muted:#64748B;--border:#E2E8F0;--bg:#FAFAFA}
body{font-family:'Lora',Georgia,serif;font-size:18px;line-height:1.85;color:var(--text);background:var(--bg)}
#reading-progress{position:fixed;top:0;left:0;height:3px;width:0%;background:linear-gradient(90deg,var(--navy),var(--gold));z-index:1000;transition:width .1s linear}
.article-container{max-width:800px;margin:0 auto;padding:60px 28px 100px}
.journal-brand{font-family:'Plus Jakarta Sans',sans-serif;font-size:12px;font-weight:700;letter-spacing:2px;color:var(--muted);text-transform:uppercase;margin-bottom:24px}
.journal-brand a{color:var(--gold);text-decoration:none}
.oa-pill{display:inline-flex;align-items:center;gap:6px;font-family:'Plus Jakarta Sans',sans-serif;font-size:11px;font-weight:700;letter-spacing:1.2px;text-transform:uppercase;background:rgba(196,127,44,.12);color:var(--gold);padding:4px 14px;border-radius:20px;margin-bottom:22px}
.article-header{padding-bottom:32px;border-bottom:2px solid var(--border);margin-bottom:36px}
.article-header h1{font-size:34px;font-weight:700;line-height:1.3;color:var(--navy);margin-bottom:22px}
.article-authors{font-family:'Plus Jakarta Sans',sans-serif;font-weight:600;font-size:15px;color:var(--navy);margin-bottom:6px}
.article-affiliations{font-family:'Plus Jakarta Sans',sans-serif;font-size:13px;color:var(--muted);margin-bottom:16px;line-height:1.6}
.article-meta{display:flex;flex-wrap:wrap;gap:18px;font-family:'Plus Jakarta Sans',sans-serif;font-size:12px;color:var(--muted);margin-top:14px}
.article-meta strong{color:var(--text)}
.abstract-block{background:linear-gradient(135deg,#F0F4FF,#EEF2FF);border-left:4px solid var(--navy);border-radius:0 12px 12px 0;padding:28px 32px;margin-bottom:32px}
.abstract-block h2{font-family:'Plus Jakarta Sans',sans-serif;font-size:11px;font-weight:700;letter-spacing:1.5px;text-transform:uppercase;color:var(--navy);margin-bottom:14px}
.abstract-block p{font-size:16px;line-height:1.8;color:#334155}
.keywords-block{margin-bottom:40px}
.kw-tag{display:inline-block;font-family:'Plus Jakarta Sans',sans-serif;font-size:12px;font-weight:600;background:#fff;color:var(--navy);border:1px solid var(--border);padding:5px 14px;border-radius:20px;margin:0 6px 6px 0}
.full-text-notice{background:#FFF7ED;border-left:4px solid #F59E0B;border-radius:0 10px 10px 0;padding:22px 28px;margin-bottom:32px}
.full-text-notice h3{font-family:'Plus Jakarta Sans',sans-serif;font-size:14px;font-weight:700;color:#92400E;margin-bottom:8px}
.full-text-notice p{font-size:15px;color:#78350F;line-height:1.7}
.full-text-notice a{color:var(--gold);font-weight:600}
</style>
</head>
<body>
<div id="reading-progress"></div>
<div class="article-container">
    <div class="journal-brand">
        <a href="/index.php/veridica">Veridica</a> &rarr; Journal of Multidisciplinary Research
    </div>
    <div class="article-header">
        <span class="oa-pill">&#x1F513; Diamond Open Access &bull; Peer Reviewed</span>
        <h1>{$escapedTitle}</h1>
        <div class="article-authors">{$authorsHtml}</div>
        <div class="article-affiliations">{$affilHtml}</div>
        <div class="article-meta">
            <span><strong>Published:</strong> {$datePublished}</span>
            <span><strong>License:</strong> CC BY 4.0</span>
            <span><strong>DOI:</strong> {$doi}</span>
        </div>
    </div>

    <div class="abstract-block">
        <h2>Abstract</h2>
        <p>{$escapedAbstract}</p>
    </div>

    <div class="keywords-block">{$kwHtml}</div>

    <div class="full-text-notice">
        <h3>&#x1F4C4; Full Manuscript Available</h3>
        <p>
            The complete peer-reviewed manuscript is available as a PDF download above.
            This HTML view presents the article metadata, abstract, and keywords for
            accessibility and web discovery. Click <strong>PDF</strong> above to read or download
            the full camera-ready publication.
        </p>
    </div>
</div>
<script>
const bar = document.getElementById('reading-progress');
document.addEventListener('scroll', () => {
    const total = document.body.scrollHeight - window.innerHeight;
    bar.style.width = (window.scrollY / total * 100) + '%';
});
</script>
</body>
</html>
HTML;
    }

    // ── Database Helpers ──────────────────────────────────────────────────────

    private function getPdo(): \PDO
    {
        $config = \Config::getDB();
        $pdo = new \PDO(
            "mysql:host={$config['host']};dbname={$config['name']};charset=utf8mb4",
            $config['username'],
            $config['password']
        );
        $pdo->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
        return $pdo;
    }

    private function registerFile(\PDO $pdo, string $relPath, string $mime): int
    {
        $stmt = $pdo->prepare("SELECT file_id FROM files WHERE path = ?");
        $stmt->execute([$relPath]);
        $row = $stmt->fetch(\PDO::FETCH_ASSOC);
        if ($row) {
            return (int)$row['file_id'];
        }
        $pdo->prepare("INSERT INTO files (path, mimetype) VALUES (?, ?)")->execute([$relPath, $mime]);
        return (int)$pdo->lastInsertId();
    }

    private function registerSubmissionFile(\PDO $pdo, int $subId, int $fileId, string $mime, string $label): int
    {
        $stmt = $pdo->prepare("SELECT submission_file_id FROM submission_files WHERE submission_id = ? AND file_id = ?");
        $stmt->execute([$subId, $fileId]);
        $row = $stmt->fetch(\PDO::FETCH_ASSOC);
        if ($row) {
            return (int)$row['submission_file_id'];
        }
        $pdo->prepare("
            INSERT INTO submission_files (submission_id, file_id, genre_id, file_stage, viewable, created_at, updated_at, uploader_user_id)
            VALUES (?, ?, 1, 10, 1, NOW(), NOW(), 1)
        ")->execute([$subId, $fileId]);
        $sfId = (int)$pdo->lastInsertId();
        $pdo->prepare("INSERT INTO submission_file_settings (submission_file_id, locale, setting_name, setting_value) VALUES (?, 'en', 'name', ?)")
            ->execute([$sfId, $label]);
        return $sfId;
    }

    private function createGalley(\PDO $pdo, int $pubId, int $sfId, string $label, int $seq, ?string $urlPath): void
    {
        // Check if already exists
        $stmt = $pdo->prepare("SELECT galley_id FROM publication_galleys WHERE publication_id = ? AND label = ?");
        $stmt->execute([$pubId, $label]);
        if ($stmt->fetch()) {
            return; // Already exists
        }
        $pdo->prepare("
            INSERT INTO publication_galleys (locale, publication_id, label, submission_file_id, seq, is_approved, url_path)
            VALUES ('en', ?, ?, ?, ?, 1, ?)
        ")->execute([$pubId, $label, $sfId, $seq, $urlPath]);
    }
}
