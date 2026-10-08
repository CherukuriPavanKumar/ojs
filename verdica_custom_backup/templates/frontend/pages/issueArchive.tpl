{**
 * Veridica archive page override.
 *}
{capture assign="pageTitle"}
    {if $prevPage}
        {translate key="archive.archivesPageNumber" pageNumber=$prevPage+1}
    {else}
        {translate key="archive.archives"}
    {/if}
{/capture}
{include file="frontend/components/header.tpl" pageTitleTranslated=$pageTitle}

</div><!-- pkp_structure_main -->
</div><!-- pkp_structure_content -->

<section class="veridica-page-header veridica-archive-header">
    <div class="v-container">
        {include file="frontend/components/breadcrumbs.tpl" currentTitle=$pageTitle}
        <span class="veridica-hero-badge">PUBLICATION ARCHIVE</span>
        <h1>{$pageTitle|escape}</h1>
        <p class="v-lead">Explore every published volume and discover the research shaping Veridica.</p>
    </div>
</section>

<div class="pkp_structure_content">
    <div class="pkp_structure_main" role="main">
        <div class="page page_issue_archive veridica-archive-page">
            {if empty($issues)}
                <div class="veridica-empty-state">
                    <i class="fas fa-book-open" aria-hidden="true"></i>
                    <p>{translate key="current.noCurrentIssueDesc"}</p>
                </div>
            {else}
                <div class="veridica-archive-intro">
                    <h2>Browse the collection</h2>
                    <p>Published issues are listed below, with articles and full issue downloads available inside each volume.</p>
                </div>
                <ul class="issues_archive veridica-issue-grid">
                    {foreach from=$issues item="issue"}
                        <li>{include file="frontend/objects/issue_summary.tpl"}</li>
                    {/foreach}
                </ul>
                {if $prevPage > 1}
                    {capture assign=prevUrl}{url router=PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive" path=$prevPage}{/capture}
                {elseif $prevPage === 1}
                    {capture assign=prevUrl}{url router=PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive"}{/capture}
                {/if}
                {if $nextPage}
                    {capture assign=nextUrl}{url router=PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive" path=$nextPage}{/capture}
                {/if}
                {include file="frontend/components/pagination.tpl" prevUrl=$prevUrl nextUrl=$nextUrl showingStart=$showingStart showingEnd=$showingEnd total=$total}
            {/if}
        </div>
    </div>
</div>

{include file="frontend/components/footer.tpl"}
