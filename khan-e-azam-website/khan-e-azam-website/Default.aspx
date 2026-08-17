<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="khan_e_azam_website._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<style>
		/* ===== Dark premium theme (scoped to this page — about/menu/contact/etc. keep the light theme) ===== */
		:root {
			--dark-1: #100C08;   /* base section background */
			--dark-2: #17130f;   /* alternating / elevated section background */
			--dark-card: #1f1a14; /* card & panel surfaces */
			--dark-border: rgba(255,255,255,0.1);
			--light-text: #f2efe9;
			--muted-text: #b7b0a4;
		}
		body, .page-wraper { background: var(--dark-1) !important; }
		.text-black2 { color: var(--light-text) !important; }
		.text-bodycolor { color: var(--muted-text) !important; }

		/* Scoped responsive fixes for homepage (prevent horizontal overflow & shrink large hero elements) */
		@media (max-width: 992px) {
			.food-card { max-width: 100% !important; width: auto !important; }
			.food-card .target-line { display: none !important; }
			.banner-media img { max-width: 100% !important; min-width: 0 !important; width: auto !important; height: auto !important; }
			.banner-inner1 { background-position: center !important; }
		}

		/* Hero food photo: these are regular (non-cutout) photos, so frame them as a circular
		   plate rather than letting a hard rectangle float over the hero. */
		.hero-food-photo {
			aspect-ratio: 1 / 1; border-radius: 50%; object-fit: cover;
			border: 6px solid rgba(255,255,255,0.12); box-shadow: 0 25px 60px rgba(0,0,0,0.5);
			background: var(--dark-card);
		}
		@media (max-width: 600px) {
			/* reduce large hero font/spacing on small phones */
			.banner-inner1 { padding-top: 30px !important; padding-bottom: 20px !important; }
			.banner-content .title { font-size: 1.6rem !important; line-height: 1.15 !important; }
			/* ensure list items and media don't force horizontal scroll */
			.dz-media, .dz-media img, .dz-img-box3, .dz-img-box5 { min-width: 0 !important; }
			/* clamp oversized elements inside sliders */
			.target-line, .leaf { display: none !important; }
		}

		/* Additional small-screen fixes for feature lists, testimonials and blog cards */
		@media (max-width: 768px) {
			/* Feature/icon blocks */
			.icon-bx-wraper, .icon-bx-wraper .icon-bx { align-items:flex-start; }
			.icon-bx { flex:0 0 56px; min-width:56px; width:56px; height:56px; }
			.icon-content { overflow-wrap:break-word; word-break:break-word; }


			/* Blog card fixes: make date badge flow and media scale */
			.dz-card { min-height: auto !important; }
			.dz-date { position:relative !important; top:auto !important; left:auto !important; margin-bottom:8px; display:inline-block; }
			.dz-media video, .dz-media img { max-width:100% !important; height:auto !important; min-width:0 !important; }
			.dz-card .dz-info { padding-bottom:16px !important; }

			/* general safety clamp to avoid page-level horizontal scroll */
			.page-wraper, .container, body { overflow-x: hidden !important; }
		}

		/* Strong overrides for very small screens to fix blog card/date overlap */
		@media (max-width: 480px) {
			.dz-card { overflow: hidden !important; border-radius: 10px !important; margin-bottom: 16px !important; }
			.dz-card .dz-media { max-height: 160px !important; height: auto !important; min-height: 0 !important; overflow: hidden !important; }
			.dz-card .dz-media img, .dz-card .dz-media video { width: 100% !important; height: auto !important; object-fit: cover !important; min-width: 0 !important; }
			.dz-card .dz-info { padding: 12px !important; position: relative !important; z-index: 2 !important; }
			/* make date flow inside card instead of absolute */
			.dz-card .dz-date { position: static !important; transform: none !important; top: auto !important; left: auto !important; display: inline-block !important; margin-bottom: 8px !important; background: rgba(255,165,0,0.95) !important; color: #fff !important; padding: 6px 10px !important; border-radius: 6px !important; font-size: 12px !important; font-weight: 700 !important; }
			/* ensure meta row doesn't wrap awkwardly */
			.dz-card .dz-info .dz-meta, .dz-card .dz-info .dz-head { display: flex !important; flex-direction: column !important; gap: 6px !important; }
			/* clip any decorative overlays that might intrude */
			.target-line, .leaf, .dz-card .quote { display: none !important; }
		}

		/* Mobile: keep the paired Savor-the-Flavors images from stretching into tall narrow strips */
		@media (max-width: 480px) {
			.savor-img { height: 160px !important; }
		}
		/* Short/landscape phones: never let the hero force extra scrolling */
		@media (max-height: 500px) and (orientation: landscape) {
			.banner-inner1 { min-height: auto !important; padding-top: 90px !important; padding-bottom: 30px !important; }
		}

		/* Section spacing system (.sp-y/.sp-t/.sp-b/.sp-mb) now lives globally in Site.Master so
		   every page can use it, not just this one. */

		/* ===== Browse Our Menu: large editorial dish cards ===== */
		.menu-swiper2 .swiper-wrapper { align-items: stretch; }
		.menu-swiper2 .swiper-slide { height: auto; display: flex; }
		.menu-highlight-card { display: flex; flex-direction: column; width: 100%; position: relative; }
		.menu-highlight-img { border-radius: 6px; overflow: hidden; }
		.menu-highlight-add {
			position: absolute; top: 14px; right: 14px; width: 42px; height: 42px; border-radius: 50%;
			background: #fff; color: var(--primary); display: flex; align-items: center; justify-content: center;
			box-shadow: 0 6px 18px rgba(0,0,0,0.15); transition: background .3s ease, color .3s ease; cursor: pointer; z-index: 2;
		}
		.menu-highlight-add:hover { background: var(--primary); color: #fff; }
		.menu-highlight-card .menu-highlight-title { white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
		.menu-highlight-card .menu-highlight-sub {
			display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;
		}
		.h-\[240px\] { height: 240px; }
		.h-\[260px\] { height: 260px; }
		@media (min-width: 640px) { .sm\:h-\[340px\] { height: 340px; } }

		/* Our Menu grid: editorial preview with circular imagery.
		   The "+" badge must live OUTSIDE the circular overflow:hidden mask — placing it inside
		   (as a corner-positioned child) let the circle clip most of the badge away. */
		.menu-preview-img-wrap { width: 110px; height: 110px; position: relative; }
		.menu-preview-img { width: 100%; height: 100%; border-radius: 50%; overflow: hidden; }
		.menu-preview-img img { width: 100%; height: 100%; object-fit: cover; display: block; }
		.menu-preview-add {
			position: absolute; bottom: 0; right: 0; width: 34px; height: 34px; border-radius: 50%;
			background: var(--primary); color: #fff; display: flex; align-items: center; justify-content: center;
			box-shadow: 0 4px 12px rgba(0,0,0,0.35); border: 2px solid var(--dark-1); cursor: pointer;
			transition: background .3s ease, transform .2s ease; font-size: 13px; z-index: 2;
		}
		.menu-preview-add:hover { background: var(--secondary); color: var(--smoky-black); transform: scale(1.1); }
		/* Renamed off the "masonry" id on purpose: the vendor isotope.pkgd bundle auto-binds a
		   broken filter handler to any #masonry/.masonry element (it initializes via .masonry()
		   but then tries to filter via .isotope() without ever isotope-initializing, and fights
		   our own click handler below) — keeping the id off its selector list makes that vendor
		   binding a no-op while our JS below does the real filtering. */
		#keaMenuGrid { align-items: stretch; }
		#keaMenuGrid.row { width: auto !important; }
		.menu-preview-desc {
			display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;
			overflow: hidden; margin: 0 auto;
		}

		/* ===== New sections: Order Now, Reservation, Location ===== */
		.order-now-card { border-color: var(--dark-border) !important; }
		.order-now-card:hover { border-color: var(--primary) !important; }
		.reservation-banner .container { min-height: 1px; }
		.w-\[90px\] { width: 90px; }
		.h-\[90px\] { height: 90px; }
		.text-\[38px\] { font-size: 38px; }
		@media (min-width: 1280px) { .xl\:text-\[42px\] { font-size: 42px; } }
		@media (min-width: 1536px) { .\32xl\:rounded-\[16px\] { border-radius: 16px; } }

		/* ===== Fallback rules for Tailwind arbitrary-value classes not present in the precompiled assets/css/style.css =====
		   (style.css is a static build, not a live compiler — new bracket-value classes need an explicit rule here.) */
		.rounded-\[16px\] { border-radius: 16px; }
		.rounded-\[20px\] { border-radius: 20px; }
		.w-\[70px\] { width: 70px; }
		.h-\[70px\] { height: 70px; }
		.w-\[220px\] { width: 220px; }
		.h-\[420px\] { height: 420px; }
		.h-\[180px\] { height: 180px; }
		.bg-\[\#ffffff1a\] { background-color: #ffffff1a; }
		.bg-\[var\(--rgba-primary-2\)\] { background-color: var(--rgba-primary-2); }
		@media (min-width: 640px) {
			.sm\:h-\[220px\] { height: 220px; }
			.sm\:h-\[460px\] { height: 460px; }
		}
		@media (min-width: 1024px) {
			.lg\:h-\[580px\] { height: 580px; }
		}

		/* ===== Hero carousel: horizontal nav arrows + plain dot pagination ===== */
		.hero-nav-btn {
			position: absolute;
			top: 50%;
			transform: translateY(-50%);
			z-index: 20;
			width: 48px;
			height: 48px;
			border-radius: 50%;
			background: rgba(255,255,255,0.15);
			color: #fff;
			display: flex;
			align-items: center;
			justify-content: center;
			cursor: pointer;
			transition: background .3s ease;
		}
		.hero-nav-btn:hover { background: var(--primary); }
		.hero-nav-prev { left: 24px; }
		.hero-nav-next { right: 24px; }
		.hero-dots { position: absolute; bottom: 22px; left: 0; right: 0; display: flex; justify-content: center; gap: 8px; z-index: 20; }
		.hero-dots .swiper-pagination-bullet { width: 9px; height: 9px; margin: 0 !important; border-radius: 50%; background: rgba(255,255,255,0.5); opacity: 1; cursor: pointer; transition: background .3s ease, width .3s ease; }
		.hero-dots .swiper-pagination-bullet-active { background: var(--secondary); width: 22px; border-radius: 5px; }
		@media (max-width: 640px) { .hero-nav-btn { display: none !important; } }

		/* ===== Testimonials: centered text-only card (no reviewer photo) ===== */
		.testimonial-noimg { box-shadow: 0 15px 55px rgba(35,35,35,0.1); }

		/* ===== Hero: cinematic scale + outline CTA (header is now a separate bar, not an overlay) ===== */
		.main-bnr-2 { margin-top: 0 !important; margin-bottom: 0 !important; }
		/* style.css intentionally insets the hero card 80px from the left above 1280px (--slider-left-spacing)
		   for a "boxed card" look — the redesign wants a full-bleed hero instead, edge to edge. */
		.main-bnr-2 .swiper-wrapper .swiper-slide .banner-inner1,
		.main-bnr-2 .banner-inner1 {
			margin-left: 0 !important;
			border-radius: 0 !important;
		}
		.banner-inner1 { min-height: clamp(480px, 82vh, 760px); display: flex; align-items: center; padding-top: 50px !important; padding-bottom: 40px !important; box-sizing: border-box; }
		.btn-hero-outline { background: transparent; border: 2px solid rgba(255,255,255,0.7); color: #fff; }
		.btn-hero-outline:hover { background: #fff; border-color: #fff; color: var(--smoky-black); }
		@media (max-width: 767px) { .banner-inner1 { min-height: auto; padding-top: 40px !important; padding-bottom: 30px !important; } }

		/* ===== Discover / About: editorial two-image composition ===== */
		.about-img-main { border-radius: 6px; overflow: hidden; }
		.about-img-accent {
			position: absolute;
			width: 190px;
			height: 190px;
			bottom: -30px;
			left: -30px;
			border: 6px solid #fff;
			border-radius: 6px;
			box-shadow: 0 20px 40px rgba(0,0,0,0.18);
			overflow: hidden;
			z-index: 2;
		}
		.about-img-accent img { width: 100%; height: 100%; object-fit: cover; }
		@media (max-width: 1024px) { .about-img-accent { display: none; } }
		.about-hours-row { display: flex; justify-content: space-between; align-items: center; padding: 12px 0; border-top: 1px solid var(--dark-border); }

		/* Menu filter pills default to near-black text — invisible on a dark section */
		.filters > li > a { color: var(--light-text) !important; }
		.filters > li.active > a, .filters > li:hover > a { color: var(--secondary) !important; }

		/* p-[20px]/sm:p-[35px] have no generated CSS in the precompiled style.css, so the blog
		   "large" video card's text sat flush against the card edges with no inset at all. */
		.dz-card-large .dz-info { padding: 20px; }
		@media (min-width: 640px) { .dz-card-large .dz-info { padding: 35px; } }
	</style>

	<!-- Banner -->
	<div class="main-bnr-2 overflow-hidden relative">
		<div class="hero-nav-btn hero-nav-prev max-xl:hidden">
			<i class="fa-solid fa-arrow-left"></i>
		</div>
		<div class="hero-nav-btn hero-nav-next max-xl:hidden">
			<i class="fa-solid fa-arrow-right"></i>
		</div>
		<div class="hero-dots"></div>
		<div class="main-slider-3">
			<div class="swiper-wrapper">
				<asp:Repeater ID="rptBanner" runat="server">
					<ItemTemplate>
						<div class="swiper-slide">
							<div class="banner-inner1 bg-cover rounded-s-[30px] max-xl:rounded-none md:pt-[120px] pt-[50px] pb-[30px] overflow-hidden relative z-[1]" style='background-image: url(<%# Eval("BgImage") %>);'>
								<%# RenderBannerVideo(Eval("VideoUrl")) %>
								<div class="container relative z-[2]">
									<div class="row items-center justify-end">
										<div class="lg:w-7/12 md:w-2/3 w-full px-[15px]">
											<div class="banner-content md:mb-[60px] mb-5">
												<span class="font-medium sm:text-xl text-base text-primary block mb-2"><%# Eval("TagLine") %></span>
												<h1 class="title mb-4 font-lobster text-white 2xl:text-[80px] xl:text-[70px] lg:text-[60px] md:text-[50px] sm:text-[36px] text-[28px] leading-tight"><%# Eval("Heading") %></h1>
												<p class="lg:max-w-[580px] md:max-w-[350px] max-w-full font-light lg:text-lg sm:text-base text-sm leading-[27px] text-[#ffffffb3] max-sm:hidden"><%# Eval("Description") %></p>
												<div class="banner-btn flex flex-wrap items-center lg:mt-10 sm:mt-[40px] mt-4" style="gap:16px;">
													<a href="Reservation.aspx" class="btn btn-lg btn-primary btn-hover-1"><span>Book a Reservation</span></a>
													<a href="Pages/Menu.aspx" class="btn btn-lg btn-hero-outline"><span>View Menu</span></a>
												</div>
											</div>
										</div>
										<div class="lg:w-5/12 md:w-1/3 px-[15px] max-sm:hidden">
											<div class="banner-media relative">
												<img src='<%# Eval("FoodImage") %>' alt="/" class="hero-food-photo w-[40vw] min-w-[40vw] max-lg:w-[55vw] max-lg:min-w-[55vw] z-[2] relative">
											</div>
										</div>
									</div>
								</div>
								<img class="leaf md:block hidden absolute top-0 left-[48.5%]" src="assets/images/main-slider/slider2/pic4.png" alt="/">
							</div>
						</div>
					</ItemTemplate>
				</asp:Repeater>
			</div>
		</div>
	</div>
	<!-- Banner -->

	<!-- Discover / About -->
	<section class="sp-y relative overflow-hidden kea-stars" style="background:var(--dark-1);">
		<div class="container">
			<div class="row items-center">
				<div class="lg:w-5/12 w-full px-[15px] mb-[70px] lg:mb-0">
					<span class="font-medium text-base text-primary block mb-3 uppercase" style="letter-spacing:0.2em; margin-top:0;">Discover</span>
					<h2 class="title font-lobster text-black2 lg:text-[54px] sm:text-5xl text-4xl mb-6 leading-tight">About<br>Khan-e-Azam</h2>
					<p class="text-bodycolor lg:text-xl text-lg leading-[32px] mb-5">Khan-e-Azam brings luxury dining with a rooftop experience to the heart of Lahore &mdash; every dish prepared using authentic ingredients and time-honoured recipes, served with warm, royal hospitality.</p>
					<p class="text-bodycolor lg:text-lg leading-[28px] mb-10">From sizzling karahis to slow-cooked biryanis, our kitchen honours tradition while our rooftop setting delivers an atmosphere built for celebration.</p>
					<a href="about.aspx" class="btn btn-lg btn-primary btn-hover-1"><span>Our Story</span></a>

					<div style="margin-top:48px;">
						<div class="about-hours-row">
							<span class="text-xs uppercase text-primary font-semibold" style="letter-spacing:0.1em;">Mon &ndash; Fri</span>
							<span class="text-black2 font-medium">2:00 PM &ndash; 2:00 AM</span>
						</div>
						<div class="about-hours-row">
							<span class="text-xs uppercase text-primary font-semibold" style="letter-spacing:0.1em;">Saturday</span>
							<span class="text-black2 font-medium">2:00 PM &ndash; 2:00 AM</span>
						</div>
						<div class="about-hours-row">
							<span class="text-xs uppercase text-primary font-semibold" style="letter-spacing:0.1em;">Sunday</span>
							<span class="text-black2 font-medium">2:00 PM &ndash; 2:00 AM</span>
						</div>
					</div>
				</div>
				<div class="lg:w-7/12 w-full px-[15px] relative">
					<div class="about-img-main">
						<img src="assets/images/banner/bnr2.jpg" alt="Signature dishes at Khan-e-Azam" class="w-full h-[320px] sm:h-[460px] lg:h-[580px] object-cover">
					</div>
					<div class="about-img-accent">
						<img src="assets/images/banner/bnr4.jpg" alt="Hand-picked spices at Khan-e-Azam" class="w-full h-full object-cover">
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Discover / About -->

	<!-- Browse Our Menu -->
	<section class="content-inner-1 overflow-hidden sp-b">
		<div class="container">
			<div class="section-head font-lobster sp-mb mx-auto relative flex items-end justify-between">
				<div>
					<span class="font-medium text-base text-primary block mb-2 uppercase" style="letter-spacing:0.2em;">Signature Dishes</span>
					<h2 class="title mb-0 text-black2 lg:text-[44px] sm:text-4xl text-3xl">Browse Our Menu</h2>
				</div>
				<div class="pagination-align flex">
					<div class="menu-button-prev1 btn-prev btn-hover-2"><i class="fa-solid fa-arrow-left sm:text-xl text-[15px]"></i></div>
					<div class="menu-button-next1 btn-next btn-hover-2"><i class="fa-solid fa-arrow-right sm:text-xl text-[15px]"></i></div>
				</div>
			</div>
		</div>
		<div class="container">
			<div class="swiper menu-swiper2 swiper-visible swiper-item-4 overflow-visible">
				<div class="swiper-wrapper">
					<asp:Repeater ID="rptBrowseMenu" runat="server">
						<ItemTemplate>
							<div class="swiper-slide">
								<div class="menu-highlight-card group">
									<div class="menu-highlight-img relative">
										<img src='<%# Eval("Image") %>' alt='<%# System.Web.HttpUtility.HtmlAttributeEncode(Eval("Name").ToString()) %>' class="w-full h-[240px] object-cover duration-500 group-hover:scale-105">
										<a class="menu-highlight-add dz-cart-add" href="javascript:void(0);"
									   data-cart-id='bm-<%# Eval("Id") %>'
									   data-name='<%# System.Web.HttpUtility.HtmlAttributeEncode(Eval("Name").ToString()) %>'
									   data-price='<%# Eval("Price") %>'
									   data-image='<%# Eval("Image") %>'><i class="fa-solid fa-plus"></i></a>
									</div>
									<div class="pt-5">
										<div class="flex justify-between items-start mb-1 gap-3">
											<h5 class="menu-highlight-title mb-0 text-lg font-semibold text-black2"><%# Eval("Name") %></h5>
											<span class="price text-primary font-semibold whitespace-nowrap"><%# Eval("Price") %></span>
										</div>
										<p class="menu-highlight-sub text-bodycolor text-sm mb-0"><%# Eval("SubTitle") %></p>
									</div>
								</div>
							</div>
						</ItemTemplate>
					</asp:Repeater>
				</div>
			</div>
			<div class="w-full text-center" style="margin-top:45px;">
				<a href="Pages/Menu.aspx" class="btn btn-lg btn-primary btn-hover-1"><span>View All</span></a>
			</div>
		</div>
	</section>
	<!-- Browse Our Menu -->

	<!-- Savor the Flavors -->
	<section class="sp-y relative overflow-hidden kea-stars" style="background:var(--dark-2);">
		<div class="container">
			<div class="row items-center">
				<div class="lg:w-6/12 w-full px-[15px] mb-[50px] lg:mb-0">
					<div class="flex" style="margin:0 -10px;">
						<div class="w-1/2" style="padding:0 10px;"><img src="assets/images/banner/bnr1.jpg" alt="Traditional Khan-e-Azam cooking" class="savor-img w-full h-[260px] sm:h-[340px] object-cover" style="border-radius:6px;"></div>
						<div class="w-1/2 mt-10" style="padding:0 10px;"><img src="assets/images/banner/bnr5.jpg" alt="Fresh ingredients at Khan-e-Azam" class="savor-img w-full h-[260px] sm:h-[340px] object-cover" style="border-radius:6px;"></div>
					</div>
				</div>
				<div class="lg:w-6/12 w-full px-[15px] lg:pl-[50px]">
					<span class="font-medium text-base text-primary block mb-3 uppercase" style="letter-spacing:0.2em;">Taste Tradition</span>
					<h2 class="title font-lobster text-black2 lg:text-[46px] sm:text-5xl text-4xl mb-6 leading-tight">Savor the Flavors of Khan-e-Azam</h2>
					<p class="text-bodycolor lg:text-xl text-lg leading-[32px] mb-10 lg:max-w-[520px]">Every plate that leaves our kitchen carries generations of culinary heritage &mdash; hand-picked spices, slow-cooked karahis and biryanis, and the warmth of true Lahori hospitality.</p>
					<a href="Pages/Menu.aspx" class="btn btn-lg btn-primary btn-hover-1"><span>Click to Open Full Menu</span></a>
				</div>
			</div>
		</div>
	</section>
	<!-- Savor the Flavors -->

	<!--Today's Special-->
	<section class="bg-[url('../images/background/pic1.png')] bg-fixed sp-y relative z-[1] after:content-[''] after:absolute after:z-[-1] after:bg-black-blur after:opacity-100 after:w-full after:h-full after:top-0 after:left-0 after:backdrop-blur-[6px] 2xl:mx-[100px] 2xl:rounded-[30px] overflow-hidden">
		<div class="container">
			<div class="sp-mb relative mx-auto text-center">
				<span class="font-medium text-base text-secondary block mb-3 uppercase" style="letter-spacing:0.2em;">This Week's Feature</span>
				<h2 class="font-lobster text-white lg:text-[46px] sm:text-5xl text-4xl">Today's Special</h2>
			</div>
			<div class="row">
				<asp:Repeater ID="rptTodaySpecial" runat="server">
					<ItemTemplate>
						<div class="lg:w-1/4 sm:w-2/4 w-full px-[15px]">
							<div class="dz-img-box4 rounded-[10px] xl:p-[15px] p-2.5 mb-[30px] flex flex-col relative overflow-hidden z-[1] style-5" style="background:var(--dark-card); border:1px solid var(--dark-border);">
								<div class="dz-content mb-[15px]">
									<div class="weight mb-[5px] flex justify-between items-center text-xs text-bodycolor">
										<span><%# Eval("Category") %></span>
										<span><%# Eval("Weight") %></span>
									</div>
									<div class="price mb-[5px] flex justify-between items-center">
										<h6 class="text-black2 text-sm sm:text-base"><%# Eval("Name") %></h6>
										<h6 class="text-primary text-sm sm:text-base"><%# Eval("Price") %></h6>
									</div>
								</div>
								<div class="dz-media rounded-[10px] mt-auto w-full overflow-hidden relative" style="height:180px;">
									<img src='<%# Eval("Image") %>' alt="/" class="block w-full h-full object-cover">
									<a class="detail-btn dz-cart-add top-[-50px] z-[2] left-[50%] translate-x-[-50%] opacity-0 rounded-xl" href="javascript:void(0);"
								   data-cart-id='ts-<%# Eval("Id") %>'
								   data-name='<%# System.Web.HttpUtility.HtmlAttributeEncode(Eval("Name").ToString()) %>'
								   data-price='<%# Eval("Price") %>'
								   data-image='<%# Eval("Image") %>'><i class="fa-solid fa-plus text-white"></i></a>
								</div>
							</div>
						</div>
					</ItemTemplate>
				</asp:Repeater>
			</div>
			<div class="w-full text-center mt-[30px]">
				<a href="Pages/Menu.aspx" class="btn btn-md btn-primary btn-hover-1"><span>See All Dishes</span></a>
			</div>
		</div>
	</section>
	<!--Today's Special-->

	<!-- Menu Categories -->
	<section class="content-inner-1 sp-t relative">
		<div class="container">
			<div class="sp-mb relative mx-auto text-center">
				<span class="font-medium text-base text-primary block mb-3 uppercase" style="letter-spacing:0.2em;">Explore</span>
				<h2 class="title font-lobster text-black2 lg:text-[46px] sm:text-5xl text-4xl">Browse By Category</h2>
			</div>
			<div class="row justify-center">
				<div class="lg:w-1/4 sm:w-1/2 w-full px-[15px] mb-[45px] text-center">
					<a href="Pages/Menu.aspx" class="group block">
						<span class="w-[90px] h-[90px] rounded-full bg-[var(--rgba-primary-1)] group-hover:bg-primary flex items-center justify-center mx-auto mb-5 duration-300">
							<i class="flaticon-restaurant text-primary group-hover:text-white text-[38px] duration-300"></i>
						</span>
						<h5 class="text-black2 mb-1 text-lg group-hover:text-primary duration-300">Main Courses</h5>
						<span class="text-bodycolor text-sm">Click to open Main Courses menu</span>
					</a>
				</div>
				<div class="lg:w-1/4 sm:w-1/2 w-full px-[15px] mb-[45px] text-center">
					<a href="Pages/Menu.aspx?category=drink" class="group block">
						<span class="w-[90px] h-[90px] rounded-full bg-[var(--rgba-primary-1)] group-hover:bg-primary flex items-center justify-center mx-auto mb-5 duration-300">
							<i class="flaticon-cocktail text-primary group-hover:text-white text-[38px] duration-300"></i>
						</span>
						<h5 class="text-black2 mb-1 text-lg group-hover:text-primary duration-300">Drinks</h5>
						<span class="text-bodycolor text-sm">Click to open Drinks menu</span>
					</a>
				</div>
				<div class="lg:w-1/4 sm:w-1/2 w-full px-[15px] mb-[45px] text-center">
					<a href="Pages/Menu.aspx?category=spicy" class="group block">
						<span class="w-[90px] h-[90px] rounded-full bg-[var(--rgba-primary-1)] group-hover:bg-primary flex items-center justify-center mx-auto mb-5 duration-300">
							<i class="flaticon-chili-pepper text-primary group-hover:text-white text-[38px] duration-300"></i>
						</span>
						<h5 class="text-black2 mb-1 text-lg group-hover:text-primary duration-300">BBQ &amp; Spicy</h5>
						<span class="text-bodycolor text-sm">Click to open Spicy menu</span>
					</a>
				</div>
				<div class="lg:w-1/4 sm:w-1/2 w-full px-[15px] mb-[45px] text-center">
					<a href="Pages/Menu.aspx?category=sweet" class="group block">
						<span class="w-[90px] h-[90px] rounded-full bg-[var(--rgba-primary-1)] group-hover:bg-primary flex items-center justify-center mx-auto mb-5 duration-300">
							<i class="flaticon-cupcake text-primary group-hover:text-white text-[38px] duration-300"></i>
						</span>
						<h5 class="text-black2 mb-1 text-lg group-hover:text-primary duration-300">Sweets</h5>
						<span class="text-bodycolor text-sm">Click to open Sweets menu</span>
					</a>
				</div>
			</div>
		</div>
	</section>
	<!-- Menu Categories -->

	<!-- Our Menu -->
	<section class="sp-y relative">
		<div class="container">
			<div class="sp-mb relative mx-auto text-center">
				<span class="font-medium text-base text-primary block mb-3 uppercase" style="letter-spacing:0.2em;">A Taste of What's Inside</span>
				<h2 class="title font-lobster text-black2 lg:text-[46px] sm:text-5xl text-4xl">Our Menu</h2>
			</div>
			<div class="row justify-center">
				<div class="w-full px-[15px] text-center">
					<div class="site-filters mb-[50px] overflow-x-auto">
						<ul class="filters flex-wrap justify-center">
							<li data-filter=".All" class="btn md:mb-0 mb-2 active"><a href="javascript:void(0);"><span><i class="flaticon-fast-food"></i></span>All</a></li>
							<li data-filter=".drink" class="btn md:mb-0 mb-2"><a href="javascript:void(0);"><span><i class="flaticon-cocktail"></i></span>COLD DRINK</a></li>
							<li data-filter=".pizza" class="btn md:mb-0 mb-2"><a href="javascript:void(0);"><span><i class="flaticon-pizza-slice"></i></span>PIZZA</a></li>
							<li data-filter=".salad" class="btn md:mb-0 mb-2"><a href="javascript:void(0);"><span><i class="flaticon-salad"></i></span>SALAD</a></li>
							<li data-filter=".sweet" class="btn md:mb-0 mb-2"><a href="javascript:void(0);"><span><i class="flaticon-cupcake"></i></span>SWEETS</a></li>
							<li data-filter=".spicy" class="btn md:mb-0 mb-2"><a href="javascript:void(0);"><span><i class="flaticon-chili-pepper"></i></span>SPICY</a></li>
							<li data-filter=".burger" class="btn md:mb-0 mb-2"><a href="javascript:void(0);"><span><i class="flaticon-hamburger-1"></i></span>BURGER</a></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="clearfix">
				<ul id="keaMenuGrid" class="row dlab-gallery-listing gallery">
					<asp:Repeater ID="rptMenuFilter" runat="server">
						<ItemTemplate>
							<li class='card-container lg:w-1/3 sm:w-1/2 w-full px-[15px] mb-[50px] <%# Eval("FilterTags") %>'>
								<div class="text-center">
									<div class="menu-preview-img-wrap mx-auto mb-4">
										<div class="menu-preview-img">
											<img src='<%# Eval("Image") %>' alt='<%# System.Web.HttpUtility.HtmlAttributeEncode(Eval("Name").ToString()) %>'>
										</div>
										<a class="menu-preview-add dz-cart-add" href="javascript:void(0);" title="Add to cart"
											data-cart-id='mp-<%# Eval("Id") %>'
											data-name='<%# System.Web.HttpUtility.HtmlAttributeEncode(Eval("Name").ToString()) %>'
											data-price='<%# Eval("Price") %>'
											data-image='<%# Eval("Image") %>'><i class="fa-solid fa-plus"></i></a>
									</div>
									<div class="flex justify-center items-baseline gap-3 mb-2">
										<h5 class="text-black2 mb-0"><%# Eval("Name") %></h5>
										<span class="text-primary font-semibold whitespace-nowrap"><%# Eval("Price") %></span>
									</div>
									<p class="menu-preview-desc text-bodycolor text-sm px-4 mb-0" style="max-width:280px;"><%# Eval("Description") %></p>
								</div>
							</li>
						</ItemTemplate>
					</asp:Repeater>
				</ul>
				<div class="w-full text-center mt-[10px]">
					<a href="Pages/Menu.aspx" class="btn btn-lg btn-primary btn-hover-1"><span>View Full Menu</span></a>
				</div>
			</div>
		</div>
	</section>
	<!-- Our Menu -->

	<script>
		document.addEventListener('DOMContentLoaded', function () {
			var btns = document.querySelectorAll('#keaMenuGrid').length ? document.querySelectorAll('.filters li') : [];
			var items = document.querySelectorAll('#keaMenuGrid .card-container');
			btns.forEach(function (btn) {
				btn.addEventListener('click', function () {
					btns.forEach(function (b) { b.classList.remove('active'); });
					this.classList.add('active');
					var filter = this.getAttribute('data-filter');
					items.forEach(function (item) {
						if (filter === '.All') {
							item.style.display = '';
						} else {
							var cls = filter.substring(1);
							item.style.display = item.classList.contains(cls) ? '' : 'none';
						}
					});
				});
			});
		});
	</script>

	<!-- Icon Features -->
	<section class="content-inner-1 sp-y kea-stars" style="background:var(--dark-2);">
		<div class="container">
			<div class="row justify-center relative">
				<asp:Repeater ID="rptIconFeatures" runat="server">
					<ItemTemplate>
						<div class="lg:w-1/3 md:w-6/12 w-full px-[15px] sm:px-[40px] mb-[40px] text-center">
							<div class="icon-bx duration-500 bg-white xl:w-[110px] xl:h-[110px] w-[90px] h-[90px] rounded-full mx-auto mb-6 flex items-center justify-center" style="box-shadow:0 10px 30px rgba(0,0,0,0.06);">
								<i class='<%# Eval("IconClass") %> text-primary xl:text-[42px] text-[34px]'></i>
							</div>
							<h5 class="dz-title mb-2 xl:text-xl text-lg"><a href='<%# Eval("LinkUrl") %>' class="text-black2"><%# Eval("Title") %></a></h5>
							<p class="text-bodycolor text-sm sm:text-[15px] mb-0" style="max-width:260px;margin:0 auto;"><%# Eval("Description") %></p>
						</div>
					</ItemTemplate>
				</asp:Repeater>
			</div>
		</div>
	</section>
	<!-- Icon Features -->

	<!-- Order Now -->
	<section class="sp-y relative overflow-hidden">
		<div class="container">
			<div class="sp-mb relative mx-auto text-center">
				<span class="font-medium text-base text-primary block mb-3 uppercase" style="letter-spacing:0.2em;">Ready to Eat?</span>
				<h2 class="title font-lobster text-black2 lg:text-[46px] sm:text-5xl text-4xl">Order Now</h2>
			</div>
			<div class="row justify-center">
				<div class="lg:w-1/4 sm:w-1/3 w-full px-[15px] mb-[30px]">
					<a href="javascript:void(0);" class="order-now-card block text-center duration-300" data-order-type="Dine-In" style="border:1px solid #eee; border-radius:8px; padding:40px 24px;">
						<i class="fa-solid fa-utensils text-primary text-[36px] mb-4 inline-block duration-300"></i>
						<h5 class="mb-2 text-lg text-black2">Dine-In</h5>
						<p class="text-bodycolor text-sm mb-0">Reserve your table &amp; enjoy the rooftop</p>
					</a>
				</div>
				<div class="lg:w-1/4 sm:w-1/3 w-full px-[15px] mb-[30px]">
					<a href="javascript:void(0);" class="order-now-card block text-center duration-300" data-order-type="Takeaway" style="border:1px solid #eee; border-radius:8px; padding:40px 24px;">
						<i class="fa-solid fa-bag-shopping text-primary text-[36px] mb-4 inline-block duration-300"></i>
						<h5 class="mb-2 text-lg text-black2">Takeaway</h5>
						<p class="text-bodycolor text-sm mb-0">Order ahead &amp; pick up at your convenience</p>
					</a>
				</div>
				<div class="lg:w-1/4 sm:w-1/3 w-full px-[15px] mb-[30px]">
					<a href="javascript:void(0);" class="order-now-card block text-center duration-300" data-order-type="Fast Delivery" style="border:1px solid #eee; border-radius:8px; padding:40px 24px;">
						<i class="fa-solid fa-truck-fast text-primary text-[36px] mb-4 inline-block duration-300"></i>
						<h5 class="mb-2 text-lg text-black2">Fast Delivery</h5>
						<p class="text-bodycolor text-sm mb-0">Hot &amp; fresh, delivered straight to your door</p>
					</a>
				</div>
			</div>
		</div>
	</section>
	<script>
		document.addEventListener('click', function (e) {
			var card = e.target.closest ? e.target.closest('.order-now-card') : null;
			if (!card) return;
			try { localStorage.setItem('kea_order_type', card.getAttribute('data-order-type')); } catch (err) {}
			window.location.href = '<%= ResolveUrl("~/Pages/Menu.aspx") %>';
		});
	</script>
	<!-- Order Now -->

	<!-- Testimonials -->
	<section class="content-inner-2 overflow-hidden sp-y">
		<div class="container">
			<div class="sp-mb relative mx-auto text-center">
				<span class="font-medium text-base text-primary block mb-3 uppercase" style="letter-spacing:0.2em;">In Their Words</span>
				<h2 class="font-lobster lg:text-[46px] sm:text-5xl text-4xl text-black2">Customer's Comment</h2>
			</div>
			<div class="swiper testimonial-two-swiper swiper-btn-lr swiper-single overflow-visible swiper-visible">
				<div class="swiper-wrapper">
					<asp:Repeater ID="rptTestimonials" runat="server">
						<ItemTemplate>
							<div class="swiper-slide">
								<div class="testimonial-noimg relative rounded-lg mx-auto text-center" style="max-width:760px; background:var(--dark-card); border:1px solid var(--dark-border);">
									<div class="p-8 sm:p-[55px] relative w-full flex flex-col items-center">
										<i class="flaticon-right-quote text-primary" style="font-size:38px; margin-bottom:20px;"></i>
										<div class="testimonial-text relative mb-[22px] text-base">
											<p class="xl:text-[19px] sm:text-lg text-base leading-[30px] sm:leading-[34px] font-medium text-black2"><%# Eval("ReviewText") %></p>
										</div>
										<div class="testimonial-info relative z-[1]">
											<h5 class="testimonial-name font-bold leading-[32px] lg:text-[22px] sm:text-xl text-lg mb-1 text-black2"><%# Eval("ReviewerName") %></h5>
											<span class="testimonial-position leading-[21px] text-sm block text-primary"><%# Eval("ReviewerPosition") %></span>
										</div>
									</div>
								</div>
							</div>
						</ItemTemplate>
					</asp:Repeater>
				</div>
				<div class="pagination">
					<div class="testimonial-2-button-prev btn-prev rounded-full top-[50%] absolute left-[-100px] max-xl:left-[-60px] hidden xl:block"><i class="fa-solid fa-arrow-left"></i></div>
					<div class="testimonial-2-button-next btn-next rounded-full top-[50%] absolute right-[-100px] max-xl:right-[-60px] hidden xl:block"><i class="fa-solid fa-arrow-right"></i></div>
				</div>
			</div>
		</div>
	</section>
	<!-- Testimonials -->

	<!-- Reservation Banner -->
	<section class="reservation-banner relative bg-black2 overflow-hidden 2xl:mx-[100px] 2xl:rounded-[16px] mt-[70px] sm:mt-[110px]" style="background-image:url('assets/images/banner/bnr2.jpg'); background-size:cover; background-position:center; min-height:60vh; display:flex; align-items:center;">
		<div class="absolute top-0 left-0 w-full h-full" style="background:linear-gradient(180deg, rgba(16,12,8,0.55) 0%, rgba(16,12,8,0.85) 100%);"></div>
		<div class="container relative z-[1] sp-y text-center">
			<span class="font-medium text-base text-secondary block mb-4 uppercase" style="letter-spacing:0.25em;">Reserve Your Table</span>
			<h2 class="font-lobster text-white lg:text-[54px] sm:text-6xl text-4xl mb-8 mx-auto leading-tight" style="max-width:820px;">Make Your Next Visit Special</h2>
			<p class="text-white mx-auto mb-10" style="max-width:560px; opacity:.85; font-size:18px;">Visit Khan-e-Azam Restaurant and make your reservation today &mdash; luxury dining with rooftop atmosphere awaits.</p>
			<a href="Reservation.aspx" class="btn btn-lg btn-primary btn-hover-1"><span>Book a Reservation</span></a>
		</div>
	</section>
	<!-- Reservation Banner -->

	<!-- Location -->
	<section class="sp-y relative">
		<div class="container">
			<div class="sp-mb relative mx-auto text-center">
				<span class="font-medium text-base text-primary block mb-3 uppercase" style="letter-spacing:0.2em;">Find Us</span>
				<h2 class="title font-lobster text-black2 lg:text-[46px] sm:text-5xl text-4xl">Khan-e-Azam</h2>
			</div>
			<div class="row items-stretch">
				<div class="lg:w-7/12 w-full px-[15px] mb-[20px] lg:mb-0">
					<div class="overflow-hidden h-full" style="min-height:440px; border-radius:6px;">
						<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3401.3789452336694!2d74.30138237532392!3d31.51261384752538!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x391904a081525043%3A0xe54d31846b95764d!2s880%20N%20Poonch%20Rd%2C%20Samanabad%20Town%2C%20Lahore%2C%20Punjab%2054000%2C%20Pakistan!5e0!3m2!1sen!2s!4v1719570000000!5m2!1sen!2s"
							width="100%" height="100%" style="border:0; min-height:440px;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade" title="Khan-e-Azam location map"></iframe>
					</div>
				</div>
				<div class="lg:w-5/12 w-full px-[15px]">
					<div class="bg-black2 h-full flex flex-col justify-center" style="border-radius:6px; padding:40px; padding:clamp(30px,4vw,50px);">
						<div class="icon-bx-wraper relative mb-5">
							<div class="icon-md"><span class="icon-cell"><i class="las la-map-marker text-primary text-2xl"></i></span></div>
							<div class="icon-content"><h6 class="tilte mb-[5px] text-white">Address</h6><p class="text-[#C4C4C4]">880 N Poonch Rd, Samanabad Town, Lahore, Punjab 54000, Pakistan</p></div>
						</div>
						<div class="icon-bx-wraper relative mb-5">
							<div class="icon-md"><span class="icon-cell"><i class="las la-phone-volume text-primary text-2xl"></i></span></div>
							<div class="icon-content"><h6 class="tilte mb-[5px] text-white">Call Us</h6><p class="text-[#C4C4C4]"><a href="tel:03089406789" class="text-[#C4C4C4] hover:text-primary">0308-9406789</a></p></div>
						</div>
						<div class="icon-bx-wraper relative mb-8">
							<div class="icon-md"><span class="icon-cell"><i class="las la-envelope-open text-primary text-2xl"></i></span></div>
							<div class="icon-content"><h6 class="tilte mb-[5px] text-white">Email</h6><p class="text-[#C4C4C4]"><a href="mailto:khaneazamrestaurant@gmail.com" class="text-[#C4C4C4] hover:text-primary">khaneazamrestaurant@gmail.com</a></p></div>
						</div>
						<a href="https://www.google.com/maps/dir/?api=1&amp;destination=880+N+Poonch+Rd,+Samanabad+Town,+Lahore,+Punjab+54000,+Pakistan" target="_blank" rel="noopener" class="btn btn-primary btn-hover-1" style="width:fit-content;"><span>Get Directions</span></a>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Location -->

	<!-- Our Blog -->
	<section class="content-inner sp-b overflow-hidden relative" style="padding-top:20px;">
		<div class="container">
			<div class="row">
				<div class="xl:w-7/12 w-full px-[15px]">
					<div class="sp-mb relative mx-auto">
						<span class="font-medium text-base text-primary block mb-3 uppercase" style="letter-spacing:0.2em;">From the Kitchen</span>
						<h2 class="font-lobster text-left lg:text-[40px] sm:text-4xl text-3xl text-black2">Recent News &amp; Updates</h2>
					</div>
					<asp:Repeater ID="rptBlogSmall" runat="server">
						<ItemTemplate>
							<div class="dz-card style-2 blog-half rounded-lg overflow-hidden duration-500 sm:flex relative mb-[20px] sm:mb-[30px]" style="background:var(--dark-card); border:1px solid var(--dark-border);">
								<div class="dz-media overflow-hidden relative sm:w-[220px] sm:min-w-[220px] md:w-[270px] md:min-w-[270px] w-full sm:h-auto h-[200px]">
									<a href="blog-standard.html" class="block h-full"><img src='<%# Eval("Image") %>' alt="/" class="w-full h-full object-cover"></a>
									<div class="dz-date"><%# FormatDate(Eval("PublishedDate")) %></div>
								</div>
								<div class="dz-info flex flex-col relative p-[15px] sm:p-[25px]">
									<h4 class="dz-title mb-[8px] sm:mb-[10px] sm:text-xl text-base"><a href="blog-standard.html" class="text-black2"><%# Eval("Title") %></a></h4>
									<div class="dz-meta mb-[10px] sm:mb-[15px]">
										<ul>
											<li class="dz-user">
												<a href="javascript:void(0);" class="text-black2 text-sm"><i class="fa-solid fa-user text-xs text-primary mr-[5px] relative top-0 scale-[1.2]"></i>
												By <span class="text-primary"><%# Eval("Author") %></span></a>
											</li>
											<li class="dz-comment">
												<a href="javascript:void(0);" class="text-black2 text-sm"><i class="fa-solid fa-message text-xs text-primary mr-[5px] relative top-0 scale-[1.2]"></i>
												<%# Eval("CommentCount") %> Comments</a>
											</li>
										</ul>
									</div>
									<div class="btn-wrapper mt-auto">
										<a href="blog-standard.html" class="btn btn-primary btn-hover-2 btn-sm sm:btn-md">Read More</a>
									</div>
								</div>
							</div>
						</ItemTemplate>
					</asp:Repeater>
				</div>
				<div class="xl:w-5/12 w-full px-[15px] mb-[30px]">
					<asp:Repeater ID="rptBlogLarge" runat="server">
						<ItemTemplate>
							<div class="dz-card style-3 dz-card-large blog-half relative sm:min-h-[500px] xl:min-h-[570px] min-h-[350px] h-full overflow-hidden rounded-lg flex flex-col" style='background-image: url(<%# Eval("Image") %>);'>
								<video autoplay loop muted playsinline class="absolute top-0 left-0 object-cover w-full h-full">
									<source src='<%# Eval("VideoUrl") %>' type="video/mp4">
								</video>
								<div class="dz-info p-[20px] sm:p-[35px] z-[1] mt-auto">
									<h3 class="dz-title mb-[10px] sm:mb-[15px] sm:text-2xl text-xl"><a href="blog-standard.html" class="text-white"><%# Eval("Title") %></a></h3>
									<div class="dz-meta mb-[15px]">
										<ul>
											<li class="dz-date absolute top-[20px] sm:top-[35px] left-[20px] sm:left-[35px] after:hidden py-[8px] sm:py-[10px] px-[12px] sm:px-[15px] block text-sm"><%# FormatDate(Eval("PublishedDate")) %></li>
											<li class="dz-user">
												<a href="javascript:void(0);" class="text-white text-sm"><i class="fa-solid fa-user text-xs text-primary mr-[5px] relative top-0 scale-[1.2]"></i>
												By <span class="text-primary"><%# Eval("Author") %></span></a>
											</li>
											<li class="dz-comment">
												<a href="javascript:void(0);" class="text-white text-sm"><i class="fa-solid fa-message text-xs text-primary mr-[5px] relative top-0 scale-[1.2]"></i>
												<%# Eval("CommentCount") %> Comments</a>
											</li>
										</ul>
									</div>
								</div>
							</div>
						</ItemTemplate>
					</asp:Repeater>
				</div>
			</div>
		</div>
	</section>
	<!-- Our Blog End -->

	<!-- Quick Order Request -->
	<section class="content-inner-1 sp-y kea-stars" style="background-color:var(--dark-2);">
		<div class="container">
			<div class="mx-auto" style="max-width:640px;">
				<div class="rounded-lg" style="background:var(--dark-card); border:1px solid var(--dark-border); padding:40px;">
					<div class="text-center mb-8">
						<span class="font-medium text-base text-primary block mb-3 uppercase" style="letter-spacing:0.2em;">Can't Browse Right Now?</span>
						<h2 class="font-lobster text-black2 lg:text-[36px] sm:text-4xl text-3xl mb-2">Quick Order Request</h2>
						<p class="text-bodycolor mb-0">Leave your details and how you'd like to order &mdash; our team will call you back to confirm.</p>
					</div>

					<asp:Label ID="lblQuickMsg" runat="server" Visible="false" CssClass="kea-quick-alert alert"></asp:Label>

					<div class="row">
						<div class="lg:w-1/2 w-full px-[15px] mb-[20px]">
							<label class="block mb-2" style="color:var(--muted-text); font-size:13px; font-weight:600;">Full Name</label>
							<asp:TextBox ID="txtQuickName" runat="server" CssClass="kea-quick-input" placeholder="Enter your full name" MaxLength="100" />
						</div>
						<div class="lg:w-1/2 w-full px-[15px] mb-[20px]">
							<label class="block mb-2" style="color:var(--muted-text); font-size:13px; font-weight:600;">Contact Number</label>
							<asp:TextBox ID="txtQuickPhone" runat="server" CssClass="kea-quick-input" placeholder="03xx-xxxxxxx" MaxLength="20" />
						</div>
						<div class="w-full px-[15px] mb-[20px]">
							<label class="block mb-2" style="color:var(--muted-text); font-size:13px; font-weight:600;">Order Type</label>
							<asp:DropDownList ID="ddlQuickOrderType" runat="server" CssClass="kea-quick-input">
								<asp:ListItem Text="Dine In" Value="Dine In" />
								<asp:ListItem Text="Take Away" Value="Take Away" />
								<asp:ListItem Text="Delivery" Value="Delivery" />
							</asp:DropDownList>
						</div>
					</div>

					<asp:Button ID="btnQuickSubmit" runat="server" Text="Submit Request" CssClass="btn btn-primary btn-hover-1 w-full" style="width:100%; height:52px; font-size:16px;" OnClick="btnQuickSubmit_Click" />
				</div>
			</div>
		</div>

		<style>
			.kea-quick-input {
				height: 50px; padding: 10px 20px; width: 100%; font-size: 15px;
				border: 1px solid var(--dark-border); border-radius: 6px; outline: none;
				background: var(--dark-1); color: var(--light-text); transition: border-color .3s;
			}
			.kea-quick-input:focus { border-color: var(--primary); }
			.kea-quick-input::placeholder { color: var(--muted-text); }
			/* .alert/.alert-success only set color via CSS vars — the "d-block"/"mb-4" Bootstrap
			   classes that were supposed to give this its own block box don't exist on this page,
			   so the label stayed inline (default for asp:Label) and visually overlapped the
			   fields right after it instead of pushing them down. */
			.kea-quick-alert {
				display: block; width: 100%; box-sizing: border-box;
				margin-bottom: 24px; border-radius: 8px; font-size: 14px; line-height: 1.6;
				word-wrap: break-word; overflow-wrap: break-word;
			}
			/* jQuery niceSelect copies the select's classes onto the wrapper it builds — style that
			   wrapper explicitly so the Order Type field matches the other dark inputs instead of
			   rendering as a narrow, unstyled, floated box. */
			.nice-select.kea-quick-input {
				float: none; display: flex; align-items: center; width: 100%; line-height: normal;
			}
			.nice-select.kea-quick-input .current { color: var(--light-text); }
			.nice-select.kea-quick-input .list {
				width: 100%; min-width: 100%; left: 0; right: 0;
				background: var(--dark-card); border: 1px solid var(--dark-border);
			}
			.nice-select.kea-quick-input .option { color: var(--light-text); background: transparent; }
			.nice-select.kea-quick-input .option:hover,
			.nice-select.kea-quick-input .option.selected,
			.nice-select.kea-quick-input .option.focus { background: var(--primary) !important; color: #fff; }
		</style>

		<script>
			// Safety net: if jQuery's niceSelect plugin (which the rest of the site's selects rely
			// on) didn't pick up this dropdown for any reason, the browser falls back to its bare
			// native <select> popup instead of the site's themed one. Re-check once everything
			// (including images/layout) has settled and wrap it then if it's still missing.
			jQuery(window).on('load', function () {
				var $ddl = jQuery('#<%= ddlQuickOrderType.ClientID %>');
				if ($ddl.length && !$ddl.next().hasClass('nice-select')) {
					$ddl.niceSelect();
				}
			});
		</script>
	</section>
	<!-- Quick Order Request -->

</asp:Content>
