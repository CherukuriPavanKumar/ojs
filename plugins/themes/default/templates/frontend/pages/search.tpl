{**
 * Veridica search page override.
 *}
{include file="frontend/components/header.tpl" pageTitle="common.search"}

</div><!-- pkp_structure_main -->
</div><!-- pkp_structure_content -->

<div class="veridica-search-page">
    <div class="veridica-page-header veridica-search-header">
        <div class="v-container">
            {include file="frontend/components/breadcrumbs.tpl" currentTitleKey="common.search"}
            <span class="veridica-hero-badge">RESEARCH INDEX</span>
            <h1>{translate key="common.search"}</h1>
            <p class="v-lead">Find articles, authors, and published research across the Veridica archive.</p>
        </div>
    </div>

    <main class="veridica-container veridica-search-content">
        {if !$heading}{assign var="heading" value="h2"}{/if}
        {capture name="searchFormUrl"}{url escape=false}{/capture}
        {assign var=formUrlParameters value=[]}
        {$smarty.capture.searchFormUrl|parse_url:$smarty.const.PHP_URL_QUERY|default:""|parse_str:$formUrlParameters}
        <form class="cmp_form veridica-search-form" method="get" action="{$smarty.capture.searchFormUrl|strtok:"?"|escape}" role="form">
            {foreach from=$formUrlParameters key=paramKey item=paramValue}
                <input type="hidden" name="{$paramKey|escape}" value="{$paramValue|escape}"/>
            {/foreach}
            <div class="search_input">
                <label class="pkp_screen_reader" for="query">{translate key="search.searchFor"}</label>
                {block name=searchQuery}
                    <input type="search" id="query" name="query" value="{$query|escape}" class="query" placeholder="{translate|escape key="common.search"}">
                {/block}
                <button class="submit veridica-search-submit" type="submit" aria-label="{translate|escape key="common.search"}"><i class="fas fa-search" aria-hidden="true"></i></button>
            </div>
            <fieldset class="search_advanced">
                <legend>{translate key="search.advancedFilters"}</legend>
                <div class="date_range">
                    <div class="from">
                        {capture assign="dateFromLegend"}{translate key="search.dateFrom"}{/capture}
                        {html_select_date_a11y legend=$dateFromLegend prefix="dateFrom" time=$dateFrom start_year=$yearStart end_year=$yearEnd}
                    </div>
                    <div class="to">
                        {capture assign="dateFromTo"}{translate key="search.dateTo"}{/capture}
                        {html_select_date_a11y legend=$dateFromTo prefix="dateTo" time=$dateTo start_year=$yearStart end_year=$yearEnd}
                    </div>
                </div>
                <div class="author">
                    <label class="label" for="authors">{translate key="search.author"}</label>
                    {block name=searchAuthors}<input type="text" id="authors" name="authors" value="{$authors|escape}">{/block}
                    {if $searchableContexts}
                        <label class="label label_contexts" for="searchJournal">{translate key="search.journal"}</label>
                        <select name="searchJournal" id="searchJournal"><option></option>{foreach from=$searchableContexts item="searchableContext"}<option value="{$searchableContext->id}" {if $searchJournal == $searchableContext->id}selected{/if}>{$searchableContext->name|escape}</option>{/foreach}</select>
                    {/if}
                </div>
                {call_hook name="Templates::Search::SearchResults::AdditionalFilters"}
            </fieldset>
        </form>

        {call_hook name="Templates::Search::SearchResults::PreResults"}
        <h2 class="pkp_screen_reader">{translate key="search.searchResults"}</h2>
        {if !$results->wasEmpty()}
            <div class="pkp_screen_reader" role="status">{if $results->count > 1}{translate key="search.searchResults.foundPlural" count=$results->count}{else}{translate key="search.searchResults.foundSingle"}{/if}</div>
        {/if}
        <ul class="search_results veridica-search-results">
            {iterate from=results item=result}<li>{include file="frontend/objects/article_summary.tpl" article=$result.publishedSubmission journal=$result.journal showDatePublished=true hideGalleys=true heading="h3"}</li>{/iterate}
        </ul>
        {if $results->wasEmpty()}
            <span role="status">{if $error}{include file="frontend/components/notification.tpl" type="error" message=$error|escape}{else}{include file="frontend/components/notification.tpl" type="notice" messageKey="search.noResults"}{/if}</span>
        {else}
            <div class="cmp_pagination">{page_info iterator=$results}{page_links anchor="results" iterator=$results name="search" query=$query searchJournal=$searchJournal authors=$authors dateFromMonth=$dateFromMonth dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateToMonth=$dateToMonth dateToDay=$dateToDay dateToYear=$dateToYear}</div>
        {/if}
        {block name=searchSyntaxInstructions}{/block}
    </main>
</div>

<div class="pkp_structure_content">
    <div class="pkp_structure_main" role="main">

{include file="frontend/components/footer.tpl"}
