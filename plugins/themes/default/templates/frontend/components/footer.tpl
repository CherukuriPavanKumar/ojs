{**
 * templates/frontend/components/footer.tpl
 * Overridden by Veridica Custom Theme for a mega footer layout
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

<div class="pkp_structure_footer_wrapper" role="contentinfo">
	<a id="pkp_content_footer"></a>

	<div class="veridica-mega-footer">
		<div class="v-footer-col">
			<h4>About Veridica</h4>
			<p>Veridica is a leading open-access publisher committed to the rapid dissemination of high-quality peer-reviewed research across multiple disciplines.</p>
			<div class="v-social-icons">
				<a href="#"><i class="fab fa-twitter"></i></a>
				<a href="#"><i class="fab fa-linkedin"></i></a>
				<a href="#"><i class="fab fa-facebook"></i></a>
			</div>
		</div>

		<div class="v-footer-col">
			<h4>Quick Links</h4>
			<ul>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about"}">About the Journal</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="submissions"}">Author Guidelines</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive"}">Past Issues</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="contact"}">Contact Us</a></li>
			</ul>
		</div>

		<div class="v-footer-col">
			<h4>Policies & Ethics</h4>
			<ul>
				<li><a href="#">Publication Ethics</a></li>
				<li><a href="#">Peer Review Process</a></li>
				<li><a href="#">Open Access Policy</a></li>
				<li><a href="#">Privacy Policy</a></li>
			</ul>
		</div>
	</div>

	<div class="pkp_structure_footer">
		{if $pageFooter}
			<div class="pkp_footer_content">
				{$pageFooter}
			</div>
		{/if}
		<p>&copy; {$smarty.now|date_format:"%Y"} Veridica Publishing Group. All rights reserved.</p>
	</div>
</div><!-- pkp_structure_footer_wrapper -->

</div><!-- pkp_structure_page -->

{load_script context="frontend"}

{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
</html>
