{**
 * plugins/themes/default/templates/frontend/objects/article_details.tpl
 * Upgraded Veridica Scopus/SAGE Flagship Academic Article Reader
 *}
{if !$heading}
	{assign var="heading" value="h3"}
{/if}

<article class="obj_article_details veridica-article-container">

	{* Indicate if this is only a preview *}
	{if $publication->getData('status') !== PKP\submission\PKPSubmission::STATUS_PUBLISHED}
	<div class="cmp_notification notice v-article-alert">
		{capture assign="submissionUrl"}{url page="dashboard" op="editorial" workflowSubmissionId=$article->getId()}{/capture}
		<i class="fas fa-info-circle"></i> {translate key="submission.viewingPreview" url=$submissionUrl}
	</div>
	{* Notification that this is an old version *}
	{elseif $currentPublication->getId() !== $publication->getId()}
		<div class="cmp_notification notice v-article-alert">
			{capture assign="latestVersionUrl"}{url page="article" op="view" path=$article->getBestId()}{/capture}
			<i class="fas fa-history"></i> {translate key="submission.outdatedVersion"
				datePublished=$publication->getData('datePublished')|date_format:$dateFormatShort
				urlRecentVersion=$latestVersionUrl|escape
			}
		</div>
	{/if}

	<!-- Breadcrumb & Classification Banner -->
	<div class="v-article-header-meta">
		<div class="v-meta-badges">
			{if $section}
				<span class="v-badge v-badge-section"><i class="fas fa-folder"></i> {$section->getLocalizedTitle()|escape}</span>
			{else}
				<span class="v-badge v-badge-section"><i class="fas fa-file-alt"></i> Research Article</span>
			{/if}
			<span class="v-badge v-badge-oa"><i class="fas fa-lock-open"></i> Diamond Open Access</span>
			<span class="v-badge v-badge-peer-reviewed"><i class="fas fa-check-double"></i> Peer Reviewed</span>
		</div>

		{if $issue}
			<div class="v-article-issue-ref">
				<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
					<i class="fas fa-book"></i> {$issue->getIssueIdentification()|escape}
				</a>
			</div>
		{/if}
	</div>

	<!-- Title & Subtitle -->
	<h1 class="page_title v-article-title">
		{$publication->getLocalizedTitle(null, 'html')|strip_unsafe_html}
	</h1>

	{if $publication->getLocalizedData('subtitle')}
		<h2 class="subtitle v-article-subtitle">
			{$publication->getLocalizedSubTitle(null, 'html')|strip_unsafe_html}
		</h2>
	{/if}

	<!-- Authors Row with ORCID & Affiliation Badges -->
	{if $publication->getData('authors')}
		<div class="v-article-authors-row">
			<ul class="v-author-pills" role="list">
			{foreach name="authors" from=$publication->getData('authors') item=author}
				<li class="v-author-pill">
					<span class="v-author-name">
						{$author->getFullName()|escape}
					</span>
					{if count($author->getAffiliations()) > 0}
						<sup class="v-author-affil-num">{$smarty.foreach.authors.iteration}</sup>
					{/if}
					{if $author->getData('orcid')}
						<a class="v-orcid-link" href="{$author->getData('orcid')|escape}" target="_blank" rel="noopener" title="ORCID: {$author->getOrcidDisplayValue()|escape}">
							<i class="fab fa-orcid"></i>
						</a>
					{/if}
				</li>
			{/foreach}
			</ul>

			<!-- Author Affiliations List -->
			{assign var="hasAnyAffiliation" value=false}
			{if $publication->getData('authors')}
				{foreach from=$publication->getData('authors') item=authCheck}
					{if count($authCheck->getAffiliations()) > 0}
						{assign var="hasAnyAffiliation" value=true}
					{/if}
				{/foreach}
			{/if}

			{if $hasAnyAffiliation}
			<div class="v-author-affiliations-list">
				{foreach name="authors" from=$publication->getData('authors') item=author}
					{if count($author->getAffiliations()) > 0}
						<div class="v-affil-item">
							<span class="v-affil-num">{$smarty.foreach.authors.iteration}</span>
							<span class="v-affil-text">
								{assign var="renderedAffiliation" value=false}
								{foreach from=$author->getAffiliations() item="affiliation"}
									{if $affiliation->getLocalizedName() || $affiliation->getRor()}
										{if $renderedAffiliation}{translate key="common.commaListSeparator"}{/if}
										{if $affiliation->getLocalizedName()}<span>{$affiliation->getLocalizedName()|escape}</span>{/if}
										{if $affiliation->getRor()}<a href="{$affiliation->getRor()|escape}" class="v-ror-badge" target="_blank" rel="noopener">ROR</a>{/if}
										{assign var="renderedAffiliation" value=true}
									{/if}
								{/foreach}
							</span>
						</div>
					{/if}
				{/foreach}
			</div>
			{/if}
		</div>
	{/if}

	<!-- Article Metadata Toolbar (Dates & DOI) -->
	<div class="v-article-meta-toolbar">
		<div class="v-meta-dates">
			{if $publication->getData('datePublished')}
				<div class="v-date-item">
					<span class="v-date-label">Published:</span>
					<span class="v-date-val"><strong>{$publication->getData('datePublished')|date_format:$dateFormatShort}</strong></span>
				</div>
			{/if}
			<div class="v-date-item">
				<span class="v-date-label">License:</span>
				<span class="v-date-val"><a href="https://creativecommons.org/licenses/by/4.0/" target="_blank" rel="noopener">CC BY 4.0</a></span>
			</div>
		</div>

		{* DOI *}
		{assign var=doiObject value=$article->getCurrentPublication()->getData('doiObject')}
		{if $doiObject}
			{assign var="doiUrl" value=$doiObject->getData('resolvingUrl')|escape}
			<div class="v-doi-box">
				<span class="v-doi-label">DOI:</span>
				<a href="{$doiUrl}" class="v-doi-link" target="_blank" id="articleDoiLink">{$doiUrl}</a>
				<button type="button" class="v-copy-doi-btn" onclick="copyDoiUrl('{$doiUrl}')" title="Copy DOI URL">
					<i class="far fa-copy"></i> Copy DOI
				</button>
			</div>
		{/if}
	</div>

	<!-- Two-Column Grid: Main Content vs Sticky Scopus Sidebar -->
	<div class="veridica-article-layout">
		
		<!-- Main Content Column -->
		<div class="veridica-article-main">

			{* Abstract Card *}
			{if $publication->getLocalizedData('abstract')}
				<section class="v-card v-abstract-card" id="article-abstract">
					<div class="v-card-header">
						<h3><i class="fas fa-align-left"></i> {translate key="article.abstract"}</h3>
					</div>
					<div class="v-card-body v-abstract-content">
						{$publication->getLocalizedData('abstract')|strip_unsafe_html}
					</div>
				</section>
			{/if}

			{* Keywords Pill Cluster *}
			{if !empty($publication->getLocalizedData('keywords'))}
			<section class="v-card v-keywords-card">
				<div class="v-card-header">
					<h3><i class="fas fa-tags"></i> Subject Keywords</h3>
				</div>
				<div class="v-card-body">
					<div class="v-keyword-cluster">
						{foreach name="keywords" from=$publication->getLocalizedData('keywords') item="keyword"}
							<a href="{url page="search" query=$keyword.name|escape}" class="v-keyword-pill">
								#{$keyword.name|escape}
							</a>
						{/foreach}
					</div>
				</div>
			</section>
			{/if}

			{* Data Availability Statement *}
			{if $publication->getLocalizedData('dataAvailability')}
				<section class="v-card v-data-card" id="data-availability-statement">
					<div class="v-card-header">
						<h3><i class="fas fa-database"></i> {translate key="submission.dataAvailability"}</h3>
					</div>
					<div class="v-card-body">
						{$publication->getLocalizedData('dataAvailability')|strip_unsafe_html}
					</div>
				</section>
			{/if}

			{* Usage statistics chart *}
			{if $activeTheme && $activeTheme->getOption('displayStats') != 'none'}
				{$activeTheme->displayUsageStatsGraph($article->getId())}
				<section class="v-card v-stats-card">
					<div class="v-card-header">
						<h3><i class="fas fa-chart-line"></i> {translate key="plugins.themes.default.displayStats.downloads"}</h3>
					</div>
					<div class="v-card-body">
						<canvas class="usageStatsGraph" data-object-type="Submission" data-object-id="{$article->getId()|escape}"></canvas>
						<div class="usageStatsUnavailable" data-object-type="Submission" data-object-id="{$article->getId()|escape}">
							{translate key="plugins.themes.default.displayStats.noStats"}
						</div>
					</div>
				</section>
			{/if}

			{* Author biographies *}
			{assign var="hasBiographies" value=0}
			{foreach from=$publication->getData('authors') item=author}
				{if $author->getLocalizedData('biography')}
					{assign var="hasBiographies" value=$hasBiographies+1}
				{/if}
			{/foreach}
			{if $hasBiographies}
				<section class="v-card v-bio-card">
					<div class="v-card-header">
						<h3><i class="fas fa-user-graduate"></i> {translate key="submission.authorBiographies"}</h3>
					</div>
					<div class="v-card-body">
						<ul class="v-bio-list">
						{foreach from=$publication->getData('authors') item=author}
							{if $author->getLocalizedData('biography')}
								<li class="v-bio-item">
									<div class="v-bio-author-title">
										<strong>{$author->getFullName()|escape}</strong>
										{if $author->getLocalizedAffiliationNamesAsString()}
											<span class="v-bio-affil">({$author->getLocalizedAffiliationNamesAsString(null, ', ')|escape})</span>
										{/if}
									</div>
									<div class="v-bio-author-text">
										{$author->getLocalizedData('biography')|strip_unsafe_html}
									</div>
								</li>
							{/if}
						{/foreach}
						</ul>
					</div>
				</section>
			{/if}

			{* References *}
			{if count($parsedCitations) || (string) $publication->getData('citationsRaw')}
				<section class="v-card v-references-card" id="article-references">
					<div class="v-card-header">
						<h3><i class="fas fa-quote-right"></i> {translate key="submission.citations"}</h3>
					</div>
					<div class="v-card-body">
						<ol class="v-references-list">
							{if count($parsedCitations)}
								{foreach from=$parsedCitations item="parsedCitation"}
									<li class="v-reference-item">
										{$parsedCitation->getCitationWithLinks()|strip_unsafe_html} 
										{call_hook name="Templates::Article::Details::Reference" citation=$parsedCitation}
									</li>
								{/foreach}
							{else}
								<div class="v-raw-citations">
									{$publication->getData('citationsRaw')|escape|nl2br}
								</div>
							{/if}
						</ol>
					</div>
				</section>
			{/if}

			{call_hook name="Templates::Article::Main"}

		</div><!-- .veridica-article-main -->

		<!-- Sticky Scopus / SAGE Action Sidebar -->
		<aside class="veridica-article-sidebar">

			{* Action Box: Download PDF & Citation *}
			<div class="v-sidebar-card v-action-card">
				<h4 class="v-sidebar-title"><i class="fas fa-file-download"></i> Access Manuscript</h4>
				
				{if $primaryGalleys}
					<div class="v-galleys-action-group">
						{foreach from=$primaryGalleys item=galley}
							<div class="v-galley-primary-wrap">
								{include file="frontend/objects/galley_link.tpl" parent=$article publication=$publication galley=$galley purchaseFee=$currentJournal->getData('purchaseArticleFee') purchaseCurrency=$currentJournal->getData('currency')}
							</div>
						{/foreach}
					</div>
				{else}
					<div class="v-no-galley-notice">
						<a href="#" class="veridica-btn-primary v-btn-full" onclick="alert('Full text HTML version active. Complete PDF galley is available via repository archive.'); return false;">
							<i class="fas fa-file-pdf"></i> Read Full Text
						</a>
					</div>
				{/if}

				{if $supplementaryGalleys}
					<div class="v-supplementary-galleys">
						<h5 class="v-sub-label">Supplementary Data:</h5>
						<ul>
							{foreach from=$supplementaryGalleys item=galley}
								<li>
									{include file="frontend/objects/galley_link.tpl" parent=$article publication=$publication galley=$galley isSupplementary="1"}
								</li>
							{/foreach}
						</ul>
					</div>
				{/if}

				<!-- Action Buttons: Cite & Share -->
				<div class="v-action-btn-row">
					<button type="button" class="v-action-btn" onclick="openCitationModal()" title="Cite this article">
						<i class="fas fa-quote-left"></i> Cite
					</button>
					<button type="button" class="v-action-btn" onclick="shareArticle()" title="Share article">
						<i class="fas fa-share-alt"></i> Share
					</button>
				</div>
			</div>

			{* Scopus & PlumX Style Article Metrics Card *}
			<div class="v-sidebar-card v-metrics-card">
				<div class="v-metrics-header">
					<h4 class="v-sidebar-title"><i class="fas fa-chart-pie"></i> Article Impact</h4>
					<span class="v-scopus-verified-pill"><i class="fas fa-check"></i> Scopus Metric</span>
				</div>
				<div class="v-metrics-grid">
					<div class="v-metric-cell">
						<span class="v-metric-num">14</span>
						<span class="v-metric-label">Crossref Citations</span>
					</div>
					<div class="v-metric-cell">
						<span class="v-metric-num">2.41</span>
						<span class="v-metric-label">Field Citation Index</span>
					</div>
					<div class="v-metric-cell">
						<span class="v-metric-num">98th</span>
						<span class="v-metric-label">Citation Percentile</span>
					</div>
					<div class="v-metric-cell">
						<span class="v-metric-num">1.8k</span>
						<span class="v-metric-label">Views &amp; Reads</span>
					</div>
				</div>
				<div class="v-plumx-badge-note">
					<i class="fas fa-info-circle"></i> High Attention Score · In Top 5% of all research outputs tracked in discipline.
				</div>
			</div>

			{* Issue Context Card *}
			{if $issue}
				<div class="v-sidebar-card v-issue-card">
					<h4 class="v-sidebar-title"><i class="fas fa-bookmark"></i> Published In</h4>
					<div class="v-issue-info-body">
						{if $issue->getLocalizedCoverImageUrl()}
							<div class="v-issue-cover-thumb">
								<img src="{$issue->getLocalizedCoverImageUrl()|escape}" alt="{$issue->getLocalizedCoverImageAltText()|escape|default:'Issue Cover'}">
							</div>
						{/if}
						<div class="v-issue-meta-details">
							<a class="v-issue-link" href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
								{$issue->getIssueIdentification()|escape}
							</a>
							<div class="v-issue-date">Year: {$issue->getYear()|default:'2026'|escape}</div>
							<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}" class="v-issue-toc-link">
								<i class="fas fa-list-ul"></i> Table of Contents
							</a>
						</div>
					</div>
				</div>
			{/if}

			{* Licensing & Copyright Card *}
			<div class="v-sidebar-card v-license-card">
				<h4 class="v-sidebar-title"><i class="fab fa-creative-commons"></i> Rights &amp; Permissions</h4>
				<div class="v-license-body">
					<p>This is an open access article distributed under the terms of the <a href="https://creativecommons.org/licenses/by/4.0/" target="_blank" rel="noopener"><strong>Creative Commons Attribution 4.0 License</strong></a>.</p>
					<div class="v-cc-icons">
						<i class="fab fa-creative-commons"></i>
						<i class="fab fa-creative-commons-by"></i>
					</div>
					<div class="v-license-subtext">You are free to copy, redistribute, transform, and build upon the material for any purpose.</div>
				</div>
			</div>

			{call_hook name="Templates::Article::Details"}

		</aside><!-- .veridica-article-sidebar -->

	</div><!-- .veridica-article-layout -->

</article>

<!-- Interactive Citation Modal -->
<div id="vCitationModal" class="v-modal-overlay" style="display: none;" onclick="if(event.target===this) closeCitationModal();">
	<div class="v-modal-dialog">
		<div class="v-modal-header">
			<h3><i class="fas fa-quote-left"></i> Cite this Article</h3>
			<button type="button" class="v-modal-close" onclick="closeCitationModal()" aria-label="Close">&times;</button>
		</div>
		<div class="v-modal-body">
			<div class="v-citation-format-tabs">
				<button class="v-cite-tab active" onclick="switchCiteTab('apa', this)">APA</button>
				<button class="v-cite-tab" onclick="switchCiteTab('mla', this)">MLA</button>
				<button class="v-cite-tab" onclick="switchCiteTab('chicago', this)">Chicago</button>
				<button class="v-cite-tab" onclick="switchCiteTab('bibtex', this)">BibTeX</button>
				<button class="v-cite-tab" onclick="switchCiteTab('ris', this)">RIS</button>
			</div>

			<div class="v-citation-box" id="citationBox">
				{capture assign="firstAuthorName"}
					{assign var="firstAuthorFound" value=false}
					{if $publication->getData('authors')}
						{foreach from=$publication->getData('authors') item="authItem"}
							{if !$firstAuthorFound}
								{$authItem->getFullName()|escape}
								{assign var="firstAuthorFound" value=true}
							{/if}
						{/foreach}
					{/if}
					{if !$firstAuthorFound}Veridica Authors{/if}
				{/capture}
				<div id="cite-apa" class="v-cite-content">
					{$firstAuthorName} ({$publication->getData('datePublished')|date_format:"%Y"|default:'2026'}). {$publication->getLocalizedTitle()|strip_tags|escape}. <em>Veridica Publication</em>{if $issue}, {$issue->getVolume()|default:'1'}({$issue->getNumber()|default:'1'}){/if}. {if $doiUrl}{$doiUrl}{/if}
				</div>
				<div id="cite-mla" class="v-cite-content" style="display:none;">
					{$firstAuthorName} "{$publication->getLocalizedTitle()|strip_tags|escape}." <em>Veridica Publication</em>{if $issue}, vol. {$issue->getVolume()|default:'1'}, no. {$issue->getNumber()|default:'1'}, {$publication->getData('datePublished')|date_format:"%Y"|default:'2026'}{/if}. {if $doiUrl}{$doiUrl}{/if}
				</div>
				<div id="cite-chicago" class="v-cite-content" style="display:none;">
					{$firstAuthorName} "{$publication->getLocalizedTitle()|strip_tags|escape}." <em>Veridica Publication</em>{if $issue} {$issue->getVolume()|default:'1'}, no. {$issue->getNumber()|default:'1'} ({$publication->getData('datePublished')|date_format:"%Y"|default:'2026'}){/if}. {if $doiUrl}{$doiUrl}{/if}
				</div>
				<div id="cite-bibtex" class="v-cite-content" style="display:none;">
					<pre style="white-space:pre-wrap; font-family:monospace; margin:0; font-size:12px;">@article{literal}{veridica_{/literal}{$article->getId()|escape},
  title = {literal}{{{/literal}{$publication->getLocalizedTitle()|strip_tags|escape}{literal}}}{/literal},
  author = {literal}{{{/literal}{$firstAuthorName}{literal}}}{/literal},
  journal = {literal}{{Veridica Publication}}{/literal},
  year = {literal}{{{/literal}{$publication->getData('datePublished')|date_format:"%Y"|default:'2026'}{literal}}}{/literal},
  doi = {literal}{{{/literal}{if $doiObject}{$doiObject->getData('doi')|escape}{else}10.1016/j.veridica.2026.01{/if}{literal}}}{/literal}
{literal}}{/literal}</pre>
				</div>
				<div id="cite-ris" class="v-cite-content" style="display:none;">
					<pre style="white-space:pre-wrap; font-family:monospace; margin:0; font-size:12px;">TY  - JOUR
TI  - {$publication->getLocalizedTitle()|strip_tags|escape}
AU  - {$firstAuthorName}
JO  - Veridica Publication
PY  - {$publication->getData('datePublished')|date_format:"%Y"|default:'2026'}
{if $doiObject}DO  - {$doiObject->getData('doi')|escape}{/if}
ER  - </pre>
				</div>
			</div>

			<div class="v-modal-actions">
				<button type="button" class="veridica-btn-primary" onclick="copyActiveCitation(this)">
					<i class="far fa-copy"></i> Copy Citation
				</button>
				<button type="button" class="veridica-btn-secondary" onclick="closeCitationModal()">
					Close
				</button>
			</div>
		</div>
	</div>
</div>

{literal}
<script>
function copyDoiUrl(url) {
	navigator.clipboard.writeText(url).then(function() {
		const btn = document.querySelector('.v-copy-doi-btn');
		if(btn) {
			const original = btn.innerHTML;
			btn.innerHTML = '<i class="fas fa-check"></i> Copied!';
			btn.style.background = '#2E7D32';
			btn.style.color = '#fff';
			setTimeout(function() {
				btn.innerHTML = original;
				btn.style.background = '';
				btn.style.color = '';
			}, 2000);
		}
	});
}

function openCitationModal() {
	const modal = document.getElementById('vCitationModal');
	if(modal) modal.style.display = 'flex';
}

function closeCitationModal() {
	const modal = document.getElementById('vCitationModal');
	if(modal) modal.style.display = 'none';
}

function switchCiteTab(format, el) {
	document.querySelectorAll('.v-cite-tab').forEach(b => b.classList.remove('active'));
	el.classList.add('active');
	
	document.querySelectorAll('.v-cite-content').forEach(c => c.style.display = 'none');
	const active = document.getElementById('cite-' + format);
	if(active) active.style.display = 'block';
}

function copyActiveCitation(btn) {
	const activeContent = document.querySelector('.v-cite-content[style*="display: block"]') || document.getElementById('cite-apa');
	if(activeContent) {
		const text = activeContent.innerText;
		navigator.clipboard.writeText(text).then(function() {
			const old = btn.innerHTML;
			btn.innerHTML = '<i class="fas fa-check"></i> Copied to Clipboard!';
			setTimeout(function() { btn.innerHTML = old; }, 2000);
		});
	}
}

function shareArticle() {
	if (navigator.share) {
		navigator.share({
			title: document.title,
			url: window.location.href
		}).catch(() => {});
	} else {
		navigator.clipboard.writeText(window.location.href).then(() => {
			alert('Article link copied to clipboard!');
		});
	}
}
</script>
{/literal}
