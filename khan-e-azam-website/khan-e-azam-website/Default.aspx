<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="khan_e_azam_website._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

 

	<!-- Banner -->
	<div class="main-bnr-2 overflow-hidden translate-y-[95px] max-xl:translate-y-[75px] mb-[90px]">
		<div class="swiper-bnr-pagination flex sm:left-0 right-0 lg:items-center flex-col justify-center w-[80px] max-xl:w-[50px] h-full absolute">
			<div class="main-button-prev block max-xl:hidden">
				<i class="fa-solid fa-arrow-up"></i>
			</div>
			<div class="main-slider-pagination main-swiper3-pagination">
				<span class="swiper-pagination-bullet relative z-[5]">01</span>
				<span class="swiper-pagination-bullet relative z-[5]">02</span>
				<span class="swiper-pagination-bullet relative z-[5]">03</span>
			</div>
			<div class="main-button-next block max-xl:hidden">
				<i class="fa-solid fa-arrow-down"></i>
			</div>
		</div>
		<div class="main-slider-3">
			<div class="swiper-wrapper">
				<div class="swiper-slide">
					<div class="banner-inner1 bg-cover rounded-s-[30px] max-xl:rounded-none md:pt-[120px] pt-[50px] pb-[30px] overflow-hidden relative z-[1]"  style="background-image: url(assets/images/main-slider/slider2/bg1.jpg);">
						<div class="container">
							<div class="row items-center justify-end">
								<div class="lg:w-7/12 md:w-2/3 px-[15px]">
									<div class="banner-content md:mb-[60px] mb-0">
										<span class="font-medium text-xl text-primary block">High Quality Test Station </span>
										<h1 class="title mb-4 font-lobster text-white 2xl:text-[80px] xl:text-[70px] lg:text-[60px] md:text-[50px] text-[36px]">We believe Good Food Offer Great Smile </h1>
										<p class="lg:max-w-[580px] md:max-w-[350px] max-w-full font-light lg:text-lg sm:text-base text-sm leading-[27px] text-[#ffffffb3]">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
										
										 <div class="banner-btn flex items-center lg:mt-10 sm:mt-[40px] mt-5 gap-[30px] lg:mb-[80px]">
											<a href="contact-us.html" class="btn btn-primary btn-md  btn-hover-1"><span>Book a Table</span></a>
											<a href="about-us.html" class="btn btn-outline btn-transparent text-primary btn-hover-1 btn-md"><span>View More</span></a>
                                		</div>
										<div class="food-card border-dashed border border-[#ffffff66] rounded-[10px] w-[370px] relative block max-xl:hidden">
											<div class="dz-head border-b border-dashed border-[#ffffff66] flex justify-between py-[15px] px-[25px]">
												<h5 class="text-white mb-2">Panner Tikka</h5>
												<ul class="rating flex">
													<li><i class="fa-solid fa-star"></i></li>
													<li><i class="fa-solid fa-star"></i></li>
													<li><i class="fa-solid fa-star"></i></li>
													<li><i class="fa-solid fa-star"></i></li>
													<li><i class="fa-solid fa-star"></i></li>
												</ul>
											</div>
											<div class="dz-body flex justify-between py-[16px] px-[25px]">
												<div class="dz-left">
													<div class="profile-info flex">
														<div class="dz-media">
															<img src="assets/images/team/pic1.jpg" alt="/" class=" w-[45px] h-[45px] rounded-full">
														</div>
														<div class="dz-content ml-2">
															<h6 class="mb-[3px] text-white">John Doe</h6>
															<p class="text-[13px] leading-5 text-[#C4C4C4] mb-4" >Master Chief</p>
														</div>
													</div>
													<p class="text-[#DCDCDC]">Lorem ipsum dolor shit amet...</p>
												</div>
												<div class="dz-right">
													<h5 class="text-primary mb-2">$15.00</h5>
													<a href="shop-cart.html" class="btn btn-primary btn-cart w-10 h-10 leading-[0.5rem] flex text-xl p-1"><i class="flaticon-shopping-cart text-white"></i></a>
												</div>
											</div>
											<img class="target-line absolute bottom-[50px] -right-full z-[2] translate-x-[25%] min-w-[485px]" src="assets/images/main-slider/slider2/line.png" alt="/">
										</div>
									</div>
								</div>
								<div class="lg:w-5/12 md:w-1/3 px-[15px]">
									<div class="banner-media relative">
										<img src="assets/images/main-slider/slider2/pic1.png" alt="/" class="w-[40vw] min-w-[40vw] max-lg:w-[60vw] max-lg:min-w-[60vw] z-[2] relative">
									</div>
								</div>
							</div>
						</div>
						<img class="leaf md:block hidden absolute top-0 left-[48.5%]" src="assets/images/main-slider/slider2/pic4.png" alt="/">
					</div>
				</div>
				<div class="swiper-slide">
					<div class="banner-inner1 bg-cover rounded-s-[30px] max-xl:rounded-none md:pt-[120px] pt-[50px] pb-[30px] overflow-hidden relative z-[1]"   style="background-image: url(assets/images/main-slider/slider2/bg2.jpg);">
						<div class="container">
							<div class="row items-center justify-end">
								<div class="lg:w-7/12 md:w-2/3 px-[15px]">
									<div class="banner-content md:mb-[60px] mb-0">
										<span class="font-medium text-xl text-primary block">The Best Food Stations</span>
										<h1 class="title mb-4 font-lobster text-white 2xl:text-[80px] xl:text-[70px] lg:text-[60px] md:text-[50px] text-[36px]">Bringing Joy to Your Plate With Food </h1>
										<p class="lg:max-w-[580px] md:max-w-[350px] max-w-full font-light lg:text-lg sm:text-base text-sm leading-[27px] text-[#ffffffb3]">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
										
										 <div class="banner-btn flex items-center lg:mt-10 sm:mt-[40px] mt-5 gap-[30px] lg:mb-[80px]">
										<a href="contact-us.html" class="btn btn-primary btn-md  btn-hover-1"><span>Book a Table</span></a>
										<a href="about-us.html" class="btn btn-outline btn-transparent text-primary btn-hover-1 btn-md"><span>View More</span></a>
									</div>
									<div class="food-card border-dashed border border-[#ffffff66] rounded-[10px] w-[370px] relative block max-xl:hidden">
										<div class="dz-head border-b border-dashed border-[#ffffff66] flex justify-between py-[15px] px-[25px]">
											<h5 class="text-white mb-2">Dal Makhni</h5>
											<ul class="rating flex">
												<li><i class="fa-solid fa-star"></i></li>
												<li><i class="fa-solid fa-star"></i></li>
												<li><i class="fa-solid fa-star"></i></li>
												<li><i class="fa-solid fa-star"></i></li>
												<li><i class="fa-solid fa-star"></i></li>
											</ul>
										</div>
										<div class="dz-body flex justify-between py-[16px] px-[25px]">
											<div class="dz-left">
												<div class="profile-info flex">
													<div class="dz-media">
														<img src="assets/images/team/pic2.jpg" alt="/" class=" w-[45px] h-[45px] rounded-full">
													</div>
													<div class="dz-content ml-2">
														<h6 class="mb-[3px] text-white">Carry Mint</h6>
														<p class="text-[13px] leading-5 text-[#C4C4C4] mb-4" >Master Chief</p>
													</div>
												</div>
												<p class="text-[#DCDCDC]">Lorem ipsum dolor shit amet...</p>
											</div>
											<div class="dz-right">
												<h5 class="text-primary mb-2">$15.00</h5>
												<a href="shop-cart.html" class="btn btn-primary btn-cart w-10 h-10 leading-[0.5rem] flex text-xl p-1"><i class="flaticon-shopping-cart text-white"></i></a>
											</div>
										</div>
										<img class="target-line absolute bottom-[50px] -right-full z-[2] translate-x-[25%] min-w-[485px]" src="assets/images/main-slider/slider2/line.png" alt="/">
									</div>
								</div>
								</div>
								<div class="lg:w-5/12 md:w-1/3 px-[15px]">
									<div class="banner-media relative">
										<img src="assets/images/main-slider/slider2/pic2.png" alt="/" class="w-[40vw] min-w-[40vw] max-lg:w-[60vw] max-lg:min-w-[60vw] z-[2] relative">
									</div>
								</div>
							</div>
						</div>
						<img class="leaf md:block hidden absolute top-0 left-[48.5%]" src="assets/images/main-slider/slider2/pic4.png" alt="/">
					</div>
				</div>
				<div class="swiper-slide">
					<div class="banner-inner1 bg-cover rounded-s-[30px] max-xl:rounded-none md:pt-[120px] pt-[50px] pb-[30px] overflow-hidden relative z-[1]"  style="background-image: url(assets/images/main-slider/slider2/bg3.jpg);">
						<div class="container">
							<div class="row items-center justify-end">
								<div class="lg:w-7/12 md:w-2/3 px-[15px]">
									<div class="banner-content md:mb-[60px] mb-0">
										<span class="font-medium text-xl text-primary block">Exploring the Delicious World</span>
										<h1 class="title mb-4 font-lobster text-white 2xl:text-[80px] xl:text-[70px] lg:text-[60px] md:text-[50px] text-[36px]">Food that Makes You Happy And Healthy</h1>
										<p class="lg:max-w-[580px] md:max-w-[350px] max-w-full font-light lg:text-lg sm:text-base text-sm leading-[27px] text-[#ffffffb3]">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
										
										 <div class="banner-btn flex items-center lg:mt-10 sm:mt-[40px] mt-5 gap-[30px] lg:mb-[80px]">
                                    <a href="contact-us.html" class="btn btn-primary btn-md  btn-hover-1"><span>Book a Table</span></a>
                                    <a href="about-us.html" class="btn btn-outline btn-transparent text-primary btn-hover-1 btn-md"><span>View More</span></a>
                                </div>
										<div class="food-card border-dashed border border-[#ffffff66] rounded-[10px] w-[370px] relative block max-xl:hidden">
											<div class="dz-head border-b border-dashed border-[#ffffff66] flex justify-between py-[15px] px-[25px]">
												<h5 class="text-white mb-2">Veg Biryani</h5>
												<ul class="rating flex">
													<li><i class="fa-solid fa-star"></i></li>
													<li><i class="fa-solid fa-star"></i></li>
													<li><i class="fa-solid fa-star"></i></li>
													<li><i class="fa-solid fa-star"></i></li>
													<li><i class="fa-solid fa-star"></i></li>
												</ul>
											</div>
											<div class="dz-body flex justify-between py-[16px] px-[25px]">
												<div class="dz-left">
													<div class="profile-info flex">
														<div class="dz-media">
															<img src="assets/images/team/pic2.jpg" alt="/" class=" w-[45px] h-[45px] rounded-full">
														</div>
														<div class="dz-content ml-2">
															<h6 class="mb-[3px] text-white">Kamy klay</h6>
															<p class="text-[13px] leading-5 text-[#C4C4C4] mb-4" >Master Chief</p>
														</div>
													</div>
													<p class="text-[#DCDCDC]">Lorem ipsum dolor shit amet...</p>
												</div>
												<div class="dz-right">
													<h5 class="text-primary mb-2">$15.00</h5>
													<a href="shop-cart.html" class="btn btn-primary btn-cart w-10 h-10 leading-[0.5rem] flex text-xl p-1"><i class="flaticon-shopping-cart text-white"></i></a>
												</div>
											</div>
											<img class="target-line absolute bottom-[50px] -right-full z-[2] translate-x-[25%] min-w-[485px]" src="assets/images/main-slider/slider2/line.png" alt="/">
										</div>
									</div>
								</div>
								<div class="lg:w-5/12 md:w-1/3 px-[15px]">
									<div class="banner-media relative">
										<img src="assets/images/main-slider/slider2/pic3.png" alt="/" class="w-[40vw] min-w-[40vw] max-lg:w-[60vw] max-lg:min-w-[60vw] z-[2] relative">
									</div>
								</div>
							</div>
						</div>
						<img class="leaf md:block hidden absolute top-0 left-[48.5%]" src="assets/images/main-slider/slider2/pic4.png" alt="/">
					</div>
				</div>
			</div>
		</div>
	</div>		
	<!-- Banner -->

	<!-- Browser Our Menu -->
	<section class="content-inner-1 pb-[100px] overflow-hidden pt-0">
		<div class="container">
			<div class="section-head font-lobster mb-[50px] max-xl:mb-[30px] mx-auto relative flex items-center justify-between">
				<h2 class="title mb-0 text-black2">Browse Our Menu</h2>
				<div class="pagination-align flex">
					<div class="menu-button-prev1 btn-prev btn-hover-2"><i class="fa-solid fa-arrow-left sm:text-xl text-[15px]"></i></div>
					<div class="menu-button-next1 btn-next btn-hover-2"><i class="fa-solid fa-arrow-right sm:text-xl text-[15px]"></i></div>
				</div>
			</div>
		</div>
		<div class="container">
			<div class="swiper menu-swiper2 swiper-visible swiper-item-4 overflow-visible">
				<div class="swiper-wrapper">
					<div class="swiper-slide">
						<div class="dz-img-box3 box-hover group style-4 bg-white p-[18px] flex flex-col h-[160px] relative z-[1] overflow-hidden rounded-[10px]">
							<div class="menu-detail flex items-center mb-3">
								<div class="dz-media mr-5 w-[60px] min-w-[60px] h-[60px]">
									<img src="assets/images/menu-small/pic1.png" alt="/">
								</div>
								<div class="dz-content">
									<h6 class="title mb-[3px] duration-500"><a href="product-detail.html">Burger</a></h6>
									<p>Delicious and Spicy</p>
								</div>
							</div>
							<div class="menu-footer max-w-[110px] mt-auto">
								<span class="text-bodycolor text-[13px]">Regular Price</span>
								<span class="price duration-500">$10.00</span>
							</div>
							<a class="detail-btn" href="product-detail.html"><i class="fa-solid fa-plus"></i></a>
						</div>
					</div>
					<div class="swiper-slide">
						<div class="dz-img-box3 box-hover group style-4 bg-white p-[18px] flex flex-col h-[160px] relative z-[1] overflow-hidden rounded-[10px]">
							<div class="menu-detail flex items-center mb-3">
								<div class="dz-media mr-5 w-[60px] min-w-[60px] h-[60px]">
									<img src="assets/images/menu-small/pic2.png" alt="/">
								</div>
								<div class="dz-content">
									<h6 class="title mb-[3px] duration-500"><a href="product-detail.html">Hot Rice</a></h6>
									<p>Delicious and Spicy</p>
								</div>
							</div>
							<div class="menu-footer max-w-[110px] mt-auto">
								<span class="text-bodycolor text-[13px]">Regular Price</span>
								<span class="price duration-500">$15.00</span>
							</div>
							<a class="detail-btn" href="product-detail.html"><i class="fa-solid fa-plus"></i></a>
						</div>
					</div>
					<div class="swiper-slide">
						<div class="dz-img-box3 box-hover group style-4 bg-white p-[18px] flex flex-col h-[160px] relative z-[1] overflow-hidden rounded-[10px]">
							<div class="menu-detail flex items-center mb-3">
								<div class="dz-media mr-5 w-[60px] min-w-[60px] h-[60px]">
									<img src="assets/images/menu-small/pic3.png" alt="/">
								</div>
								<div class="dz-content">
									<h6 class="title mb-[3px] duration-500"><a href="product-detail.html">Momos</a></h6>
									<p>Delicious and Spicy</p>
								</div>
							</div>
							<div class="menu-footer max-w-[110px] mt-auto">
								<span class="text-bodycolor text-[13px]">Regular Price</span>
								<span class="price duration-500">$25.00</span>
							</div>
							<a class="detail-btn" href="product-detail.html"><i class="fa-solid fa-plus"></i></a>
						</div>
					</div>
					<div class="swiper-slide">
						<div class="dz-img-box3 box-hover group style-4 bg-white p-[18px] flex flex-col h-[160px] relative z-[1] overflow-hidden rounded-[10px]">
							<div class="menu-detail flex items-center mb-3">
								<div class="dz-media mr-5 w-[60px] min-w-[60px] h-[60px]">
									<img src="assets/images/menu-small/pic4.png" alt="/">
								</div>
								<div class="dz-content">
									<h6 class="title mb-[3px] duration-500"><a href="product-detail.html">Pasta</a></h6>
									<p>Delicious and Spicy</p>
								</div>
							</div>
							<div class="menu-footer max-w-[110px] mt-auto">
								<span class="text-bodycolor text-[13px]">Regular Price</span>
								<span class="price duration-500">$45.00</span>
							</div>
							<a class="detail-btn" href="product-detail.html"><i class="fa-solid fa-plus"></i></a>
						</div>
					</div>
					<div class="swiper-slide">
						<div class="dz-img-box3 box-hover group style-4 bg-white p-[18px] flex flex-col h-[160px] relative z-[1] overflow-hidden rounded-[10px]">
							<div class="menu-detail flex items-center mb-3">
								<div class="dz-media mr-5 w-[60px] min-w-[60px] h-[60px]">
									<img src="assets/images/menu-small/pic5.png" alt="/">
								</div>
								<div class="dz-content">
									<h6 class="title mb-[3px] duration-500"><a href="product-detail.html">Panner</a></h6>
									<p>Delicious and Spicy</p>
								</div>
							</div>
							<div class="menu-footer max-w-[110px] mt-auto">
								<span class="text-bodycolor text-[13px]">Regular Price</span>
								<span class="price duration-500">$20.00</span>
							</div>
							<a class="detail-btn" href="product-detail.html"><i class="fa-solid fa-plus"></i></a>
						</div>
					</div>
					<div class="swiper-slide">
						<div class="dz-img-box3 box-hover group style-4 bg-white p-[18px] flex flex-col h-[160px] relative z-[1] overflow-hidden rounded-[10px]"">
							<div class="menu-detail flex items-center mb-3">
								<div class="dz-media mr-5 w-[60px] min-w-[60px] h-[60px]">
									<img src="assets/images/menu-small/pic6.png" alt="/">
								</div>
								<div class="dz-content">
									<h6 class="title mb-[3px] duration-500"><a href="product-detail.html">Soya Rice</a></h6>
									<p>Delicious and Spicy</p>
								</div>
							</div>
							<div class="menu-footer max-w-[110px] mt-auto">
								<span class="text-bodycolor text-[13px]">Regular Price</span>
								<span class="price duration-500">$90.00</span>
							</div>
							<a class="detail-btn" href="product-detail.html"><i class="fa-solid fa-plus"></i></a>
						</div>
					</div>
					<div class="swiper-slide">
						<div class="dz-img-box3 box-hover group style-4 bg-white p-[18px] flex flex-col h-[160px] relative z-[1] overflow-hidden rounded-[10px]">
							<div class="menu-detail flex items-center mb-3">
								<div class="dz-media mr-5 w-[60px] min-w-[60px] h-[60px]">
									<img src="assets/images/menu-small/pic1.png" alt="/">
								</div>
								<div class="dz-content">
									<h6 class="title mb-[3px] duration-500"><a href="product-detail.html">Burger</a></h6>
									<p>Delicious and Spicy</p>
								</div>
							</div>
							<div class="menu-footer max-w-[110px] mt-auto">
								<span class="text-bodycolor text-[13px]">Regular Price</span>
								<span class="price duration-500">$10.00</span>
							</div>
							<a class="detail-btn" href="product-detail.html"><i class="fa-solid fa-plus"></i></a>
						</div>
					</div>
					<div class="swiper-slide">
						<div class="dz-img-box3 box-hover group style-4 bg-white p-[18px] flex flex-col h-[160px] relative z-[1] overflow-hidden rounded-[10px]">
							<div class="menu-detail flex items-center mb-3">
								<div class="dz-media mr-5 w-[60px] min-w-[60px] h-[60px]">
									<img src="assets/images/menu-small/pic2.png" alt="/">
								</div>
								<div class="dz-content">
									<h6 class="title mb-[3px] duration-500"><a href="product-detail.html">Hot Rice</a></h6>
									<p>Delicious and Spicy</p>
								</div>
							</div>
							<div class="menu-footer max-w-[110px] mt-auto">
								<span class="text-bodycolor text-[13px]">Regular Price</span>
								<span class="price duration-500">$15.00</span>
							</div>
							<a class="detail-btn" href="product-detail.html"><i class="fa-solid fa-plus"></i></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Browser Our Menu -->

	<!--Today's Special-->
	<section class="bg-[url('../images/background/pic1.png')] bg-fixed sm:pt-[100px] pt-[50px] lg:pb-[70px] sm:pb-10 pb-5 relative z-[1] after:content-[''] after:absolute after:z-[-1] after:bg-black-blur after:opacity-100 after:w-full after:h-full after:top-0 after:left-0 after:backdrop-blur-[6px] 2xl:mx-[100px] 2xl:rounded-[30px] overflow-hidden">
		<div class="container">
			<div class="mb-[50px] max-xl:mb-[30px] relative mx-auto text-center">
				<h2 class="font-lobster text-white">Today's Special</h2>
			</div>	
			<div class="row">
				<div class="lg:w-1/4 sm:w-2/4 w-full px-[15px]">
					<div class="dz-img-box4 bg-white rounded-[10px] xl:p-[15px] p-2.5 mb-[30px] flex flex-col relative overflow-hidden z-[1] style-5">
						<div class="dz-content mb-[15px]">
							<div class="weight mb-[5px] flex justify-between items-center text-xs text-bodycolor">
								<span>Pizza</span>
								<span>756g</span>
							</div>
							<div class="price mb-[5px] flex justify-between items-center">
								<h6 class="text-[#000]">Pepperoni</h6>
								<h6 class="text-primary">$15.00</h6>
							</div>
						</div>
						<div class="dz-media rounded-[10px] mt-auto w-full h-full overflow-hidden relative">
							<img src="assets/images/gallery/grid3/pic1.jpg" alt="/" class="block w-full h-full">
							<a class="detail-btn top-[-50px] z-[2] left-[50%] translate-x-[-50%] opacity-0 rounded-xl" href="our-menu-1.html"><i class="fa-solid fa-plus text-white"></i></a>
						</div>
					</div>
				</div>
				<div class="lg:w-1/4 sm:w-2/4 w-full px-[15px]">
					<div class="dz-img-box4 bg-white rounded-[10px] xl:p-[15px] p-2.5 mb-[30px] flex flex-col relative overflow-hidden z-[1] style-5">
						<div class="dz-content mb-[15px]">
							<div class="weight mb-[5px] flex justify-between items-center text-xs text-bodycolor">
								<span>Pancake</span>
								<span>756g</span>
							</div>
							<div class="price mb-[5px] flex justify-between items-center">
								<h6 class="text-[#000]">Pancake stack</h6>
								<h6 class="text-primary">$18.00</h6>
							</div>
						</div>
						<div class="dz-media rounded-[10px] mt-auto w-full h-full overflow-hidden relative">
							<img src="assets/images/gallery/grid3/pic2.jpg" alt="/" class="block w-full h-full">
							<a class="detail-btn top-[-50px] z-[2] left-[50%] translate-x-[-50%] opacity-0 rounded-xl" href="our-menu-1.html"><i class="fa-solid fa-plus text-white"></i></a>
						</div>
					</div>
				</div>
				<div class="lg:w-1/4 sm:w-2/4 w-full px-[15px]">
					<div class="dz-img-box4 bg-white rounded-[10px] xl:p-[15px] p-2.5 mb-[30px] flex flex-col relative overflow-hidden z-[1] style-5">
						<div class="dz-content mb-[15px]">
							<div class="weight mb-[5px] flex justify-between items-center text-xs text-bodycolor">
								<span>Salad</span>
								<span>756g</span>
							</div>
							<div class="price mb-[5px] flex justify-between items-center">
								<h6 class="text-[#000]">Halumini</h6>
								<h6 class="text-primary">$10.00</h6>
							</div>
						</div>
						<div class="dz-media rounded-[10px] mt-auto w-full h-full overflow-hidden relative">
							<img src="assets/images/gallery/grid3/pic3.jpg" alt="/" class="block w-full h-full">
							<a class="detail-btn top-[-50px] z-[2] left-[50%] translate-x-[-50%] opacity-0 rounded-xl" href="our-menu-1.html"><i class="fa-solid fa-plus text-white"></i></a>
						</div>
					</div>
				</div>
				<div class="lg:w-1/4 sm:w-2/4 w-full px-[15px]">
					<div class="dz-img-box4 bg-white rounded-[10px] xl:p-[15px] p-2.5 mb-[30px] flex flex-col relative overflow-hidden z-[1] style-5">
						<div class="dz-content mb-[15px]">
							<div class="weight mb-[5px] flex justify-between items-center text-xs text-bodycolor">
								<span>Egg</span>
								<span>756g</span>
							</div>
							<div class="price mb-[5px] flex justify-between items-center">
								<h6 class="text-[#000]">Eggs</h6>
								<h6 class="text-primary">$12.00</h6>
							</div>
						</div>
						<div class="dz-media rounded-[10px] mt-auto w-full h-full overflow-hidden relative">
							<img src="assets/images/gallery/grid3/pic4.jpg" alt="/" class="block w-full h-full">
							<a class="detail-btn top-[-50px] z-[2] left-[50%] translate-x-[-50%] opacity-0 rounded-xl" href="our-menu-1.html"><i class="fa-solid fa-plus text-white"></i></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--Today's Special-->

	<!-- Our Menu-->
	<section class="content-inner-1 lg:py-[100px] py-[50px] relative ">
		<div class="container">
			<div class="mb-[50px] max-xl:mb-[30px] relative mx-auto text-center">
				<h2 class="title font-lobster text-black2">Our Menu</h2>
			</div>
			<div class="row justify-center">
				<div class="w-full px-[15px] text-center">
					<div class="site-filters mb-5">
						<ul class="filters">
							<li data-filter=".All" class="btn md:mb-0 mb-5 active"><a href="javascript:void(0);"><span><i class="flaticon-fast-food"></i></span>All</a></li>
							<li data-filter=".drink" class="btn md:mb-0 mb-5"><a href="javascript:void(0);"><span><i class="flaticon-cocktail"></i></span>COLD DRINK</a></li>
							<li data-filter=".pizza" class="btn md:mb-0 mb-5"><a href="javascript:void(0);"><span><i class="flaticon-pizza-slice"></i></span>PIZZA</a></li>
							<li data-filter=".salad" class="btn md:mb-0 mb-5 active"><a href="javascript:void(0);"><span><i class="flaticon-salad"></i></span>SALAD</a></li>
							<li data-filter=".sweet" class="btn md:mb-0 mb-5 active"><a href="javascript:void(0);"><span><i class="flaticon-cupcake"></i></span>SWEETS</a></li>
							<li data-filter=".spicy" class="btn md:mb-0 mb-5 active"><a href="javascript:void(0);"><span><i class="flaticon-chili-pepper"></i></span>SPICY</a></li>
							<li data-filter=".burger" class="btn md:mb-0 mb-5 active"><a href="javascript:void(0);"><span><i class="flaticon-hamburger-1"></i></span>BURGER</a></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="clearfix">
				<ul id="masonry" class="row dlab-gallery-listing gallery">
					<li class="card-container md:w-2/4 px-[15px] mb-[5px] All drink sweet salad">
						<div class="dz-img-box5 flex lg:flex-row md:flex-col flex-row lg:items-start md:items-center items-start lg:text-left md:text-center text-start xl:py-5 xl:px-[25px] p-[10px] rounded-[10px] duration-500 relative z-[1]">
							<div class="dz-media lg:mr-3 md:mr-0 mr-3 lg:mb-0 md:mb-5 mb-0 min-w-[80px] w-[80px]">
								<img src="assets/images/menu-small/grid/pic1.png" alt="/">
							</div>
							<div class="dz-content w-full">
								<div class="dz-head flex justify-between items-center">
									<span class="header-text sm:text-lg text-base font-semibold leading-7"><a href="our-menu-1.html" class="text-black2 max-w-[280px] text-ellipsis overflow-hidden block whitespace-nowrap hover:text-primary">Pulled Chicken SandWich</a></span>
									<span class="img-line sm:block hidden"></span>
									<span class="header-price sm:block hidden text-primary font-semibold text-xl leading-7">$30</span>
								</div>
								<p class="dz-body sm:text-[15px] text-sm text-bodycolor leading-[21px] font-normal">
									Lorem Ipsum is simply dummy text of the printing and typesetting industry.
								</p>
							</div>
						</div>
					</li>
					<li class="card-container md:w-2/4 px-[15px] mb-[5px] All pizza sweet">
						<div class="dz-img-box5 flex lg:flex-row md:flex-col flex-row lg:items-start md:items-center items-start lg:text-left md:text-center text-start xl:py-5 xl:px-[25px] p-[10px] rounded-[10px] duration-500 relative z-[1]">
							<div class="dz-media lg:mr-3 md:mr-0 mr-3 lg:mb-0 md:mb-5 mb-0 min-w-[80px] w-[80px]">
								<img src="assets/images/menu-small/grid/pic2.png" alt="/">
							</div>
							<div class="dz-content w-full">
								<div class="dz-head flex justify-between items-center">
									<span class="header-text sm:text-lg text-base font-semibold leading-7"><a href="our-menu-1.html" class="text-black2 max-w-[280px] text-ellipsis overflow-hidden block whitespace-nowrap hover:text-primary">BBQ Chicken Sandwich</a></span>
									<span class="img-line sm:block hidden"></span>
									<span class="header-price sm:block hidden text-primary font-semibold text-xl leading-7">$30</span>
								</div>
								<p class="dz-body sm:text-[15px] text-sm text-bodycolor leading-[21px] font-normal">
									Lorem Ipsum is simply dummy text of the printing and typesetting industry.
								</p>
							</div>
						</div>
					</li>
					<li class="card-container md:w-2/4 px-[15px] mb-[5px] All salad spicy">
						<div class="dz-img-box5 flex lg:flex-row md:flex-col flex-row lg:items-start md:items-center items-start lg:text-left md:text-center text-start xl:py-5 xl:px-[25px] p-[10px] rounded-[10px] duration-500 relative z-[1]">
							<div class="dz-media lg:mr-3 md:mr-0 mr-3 lg:mb-0 md:mb-5 mb-0 min-w-[80px] w-[80px]">
								<img src="assets/images/menu-small/grid/pic3.png" alt="/">
							</div>
							<div class="dz-content w-full">
								<div class="dz-head flex justify-between items-center">
									<span class="header-text sm:text-lg text-base font-semibold leading-7"><a href="our-menu-1.html" class="text-black2 max-w-[280px] text-ellipsis overflow-hidden block whitespace-nowrap hover:text-primary">Canada Dry Ginger Ale</a></span>
									<span class="img-line sm:block hidden"></span>
									<span class="header-price sm:block hidden text-primary font-semibold text-xl leading-7">$60</span>
								</div>
								<p class="dz-body sm:text-[15px] text-sm text-bodycolor leading-[21px] font-normal">
									Lorem Ipsum is simply dummy text of the printing and typesetting industry.
								</p>
							</div>
						</div>
					</li>
					<li class="card-container md:w-2/4 px-[15px] mb-[5px] All drink spicy sweet">
						<div class="dz-img-box5 flex lg:flex-row md:flex-col flex-row lg:items-start md:items-center items-start lg:text-left md:text-center text-start xl:py-5 xl:px-[25px] p-[10px] rounded-[10px] duration-500 relative z-[1]">
							<div class="dz-media lg:mr-3 md:mr-0 mr-3 lg:mb-0 md:mb-5 mb-0 min-w-[80px] w-[80px]">
								<img src="assets/images/menu-small/grid/pic4.png" alt="/">
							</div>
							<div class="dz-content w-full">
								<div class="dz-head flex justify-between items-center">
									<span class="header-text sm:text-lg text-base font-semibold leading-7"><a href="our-menu-1.html" class="text-black2 max-w-[280px] text-ellipsis overflow-hidden block whitespace-nowrap hover:text-primary">Honey Mustard Pasta</a></span>
									<span class="img-line sm:block hidden"></span>
									<span class="header-price sm:block hidden text-primary font-semibold text-xl leading-7">$20</span>
								</div>
								<p class="dz-body sm:text-[15px] text-sm text-bodycolor leading-[21px] font-normal">
									Lorem Ipsum is simply dummy text of the printing and typesetting industry.
								</p>
							</div>
						</div>
					</li>
					<li class="card-container md:w-2/4 px-[15px] mb-[5px] All burger">
						<div class="dz-img-box5 flex lg:flex-row md:flex-col flex-row lg:items-start md:items-center items-start lg:text-left md:text-center text-start xl:py-5 xl:px-[25px] p-[10px] rounded-[10px] duration-500 relative z-[1]">
							<div class="dz-media lg:mr-3 md:mr-0 mr-3 lg:mb-0 md:mb-5 mb-0 min-w-[80px] w-[80px]">
								<img src="assets/images/menu-small/grid/pic5.png" alt="/">
							</div>
							<div class="dz-content w-full">
								<div class="dz-head flex justify-between items-center">
									<span class="header-text sm:text-lg text-base font-semibold leading-7"><a href="our-menu-1.html" class="text-black2 max-w-[280px] text-ellipsis overflow-hidden block whitespace-nowrap hover:text-primary">Martinelli’s Apple Juice</a></span>
									<span class="img-line sm:block hidden"></span>
									<span class="header-price sm:block hidden text-primary font-semibold text-xl leading-7">$80</span>
								</div>
								<p class="dz-body sm:text-[15px] text-sm text-bodycolor leading-[21px] font-normal">
									Lorem Ipsum is simply dummy text of the printing and typesetting industry.
								</p>
							</div>
						</div>
					</li>
					<li class="card-container md:w-2/4 px-[15px] mb-[5px] All pizza burger">
						<div class="dz-img-box5 flex lg:flex-row md:flex-col flex-row lg:items-start md:items-center items-start lg:text-left md:text-center text-start xl:py-5 xl:px-[25px] p-[10px] rounded-[10px] duration-500 relative z-[1]">
							<div class="dz-media lg:mr-3 md:mr-0 mr-3 lg:mb-0 md:mb-5 mb-0 min-w-[80px] w-[80px]">
								<img src="assets/images/menu-small/grid/pic6.png" alt="/">
							</div>
							<div class="dz-content w-full">
								<div class="dz-head flex justify-between items-center">
									<span class="header-text sm:text-lg text-base font-semibold leading-7"><a href="our-menu-1.html" class="text-black2 max-w-[280px] text-ellipsis overflow-hidden block whitespace-nowrap hover:text-primary">Chicken Honey Plate</a></span>
									<span class="img-line sm:block hidden"></span>
									<span class="header-price sm:block hidden text-primary font-semibold text-xl leading-7">$80</span>
								</div>
								<p class="dz-body sm:text-[15px] text-sm text-bodycolor leading-[21px] font-normal">
									Lorem Ipsum is simply dummy text of the printing and typesetting industry.
								</p>
							</div>
						</div>
					</li>
					<li class="card-container md:w-2/4 px-[15px] mb-[5px] All burger salad">
						<div class="dz-img-box5 flex lg:flex-row md:flex-col flex-row lg:items-start md:items-center items-start lg:text-left md:text-center text-start xl:py-5 xl:px-[25px] p-[10px] rounded-[10px] duration-500 relative z-[1]">
							<div class="dz-media lg:mr-3 md:mr-0 mr-3 lg:mb-0 md:mb-5 mb-0 min-w-[80px] w-[80px]">
								<img src="assets/images/menu-small/grid/pic7.png" alt="/">
							</div>
							<div class="dz-content w-full">
								<div class="dz-head flex justify-between items-center">
									<span class="header-text sm:text-lg text-base font-semibold leading-7"><a href="our-menu-1.html" class="text-black2 max-w-[280px] text-ellipsis overflow-hidden block whitespace-nowrap hover:text-primary">Mango Mania Smoothie</a></span>
									<span class="img-line sm:block hidden"></span>
									<span class="header-price sm:block hidden text-primary font-semibold text-xl leading-7">$30</span>
								</div>
								<p class="dz-body sm:text-[15px] text-sm text-bodycolor leading-[21px] font-normal">
									Lorem Ipsum is simply dummy text of the printing and typesetting industry.
								</p>
							</div>
						</div>
					</li>
					<li class="card-container md:w-2/4 px-[15px] mb-[5px] All drink">
						<div class="dz-img-box5 flex lg:flex-row md:flex-col flex-row lg:items-start md:items-center items-start lg:text-left md:text-center text-start xl:py-5 xl:px-[25px] p-[10px] rounded-[10px] duration-500 relative z-[1]">
							<div class="dz-media lg:mr-3 md:mr-0 mr-3 lg:mb-0 md:mb-5 mb-0 min-w-[80px] w-[80px]">
								<img src="assets/images/menu-small/grid/pic8.png" alt="/">
							</div>
							<div class="dz-content w-full">
								<div class="dz-head flex justify-between items-center">
									<span class="header-text sm:text-lg text-base font-semibold leading-7"><a href="our-menu-1.html" class="text-black2 max-w-[280px] text-ellipsis overflow-hidden block whitespace-nowrap hover:text-primary">Jamaican Jerk Sandwich</a></span>
									<span class="img-line sm:block hidden"></span>
									<span class="header-price sm:block hidden text-primary font-semibold text-xl leading-7">$80</span>
								</div>
								<p class="dz-body sm:text-[15px] text-sm text-bodycolor leading-[21px] font-normal">
									Lorem Ipsum is simply dummy text of the printing and typesetting industry.
								</p>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</section>
	<!-- Are Menu-->
    
	<!-- Icon wrapper-2  -->
	<section class="content-inner  sm:pb-[70px] pt-[50px] pb-5">
		<div class="container">
			<div class="row justify-center relative icon-wrapper2 md:mx-[-30px]">
				<div class="lg:w-2/6 w-full md:w-6/12 px-[30px] max-2lg:px-6 mb-[30px]">
					<div class="icon-bx-wraper bg-white overflow-hidden flex items-center duration-500">
						<div class="icon-bx duration-500 bg-[var(--rgba-primary-1)] xl:w-[100px] xl:h-[100px] xl:min-w-[100px] w-[80px] h-[80px] min-w-[80px] rounded-full text-center mr-5 xl:leading-[110px] leading-[80px]">
							<span class="icon-cell text-primary duration-500">
								<i class="flaticon-offer xl:text-[45px] text-[35px]"></i>
							</span>
						</div>
						<div class="icon-content overflow-hidden">
							<h5 class="dz-title mb-2 xl:text-xl text-lg"><a href="services.html">Discount Voucher</a></h5>
							<p class="text-[15px]">lorem ipsum dolor shit amet lorem ipsum</p>
						</div>
					</div>
				</div>
				<div class="lg:w-2/6 w-full md:w-6/12 px-[30px] max-2lg:px-6 mb-[30px]">
					<div class="icon-bx-wraper bg-white overflow-hidden flex items-center duration-500">
						<div class="icon-bx duration-500 bg-[var(--rgba-primary-1)] xl:w-[100px] xl:h-[100px] xl:min-w-[100px] w-[80px] h-[80px] min-w-[80px] rounded-full text-center mr-5 xl:leading-[110px] leading-[80px]">
							<span class="icon-cell text-primary duration-500">
								<i class="flaticon-hamburger xl:text-[45px] text-[35px]"></i>
							</span>
						</div>
						<div class="icon-content overflow-hidden">
							<h5 class="dz-title mb-2 xl:text-xl text-lg"><a href="services.html">Fresh Healthy Food</a></h5>
							<p class="text-[15px]">lorem ipsum dolor shit amet lorem ipsum</p>
						</div>
					</div>
				</div>
				<div class="lg:w-2/6 w-full md:w-6/12 px-[30px] max-2lg:px-6 mb-[30px]">
					<div class="icon-bx-wraper bg-white overflow-hidden flex items-center duration-500">
						<div class="icon-bx duration-500 bg-[var(--rgba-primary-1)] xl:w-[100px] xl:h-[100px] xl:min-w-[100px] w-[80px] h-[80px] min-w-[80px] rounded-full text-center mr-5 xl:leading-[110px] leading-[80px]">
							<span class="icon-cell text-primary duration-500">
								<i class="flaticon-room-service xl:text-[45px] text-[35px]"></i>
							</span>
						</div>
						<div class="icon-content overflow-hidden">
							<h5 class="dz-title mb-2 xl:text-xl text-lg"><a href="services.html">Discount Voucher</a></h5>
							<p class="text-[15px]">lorem ipsum dolor shit amet lorem ipsum</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Master Chef -->
	<section class="bg-light sm:content-inner lg:pt-[100px] pt-[70px] lg:pb-[70px] pb-[40px] relative overflow-hidden max-2xl:mx-0 mx-[100px] max-2xl:rounded-none rounded-[30px] bg-[url('images/background/pic10.html')] bg-fixed">
		<div class="container">
			<div class="mb-[50px] max-xl:mb-[30px] relative mx-auto text-center">
				<h2 class="font-lobster">Meet The Chef's</h2>
			</div>
			<div class="swiper team-swiper overflow-visible swiper-visible">
				<div class="swiper-wrapper">
					<div class="swiper-slide">
						<div class="slide-box mb-[30px]">
							<div class="shadow-[0_15px_55px_rgba(35,35,35,0.15)] rounded-[10px] bg-white overflow-hidden group">
								<div class="relative  overflow-hidden z-[1] before:content-[''] before:absolute before:w-[200px] before:h-[200px] before:bg-black2 before:top-[-100px] before:left-[-100px] before:opacity-30 before:z-[1] before:duration-500 before:rounded-full before:scale-50 before:translate-x-[-50%] group-hover:before:scale-[7]">
									<img src="assets/images/team/pic1.jpg" alt="/" class="group-hover:scale-110 duration-500 block w-full">
								</div>
								<div class="content bg-white flex justify-between items-center py-[15px] px-5">
									<div class="clearfix">
										<h6>
											<a href="team-detail.html">
												Sarah Albert
											</a>
										</h6>	
										<span class="font-normal text-sm leading-5 text-primary">Senior Chef</span>
									</div>
									<ul class="team-social">
										<li class="relative">
											<a href="javascript:void(0);" class="text-xl inline-block h-10 w-10 leading-10 text-center rounded-lg bg-primary text-white pt-[2px]">
												<i class="flaticon-share"></i>
											</a>
											<ul class="sub-team-social absolute bottom-0 z-[1] w-10 rounded-lg opacity-0 duration-500 	hover:opacity-100 hover:pb-[80px]">
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#4867AA] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fab fa-facebook-f"></i>
													</a>
												</li>
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#81B2DF] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fab fa-twitter"></i>
													</a>
												</li>												
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#D74141] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fab fa-instagram"></i>
													</a>
												</li>										
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#3A9DF9] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fa-brands fa-linkedin-in"></i>
													</a>
												</li>											
											</ul>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="swiper-slide"> 
						<div class="slide-box mb-[30px]">
							<div class="shadow-[0_15px_55px_rgba(35,35,35,0.15)] rounded-[10px] bg-white overflow-hidden group">
								<div class="relative  overflow-hidden z-[1] before:content-[''] before:absolute before:w-[200px] before:h-[200px] before:bg-black2 before:top-[-100px] before:left-[-100px] before:opacity-30 before:z-[1] before:duration-500 before:rounded-full before:scale-50 before:translate-x-[-50%] group-hover:before:scale-[7]">
									<img src="assets/images/team/pic2.jpg" alt="/" class="group-hover:scale-110 duration-500 block w-full">
								</div>
								<div class="content bg-white flex justify-between items-center py-[15px] px-5">
									<div class="clearfix">
										<h6>
											<a href="team-detail.html">
												John Doe
											</a>
										</h6>
										<span class="font-normal text-sm leading-5 text-primary">Senior Chef</span>
									</div>
									<ul class="team-social">
										<li class="relative">
											<a href="javascript:void(0);" class="text-xl inline-block h-10 w-10 leading-10 text-center rounded-lg bg-primary text-white pt-[2px]">
												<i class="flaticon-share"></i>
											</a>
											<ul class="sub-team-social absolute bottom-0 z-[1] w-10 rounded-lg opacity-0 duration-500 	hover:opacity-100 hover:pb-[80px]">
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#4867AA] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fab fa-facebook-f"></i>
													</a>
												</li>
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#81B2DF] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fab fa-twitter"></i>
													</a>
												</li>												
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#D74141] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fab fa-instagram"></i>
													</a>
												</li>										
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#3A9DF9] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fa-brands fa-linkedin-in"></i>
													</a>
												</li>											
											</ul>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="swiper-slide">
						<div class="slide-box mb-[30px]">
							<div class="shadow-[0_15px_55px_rgba(35,35,35,0.15)] rounded-[10px] bg-white overflow-hidden group">
								<div class="relative  overflow-hidden z-[1] before:content-[''] before:absolute before:w-[200px] before:h-[200px] before:bg-black2 before:top-[-100px] before:left-[-100px] before:opacity-30 before:z-[1] before:duration-500 before:rounded-full before:scale-50 before:translate-x-[-50%] group-hover:before:scale-[7]">
									<img src="assets/images/team/pic3.jpg" alt="/" class="group-hover:scale-110 duration-500 block w-full">
								</div>
								<div class="content bg-white flex justify-between items-center py-[15px] px-5">
									<div class="clearfix">
										<h6>
											<a href="team-detail.html">
												Jemy carline
											</a>
										</h6>
										<span class="font-normal text-sm leading-5 text-primary">Senior Chef</span>
									</div>
									<ul class="team-social">
										<li class="relative">
											<a href="javascript:void(0);" class="text-xl inline-block h-10 w-10 leading-10 text-center rounded-lg bg-primary text-white pt-[2px]">
												<i class="flaticon-share"></i>
											</a>
											<ul class="sub-team-social absolute bottom-0 z-[1] w-10 rounded-lg opacity-0 duration-500 	hover:opacity-100 hover:pb-[80px]">
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#4867AA] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fab fa-facebook-f"></i>
													</a>
												</li>
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#81B2DF] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fab fa-twitter"></i>
													</a>
												</li>												
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#D74141] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fab fa-instagram"></i>
													</a>
												</li>										
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#3A9DF9] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fa-brands fa-linkedin-in"></i>
													</a>
												</li>											
											</ul>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="swiper-slide"> 
						<div class="slide-box mb-[30px]">
							<div class="shadow-[0_15px_55px_rgba(35,35,35,0.15)] rounded-[10px] bg-white overflow-hidden group">
								<div class="relative  overflow-hidden z-[1] before:content-[''] before:absolute before:w-[200px] before:h-[200px] before:bg-black2 before:top-[-100px] before:left-[-100px] before:opacity-30 before:z-[1] before:duration-500 before:rounded-full before:scale-50 before:translate-x-[-50%] group-hover:before:scale-[7]">
									<img src="assets/images/team/pic4.jpg" alt="/" class="group-hover:scale-110 duration-500 block w-full">
								</div>
								<div class="content bg-white flex justify-between items-center py-[15px] px-5">
									<div class="clearfix">
										<h6>
											<a href="team-detail.html">
												Cotline Care
											</a>
										</h6>
										<span class="font-normal text-sm leading-5 text-primary">Senior Chef</span>
									</div>
									<ul class="team-social">
										<li class="relative">
											<a href="javascript:void(0);" class="text-xl inline-block h-10 w-10 leading-10 text-center rounded-lg bg-primary text-white pt-[2px]">
												<i class="flaticon-share"></i>
											</a>
											<ul class="sub-team-social absolute bottom-0 z-[1] w-10 rounded-lg opacity-0 duration-500 	hover:opacity-100 hover:pb-[80px]">
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#4867AA] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fab fa-facebook-f"></i>
													</a>
												</li>
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#81B2DF] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fab fa-twitter"></i>
													</a>
												</li>												
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#D74141] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fab fa-instagram"></i>
													</a>
												</li>										
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#3A9DF9] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fa-brands fa-linkedin-in"></i>
													</a>
												</li>											
											</ul>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="swiper-slide"> 
						<div class="slide-box mb-[30px]">
							<div class="shadow-[0_15px_55px_rgba(35,35,35,0.15)] rounded-[10px] bg-white overflow-hidden group">
								<div class="relative  overflow-hidden z-[1] before:content-[''] before:absolute before:w-[200px] before:h-[200px] before:bg-black2 before:top-[-100px] before:left-[-100px] before:opacity-30 before:z-[1] before:duration-500 before:rounded-full before:scale-50 before:translate-x-[-50%] group-hover:before:scale-[7]">
									<img src="assets/images/team/pic1.jpg" alt="/" class="group-hover:scale-110 duration-500 block w-full">
								</div>
								<div class="content bg-white flex justify-between items-center py-[15px] px-5">
									<div class="clearfix">
										<h6>
											<a href="team-detail.html">
												Sarah Albert
											</a>
										</h6>
										<span class="font-normal text-sm leading-5 text-primary">Senior Chef</span>
									</div>
									<ul class="team-social">
										<li class="relative">
											<a href="javascript:void(0);" class="text-xl inline-block h-10 w-10 leading-10 text-center rounded-lg bg-primary text-white pt-[2px]">
												<i class="flaticon-share"></i>
											</a>
											<ul class="sub-team-social absolute bottom-0 z-[1] w-10 rounded-lg opacity-0 duration-500 	hover:opacity-100 hover:pb-[80px]">
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#4867AA] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fab fa-facebook-f"></i>
													</a>
												</li>
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#81B2DF] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fab fa-twitter"></i>
													</a>
												</li>												
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#D74141] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fab fa-instagram"></i>
													</a>
												</li>										
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#3A9DF9] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fa-brands fa-linkedin-in"></i>
													</a>
												</li>											
											</ul>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="swiper-slide"> 
						<div class="slide-box mb-[30px]">
							<div class="shadow-[0_15px_55px_rgba(35,35,35,0.15)] rounded-[10px] bg-white overflow-hidden group">
								<div class="relative  overflow-hidden z-[1] before:content-[''] before:absolute before:w-[200px] before:h-[200px] before:bg-black2 before:top-[-100px] before:left-[-100px] before:opacity-30 before:z-[1] before:duration-500 before:rounded-full before:scale-50 before:translate-x-[-50%] group-hover:before:scale-[7]">
									<img src="assets/images/team/pic2.jpg" alt="/" class="group-hover:scale-110 duration-500 block w-full">
								</div>
								<div class="content bg-white flex justify-between items-center py-[15px] px-5">
									<div class="clearfix">
										<h6>
											<a href="team-detail.html">
												Sarah Albert
											</a>
										</h6>
										<span class="font-normal text-sm leading-5 text-primary">Senior Chef</span>
									</div>
									<ul class="team-social">
										<li class="relative">
											<a href="javascript:void(0);" class="text-xl inline-block h-10 w-10 leading-10 text-center rounded-lg bg-primary text-white pt-[2px]">
												<i class="flaticon-share"></i>
											</a>
											<ul class="sub-team-social absolute bottom-0 z-[1] w-10 rounded-lg opacity-0 duration-500 	hover:opacity-100 hover:pb-[80px]">
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#4867AA] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fab fa-facebook-f"></i>
													</a>
												</li>
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#81B2DF] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fab fa-twitter"></i>
													</a>
												</li>												
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#D74141] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fab fa-instagram"></i>
													</a>
												</li>										
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#3A9DF9] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fa-brands fa-linkedin-in"></i>
													</a>
												</li>											
											</ul>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="swiper-slide"> 
						<div class="slide-box mb-[30px]">
							<div class="shadow-[0_15px_55px_rgba(35,35,35,0.15)] rounded-[10px] bg-white overflow-hidden group">
								<div class="relative  overflow-hidden z-[1] before:content-[''] before:absolute before:w-[200px] before:h-[200px] before:bg-black2 before:top-[-100px] before:left-[-100px] before:opacity-30 before:z-[1] before:duration-500 before:rounded-full before:scale-50 before:translate-x-[-50%] group-hover:before:scale-[7]">
									<img src="assets/images/team/pic3.jpg" alt="/" class="group-hover:scale-110 duration-500 block w-full">
								</div>
								<div class="content bg-white flex justify-between items-center py-[15px] px-5">
									<div class="clearfix">
										<h6>
											<a href="team-detail.html">
												Sarah Albert
											</a>
										</h6>
										<span class="font-normal text-sm leading-5 text-primary">Senior Chef</span>
									</div>
									<ul class="team-social">
										<li class="relative">
											<a href="javascript:void(0);" class="text-xl inline-block h-10 w-10 leading-10 text-center rounded-lg bg-primary text-white pt-[2px]">
												<i class="flaticon-share"></i>
											</a>
											<ul class="sub-team-social absolute bottom-0 z-[1] w-10 rounded-lg opacity-0 duration-500 	hover:opacity-100 hover:pb-[80px]">
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#4867AA] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fab fa-facebook-f"></i>
													</a>
												</li>
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#81B2DF] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fab fa-twitter"></i>
													</a>
												</li>												
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#D74141] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fab fa-instagram"></i>
													</a>
												</li>										
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#3A9DF9] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fa-brands fa-linkedin-in"></i>
													</a>
												</li>											
											</ul>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="swiper-slide"> 
						<div class="slide-box mb-[30px]">
							<div class="shadow-[0_15px_55px_rgba(35,35,35,0.15)] rounded-[10px] bg-white overflow-hidden group">
								<div class="relative  overflow-hidden z-[1] before:content-[''] before:absolute before:w-[200px] before:h-[200px] before:bg-black2 before:top-[-100px] before:left-[-100px] before:opacity-30 before:z-[1] before:duration-500 before:rounded-full before:scale-50 before:translate-x-[-50%] group-hover:before:scale-[7]">
									<img src="assets/images/team/pic4.jpg" alt="/" class="group-hover:scale-110 duration-500 block w-full">
								</div>
								<div class="content bg-white flex justify-between items-center py-[15px] px-5">
									<div class="clearfix">
										<h6>
											<a href="team-detail.html">
												Sarah Albert
											</a>
										</h6>
										<span class="font-normal text-sm leading-5 text-primary">Senior Chef</span>
									</div>
									<ul class="team-social">
										<li class="relative">
											<a href="javascript:void(0);" class="text-xl inline-block h-10 w-10 leading-10 text-center rounded-lg bg-primary text-white pt-[2px]">
												<i class="flaticon-share"></i>
											</a>
											<ul class="sub-team-social absolute bottom-0 z-[1] w-10 rounded-lg opacity-0 duration-500 	hover:opacity-100 hover:pb-[80px]">
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#4867AA] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fab fa-facebook-f"></i>
													</a>
												</li>
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#81B2DF] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fab fa-twitter"></i>
													</a>
												</li>												
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#D74141] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fab fa-instagram"></i>
													</a>
												</li>										
												<li class="mb-2 relative">
													<a href="javascript:void(0);" class="text-white duration-500 text-center text-lg bg-[#3A9DF9] h-10 w-10 flex items-center justify-center rounded-lg">
														<i class="fa-brands fa-linkedin-in"></i>
													</a>
												</li>											
											</ul>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="pagination">
				<div class="team-button-prev prev1 btn-prev rounded-full top-[50%] absolute left-[-100px] max-xl:left-[-55px]"><i class="fa-solid fa-arrow-left"></i></div>
				<div class="team-button-next btn-next next1 rounded-full top-[50%] absolute right-[-100px] max-xl:right-[-55px]"><i class="fa-solid fa-arrow-right"></i></div>
			</div>
		</div>
	</section>
	<!-- Master Chef End -->

	<!-- Testimonials -->
	<section class="content-inner-2 overflow-hidden lg:pt-[100px] sm:pt-[70px] pt-[50px]">
		<div class="container">
			<div class="mb-[50px] max-xl:mb-[30px] relative mx-auto text-center">
				<h2 class="font-lobster">Customer's Comment</h2>
			</div>
			<div class="swiper testimonial-two-swiper swiper-btn-lr swiper-single overflow-visible swiper-visible">
				<div class="swiper-wrapper">
					<div class="swiper-slide">
						<div class="testimonial-2 flex lg:flex-row flex-col bg-white relative">
							<div class="dz-media rounded-lg xl:w-[570px] xl:min-w-[570px] lg:w-[450px] lg:min-w-[450px] w-full relative overflow-hidden">
								<img src="assets/images/testimonial/large/pic1.jpg" alt="/">
							</div>
							<div class="testimonial-1 lg:pt-5 lg:pb-[30px] lg:pl-[30px] py-5 relative w-full flex flex-col">
								<div class="testimonial-text relative mb-[15px] text-base">
									<p class="xl:text-[18px] text-base leading-[32px] font-medium text-[#222222]">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text.</p>
								</div>
								<div class="testimonial-info pl-[15px] xl:mt-[60px] relative z-[1] after:content-[''] after:bg-primary after:rounded after:h-[5px] after:w-[50px] after:absolute after:top-[25px] after:left-[-22px] after:rotate-90">
									<h5 class="testimonial-name font-bold leading-[32px] lg:text-[25px] text-lg">Carry Mint</h5>
									<span class="testimonial-position leading-[21px] text-sm block text-primary">Food Expert</span>
								</div>
								<i class="flaticon-right-quote quote absolute lg:right-[35px] right-5 bottom-[15px] xl:text-[102px] lg:text-[85px] text-[65px] text-primary inline-flex items-center"></i>
							</div>
						</div>
					</div>
					<div class="swiper-slide">
						<div class="testimonial-2 flex lg:flex-row flex-col bg-white relative">
							<div class="dz-media rounded-lg xl:w-[570px] xl:min-w-[570px] lg:w-[450px] lg:min-w-[450px] w-full relative overflow-hidden">
								<img src="assets/images/testimonial/large/pic2.jpg" alt="/">
							</div>
							<div class="testimonial-1 lg:pt-5 lg:pb-[30px] lg:pl-[30px] py-5 relative w-full flex flex-col">
								<div class="testimonial-text relative mb-[15px] text-base">
									<p class="xl:text-[18px] text-base leading-[32px] font-medium text-[#222222]">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text.</p>
								</div>
								<div class="testimonial-info pl-[15px] xl:mt-[60px] relative z-[1] after:content-[''] after:bg-primary after:rounded after:h-[5px] after:w-[50px] after:absolute after:top-[25px] after:left-[-22px] after:rotate-90">
									<h5 class="testimonial-name font-bold leading-[32px] lg:text-[25px] text-lg">John Doe</h5>
									<span class="testimonial-position leading-[21px] text-sm block text-primary">Food Expert</span>
								</div>
								<i class="flaticon-right-quote quote absolute lg:right-[35px] right-5 bottom-[15px] xl:text-[102px] lg:text-[85px] text-[65px] text-primary inline-flex items-center"></i>
							</div>
						</div>
					</div>
					<div class="swiper-slide">
						<div class="testimonial-2 flex lg:flex-row flex-col bg-white relative">
							<div class="dz-media rounded-lg xl:w-[570px] xl:min-w-[570px] lg:w-[450px] lg:min-w-[450px] w-full relative overflow-hidden">
								<img src="assets/images/testimonial/large/pic3.jpg" alt="/">
							</div>
							<div class="testimonial-1 lg:pt-5 lg:pb-[30px] lg:pl-[30px] py-5 relative w-full flex flex-col">
								<div class="testimonial-text relative mb-[15px] text-base">
									<p class="xl:text-[18px] text-base leading-[32px] font-medium text-[#222222]">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text.</p>
								</div>
								<div class="testimonial-info pl-[15px] xl:mt-[60px] relative z-[1] after:content-[''] after:bg-primary after:rounded after:h-[5px] after:w-[50px] after:absolute after:top-[25px] after:left-[-22px] after:rotate-90">
									<h5 class="testimonial-name font-bold leading-[32px] lg:text-[25px] text-lg">Marn Kamk</h5>
									<span class="testimonial-position leading-[21px] text-sm block text-primary">Food Expert</span>
								</div>
								<i class="flaticon-right-quote quote absolute lg:right-[35px] right-5 bottom-[15px] xl:text-[102px] lg:text-[85px] text-[65px] text-primary inline-flex items-center"></i>
							</div>
						</div>
					</div>
				</div>
				<div class="pagination">
					<div class="testimonial-2-button-prev btn-prev rounded-full top-[50%] absolute left-[-100px] max-xl:left-[-60px]"><i class="fa-solid fa-arrow-left"></i></div>
					<div class="testimonial-2-button-next btn-next rounded-full top-[50%] absolute right-[-100px] max-xl:right-[-60px]"><i class="fa-solid fa-arrow-right"></i></div>
				</div>
			</div>
		</div>
	</section>
	<!-- Testimonial -->	

	<!-- Our Blog  -->
	<section class="content-inner lg:pb-[70px] pb-10 overflow-hidden relative">
		<div class="container">
			<div class="row">
				<div class="xl:w-7/12 px-[15px] w-full">
					<div class="mb-[50px] max-xl:mb-[30px] relative mx-auto text-center">
						<h2 class="font-lobster text-left">Recent News & Updates</h2>
					</div>
					<div class="dz-card style-2 blog-half rounded-lg overflow-hidden duration-500 bg-[#2222220d] md:flex relative mb-[30px]">
						<div class="dz-media overflow-hidden relative md:w-[270px] md:min-w-[270px] w-full md:h-auto h-[250px]">
							<a href="blog-standard.html" class="block h-full"><img src="assets/images/blog/grid2/pic1.jpg" alt="/" class="min-w-auto w-full"></a>
							<div class="dz-date">12 Feb 2024</div>
						</div>
						<div class="dz-info flex flex-col relative p-[25px] ">
							<h4 class="dz-title mb-[10px]"><a href="blog-standard.html">Chill Out with These Refreshing</a></h4>
							<div class="dz-meta mb-[15px]">
								<ul>
									<li class="dz-user">
										<a href="javascript:void(0);" class="text-black2"><i class="fa-solid fa-user text-xs text-primary mr-[5px] relative top-0 scale-[1.2]"></i>
										By <span class="text-primary">RK Gupta</span></a>
									</li>
									<li class="dz-comment">
										<a href="javascript:void(0);" class="text-black2"><i class="fa-solid fa-message text-xs text-primary mr-[5px] relative top-0 scale-[1.2]"></i>
										10 Comments</a>
									</li>
								</ul>
							</div>
							<div class="btn-wrapper mt-auto">
								<a href="blog-standard.html" class="btn btn-primary btn-hover-2">Read More</a>
							</div>
						</div>
					</div>
					<div class="dz-card style-2 blog-half rounded-lg overflow-hidden duration-500 bg-[#2222220d] md:flex relative mb-[30px]">
						<div class="dz-media overflow-hidden relative md:w-[270px] md:min-w-[270px] w-full md:h-auto h-[250px]">
							<a href="blog-standard.html" class="block h-full"><img src="assets/images/blog/grid2/pic2.jpg" alt="/" class="min-w-auto w-full"></a>
							<div class="dz-date">24 Feb 2024</div>
						</div>
						<div class="dz-info flex flex-col relative p-[25px] ">
							<h4 class="dz-title mb-[10px]"><a href="blog-standard.html">Taste Excitement: A Sneak Peek into the</a></h4>
							<div class="dz-meta mb-[15px]">
								<ul>
									<li class="dz-user">
										<a href="javascript:void(0);" class="text-black2"><i class="fa-solid fa-user text-xs text-primary mr-[5px] relative top-0 scale-[1.2]"></i>
										By <span class="text-primary">KK Sharma</span></a>
									</li>
									<li class="dz-comment">
										<a href="javascript:void(0);" class="text-black2"><i class="fa-solid fa-message text-xs text-primary mr-[5px] relative top-0 scale-[1.2]"></i>
										24 Comments</a>
									</li>
								</ul>
							</div>
							<div class="btn-wrapper mt-auto">
								<a href="blog-standard.html" class="btn btn-primary btn-hover-2">Read More</a>
							</div>
						</div>
					</div>
				</div>
				<div class="xl:w-5/12 w-full px-[15px] mb-[30px]">
					<div class="dz-card style-3 dz-card-large blog-half relative sm:min-h-[570px] min-h-[450px] h-full overflow-hidden rounded-lg flex flex-col" style="background-image: url(assets/images/blog/large/pic1.jpg)">
						<video autoplay loop muted class="absolute top-0 left-0 object-cover w-full h-full">
							<source src="assets/video/video.mp4" type="video/mp4">
						</video>
						<div class="dz-info p-[35px] z-[1] mt-auto">
							<h3 class="dz-title mb-[15px]"><a href="blog-standard.html" class="text-white">Exploring the World of Pizza</a></h3>
							<div class="dz-meta mb-[15px]">
								<ul>
									<li class="dz-date absolute top-[35px] left-[35px] after:hidden py-[10px] px-[15px] block">14 Feb 2024</li>
									<li class="dz-user">
										<a href="javascript:void(0);" class="text-white"><i class="fa-solid fa-user text-xs text-primary mr-[5px] relative top-0 scale-[1.2]"></i>
										By <span class="text-primary">RK Gupta</span></a>
									</li>
									<li class="dz-comment">
										<a href="javascript:void(0);" class="text-white"><i class="fa-solid fa-message text-xs text-primary mr-[5px] relative top-0 scale-[1.2]"></i>
										10 Comments</a>
									</li>
								</ul>
							</div>
						</div>							
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Our Blog End  -->
	

</asp:Content>
