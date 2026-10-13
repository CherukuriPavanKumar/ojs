{**
 * plugins/generic/htmlArticleGalley/display.tpl — Veridica Premium Reader
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @hook Templates::Common::Footer::PageFooter []
 *}
<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>{$article->getCurrentPublication()->getLocalizedFullTitle(null, 'html')|strip_unsafe_html} | Veridica</title>
{include file="frontend/components/headerHead.tpl"}
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&family=Lora:wght@400;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
/* ===== VERIDICA HTML ARTICLE READER ===== */
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

:root {
    --navy: #0A2342;
    --navy-light: #1E3A5F;
    --accent: #C47F2C;
    --red: #B91C1C;
    --border: #E2E8F0;
    --bg: #F8FAFC;
    --white: #fff;
    --text: #1E293B;
    --muted: #64748B;
    --reader-bar-h: 56px;
}

html, body {
    height: 100%;
    overflow: hidden;
}

body {
    font-family: 'Plus Jakarta Sans', sans-serif;
    background: var(--bg);
    display: flex;
    flex-direction: column;
}

/* ── Reading progress bar ── */
#v-read-progress {
    position: fixed;
    top: var(--reader-bar-h);
    left: 0;
    height: 3px;
    width: 0%;
    background: linear-gradient(90deg, var(--red), var(--accent));
    z-index: 200;
    transition: width 0.1s linear;
    pointer-events: none;
}

/* ── Top reader bar ── */
.v-reader-bar {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    height: var(--reader-bar-h);
    background: var(--navy);
    display: flex;
    align-items: center;
    gap: 0;
    z-index: 100;
    box-shadow: 0 2px 16px rgba(0,0,0,0.25);
}

/* Back button */
.v-reader-back {
    display: flex;
    align-items: center;
    gap: 8px;
    padding: 0 20px;
    height: 100%;
    color: rgba(255,255,255,0.8);
    text-decoration: none;
    font-size: 13px;
    font-weight: 600;
    white-space: nowrap;
    border-right: 1px solid rgba(255,255,255,0.12);
    transition: all 0.2s ease;
}
.v-reader-back:hover {
    background: rgba(255,255,255,0.08);
    color: #fff;
}
.v-reader-back i {
    font-size: 14px;
}

/* Article title in bar */
.v-reader-title {
    flex: 1;
    padding: 0 20px;
    font-family: 'Lora', Georgia, serif;
    font-size: 14px;
    font-weight: 600;
    color: rgba(255,255,255,0.9);
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    line-height: 1.3;
}

/* Right-side actions */
.v-reader-actions {
    display: flex;
    align-items: center;
    gap: 2px;
    padding: 0 12px;
    border-left: 1px solid rgba(255,255,255,0.12);
    height: 100%;
}

/* Galley switcher pills */
.v-galley-pills {
    display: flex;
    align-items: center;
    gap: 6px;
    padding: 0 16px;
    border-left: 1px solid rgba(255,255,255,0.12);
    height: 100%;
}

.v-galley-pill {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 6px 14px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 700;
    text-decoration: none;
    transition: all 0.2s;
    border: 1.5px solid transparent;
}

.v-galley-pill.active-html {
    background: rgba(255,255,255,0.15);
    color: #fff;
    border-color: rgba(255,255,255,0.3);
}

.v-galley-pill.pdf-link {
    background: linear-gradient(135deg, #B91C1C, #991B1B);
    color: #fff;
    box-shadow: 0 2px 8px rgba(185,28,28,0.4);
}

.v-galley-pill.pdf-link:hover {
    background: linear-gradient(135deg, #DC2626, #B91C1C);
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(185,28,28,0.5);
}

/* Action icon buttons */
.v-reader-action-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 36px;
    height: 36px;
    border-radius: 8px;
    background: transparent;
    border: none;
    color: rgba(255,255,255,0.7);
    font-size: 14px;
    cursor: pointer;
    transition: all 0.2s;
    text-decoration: none;
}
.v-reader-action-btn:hover {
    background: rgba(255,255,255,0.1);
    color: #fff;
}

/* ── iframe wrapper ── */
.v-reader-content {
    margin-top: var(--reader-bar-h);
    flex: 1;
    height: calc(100vh - var(--reader-bar-h));
    position: relative;
}

.v-reader-content iframe {
    width: 100%;
    height: 100%;
    border: none;
    display: block;
    background: #FAFAFA;
}

/* Outdated version notice */
.galley_view_notice {
    background: linear-gradient(135deg, #FEF3C7, #FDE68A);
    border-bottom: 2px solid #F59E0B;
    padding: 14px 24px;
    font-family: 'Plus Jakarta Sans', sans-serif;
    font-size: 14px;
    color: #92400E;
}

@media (max-width: 768px) {
    .v-reader-title { display: none; }
    .v-galley-pills { padding: 0 10px; }
    .v-galley-pill span { display: none; }
    .v-reader-back { padding: 0 14px; }
    .v-reader-back span { display: none; }
}
</style>
</head>
<body>

{capture assign="articleUrl"}{url page="article" op="view" path=$article->getBestId()}{/capture}
{capture assign="journalUrl"}{url page="index"}{/capture}

{* ── Reading progress bar ── *}
<div id="v-read-progress"></div>

{* ── Top Reader Bar ── *}
<div class="v-reader-bar">

    {* Back to abstract *}
    <a href="{$articleUrl}" class="v-reader-back" title="Back to article abstract">
        <i class="fas fa-arrow-left"></i>
        <span>Abstract</span>
    </a>

    {* Article title *}
    <div class="v-reader-title">
        {$article->getCurrentPublication()->getLocalizedTitle(null, 'html')|strip_unsafe_html}
    </div>

    {* Galley switcher *}
    <div class="v-galley-pills">
        {* Current: HTML — active pill *}
        <span class="v-galley-pill active-html">
            <i class="fas fa-globe"></i>
            <span>HTML</span>
        </span>

        {* PDF link from primary galleys *}
        {foreach from=$article->getCurrentPublication()->getData('galleys') item=g}
            {if $g->isPdfGalley()}
                {capture assign="pdfUrl"}{url page="article" op="view" path=$article->getBestId()|to_array:$g->getBestGalleyId()}{/capture}
                <a href="{$pdfUrl}" class="v-galley-pill pdf-link" title="Download PDF">
                    <i class="fas fa-file-pdf"></i>
                    <span>PDF</span>
                </a>
            {/if}
        {/foreach}
    </div>

    {* Action buttons *}
    <div class="v-reader-actions">
        <button class="v-reader-action-btn" onclick="window.print()" title="Print article">
            <i class="fas fa-print"></i>
        </button>
        <button class="v-reader-action-btn" id="v-fullscreen-btn" onclick="toggleFullscreen()" title="Toggle fullscreen">
            <i class="fas fa-expand" id="v-fs-icon"></i>
        </button>
    </div>

</div>

{* ── Article Content ── *}
<div class="v-reader-content">

    {if !$isLatestPublication}
        <div class="galley_view_notice" role="alert">
            {translate key="submission.outdatedVersion" datePublished=$galleyPublication->getData('datePublished')|date_format:$dateFormatLong urlRecentVersion=$articleUrl}
        </div>
    {/if}

    {if !$isLatestPublication}
        {capture assign="htmlUrl"}
            {url page="article" op="download" path=$article->getBestId()|to_array:'version':$galleyPublication->getId():$galley->getBestGalleyId():$submissionFile->getId() inline=true}
        {/capture}
    {else}
        {capture assign="htmlUrl"}
            {url page="article" op="download" path=$article->getBestId()|to_array:$galley->getBestGalleyId():$submissionFile->getId() inline=true}
        {/capture}
    {/if}

    <iframe
        name="htmlFrame"
        id="htmlFrame"
        src="{$htmlUrl}"
        title="{translate key="submission.representationOfTitle" representation=$galley->getLabel() title=$galleyPublication->getLocalizedFullTitle(null, 'html')|strip_unsafe_html}"
        allowfullscreen
        webkitallowfullscreen
        onload="syncProgress(this)"
    ></iframe>

</div>

{call_hook name="Templates::Common::Footer::PageFooter"}

<script>
// ── Sync reading progress from iframe scroll ──
function syncProgress(iframe) {
    try {
        const doc = iframe.contentDocument || iframe.contentWindow.document;
        const bar = document.getElementById('v-read-progress');
        doc.addEventListener('scroll', () => {
            const el = doc.scrollingElement || doc.documentElement;
            const pct = el.scrollHeight > el.clientHeight
                ? (el.scrollTop / (el.scrollHeight - el.clientHeight)) * 100
                : 0;
            bar.style.width = pct + '%';
        });
    } catch(e) { /* cross-origin fallback */ }
}

// ── Fullscreen toggle ──
function toggleFullscreen() {
    const icon = document.getElementById('v-fs-icon');
    if (!document.fullscreenElement) {
        document.documentElement.requestFullscreen().then(() => {
            icon.className = 'fas fa-compress';
        });
    } else {
        document.exitFullscreen().then(() => {
            icon.className = 'fas fa-expand';
        });
    }
}

// ── Keyboard shortcuts ──
document.addEventListener('keydown', e => {
    if (e.key === 'Escape' && !document.fullscreenElement) {
        window.location.href = '{$articleUrl}';
    }
    if (e.key === 'F' || e.key === 'f') {
        if (e.target.tagName !== 'INPUT' && e.target.tagName !== 'TEXTAREA') {
            toggleFullscreen();
        }
    }
});
</script>

</body>
</html>
