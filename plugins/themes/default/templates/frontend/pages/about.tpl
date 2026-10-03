{**
 * templates/frontend/pages/about.tpl
 * Overridden by Veridica Custom Theme for a premium About page layout
 *}
{include file="frontend/components/header.tpl" pageTitle="about.aboutContext"}

<div class="veridica-page-header">
    <div class="v-container">
        <h1>{translate key="about.aboutContext"}</h1>
        <p class="v-lead">Learn more about our mission, editorial board, and publishing policies.</p>
        {include file="frontend/components/editLink.tpl" page="management" op="settings" path="context" anchor="masthead" sectionTitleKey="about.aboutContext"}
    </div>
</div>

<div class="veridica-page-content v-container">
    <div class="v-reading-column">
        {$currentContext->getLocalizedData('about')}
    </div>
</div>

{include file="frontend/components/footer.tpl"}
