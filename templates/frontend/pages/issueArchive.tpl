{**
 * templates/frontend/pages/issueArchive.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display a list of recent issues.
 *
 * @uses $issues Array Collection of issues to display
 * @uses $prevPage int The previous page number
 * @uses $nextPage int The next page number
 * @uses $showingStart int The number of the first item on this page
 * @uses $showingEnd int The number of the last item on this page
 * @uses $total int Count of all published monographs
 *}
{capture assign="pageTitle"}
	{if $prevPage}
		{translate key="archive.archivesPageNumber" pageNumber=$prevPage+1}
	{else}
		{translate key="archive.archives"}
	{/if}
{/capture}
{include file="frontend/components/header.tpl" pageTitleTranslated=$pageTitle}

<div class="page page_issue_archive veridica-inner-page">
	{include file="frontend/components/breadcrumbs.tpl" currentTitle=$pageTitle}

	<!-- Hero Header -->
	<div class="v-inner-hero">
		<div class="v-hero-badge"><i class="fas fa-archive"></i> JOURNAL ARCHIVE</div>
		<h1 class="v-hero-title">Volume &amp; Issue Archive</h1>
		<p class="v-hero-subtitle">
			Comprehensive repository of all published volumes, issues, and peer-reviewed articles. Every manuscript is freely accessible under Diamond Open Access (CC BY 4.0) with persistent Crossref DOIs.
		</p>
	</div>

	<!-- Trust & Indexing Ribbon -->
	<div class="v-archive-stats-bar">
		<div class="v-arch-stat-item">
			<i class="fas fa-layer-group"></i>
			<span><strong>Continuous Publication</strong> &bull; Quarterly Volumes</span>
		</div>
		<div class="v-arch-stat-item">
			<i class="fas fa-lock-open"></i>
			<span><strong>100% Diamond Open Access</strong> &bull; Free Worldwide</span>
		</div>
		<div class="v-arch-stat-item">
			<i class="fas fa-fingerprint"></i>
			<span><strong>Crossref DOIs</strong> &bull; Permanent Preservation</span>
		</div>
	</div>

	{* No issues have been published *}
	{if empty($issues)}
		<div class="v-no-galley-notice" style="padding: 36px 20px; margin: 32px 0;">
			<i class="fas fa-hourglass-start" style="font-size: 32px; color: var(--v-accent); margin-bottom: 12px; display: inline-block;"></i>
			<h3 style="font-family: 'Plus Jakarta Sans', sans-serif; font-size: 18px; color: var(--v-navy); margin: 0 0 6px 0;">{translate key="current.noCurrentIssueDesc"}</h3>
			<p style="color: #64748B; margin: 0;">Manuscripts currently accepted are undergoing production typesetting.</p>
		</div>

	{* List issues *}
	{else}
		<ul class="issues_archive">
			{foreach from=$issues item="issue"}
				<li>
					{include file="frontend/objects/issue_summary.tpl"}
				</li>
			{/foreach}
		</ul>

		{* Pagination *}
		{if $prevPage > 1}
			{capture assign=prevUrl}{url router=PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive" path=$prevPage}{/capture}
		{elseif $prevPage === 1}
			{capture assign=prevUrl}{url router=PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive"}{/capture}
		{/if}
		{if $nextPage}
			{capture assign=nextUrl}{url router=PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive" path=$nextPage}{/capture}
		{/if}
		{include
			file="frontend/components/pagination.tpl"
			prevUrl=$prevUrl
			nextUrl=$nextUrl
			showingStart=$showingStart
			showingEnd=$showingEnd
			total=$total
		}
	{/if}
</div>

{include file="frontend/components/footer.tpl"}
