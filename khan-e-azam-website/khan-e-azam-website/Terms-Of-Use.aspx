<%@ Page Title="Terms of Use" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Terms-Of-Use.aspx.cs" Inherits="khan_e_azam_website.Terms_Of_Use" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<div style="height: 80px;"></div>

	<section class="content-inner bg-primary text-center" style="padding-top:60px; padding-bottom:60px;">
		<div class="container">
			<h1 class="font-lobster text-white mb-0" style="font-size:clamp(2rem,5vw,3rem);">Terms of Use</h1>
		</div>
	</section>

	<section class="content-inner kea-stars" style="background-color:var(--dark-1);">
		<div class="container" style="max-width:860px;">
			<p class="text-bodycolor mb-5">Last updated: <%: DateTime.Now.ToString("MMMM yyyy") %></p>

			<h4 class="mb-3 text-black2">Using This Website</h4>
			<p class="text-bodycolor leading-[26px] mb-6">This website is provided by Khan-e-Azam Restaurant for browsing our menu, placing orders, tracking existing orders, and making reservation enquiries. By using this site, you agree to provide accurate information when placing an order or contacting us.</p>

			<h4 class="mb-3 text-black2">Orders &amp; Availability</h4>
			<p class="text-bodycolor leading-[26px] mb-6">Menu items, prices, and availability are subject to change without notice. Placing an order through this website constitutes a request that we will confirm; we reserve the right to decline or adjust an order (for example, due to item unavailability) and will contact you directly if that happens.</p>

			<h4 class="mb-3 text-black2">Reservations</h4>
			<p class="text-bodycolor leading-[26px] mb-6">Reservation requests made via WhatsApp or phone are confirmed directly by our team and are subject to table availability.</p>

			<h4 class="mb-3 text-black2">Intellectual Property</h4>
			<p class="text-bodycolor leading-[26px] mb-6">All content on this website &mdash; including our logo, photography, and menu descriptions &mdash; belongs to Khan-e-Azam Restaurant and may not be reproduced without permission.</p>

			<h4 class="mb-3 text-black2">Contact Us</h4>
			<p class="text-bodycolor leading-[26px] mb-0">Questions about these Terms can be sent to <a href="mailto:khaneazamrestaurant@gmail.com" class="text-primary">khaneazamrestaurant@gmail.com</a> or <a href="tel:03089406789" class="text-primary">0308-9406789</a>.</p>
		</div>
	</section>
</asp:Content>
