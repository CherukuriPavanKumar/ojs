{**
 * templates/frontend/pages/indexJournal.tpl
 *
 * Veridica Academic Publishing Portal Homepage
 * Inspired by Scopus & SAGE Journals (High-Density Academic Discovery Console)
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

<!-- Import Academic Serif & Clean Sans-Serif Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,600;0,700;1,400&family=Inter:wght@400;500;600;700&family=Lora:ital,wght@0,500;0,600;0,700;1,400&display=swap" rel="stylesheet">

<div class="veridica-portal-root">

    <!-- ================================================================= -->
    <!-- 1. SCOPUS-STYLE RESEARCH DISCOVERY HERO & MULTI-MODE SEARCH CONSOLE -->
    <!-- ================================================================= -->
    <section class="vsc-hero-discovery" role="region" aria-label="Research Discovery & Search Console">
        <div class="vsc-hero-container">
            <!-- Institutional Prestige Ribbon -->
            <div class="vsc-prestige-badge">
                <span class="vsc-badge-dot"></span>
                <span>PEER-REVIEWED &bull; DIAMOND OPEN ACCESS &bull; SCHOLARLY PUBLICATION</span>
                {if $currentJournal->getData('onlineIssn') || $currentJournal->getData('printIssn')}
                    <span class="vsc-badge-issn">ISSN: {$currentJournal->getData('onlineIssn')|default:$currentJournal->getData('printIssn')|escape}</span>
                {else}
                    <span class="vsc-badge-issn">CC-BY 4.0</span>
                {/if}
            </div>

            <h1 class="vsc-hero-title">
                Advancing Scholarly Discovery &amp; Global Science
            </h1>
            <p class="vsc-hero-tagline" style="text-align: center !important; margin-left: auto !important; margin-right: auto !important; margin-top: 0 !important; margin-bottom: 36px !important; display: block !important; max-width: 760px !important;">
                Search open-access peer-reviewed literature, author metrics, and data citations across the Veridica Academic Network.
            </p>

            <!-- SCOPUS MULTI-TAB SEARCH HUB -->
            <div class="vsc-search-hub">
                <!-- Mode Switch Tabs -->
                <div class="vsc-search-tabs" role="tablist">
                    <button type="button" class="vsc-search-tab active" data-mode="documents" role="tab" aria-selected="true" id="tab-search-docs">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line></svg>
                        Documents Search
                    </button>
                    <button type="button" class="vsc-search-tab" data-mode="authors" role="tab" aria-selected="false" id="tab-search-authors">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                        Authors &amp; ORCID
                    </button>
                    <button type="button" class="vsc-search-tab" data-mode="topics" role="tab" aria-selected="false" id="tab-search-topics">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>
                        Research Topics
                    </button>
                </div>

                <!-- Live Search Form linking to OJS Search Controller -->
                <form class="vsc-search-form" id="vsc-search-form" method="get" action="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="search" op="search"}">
                    <div class="vsc-search-input-wrap">
                        <div class="vsc-search-field-select-wrap">
                            <select id="vsc-field-select" name="searchField" class="vsc-field-select" aria-label="Search Field Scope">
                                <option value="all">Title, Abstract, Keywords</option>
                                <option value="title">Article Title</option>
                                <option value="authors">Author / Researcher</option>
                                <option value="abstract">Abstract</option>
                                <option value="doi">DOI / ISSN</option>
                            </select>
                        </div>
                        <div class="vsc-search-input-inner">
                            <svg class="vsc-search-icon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#64748B" stroke-width="2"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                            <input type="text" id="vsc-query-input" name="query" class="vsc-search-input" placeholder="Enter keywords, author name, DOI, or research topic..." required autocomplete="off">
                        </div>
                        <button type="submit" class="vsc-search-btn" id="vsc-search-btn">
                            <span>Search</span>
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="9 18 15 12 9 6"></polyline></svg>
                        </button>
                    </div>

                    <!-- Search Sub-bar: Search Tips, Advanced Search, and Quick Query Tags -->
                    <div class="vsc-search-subbar">
                        <div class="vsc-quick-tags">
                            <span class="vsc-quick-label">Trending Topics:</span>
                            <button type="button" class="vsc-tag-pill" data-query="Autonomous Agents">Autonomous Agents</button>
                            <button type="button" class="vsc-tag-pill" data-query="Quantum Computing">Quantum Computing</button>
                            <button type="button" class="vsc-tag-pill" data-query="Genomic Profiling">Genomic Profiling</button>
                            <button type="button" class="vsc-tag-pill" data-query="Post-Quantum Cryptography">Post-Quantum Cryptography</button>
                            <button type="button" class="vsc-tag-pill" data-query="Open Access">Open Access</button>
                        </div>
                        <div class="vsc-search-links">
                            <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="search"}" class="vsc-adv-link">
                                Advanced Search
                                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
                            </a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </section>

    <!-- ================================================================= -->
    <!-- 2. JOURNAL QUICK-FACTS RIBBON (Real Data Only)                    -->
    <!-- ================================================================= -->
    <section class="vsc-metrics-ribbon" role="region" aria-label="Journal Facts">
        <div class="vsc-ribbon-grid">
            {if $issue}
            <div class="vsc-ribbon-stat">
                <div class="vsc-ribbon-val">{$issueSeries|escape}</div>
                <div class="vsc-ribbon-label">Current Issue</div>
                <div class="vsc-ribbon-sub">Now publishing</div>
            </div>
            <div class="vsc-ribbon-divider"></div>
            {/if}
            <div class="vsc-ribbon-stat">
                <div class="vsc-ribbon-val vsc-gold">100%</div>
                <div class="vsc-ribbon-label">Diamond Open Access</div>
                <div class="vsc-ribbon-sub">Zero APCs &bull; Free Access</div>
            </div>
            <div class="vsc-ribbon-divider"></div>
            <div class="vsc-ribbon-stat">
                <div class="vsc-ribbon-val">CC-BY 4.0</div>
                <div class="vsc-ribbon-label">Author Copyright</div>
                <div class="vsc-ribbon-sub">Authors retain full rights</div>
            </div>
            <div class="vsc-ribbon-divider"></div>
            <div class="vsc-ribbon-stat">
                {if $currentJournal->getData('onlineIssn') || $currentJournal->getData('printIssn')}
                    <div class="vsc-ribbon-val">{$currentJournal->getData('onlineIssn')|default:$currentJournal->getData('printIssn')|escape}</div>
                    <div class="vsc-ribbon-label">ISSN</div>
                    <div class="vsc-ribbon-sub">Registered Publication</div>
                {else}
                    <div class="vsc-ribbon-val">Crossref</div>
                    <div class="vsc-ribbon-label">Permanent DOIs</div>
                    <div class="vsc-ribbon-sub">Registered Metadata</div>
                {/if}
            </div>
            <div class="vsc-ribbon-divider"></div>
            <div class="vsc-ribbon-stat">
                <div class="vsc-ribbon-val">Single-Blind</div>
                <div class="vsc-ribbon-label">Peer Review</div>
                <div class="vsc-ribbon-sub">COPE Compliant &bull; Ethical</div>
            </div>
        </div>
    </section>

    <!-- ================================================================= -->
    <!-- 3. MAIN PORTAL CONTENT WRAPPER                                    -->
    <!-- ================================================================= -->
    <div class="vsc-portal-container">

        {if $journalDescription}
        <section class="vsc-about-snippet">
            <div class="vsc-about-snippet-inner">
                <span class="vsc-section-eyebrow">Aims &amp; Scope</span>
                <div class="vsc-about-snippet-text">{$journalDescription|strip_unsafe_html}</div>
            </div>
        </section>
        {/if}

        <!-- 3A. FEATURED CURRENT ISSUE & LATEST RESEARCH SECTION -->
        <section class="vsc-issue-section" id="current-issue">
            <div class="vsc-section-header">
                <div>
                    <span class="vsc-section-eyebrow">Current Issue</span>
                    <h2 class="vsc-section-title">
                        {if $issue}
                            {$issue->getIssueIdentification()|escape}
                        {else}
                            Current Issue
                        {/if}
                    </h2>
                </div>
                <div class="vsc-header-actions">
                    <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive"}" class="vsc-btn-outline-sm">
                        View Past Issues Archive
                    </a>
                </div>
            </div>

            {* === DYNAMIC SPOTLIGHT: Latest Article from Current Issue === *}
            {assign var="spotlightArticle" value=null}
            {if $publishedSubmissions}
                {foreach from=$publishedSubmissions item=sec}
                    {if $sec.articles && !$spotlightArticle}
                        {foreach from=$sec.articles item=art}
                            {if !$spotlightArticle}
                                {assign var="spotlightArticle" value=$art}
                            {/if}
                        {/foreach}
                    {/if}
                {/foreach}
            {/if}
            {if $spotlightArticle}
                {assign var="spotlightPub" value=$spotlightArticle->getCurrentPublication()}
                <div class="vsc-spotlight-card">
                            <div class="vsc-spotlight-header">
                                <div class="vsc-spotlight-badges">
                                    <span class="vsc-badge-oa">
                                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="12" cy="12" r="10"></circle><path d="M12 6v6l4 2"></path></svg>
                                        Open Access
                                    </span>
                                    {if $spotlightPub->getData('sectionTitle')}
                                        <span class="vsc-badge-type">{$spotlightPub->getData('sectionTitle')|escape}</span>
                                    {else}
                                        <span class="vsc-badge-type">Research Article</span>
                                    {/if}
                                    <span class="vsc-badge-license">CC-BY 4.0</span>
                                </div>
                                {if $spotlightPub->getData('pub-id::doi')}
                                    <span class="vsc-doi-tag">DOI: {$spotlightPub->getData('pub-id::doi')|escape}</span>
                                {/if}
                            </div>

                            <h3 class="vsc-spotlight-title">
                                <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="article" op="view" path=$spotlightArticle->getBestId()}">
                                    {$spotlightPub->getLocalizedTitle()|strip_unsafe_html}
                                </a>
                            </h3>

                            {assign var="spotlightAuthors" value=$spotlightPub->getData('authors')}
                            {if $spotlightAuthors}
                            <div class="vsc-spotlight-authors">
                                {foreach from=$spotlightAuthors item=author name=authorLoop}
                                    <span class="vsc-author">
                                        {if $author->getData('orcid')}<span class="vsc-orcid-badge">iD</span>{/if}
                                        {$author->getFullName()|escape}
                                    </span>
                                    {if !$smarty.foreach.authorLoop.last}<span class="vsc-author-sep">&bull;</span>{/if}
                                    {if $smarty.foreach.authorLoop.iteration >= 3 && !$smarty.foreach.authorLoop.last}
                                        <span class="vsc-affiliation">et al.</span>
                                        {break}
                                    {/if}
                                {/foreach}
                            </div>
                            {/if}

                            {if $spotlightPub->getLocalizedData('abstract')}
                            <p class="vsc-spotlight-abstract">
                                {$spotlightPub->getLocalizedData('abstract')|strip_tags|truncate:320:"...":false|escape}
                            </p>
                            {/if}

                            <div class="vsc-spotlight-footer">
                                <div class="vsc-spotlight-metrics">
                                    {if $spotlightPub->getData('datePublished')}
                                    <span class="vsc-metric-pill">
                                        <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 14 14"></polyline></svg>
                                        Published {$spotlightPub->getData('datePublished')|date_format:$dateFormatShort}
                                    </span>
                                    {/if}
                                </div>
                                <div class="vsc-spotlight-actions">
                                    <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="article" op="view" path=$spotlightArticle->getBestId()}" class="vsc-btn-primary-sm">
                                        Read Full Article &rarr;
                                    </a>
                                </div>
                            </div>
                        </div>
                    {/if}

            <!-- Dynamic Table of Contents (from OJS Issue) -->
            {if $issue}
                <div class="vsc-toc-wrapper">
                    <h3 class="vsc-toc-heading">Issue Table of Contents</h3>
                    <div class="vsc-article-grid">
                        {include file="frontend/objects/issue_toc.tpl" heading="h4"}
                    </div>
                </div>
            {/if}
        </section>

        <!-- 3B. AUTHOR & REVIEWER ACTION SPLIT GATEWAY -->
        <section class="vsc-gateways-section">
            <div class="vsc-gateway-card vsc-gateway-author">
                <div class="vsc-gateway-content">
                    <span class="vsc-gateway-badge">For Researchers &amp; Authors</span>
                    <h3 class="vsc-gateway-title">Publish Your Next Research Paper</h3>
                    <p class="vsc-gateway-desc">
                        Experience transparent peer review, Diamond Open Access distribution with zero APC author fees, and permanent Crossref DOI indexing.
                    </p>
                    <ul class="vsc-gateway-perks">
                        <li><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#C9A84C" stroke-width="2.5"><polyline points="20 6 9 17 4 12"></polyline></svg> 100% Diamond Open Access — zero APCs, authors retain full copyright</li>
                        <li><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#C9A84C" stroke-width="2.5"><polyline points="20 6 9 17 4 12"></polyline></svg> Permanent Crossref DOI registration &amp; ORCID auto-sync on acceptance</li>
                        <li><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#C9A84C" stroke-width="2.5"><polyline points="20 6 9 17 4 12"></polyline></svg> Rigorous single-blind peer review by qualified international reviewers</li>
                    </ul>
                    <div class="vsc-gateway-actions">
                        <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="submissions"}" class="vsc-btn-gold">
                            Submit Manuscript &rarr;
                        </a>
                        <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="submissions"}#authorGuidelines" class="vsc-gateway-link">
                            Author Guidelines &amp; LaTeX Templates
                        </a>
                    </div>
                </div>
            </div>

            <div class="vsc-gateway-card vsc-gateway-reviewer">
                <div class="vsc-gateway-content">
                    <span class="vsc-gateway-badge">For Academics &amp; Scholars</span>
                    <h3 class="vsc-gateway-title">Join Our Peer Review Community</h3>
                    <p class="vsc-gateway-desc">
                        Contribute your expertise to rigorously evaluate frontier scientific discoveries. Receive verified reviewer recognition and editorial board opportunities.
                    </p>
                    <ul class="vsc-gateway-perks">
                        <li><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#003366" stroke-width="2.5"><polyline points="20 6 9 17 4 12"></polyline></svg> Official verified peer review recognition for promotion dossiers</li>
                        <li><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#003366" stroke-width="2.5"><polyline points="20 6 9 17 4 12"></polyline></svg> Streamlined online review dashboard with 1-click evaluation</li>
                        <li><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#003366" stroke-width="2.5"><polyline points="20 6 9 17 4 12"></polyline></svg> Direct pathway to Section Editor and Editorial Board roles</li>
                    </ul>
                    <div class="vsc-gateway-actions">
                        <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="contact"}" class="vsc-btn-navy">
                            Register as Reviewer &rarr;
                        </a>
                        <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="editorialTeam"}" class="vsc-gateway-link">
                            View Editorial Board
                        </a>
                    </div>
                </div>
            </div>
        </section>

        <!-- 3C. SCHOLARLY PUBLISHING STANDARDS & DIGITAL INFRASTRUCTURE -->
        <section class="vsc-indexing-seals-section">
            <div class="vsc-seals-header">
                <span class="vsc-seals-title">SCHOLARLY STANDARDS &amp; SCIENTIFIC INFRASTRUCTURE</span>
            </div>
            <div class="vsc-seals-row">
                <div class="vsc-seal-item">
                    <span class="vsc-seal-badge">CROSSREF</span>
                    <span class="vsc-seal-desc">Permanent DOI Registration</span>
                </div>
                <div class="vsc-seal-item">
                    <span class="vsc-seal-badge">ORCID</span>
                    <span class="vsc-seal-desc">Author Attribution &amp; Verification</span>
                </div>
                <div class="vsc-seal-item">
                    <span class="vsc-seal-badge">OPEN ACCESS</span>
                    <span class="vsc-seal-desc">CC-BY 4.0 Diamond Model</span>
                </div>
                <div class="vsc-seal-item">
                    <span class="vsc-seal-badge">COPE COMPLIANT</span>
                    <span class="vsc-seal-desc">Committee on Publication Ethics</span>
                </div>
                <div class="vsc-seal-item">
                    <span class="vsc-seal-badge">PKP PN</span>
                    <span class="vsc-seal-desc">Long-Term Digital Preservation</span>
                </div>
            </div>
        </section>

    </div><!-- .vsc-portal-container -->

</div><!-- .veridica-portal-root -->

<!-- ========================================================================= -->
<!-- SCOPUS / SAGE COMPREHENSIVE STYLING & INTERACTION SCRIPT                  -->
<!-- ========================================================================= -->
<style>
{literal}
:root {
    --v-navy: #003366;
    --v-navy-dark: #002244;
    --v-gold: #C9A84C;
    --v-gold-dark: #A68428;
    --v-gold-light: #F9F5EC;
    --v-slate: #1E293B;
    --v-slate-light: #F8FAFC;
    --v-border: #E2E8F0;
    --v-border-dark: #CBD5E1;
    --v-text-main: #0F172A;
    --v-text-muted: #64748B;
    --v-bg-page: #FCFAF7;
    --v-card-bg: #FFFFFF;
    --v-radius: 8px;
    --v-radius-lg: 12px;
    --v-shadow-sm: 0 1px 3px rgba(0,0,0,0.06), 0 1px 2px rgba(0,0,0,0.04);
    --v-shadow: 0 4px 6px -1px rgba(0,0,0,0.07), 0 2px 4px -1px rgba(0,0,0,0.04);
    --v-shadow-lg: 0 10px 15px -3px rgba(0,0,0,0.08), 0 4px 6px -2px rgba(0,0,0,0.04);
}

/* Full Width Breakout on Homepage */
body.pkp_page_index .pkp_structure_main,
.pkp_structure_main:has(.veridica-portal-root) {
    max-width: 100% !important;
    width: 100% !important;
    padding: 0 !important;
    margin: 0 !important;
    float: none !important;
    border: none !important;
}
body.pkp_page_index .pkp_structure_main::before,
body.pkp_page_index .pkp_structure_main::after,
.pkp_structure_main:has(.veridica-portal-root)::before,
.pkp_structure_main:has(.veridica-portal-root)::after {
    display: none !important;
    content: none !important;
}

.veridica-portal-root {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
    color: var(--v-text-main);
    background-color: #FAF8F5;
    min-height: 100vh;
    overflow-x: hidden;
}

/* ========================================================================= */
/* 1. HERO DISCOVERY SECTION                                                 */
/* ========================================================================= */
.vsc-hero-discovery {
    background: linear-gradient(180deg, #FFFFFF 0%, #F5F1EA 100%);
    border-bottom: 1px solid #E8DEC8;
    padding: 56px clamp(24px, 5vw, 48px) 48px;
    text-align: center;
    position: relative;
}

.vsc-hero-container {
    max-width: 1140px;
    margin: 0 auto;
}

.vsc-prestige-badge {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background: rgba(0, 51, 102, 0.06);
    border: 1px solid rgba(0, 51, 102, 0.15);
    color: var(--v-navy);
    font-size: 11px;
    font-weight: 700;
    letter-spacing: 0.12em;
    padding: 6px 16px;
    border-radius: 50px;
    margin-bottom: 20px;
    text-transform: uppercase;
}

.vsc-badge-dot {
    width: 7px;
    height: 7px;
    background: var(--v-gold);
    border-radius: 50%;
    display: inline-block;
}

.vsc-badge-issn {
    background: var(--v-navy);
    color: #FFFFFF;
    font-size: 10px;
    font-weight: 600;
    padding: 2px 8px;
    border-radius: 10px;
    margin-left: 4px;
}

.vsc-hero-title {
    font-family: 'Cormorant Garamond', 'Lora', Georgia, serif;
    font-size: 3.2rem;
    font-weight: 700;
    color: #18233C;
    line-height: 1.15;
    margin: 0 0 16px;
    letter-spacing: -0.01em;
}

.veridica-portal-root .vsc-hero-tagline,
.vsc-hero-discovery .vsc-hero-tagline,
.vsc-hero-tagline {
    font-size: 1.15rem !important;
    color: #5C5248 !important;
    max-width: 760px !important;
    margin-left: auto !important;
    margin-right: auto !important;
    margin-top: 0 !important;
    margin-bottom: 36px !important;
    line-height: 1.6 !important;
    text-align: center !important;
    display: block !important;
}

/* ========================================================================= */
/* SCOPUS SEARCH HUB                                                         */
/* ========================================================================= */
.vsc-search-hub {
    background: #FFFFFF;
    border: 1px solid #E2D9C8;
    border-radius: 12px;
    box-shadow: 0 12px 32px rgba(44, 36, 29, 0.08);
    padding: 16px 20px;
    text-align: left;
    max-width: 960px;
    margin: 0 auto;
}

.vsc-search-tabs {
    display: flex;
    gap: 8px;
    border-bottom: 1px solid #ECE4D4;
    padding-bottom: 12px;
    margin-bottom: 16px;
}

.vsc-search-tab {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 8px 16px;
    border-radius: 6px;
    border: none;
    background: transparent;
    font-size: 13.5px;
    font-weight: 600;
    color: #64748B;
    cursor: pointer;
    transition: all 0.15s ease;
}

.vsc-search-tab:hover {
    color: var(--v-navy);
    background: rgba(0, 51, 102, 0.04);
}

.vsc-search-tab.active {
    background: var(--v-navy);
    color: #FFFFFF;
}

.vsc-search-input-wrap {
    display: flex;
    align-items: center;
    border: 2px solid #D6C9A8;
    border-radius: 8px;
    overflow: hidden;
    background: #FFFFFF;
    transition: border-color 0.2s ease, box-shadow 0.2s ease;
}

.vsc-search-input-wrap:focus-within {
    border-color: var(--v-navy);
    box-shadow: 0 0 0 3px rgba(0, 51, 102, 0.12);
}

.vsc-search-field-select-wrap {
    background: #F8F5EE;
    border-right: 1px solid #E2D9C8;
}

.vsc-field-select {
    border: none;
    background: transparent;
    padding: 14px 14px;
    font-size: 13px;
    font-weight: 600;
    color: #2C241D;
    cursor: pointer;
    outline: none;
}

.vsc-search-input-inner {
    display: flex;
    align-items: center;
    flex: 1;
    padding: 0 14px;
    gap: 10px;
}

.vsc-search-input {
    border: none;
    outline: none;
    width: 100%;
    font-size: 15px;
    color: #1E293B;
    padding: 14px 0;
    background: transparent;
}

.vsc-search-btn {
    background: var(--v-navy);
    color: #FFFFFF;
    border: none;
    padding: 14px 28px;
    font-size: 14.5px;
    font-weight: 700;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 6px;
    transition: background 0.15s ease;
}

.vsc-search-btn:hover {
    background: #002244;
}

.vsc-search-subbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 14px;
    font-size: 12.5px;
    color: #64748B;
    flex-wrap: wrap;
    gap: 12px;
}

.vsc-quick-tags {
    display: flex;
    align-items: center;
    gap: 6px;
    flex-wrap: wrap;
}

.vsc-quick-label {
    font-weight: 600;
    color: #475569;
}

.vsc-tag-pill {
    background: #F1ECE1;
    border: 1px solid #E0D5BE;
    color: #2C241D;
    font-size: 11.5px;
    font-weight: 500;
    padding: 3px 10px;
    border-radius: 4px;
    cursor: pointer;
    transition: all 0.15s ease;
}

.vsc-tag-pill:hover {
    background: var(--v-navy);
    color: #FFFFFF;
    border-color: var(--v-navy);
}

.vsc-adv-link {
    color: var(--v-navy);
    font-weight: 600;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 4px;
}

.vsc-adv-link:hover {
    text-decoration: underline;
    color: var(--v-gold-dark);
}

/* ========================================================================= */
/* 2. RESEARCH METRICS RIBBON                                                */
/* ========================================================================= */
.vsc-metrics-ribbon {
    background: #FFFFFF;
    border-bottom: 1px solid #E8DEC8;
    padding: 24px clamp(24px, 5vw, 48px);
    box-shadow: 0 2px 10px rgba(44, 36, 29, 0.04);
}

.vsc-ribbon-grid {
    max-width: 1200px;
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
    align-items: center;
    text-align: center;
    flex-wrap: wrap;
    gap: 16px;
}

.vsc-ribbon-stat {
    flex: 1;
    min-width: 140px;
}

.vsc-ribbon-val {
    font-family: 'Cormorant Garamond', 'Lora', Georgia, serif;
    font-size: clamp(1.6rem, 2.2vw, 2.1rem);
    font-weight: 700;
    color: var(--v-navy);
    line-height: 1.15;
    margin-bottom: 4px;
}

.vsc-ribbon-val.vsc-gold {
    color: #B38622;
}

.vsc-unit {
    font-size: 1.1rem;
    font-weight: 600;
    font-family: 'Inter', sans-serif;
}

.vsc-ribbon-label {
    font-size: 13px;
    font-weight: 700;
    color: #1E293B;
    margin-bottom: 2px;
}

.vsc-ribbon-sub {
    font-size: 11px;
    color: #64748B;
}

.vsc-ribbon-divider {
    width: 1px;
    height: 48px;
    background: #E8DEC8;
}

/* ========================================================================= */
/* 3. PORTAL CONTAINER & SECTIONS                                            */
/* ========================================================================= */
.vsc-portal-container {
    max-width: 1220px;
    margin: 0 auto;
    padding: 48px clamp(24px, 5vw, 48px) 64px;
}

.vsc-section-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    margin-bottom: 24px;
    border-bottom: 2px solid #E8DEC8;
    padding-bottom: 12px;
}

.vsc-section-eyebrow {
    font-size: 11.5px;
    font-weight: 700;
    letter-spacing: 0.1em;
    color: #B38622;
    text-transform: uppercase;
    display: block;
    margin-bottom: 4px;
}

.vsc-section-title {
    font-family: 'Cormorant Garamond', 'Lora', Georgia, serif;
    font-size: 2rem;
    font-weight: 700;
    color: #18233C;
    margin: 0;
}

.vsc-header-link {
    font-size: 13.5px;
    font-weight: 600;
    color: var(--v-navy);
    text-decoration: none;
}

.vsc-header-link:hover {
    text-decoration: underline;
}

/* About Snippet (When Journal Description is Configured) */
.vsc-about-snippet {
    background: #FFFFFF;
    border: 1px solid #E2D9C8;
    border-radius: var(--v-radius-lg);
    padding: 28px 32px;
    margin-bottom: 44px;
    box-shadow: var(--v-shadow-sm);
}

.vsc-about-snippet-inner {
    max-width: 900px;
}

.vsc-about-snippet-text {
    font-size: 15px;
    color: #475569;
    line-height: 1.7;
}

/* ========================================================================= */
/* CURRENT ISSUE & SPOTLIGHT CARD (SCOPUS CARD STYLE)                        */
/* ========================================================================= */
.vsc-issue-section {
    margin-bottom: 56px;
}

.vsc-spotlight-card {
    background: #FFFFFF;
    border: 1px solid #D6C9A8;
    border-left: 5px solid var(--v-gold);
    border-radius: var(--v-radius-lg);
    padding: 32px;
    box-shadow: var(--v-shadow);
    margin-bottom: 32px;
    transition: box-shadow 0.2s ease;
}

.vsc-spotlight-card:hover {
    box-shadow: var(--v-shadow-lg);
}

.vsc-spotlight-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 16px;
    flex-wrap: wrap;
    gap: 8px;
}

.vsc-spotlight-badges {
    display: flex;
    align-items: center;
    gap: 8px;
    flex-wrap: wrap;
}

.vsc-badge-oa {
    background: rgba(179, 134, 34, 0.12);
    color: #8C6614;
    font-size: 11px;
    font-weight: 700;
    padding: 4px 10px;
    border-radius: 4px;
    display: inline-flex;
    align-items: center;
    gap: 4px;
    border: 1px solid rgba(179, 134, 34, 0.25);
}

.vsc-badge-type {
    background: rgba(0, 51, 102, 0.08);
    color: var(--v-navy);
    font-size: 11px;
    font-weight: 700;
    padding: 4px 10px;
    border-radius: 4px;
}

.vsc-badge-license {
    background: #F1ECE1;
    color: #475569;
    font-size: 11px;
    font-weight: 600;
    padding: 4px 8px;
    border-radius: 4px;
}

.vsc-doi-tag {
    font-size: 12px;
    font-family: monospace;
    color: #64748B;
    background: #F8FAFC;
    padding: 4px 8px;
    border-radius: 4px;
    border: 1px solid #E2E8F0;
}

.vsc-spotlight-title {
    font-family: 'Cormorant Garamond', 'Lora', Georgia, serif;
    font-size: 1.85rem;
    font-weight: 700;
    margin: 0 0 12px;
    line-height: 1.25;
}

.vsc-spotlight-title a {
    color: #18233C;
    text-decoration: none;
    transition: color 0.15s ease;
}

.vsc-spotlight-title a:hover {
    color: var(--v-navy);
    text-decoration: underline;
}

.vsc-spotlight-authors {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 13.5px;
    color: #475569;
    margin-bottom: 16px;
    flex-wrap: wrap;
}

.vsc-author {
    font-weight: 600;
    color: #1E293B;
    display: inline-flex;
    align-items: center;
    gap: 4px;
}

.vsc-orcid-badge {
    background: #A6CE39;
    color: #FFFFFF;
    font-size: 9px;
    font-weight: 800;
    padding: 1px 4px;
    border-radius: 3px;
    display: inline-block;
}

.vsc-author-sep {
    color: #CBD5E1;
}

.vsc-affiliation {
    color: #64748B;
    font-style: italic;
    font-size: 12.5px;
}

.vsc-spotlight-abstract {
    font-size: 14.5px;
    color: #334155;
    line-height: 1.65;
    margin: 0 0 24px;
}

.vsc-spotlight-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-top: 1px solid #EFEAE0;
    padding-top: 16px;
    flex-wrap: wrap;
    gap: 16px;
}

.vsc-spotlight-metrics {
    display: flex;
    gap: 12px;
    flex-wrap: wrap;
}

.vsc-metric-pill {
    background: #F8F5EE;
    color: #475569;
    font-size: 12px;
    font-weight: 600;
    padding: 6px 12px;
    border-radius: 4px;
    border: 1px solid #E2D9C8;
    display: inline-flex;
    align-items: center;
    gap: 6px;
}

.vsc-spotlight-actions {
    display: flex;
    gap: 10px;
}

.vsc-btn-primary-sm, .vsc-btn-outline-sm {
    padding: 9px 18px;
    border-radius: 6px;
    font-size: 13.5px;
    font-weight: 600;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 6px;
    transition: all 0.15s ease;
}

.vsc-btn-primary-sm {
    background: var(--v-navy);
    color: #FFFFFF;
}

.vsc-btn-primary-sm:hover {
    background: #002244;
}

.vsc-btn-outline-sm {
    background: transparent;
    color: var(--v-navy);
    border: 1px solid var(--v-navy);
}

.vsc-btn-outline-sm:hover {
    background: rgba(0, 51, 102, 0.06);
}

.vsc-toc-wrapper {
    margin-top: 24px;
}

.vsc-toc-heading {
    font-family: 'Lora', Georgia, serif;
    font-size: 18px;
    font-weight: 700;
    color: #18233C;
    margin: 0 0 16px;
    padding-bottom: 8px;
    border-bottom: 1px solid #E2D9C8;
}

/* ========================================================================= */
/* 4. AUTHOR & REVIEWER SPLIT GATEWAYS (SAGE STYLE)                          */
/* ========================================================================= */
.vsc-gateways-section {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 24px;
    margin-bottom: 56px;
}

.vsc-gateway-card {
    border-radius: var(--v-radius-lg);
    padding: 36px;
    box-shadow: var(--v-shadow);
    border: 1px solid #E0D5C1;
    position: relative;
    overflow: hidden;
}

.vsc-gateway-author {
    background: linear-gradient(135deg, #FFFFFF 0%, #FBF7EE 100%);
    border-top: 4px solid var(--v-gold);
}

.vsc-gateway-reviewer {
    background: linear-gradient(135deg, #FFFFFF 0%, #EEF4F9 100%);
    border-top: 4px solid var(--v-navy);
}

.vsc-gateway-badge {
    font-size: 11px;
    font-weight: 700;
    letter-spacing: 0.1em;
    text-transform: uppercase;
    display: block;
    margin-bottom: 8px;
    color: #64748B;
}

.vsc-gateway-title {
    font-family: 'Cormorant Garamond', 'Lora', Georgia, serif;
    font-size: 1.85rem;
    font-weight: 700;
    color: #18233C;
    margin: 0 0 12px;
}

.vsc-gateway-desc {
    font-size: 14px;
    color: #475569;
    line-height: 1.6;
    margin: 0 0 20px;
}

.vsc-gateway-perks {
    list-style: none;
    padding: 0;
    margin: 0 0 28px;
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.vsc-gateway-perks li {
    font-size: 13.5px;
    color: #334155;
    display: flex;
    align-items: center;
    gap: 10px;
}

.vsc-gateway-actions {
    display: flex;
    align-items: center;
    gap: 16px;
    flex-wrap: wrap;
}

.vsc-btn-gold {
    background: #C9A84C;
    color: #002244;
    padding: 12px 24px;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 700;
    text-decoration: none;
    box-shadow: 0 4px 12px rgba(201, 168, 76, 0.3);
    transition: all 0.15s ease;
}

.vsc-btn-gold:hover {
    background: #B38622;
    color: #FFFFFF;
    transform: translateY(-2px);
}

.vsc-btn-navy {
    background: var(--v-navy);
    color: #FFFFFF;
    padding: 12px 24px;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 700;
    text-decoration: none;
    box-shadow: 0 4px 12px rgba(0, 51, 102, 0.25);
    transition: all 0.15s ease;
}

.vsc-btn-navy:hover {
    background: #002244;
    transform: translateY(-2px);
}

.vsc-gateway-link {
    font-size: 13px;
    font-weight: 600;
    color: #475569;
    text-decoration: underline;
}

.vsc-gateway-link:hover {
    color: var(--v-navy);
}

/* ========================================================================= */
/* 5. INDEXING SEALS BAR                                                     */
/* ========================================================================= */
.vsc-indexing-seals-section {
    background: #FFFFFF;
    border: 1px solid #E2D9C8;
    border-radius: var(--v-radius-lg);
    padding: 24px 32px;
    text-align: center;
}

.vsc-seals-header {
    margin-bottom: 16px;
}

.vsc-seals-title {
    font-size: 11px;
    font-weight: 700;
    letter-spacing: 0.14em;
    color: #64748B;
}

.vsc-seals-row {
    display: flex;
    justify-content: space-around;
    align-items: center;
    flex-wrap: wrap;
    gap: 20px;
}

.vsc-seal-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 4px;
}

.vsc-seal-badge {
    font-family: 'Cinzel', serif, Georgia;
    font-size: 15px;
    font-weight: 700;
    color: var(--v-navy);
    letter-spacing: 0.08em;
}

.vsc-seal-desc {
    font-size: 11px;
    color: #64748B;
}

/* Responsive Breakpoints */
@media (max-width: 1024px) {
    .vsc-disciplines-grid {
        grid-template-columns: repeat(2, 1fr);
    }
    .vsc-gateways-section {
        grid-template-columns: 1fr;
    }
}

@media (max-width: 768px) {
    .vsc-hero-title {
        font-size: 2.2rem;
    }
    .vsc-ribbon-grid {
        flex-direction: column;
        gap: 16px;
    }
    .vsc-ribbon-divider {
        display: none;
    }
    .vsc-search-input-wrap {
        flex-direction: column;
        align-items: stretch;
    }
    .vsc-search-field-select-wrap {
        border-right: none;
        border-bottom: 1px solid #E2D9C8;
    }
    .vsc-search-btn {
        width: 100%;
        justify-content: center;
    }
    .vsc-spotlight-footer {
        flex-direction: column;
        align-items: flex-start;
    }
    .vsc-spotlight-actions {
        width: 100%;
        justify-content: space-between;
    }
}
{/literal}
</style>

<!-- Interactive Scripts for Scopus Tab Switching & Trending Tag Filters -->
<script>
{literal}
document.addEventListener('DOMContentLoaded', function() {
    var searchTabs = document.querySelectorAll('.vsc-search-tab');
    var queryInput = document.getElementById('vsc-query-input');
    var fieldSelect = document.getElementById('vsc-field-select');
    var tagPills = document.querySelectorAll('.vsc-tag-pill');
    var searchForm = document.getElementById('vsc-search-form');

    function updateInputName() {
        var mode = fieldSelect.value;
        if (mode === 'authors') {
            queryInput.name = 'authors';
        } else if (mode === 'title') {
            queryInput.name = 'title';
        } else if (mode === 'abstract') {
            queryInput.name = 'abstract';
        } else {
            queryInput.name = 'query';
        }
    }

    fieldSelect.addEventListener('change', updateInputName);
    searchForm.addEventListener('submit', updateInputName);

    // Scopus Tab Mode Switching
    searchTabs.forEach(function(tab) {
        tab.addEventListener('click', function() {
            searchTabs.forEach(function(t) {
                t.classList.remove('active');
                t.setAttribute('aria-selected', 'false');
            });
            tab.classList.add('active');
            tab.setAttribute('aria-selected', 'true');

            var mode = tab.getAttribute('data-mode');
            if (mode === 'authors') {
                fieldSelect.value = 'authors';
                queryInput.placeholder = 'Search by researcher name or 16-digit ORCID iD...';
            } else if (mode === 'topics') {
                fieldSelect.value = 'all';
                queryInput.placeholder = 'Search by research topic, keywords, or title...';
            } else {
                fieldSelect.value = 'all';
                queryInput.placeholder = 'Enter keywords, article title, DOI, or abstract...';
            }
            updateInputName();
            queryInput.focus();
        });
    });

    // Tag pills click -> populate and search
    tagPills.forEach(function(pill) {
        pill.addEventListener('click', function() {
            var q = pill.getAttribute('data-query');
            queryInput.value = q;
            fieldSelect.value = 'all';
            updateInputName();
            searchForm.submit();
        });
    });
});
{/literal}
</script>

{include file="frontend/components/footer.tpl"}
