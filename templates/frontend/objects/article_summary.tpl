{**
 * templates/frontend/objects/article_summary.tpl
 * Upgraded Veridica Scopus/SAGE Flagship Article Summary Card
 *}
{assign var=publication value=$article->getCurrentPublication()}
{assign var=articlePath value=$publication->getData('urlPath')|default:$article->getId()}
{if !$heading}
	{assign var="heading" value="h3"}
{/if}

{if (!$section.hideAuthor && $publication->getData('hideAuthor') == APP\submission\Submission::AUTHOR_TOC_DEFAULT) || $publication->getData('hideAuthor') == APP\submission\Submission::AUTHOR_TOC_SHOW}
	{assign var="showAuthor" value=true}
{/if}

<div class="obj_article_summary v-academic-card">

	{* 1. Top Scholarly Metadata Bar *}
	<div class="v-art-topbar">
		<div class="v-art-badges-group">
			<span class="v-art-pill v-pill-type">
				<i class="fas fa-file-alt"></i> {if $section.title}{$section.title|escape}{else}Research Article{/if}
			</span>
			<span class="v-art-pill v-pill-oa">
				<i class="fas fa-lock-open"></i> Diamond OA
			</span>
			{assign var=doiObject value=$publication->getData('doiObject')}
			{if $doiObject}
				<span class="v-art-pill v-pill-doi" title="DOI: {$doiObject->getData('doi')|escape}">
					<i class="fas fa-fingerprint"></i> {$doiObject->getData('doi')|escape}
				</span>
			{elseif $publication->getData('pub-id::doi')}
				<span class="v-art-pill v-pill-doi" title="DOI: {$publication->getData('pub-id::doi')|escape}">
					<i class="fas fa-fingerprint"></i> {$publication->getData('pub-id::doi')|escape}
				</span>
			{/if}
		</div>
		<div class="v-art-meta-group">
			{if $publication->getData('pages')}
				<span class="v-art-pages-tag"><i class="fas fa-book-open"></i> pp. {$publication->getData('pages')|escape}</span>
			{/if}
			{if $publication->getData('datePublished')}
				<span class="v-art-date-tag"><i class="far fa-calendar-alt"></i> {$publication->getData('datePublished')|date_format:$dateFormatShort}</span>
			{/if}
		</div>
	</div>

	{* 2. Prominent Article Title *}
	<{$heading} class="v-art-title">
		<a id="article-{$article->getId()}" {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if}>
			{$publication->getLocalizedTitle(null, 'html')|strip_unsafe_html}
			{assign var=localizedSubtitle value=$publication->getLocalizedSubtitle(null, 'html')|strip_unsafe_html}
			{if $localizedSubtitle}
				<span class="subtitle">{$localizedSubtitle}</span>
			{/if}
		</a>
	</{$heading}>

	{* 3. Authors Row with Verified ORCID Badges *}
	{if $publication->getData('authors')}
		<div class="v-art-authors-row">
			<div class="v-author-list">
				{foreach from=$publication->getData('authors') item=author name=authLoop}
					<span class="v-author-item">
						<span class="v-author-name">{$author->getFullName()|escape}</span>
						{if $author->getData('orcid')}
							<a href="{$author->getData('orcid')|escape}" target="_blank" rel="noopener" class="v-orcid-badge" title="ORCID: {$author->getOrcidDisplayValue()|escape}">
								<i class="fab fa-orcid"></i>
							</a>
						{/if}
					</span>
					{if !$smarty.foreach.authLoop.last}<span class="v-author-sep">&bull;</span>{/if}
				{/foreach}
			</div>
		</div>
	{/if}

	{* 4. Structured Abstract Preview *}
	{if $publication->getLocalizedData('abstract')}
		<div class="v-art-abstract">
			{$publication->getLocalizedData('abstract')|strip_tags|truncate:280:"...":false|escape}
		</div>
	{/if}

	{* 5. Keywords Cluster *}
	{if !empty($publication->getLocalizedData('keywords'))}
		<div class="v-art-keywords">
			{foreach name="kws" from=$publication->getLocalizedData('keywords') item="keyword"}
				{if $smarty.foreach.kws.iteration <= 5}
					<span class="v-kw-pill">#{$keyword.name|escape}</span>
				{/if}
			{/foreach}
		</div>
	{/if}

	{* 6. Bottom Action & Galleys Footer *}
	<div class="v-art-footer">
		<div class="v-art-footer-left">
			<span class="v-art-license-note"><i class="fab fa-creative-commons"></i> CC BY 4.0 &bull; Diamond Open Access</span>
		</div>
		<div class="v-art-footer-actions">
			{if !$hideGalleys && $publication->getData('galleys')}
				<ul class="v-galley-btn-group">
					{foreach from=$publication->getData('galleys') item=galley}
						{if $primaryGenreIds}
							{assign var="file" value=$galley->getFile()}
							{if !$galley->getData('urlRemote') && !($file && in_array($file->getGenreId(), $primaryGenreIds))}
								{continue}
							{/if}
						{/if}
						<li>
							{assign var="hasArticleAccess" value=$hasAccess}
							{if $currentContext->getSetting('publishingMode') == APP\journal\Journal::PUBLISHING_MODE_OPEN || $publication->getData('accessStatus') == APP\submission\Submission::ARTICLE_ACCESS_OPEN}
								{assign var="hasArticleAccess" value=1}
							{/if}
							{assign var="id" value="article-{$article->getId()}-galley-{$galley->getId()}"}
							{include file="frontend/objects/galley_link.tpl" parent=$article publication=$publication id=$id labelledBy="{$id} article-{$article->getId()}" hasAccess=$hasArticleAccess purchaseFee=$currentJournal->getData('purchaseArticleFee') purchaseCurrency=$currentJournal->getData('currency')}
						</li>
					{/foreach}
				</ul>
			{/if}
			<a class="v-art-read-btn" {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if}>
				<span>Read Article</span> <i class="fas fa-arrow-right"></i>
			</a>
		</div>
	</div>

	{call_hook name="Templates::Issue::Issue::Article"}
</div>
