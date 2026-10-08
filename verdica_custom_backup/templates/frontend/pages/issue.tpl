{**
 * Veridica single issue page override.
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$issueIdentification}

</div><!-- pkp_structure_main -->
</div><!-- pkp_structure_content -->

<div class="veridica-issue-page">
    {if !$issue}
        <div class="veridica-page-header veridica-issue-header">
            <div class="v-container">
                {include file="frontend/components/breadcrumbs_issue.tpl" currentTitleKey="current.noCurrentIssue"}
                <h1>{translate key="current.noCurrentIssue"}</h1>
            </div>
        </div>
        <div class="veridica-container veridica-issue-empty">
            {include file="frontend/components/notification.tpl" type="warning" messageKey="current.noCurrentIssueDesc"}
        </div>
    {else}
        <div class="veridica-page-header veridica-issue-header">
            <div class="v-container">
                {include file="frontend/components/breadcrumbs_issue.tpl" currentTitle=$issueIdentification}
                <span class="veridica-hero-badge">TABLE OF CONTENTS</span>
                <h1>{$issueIdentification|escape}</h1>
                <p class="v-lead">Read the latest peer-reviewed research from Veridica.</p>
            </div>
        </div>
        <main class="veridica-container veridica-issue-content">
            {include file="frontend/objects/issue_toc.tpl"}
        </main>
    {/if}
</div>

<div class="pkp_structure_content">
    <div class="pkp_structure_main" role="main">

{include file="frontend/components/footer.tpl"}
