<%@ Page Title="Reservation" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Reservation.aspx.cs" Inherits="khan_e_azam_website.Reservation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<style>
		/* p-[40px] / w-[80px] / h-[80px] have no generated CSS in the precompiled style.css
		   (no source template ever used those exact bracket values), so they silently no-op —
		   using real classes here instead of relying on more arbitrary-value fallback rules. */
		.reserve-cta-card {
			display: flex; flex-direction: column; align-items: center; justify-content: center;
			padding: 45px 40px; text-align: center; transition: transform .3s ease, box-shadow .3s ease;
		}
		.reserve-cta-card:hover { transform: translateY(-6px); box-shadow: 0 20px 45px rgba(0,0,0,0.12); }
		.reserve-icon-circle { width: 80px; height: 80px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 22px; flex-shrink: 0; }
		@keyframes reservePulse { 0% { transform: scale(1); opacity: 1; } 50% { transform: scale(1.15); opacity: .75; } 100% { transform: scale(1); opacity: 1; } }
		.reserve-pulse { animation: reservePulse 1.8s ease-in-out infinite; }
		@media (prefers-reduced-motion: reduce) { .reserve-pulse { animation: none; } }
		/* Fallback rules for Tailwind arbitrary-value classes not present in the precompiled style.css */
		.rounded-\[20px\] { border-radius: 20px; }
	</style>

	<div style="height: 80px;"></div>

	<!-- Hero -->
	<section class="relative w-full flex items-center justify-center overflow-hidden" style="height: 60vh; min-height: 420px;">
		<img src="assets/images/banner/bnr3.jpg" class="absolute w-full h-full object-cover z-0" style="top:0; left:0;" alt="" />
		<div class="absolute w-full h-full z-0" style="top:0; left:0; background:rgba(16,12,8,0.65);"></div>
		<div class="relative z-[1] text-center px-6">
			<span class="text-secondary font-medium uppercase block mb-4" style="letter-spacing:0.2em;">Book Your Table</span>
			<h1 class="font-lobster text-white mb-4" style="font-size:clamp(2rem,5vw,3.5rem);">Make Your Reservation<br />at <span class="text-primary">Khan-e-Azam</span></h1>
			<p class="text-white mx-auto" style="max-width:600px; opacity:.85;">Luxury dining with rooftop &mdash; reserve ahead and we'll have your table ready.</p>
		</div>
	</section>
	<!-- Hero -->

	<!-- Reserve CTAs -->
	<section class="content-inner-1 lg:py-[90px] py-[50px] kea-stars" style="background-color:var(--dark-1);">
		<div class="container">
			<div class="row justify-center">
				<div class="lg:w-5/12 sm:w-1/2 w-full px-[15px] mb-[25px]">
					<a href="https://wa.me/923089406789?text=Hi%2C%20I%27d%20like%20to%20make%20a%20reservation%20at%20Khan-e-Azam." target="_blank" rel="noopener"
						class="reserve-cta-card rounded-[20px] h-full" style="background:var(--dark-card); border:1px solid var(--dark-border);">
						<span class="reserve-icon-circle" style="background:#25D36622;">
							<i class="fab fa-whatsapp reserve-pulse" style="font-size:38px; color:#25D366;"></i>
						</span>
						<h4 class="mb-2 text-black2">Reserve on WhatsApp</h4>
						<p class="text-bodycolor mb-0">Message us your date, time &amp; party size &mdash; we'll confirm right away.</p>
					</a>
				</div>
				<div class="lg:w-5/12 sm:w-1/2 w-full px-[15px] mb-[25px]">
					<a href="tel:03089406789" class="reserve-cta-card rounded-[20px] h-full" style="background:var(--dark-card); border:1px solid var(--dark-border);">
						<span class="reserve-icon-circle" style="background:var(--rgba-primary-1);">
							<i class="fa-solid fa-phone-volume" style="font-size:34px; color:var(--primary);"></i>
						</span>
						<h4 class="mb-2 text-black2">Call to Reserve</h4>
						<p class="text-bodycolor mb-0">Speak with our team directly at <span class="text-primary font-semibold">0308-9406789</span>.</p>
					</a>
				</div>
			</div>
		</div>
	</section>
	<!-- Reserve CTAs -->

	<!-- Table Reservation Form -->
	<section class="content-inner-1 sp-y kea-stars" style="background-color:var(--dark-2);">
		<div class="container">
			<div class="mx-auto" style="max-width:720px;">
				<div class="rounded-lg" style="background:var(--dark-card); border:1px solid var(--dark-border); padding:40px;">
					<div class="text-center mb-8">
						<span class="font-medium text-base text-primary block mb-3 uppercase" style="letter-spacing:0.2em;">Prefer to Book Online?</span>
						<h2 class="font-lobster text-black2 lg:text-[36px] sm:text-4xl text-3xl mb-2">Table Reservation</h2>
						<p class="text-bodycolor mb-0">Fill in your details and we'll confirm your table by phone.</p>
					</div>

					<asp:Label ID="lblReserveMsg" runat="server" Visible="false" CssClass="kea-reserve-alert alert"></asp:Label>

					<div class="row">
						<div class="lg:w-1/2 w-full px-[15px] mb-[20px]">
							<label class="block mb-2" style="color:var(--muted-text); font-size:13px; font-weight:600;">Full Name</label>
							<asp:TextBox ID="txtReserveName" runat="server" CssClass="kea-reserve-input" placeholder="Enter your full name" MaxLength="100" />
						</div>
						<div class="lg:w-1/2 w-full px-[15px] mb-[20px]">
							<label class="block mb-2" style="color:var(--muted-text); font-size:13px; font-weight:600;">Contact Number</label>
							<asp:TextBox ID="txtReservePhone" runat="server" CssClass="kea-reserve-input" placeholder="03xx-xxxxxxx" MaxLength="20" />
						</div>
						<div class="lg:w-1/3 w-full px-[15px] mb-[20px]">
							<label class="block mb-2" style="color:var(--muted-text); font-size:13px; font-weight:600;">Date</label>
							<asp:TextBox ID="txtReserveDate" runat="server" CssClass="kea-reserve-input" TextMode="Date" />
						</div>
						<div class="lg:w-1/3 w-full px-[15px] mb-[20px]">
							<label class="block mb-2" style="color:var(--muted-text); font-size:13px; font-weight:600;">Time</label>
							<asp:TextBox ID="txtReserveTime" runat="server" CssClass="kea-reserve-input" TextMode="Time" />
						</div>
						<div class="lg:w-1/3 w-full px-[15px] mb-[20px]">
							<label class="block mb-2" style="color:var(--muted-text); font-size:13px; font-weight:600;">Party Size</label>
							<asp:DropDownList ID="ddlReservePartySize" runat="server" CssClass="kea-reserve-input">
								<asp:ListItem Text="1 Guest" Value="1" />
								<asp:ListItem Text="2 Guests" Value="2" />
								<asp:ListItem Text="3 Guests" Value="3" />
								<asp:ListItem Text="4 Guests" Value="4" Selected="True" />
								<asp:ListItem Text="5 Guests" Value="5" />
								<asp:ListItem Text="6 Guests" Value="6" />
								<asp:ListItem Text="7 Guests" Value="7" />
								<asp:ListItem Text="8+ Guests" Value="8" />
							</asp:DropDownList>
						</div>
						<div class="w-full px-[15px] mb-[20px]">
							<label class="block mb-2" style="color:var(--muted-text); font-size:13px; font-weight:600;">Special Requests <span style="color:var(--muted-text); font-weight:400;">(optional)</span></label>
							<asp:TextBox ID="txtReserveNotes" runat="server" CssClass="kea-reserve-input kea-reserve-textarea" TextMode="MultiLine" Rows="3" placeholder="Birthday setup, window seating, dietary needs, etc." MaxLength="500" />
						</div>
					</div>

					<asp:Button ID="btnReserveSubmit" runat="server" Text="Request Reservation" CssClass="btn btn-primary btn-hover-1 w-full" style="width:100%; height:52px; font-size:16px;" OnClick="btnReserveSubmit_Click" />
				</div>
			</div>
		</div>

		<style>
			.kea-reserve-input {
				height: 50px; padding: 10px 20px; width: 100%; font-size: 15px;
				border: 1px solid var(--dark-border); border-radius: 6px; outline: none;
				background: var(--dark-1); color: var(--light-text); transition: border-color .3s;
			}
			.kea-reserve-input:focus { border-color: var(--primary); }
			.kea-reserve-input::placeholder { color: var(--muted-text); }
			.kea-reserve-textarea { height: auto; resize: none; }
			.kea-reserve-alert {
				display: block; width: 100%; box-sizing: border-box;
				margin-bottom: 24px; border-radius: 8px; font-size: 14px; line-height: 1.6;
				word-wrap: break-word; overflow-wrap: break-word;
			}
		</style>
	</section>
	<!-- Table Reservation Form -->

	<!-- Opening Hours + Location -->
	<section class="content-inner-1 lg:pb-[100px] pb-[50px] kea-stars" style="background-color:var(--dark-1);">
		<div class="container">
			<div class="row items-stretch">
				<div class="lg:w-5/12 w-full px-[15px] mb-[25px] lg:mb-0">
					<div class="bg-black2 rounded-[20px] p-[35px] sm:p-[45px] h-full">
						<h4 class="text-white flex items-center mb-5"><i class="flaticon-clock text-primary text-2xl mr-3"></i>Opening Hours</h4>
						<ul class="text-[#DCDCDC]">
							<li class="flex justify-between py-2 border-b border-[#ffffff1a]"><span>Monday &ndash; Friday</span><span class="text-white">2:00 PM &ndash; 2:00 AM</span></li>
							<li class="flex justify-between py-2 border-b border-[#ffffff1a]"><span>Saturday</span><span class="text-white">2:00 PM &ndash; 2:00 AM</span></li>
							<li class="flex justify-between py-2"><span>Sunday</span><span class="text-white">2:00 PM &ndash; 2:00 AM</span></li>
						</ul>
						<hr style="border-color:#ffffff1a; margin:25px 0;" />
						<p class="text-[#C4C4C4] text-sm mb-0">For parties of 8 or more, please reserve at least 24 hours in advance.</p>
					</div>
				</div>
				<div class="lg:w-7/12 w-full px-[15px]">
					<div class="rounded-[20px] overflow-hidden h-full" style="min-height:320px;">
						<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3401.3789452336694!2d74.30138237532392!3d31.51261384752538!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x391904a081525043%3A0xe54d31846b95764d!2s880%20N%20Poonch%20Rd%2C%20Samanabad%20Town%2C%20Lahore%2C%20Punjab%2054000%2C%20Pakistan!5e0!3m2!1sen!2s!4v1719570000000!5m2!1sen!2s"
							width="100%" height="100%" style="border:0; min-height:320px;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade" title="Khan-e-Azam location map"></iframe>
					</div>
				</div>
			</div>
			<div class="w-full text-center mt-[40px]">
				<a href="Pages/Menu.aspx" class="btn btn-md btn-primary btn-hover-1"><span>Browse Our Menu First</span></a>
			</div>
		</div>
	</section>
	<!-- Opening Hours + Location -->

</asp:Content>
