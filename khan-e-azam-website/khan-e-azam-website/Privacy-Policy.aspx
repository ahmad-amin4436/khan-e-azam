<%@ Page Title="Privacy Policy" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Privacy-Policy.aspx.cs" Inherits="khan_e_azam_website.Privacy_Policy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<div style="height: 80px;"></div>

	<section class="content-inner bg-primary text-center" style="padding-top:60px; padding-bottom:60px;">
		<div class="container">
			<h1 class="font-lobster text-white mb-0" style="font-size:clamp(2rem,5vw,3rem);">Privacy Policy</h1>
		</div>
	</section>

	<section class="content-inner kea-stars" style="background-color:var(--dark-1);">
		<div class="container" style="max-width:860px;">
			<p class="text-bodycolor mb-5">Last updated: <%: DateTime.Now.ToString("MMMM yyyy") %></p>

			<h4 class="mb-3 text-black2">Information We Collect</h4>
			<p class="text-bodycolor leading-[26px] mb-6">When you place an order or make a reservation enquiry with Khan-e-Azam, we collect the information you provide directly &mdash; such as your name, phone number, delivery address, and order details. We do not require you to create an account or provide payment card details through this website.</p>

			<h4 class="mb-3 text-black2">How We Use Your Information</h4>
			<p class="text-bodycolor leading-[26px] mb-6">Your information is used solely to process and fulfil your order, respond to reservation enquiries, and improve our service. We do not sell or rent your personal information to third parties.</p>

			<h4 class="mb-3 text-black2">Cart &amp; Local Storage</h4>
			<p class="text-bodycolor leading-[26px] mb-6">Items you add to your cart are stored locally in your browser (using <code style="background:var(--dark-card); color:var(--light-text); padding:2px 6px; border-radius:4px;">localStorage</code>) so your selection is preserved between visits. This data stays on your device and is only sent to us when you complete an order.</p>

			<h4 class="mb-3 text-black2">Order Tracking</h4>
			<p class="text-bodycolor leading-[26px] mb-6">When you place an order, you receive an order reference number that can be used to check your order status. Please keep this reference private, as anyone with it can view the associated order details.</p>

			<h4 class="mb-3 text-black2">Contact Us</h4>
			<p class="text-bodycolor leading-[26px] mb-0">If you have questions about this Privacy Policy or wish to request that we delete information you've shared with us, contact us at <a href="mailto:khaneazamrestaurant@gmail.com" class="text-primary">khaneazamrestaurant@gmail.com</a> or <a href="tel:03089406789" class="text-primary">0308-9406789</a>.</p>
		</div>
	</section>
</asp:Content>
