{**
 * templates/frontend/components/footer.tpl
 * Upgraded Veridica Academic Footer with Indexing Trust Seals, 4-Column Directory, and Diamond Open Access Notice
 *}

	</div><!-- pkp_structure_main -->

	{* Sidebars *}
	{if empty($isFullWidth)}
		{capture assign="sidebarCode"}{call_hook name="Templates::Common::Sidebar"}{/capture}
		{if $sidebarCode}
			<div class="pkp_structure_sidebar left" role="complementary">
				{$sidebarCode}
			</div><!-- pkp_sidebar.left -->
		{/if}
	{/if}
</div><!-- pkp_structure_content -->

<footer class="pkp_structure_footer_wrapper veridica-global-footer" role="contentinfo">
	<a id="pkp_content_footer"></a>

	<!-- Top Indexing & Trust Seals Bar -->
	<div class="v-footer-trust-strip">
		<div class="v-footer-trust-inner">
			<span class="v-trust-title"><i class="fas fa-certificate"></i> SCHOLARLY STANDARDS &amp; INFRASTRUCTURE</span>
			<div class="v-trust-badges">
				<div class="v-seal-badge"><i class="fas fa-fingerprint"></i> CROSSREF <span>Member</span></div>
				<div class="v-seal-badge"><i class="fab fa-orcid"></i> ORCID <span>Integrated</span></div>
				<div class="v-seal-badge"><i class="fas fa-lock-open"></i> OPEN ACCESS <span>Diamond</span></div>
				<div class="v-seal-badge"><i class="fas fa-balance-scale"></i> COPE <span>Integrity</span></div>
				<div class="v-seal-badge"><i class="fas fa-archive"></i> PKP PN <span>Preservation</span></div>
			</div>
		</div>
	</div>

	<!-- 4-Column Main Footer Directory -->
	<div class="veridica-mega-footer">
		<div class="v-footer-col v-footer-col-brand">
			<div class="v-footer-brand-header">
				<div class="v-brand-icon"><i class="fas fa-scroll"></i></div>
				<div>
					<h3>{$currentJournal->getLocalizedName()|escape}</h3>
					<div class="v-brand-tagline">SCHOLARLY PEER-REVIEWED PUBLICATION</div>
				</div>
			</div>
			<p>An international Diamond Open Access journal dedicated to the rigorous, rapid dissemination of peer-reviewed research across frontier science and scholarly inquiry.</p>
			
			{if $currentJournal->getData('onlineIssn') || $currentJournal->getData('printIssn')}
			<div class="v-issn-pill-group">
				{if $currentJournal->getData('onlineIssn')}<span class="v-issn-pill"><i class="fas fa-barcode"></i> e-ISSN: <strong>{$currentJournal->getData('onlineIssn')|escape}</strong></span>{/if}
				{if $currentJournal->getData('printIssn')}<span class="v-issn-pill"><i class="fas fa-book-open"></i> p-ISSN: <strong>{$currentJournal->getData('printIssn')|escape}</strong></span>{/if}
			</div>
			{/if}

			<div class="v-social-icons">
				<a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="submissions"}" aria-label="Submissions" title="Submissions"><i class="fas fa-upload"></i></a>
				<a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="current"}" aria-label="Current Issue" title="Current Issue"><i class="fas fa-book"></i></a>
				<a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="search"}" aria-label="Search" title="Search"><i class="fas fa-search"></i></a>
				<a href="https://orcid.org" target="_blank" rel="noopener" aria-label="ORCID" title="ORCID"><i class="fab fa-orcid"></i></a>
			</div>
		</div>

		<div class="v-footer-col">
			<h4>Discover &amp; Explore</h4>
			<ul>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="current"}"><i class="fas fa-chevron-right"></i> Current Issue</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive"}"><i class="fas fa-chevron-right"></i> Past Issue Archive</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="search"}"><i class="fas fa-chevron-right"></i> Advanced Search Console</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="submissions"}"><i class="fas fa-chevron-right"></i> Submit Manuscript</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about"}"><i class="fas fa-chevron-right"></i> About {$currentJournal->getLocalizedName()|escape}</a></li>
			</ul>
		</div>

		<div class="v-footer-col">
			<h4>Authors &amp; Reviewers</h4>
			<ul>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="submissions"}"><i class="fas fa-chevron-right"></i> Author Guidelines</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="submission"}"><i class="fas fa-chevron-right"></i> Submit Manuscript Online</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="editorialPolicies"}"><i class="fas fa-chevron-right"></i> Peer Review Process</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="openAccess"}"><i class="fas fa-chevron-right"></i> Diamond Open Access Policy</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="ethics"}"><i class="fas fa-chevron-right"></i> COPE Publication Ethics</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="reviewerGuidelines"}"><i class="fas fa-chevron-right"></i> Reviewer Recognition &amp; Guide</a></li>
			</ul>
		</div>

		<div class="v-footer-col">
			<h4>Governance &amp; Contact</h4>
			<ul>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about"}"><i class="fas fa-chevron-right"></i> About the Journal</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="editorialMasthead"}"><i class="fas fa-chevron-right"></i> Editorial Board &amp; Masthead</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="privacy"}"><i class="fas fa-chevron-right"></i> Privacy &amp; Data Governance</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="contact"}"><i class="fas fa-chevron-right"></i> Contact Editorial Office</a></li>
			</ul>
			<div class="v-footer-contact-snippet">
				{if $currentJournal->getData('contactEmail')}
				<div class="v-contact-line"><i class="fas fa-envelope"></i> <span>{$currentJournal->getData('contactEmail')|escape}</span></div>
				{/if}
				<div class="v-contact-line"><i class="fas fa-clock"></i> <span>Response time: &le; 48 hrs</span></div>
			</div>
		</div>
	</div>

	<!-- Bottom Copyright and Diamond Open Access Notice -->
	<div class="pkp_structure_footer">
		<div class="v-footer-bottom-inner">
			<div class="v-footer-copy">
				&copy; {$smarty.now|date_format:"%Y"} <strong>Veridica Publishing Group</strong>. All rights reserved.
				<span class="v-footer-sep">&bull;</span>
				<span>Powered by Open Journal Systems 3.5</span>
			</div>
			<div class="v-footer-license-note">
				<i class="fab fa-creative-commons"></i> <i class="fab fa-creative-commons-by"></i>
				<span>All articles licensed under <a href="https://creativecommons.org/licenses/by/4.0/" target="_blank" rel="noopener">Creative Commons Attribution 4.0 International (CC BY 4.0)</a>. Diamond Open Access: No Author APCs.</span>
			</div>
			<a href="#top" class="v-back-to-top" title="Back to top" aria-label="Back to top">
				<i class="fas fa-arrow-up"></i>
			</a>
		</div>
	</div>
</footer><!-- .pkp_structure_footer_wrapper -->

</div><!-- pkp_structure_page -->

{load_script context="frontend"}

{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
</html>
