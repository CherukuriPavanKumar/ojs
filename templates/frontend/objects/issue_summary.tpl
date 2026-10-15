{**
 * templates/frontend/objects/issue_summary.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief View of an Issue which displays a summary for use in lists
 *
 * @uses $issue Issue The issue
 *}
{if $issue->getShowTitle()}
{assign var=issueTitle value=$issue->getLocalizedTitle()}
{/if}
{assign var=issueSeries value=$issue->getIssueSeries()}
{assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}

<div class="obj_issue_summary v-issue-card-enhanced">

	<!-- Header Metadata Badges -->
	<div class="v-issue-card-header">
		<div class="v-issue-meta-tags">
			<span class="v-issue-vol-badge">
				<i class="fas fa-bookmark"></i> {$issueSeries|escape|default:$issue->getIssueIdentification()|escape}
			</span>
			{if $issue->getDatePublished()}
				<span class="v-issue-date-badge">
					<i class="far fa-calendar-alt"></i> Published: {$issue->getDatePublished()|date_format:$dateFormatShort}
				</span>
			{/if}
			<span class="v-issue-oa-badge">
				<i class="fas fa-lock-open"></i> Diamond OA
			</span>
		</div>
		{if $issue->getStoredPubId('doi')}
			<div class="v-issue-doi-badge">
				<i class="fas fa-fingerprint"></i> DOI: {$issue->getStoredPubId('doi')|escape}
			</div>
		{/if}
	</div>

	<div class="v-issue-card-body-row">
		{if $issueCover}
			<a class="v-issue-cover-link" href="{url op="view" path=$issue->getBestIssueId()}">
				<img src="{$issueCover|escape}" alt="{$issue->getLocalizedCoverImageAltText()|escape|default:'Issue Cover'}" class="v-issue-cover-img">
			</a>
		{/if}

		<div class="v-issue-card-main-info">
			<h2 class="v-issue-title-heading">
				<a class="title" href="{url op="view" path=$issue->getBestIssueId()}">
					{if $issueTitle}
						{$issueTitle|escape}
					{else}
						{$issueSeries|escape}
					{/if}
				</a>
			</h2>

			{if $issue->getLocalizedDescription()}
				<div class="v-issue-description-text">
					{$issue->getLocalizedDescription()|strip_unsafe_html}
				</div>
			{/if}

			<div class="v-issue-footer-actions">
				<a href="{url op="view" path=$issue->getBestIssueId()}" class="v-issue-view-btn">
					<i class="fas fa-list-ul"></i> Browse Table of Contents &rarr;
				</a>
			</div>
		</div>
	</div>

</div><!-- .obj_issue_summary -->
