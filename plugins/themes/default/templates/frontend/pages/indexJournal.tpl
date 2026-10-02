{**
 * templates/frontend/pages/indexJournal.tpl
 * Overridden by Veridica Custom Theme for a premium academic look
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

<div class="veridica-homepage">

    <!-- HERO SECTION -->
    <section class="veridica-hero">
        <div class="veridica-hero-overlay"></div>
        <div class="veridica-hero-content">
            <span class="veridica-hero-badge">OPEN ACCESS PUBLISHER</span>
            <h1 class="veridica-hero-title">
                {$currentJournal->getLocalizedName()|escape}
            </h1>
            <p class="veridica-hero-subtitle">
                {$currentContext->getLocalizedData('description')|strip_tags|truncate:200:"..."}
            </p>
            <div class="veridica-hero-actions">
                <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="submissions"}" class="veridica-btn-primary">
                    <i class="fas fa-file-upload"></i> Submit Manuscript
                </a>
                <a href="#current-issue" class="veridica-btn-secondary">
                    Browse Latest Issue
                </a>
            </div>
        </div>
    </section>

    <!-- MAIN CONTENT AREA -->
    <div class="veridica-container">

        <!-- ANNOUNCEMENTS (if any) -->
        {if $numAnnouncementsHomepage && $announcements|@count}
            <section class="veridica-section veridica-announcements">
                {include file="frontend/objects/announcements_list.tpl" numAnnouncements=$numAnnouncementsHomepage}
            </section>
        {/if}

        <!-- LATEST ISSUE -->
        {if $issue}
            <section id="current-issue" class="veridica-section">
                <div class="veridica-section-header">
                    <h2>Latest Published Issue</h2>
                    <span class="veridica-issue-id">{$issue->getIssueIdentification()|escape}</span>
                </div>
                
                <div class="veridica-article-grid">
                    {* We include the core issue TOC but we will style its internal classes via CSS *}
                    {include file="frontend/objects/issue_toc.tpl" heading="h3"}
                </div>
                
                <div class="veridica-section-footer">
                    <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive"}" class="veridica-link-btn">
                        View All Past Issues <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
            </section>
        {/if}

        <!-- JOURNAL METRICS / FEATURES -->
        <section class="veridica-features">
            <div class="veridica-feature-card">
                <i class="fas fa-globe"></i>
                <h3>Global Reach</h3>
                <p>Fully open access publishing with worldwide indexing and robust distribution networks.</p>
            </div>
            <div class="veridica-feature-card">
                <i class="fas fa-check-double"></i>
                <h3>Rigorous Peer Review</h3>
                <p>Ensuring the highest standards of academic integrity with fast turnaround times.</p>
            </div>
            <div class="veridica-feature-card">
                <i class="fas fa-id-badge"></i>
                <h3>Crossref & ORCID</h3>
                <p>DOIs assigned to all published articles with native ORCID author integration.</p>
            </div>
        </section>

    </div>
</div>

{include file="frontend/components/footer.tpl"}
