{**
 * templates/frontend/pages/submissions.tpl
 * Overridden by Veridica Custom Theme for a premium Author Guidelines page
 *}
{include file="frontend/components/header.tpl" pageTitle="about.submissions"}

	</div><!-- pkp_structure_main -->
</div><!-- pkp_structure_content -->

<div class="veridica-page-header">
    <div class="v-container">
        <h1>{translate key="about.submissions"}</h1>
        <p class="v-lead">Guidelines, requirements, and policies for authors submitting manuscripts to Veridica.</p>
    </div>
</div>

<div class="veridica-page-content v-container">
    
    {* Modern Action Bar for Logging In / Submitting *}
    <div class="v-submission-action-bar">
        <div class="v-action-text">
            <h3>Ready to submit your research?</h3>
            <p>Ensure you have reviewed all author guidelines and the submission checklist below before starting your submission.</p>
        </div>
        <div class="v-action-buttons">
            {if $sections|@count == 0 || $currentContext->getData('disableSubmissions')}
                <div class="cmp_notification notice">{translate key="author.submit.notAccepting"}</div>
            {else}
                {if $isUserLoggedIn}
                    <a href="{url page="submission"}" class="veridica-btn-primary">{translate key="about.onlineSubmissions.newSubmission"}</a>
                    <a href="{url page="submissions"}" class="veridica-btn-secondary">{translate key="about.onlineSubmissions.viewSubmissions"}</a>
                {else}
                    <a href="{url page="login"}" class="veridica-btn-primary">{translate key="about.onlineSubmissions.login"}</a>
                    <a href="{url page="user" op="register"}" class="veridica-btn-secondary">{translate key="about.onlineSubmissions.register"}</a>
                {/if}
            {/if}
        </div>
    </div>

    <div class="v-submission-grid">
        <div class="v-submission-main">
            {if $currentContext->getLocalizedData('authorGuidelines')}
                <section class="v-content-card" id="authorGuidelines">
                    <h2>
                        {translate key="about.authorGuidelines"}
                        {include file="frontend/components/editLink.tpl" page="management" op="settings" path="workflow" anchor="submission/instructions" sectionTitleKey="about.authorGuidelines"}
                    </h2>
                    <div class="v-card-body">
                        {$currentContext->getLocalizedData('authorGuidelines')}
                    </div>
                </section>
            {/if}

            {if $submissionChecklist}
                <section class="v-content-card checklist" id="submissionChecklist">
                    <h2>
                        {translate key="about.submissionPreparationChecklist"}
                        {include file="frontend/components/editLink.tpl" page="management" op="settings" path="workflow" anchor="submission/instructions" sectionTitleKey="about.submissionPreparationChecklist"}
                    </h2>
                    <div class="v-card-body">
                        {$submissionChecklist}
                    </div>
                </section>
            {/if}
            
            {if isset($submissionChecklistAfterContent)}
                <div class="v-card-body">
                    {$submissionChecklistAfterContent}
                </div>
            {/if}
        </div>

        <aside class="v-submission-sidebar">
            {if $currentContext->getLocalizedData('copyrightNotice')}
                <div class="v-sidebar-widget">
                    <h3>
                        {translate key="about.copyrightNotice"}
                        {include file="frontend/components/editLink.tpl" page="management" op="settings" path="workflow" anchor="submission/instructions" sectionTitleKey="about.copyrightNotice"}
                    </h3>
                    <div class="widget-content">
                        {$currentContext->getLocalizedData('copyrightNotice')}
                    </div>
                </div>
            {/if}

            {if $currentContext->getLocalizedData('privacyStatement')}
                <div class="v-sidebar-widget">
                    <h3>
                        {translate key="about.privacyStatement"}
                        {include file="frontend/components/editLink.tpl" page="management" op="settings" path="website" anchor="setup/privacy" sectionTitleKey="about.privacyStatement"}
                    </h3>
                    <div class="widget-content">
                        {$currentContext->getLocalizedData('privacyStatement')}
                    </div>
                </div>
            {/if}
        </aside>
    </div>

</div><!-- .veridica-page-content -->

<div class="pkp_structure_content">
	<div class="pkp_structure_main" role="main">

{include file="frontend/components/footer.tpl"}
