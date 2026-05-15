<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="khan_e_azam_website._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

	<!-- Banner -->
	<div class="main-bnr-2 overflow-hidden translate-y-[95px] max-xl:translate-y-[75px] mb-[90px] max-xl:mb-[75px] max-sm:mb-[60px]">
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
				<asp:Repeater ID="rptBanner" runat="server">
					<ItemTemplate>
						<div class="swiper-slide">
							<div class="banner-inner1 bg-cover rounded-s-[30px] max-xl:rounded-none md:pt-[120px] pt-[50px] pb-[30px] overflow-hidden relative z-[1]" style='background-image: url(<%# Eval("BgImage") %>);'>
								<div class="container">
									<div class="row items-center justify-end">
										<div class="lg:w-7/12 md:w-2/3 w-full px-[15px]">
											<div class="banner-content md:mb-[60px] mb-5">
												<span class="font-medium sm:text-xl text-base text-primary block mb-2"><%# Eval("TagLine") %></span>
												<h1 class="title mb-4 font-lobster text-white 2xl:text-[80px] xl:text-[70px] lg:text-[60px] md:text-[50px] sm:text-[36px] text-[28px] leading-tight"><%# Eval("Heading") %></h1>
												<p class="lg:max-w-[580px] md:max-w-[350px] max-w-full font-light lg:text-lg sm:text-base text-sm leading-[27px] text-[#ffffffb3] max-sm:hidden"><%# Eval("Description") %></p>
												<div class="banner-btn flex flex-wrap items-center lg:mt-10 sm:mt-[40px] mt-4 gap-[12px] sm:gap-[30px] lg:mb-[80px] mb-5">
												</div>
												<div class="food-card border-dashed border border-[#ffffff66] rounded-[10px] w-[370px] relative block max-xl:hidden">
													<div class="dz-head border-b border-dashed border-[#ffffff66] flex justify-between py-[15px] px-[25px]">
														<h5 class="text-white mb-2"><%# Eval("FoodCardName") %></h5>
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
																	<img src='<%# Eval("ChefImage") %>' alt="/" class="w-[45px] h-[45px] rounded-full">
																</div>
																<div class="dz-content ml-2">
																	<h6 class="mb-[3px] text-white"><%# Eval("ChefName") %></h6>
																	<p class="text-[13px] leading-5 text-[#C4C4C4] mb-4"><%# Eval("ChefRole") %></p>
																</div>
															</div>
															<p class="text-[#DCDCDC]"><%# Eval("CardDescription") %></p>
														</div>
														<div class="dz-right">
															<h5 class="text-primary mb-2"><%# Eval("Price") %></h5>
															<a href="Pages/Cart.aspx" class="btn btn-primary btn-cart w-10 h-10 leading-[0.5rem] flex text-xl p-1"><i class="flaticon-shopping-cart text-white"></i></a>
														</div>
													</div>
													<img class="target-line absolute bottom-[50px] -right-full z-[2] translate-x-[25%] min-w-[485px]" src="assets/images/main-slider/slider2/line.png" alt="/">
												</div>
											</div>
										</div>
										<div class="lg:w-5/12 md:w-1/3 px-[15px] max-sm:hidden">
											<div class="banner-media relative">
												<img src='<%# Eval("FoodImage") %>' alt="/" class="w-[40vw] min-w-[40vw] max-lg:w-[55vw] max-lg:min-w-[55vw] z-[2] relative">
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

	<!-- Browse Our Menu -->
	<section class="content-inner-1 overflow-hidden pt-0 pb-[60px] sm:pb-[80px] lg:pb-[100px]">
		<div class="container">
			<div class="section-head font-lobster mb-[30px] sm:mb-[50px] mx-auto relative flex items-center justify-between">
				<h2 class="title mb-0 text-black2 sm:text-4xl text-2xl">Browse Our Menu</h2>
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
								<div class="dz-img-box3 box-hover group style-4 bg-white p-[18px] flex flex-col h-[160px] relative z-[1] overflow-hidden rounded-[10px]">
									<div class="menu-detail flex items-center mb-3">
										<div class="dz-media mr-5 w-[60px] min-w-[60px] h-[60px]">
											<img src='<%# Eval("Image") %>' alt="/">
										</div>
										<div class="dz-content">
											<h6 class="title mb-[3px] duration-500"><a href="product-detail.html"><%# Eval("Name") %></a></h6>
											<p class="text-sm"><%# Eval("SubTitle") %></p>
										</div>
									</div>
									<div class="menu-footer max-w-[110px] mt-auto">
										<span class="text-bodycolor text-[13px]">Regular Price</span>
										<span class="price duration-500"><%# Eval("Price") %></span>
									</div>
									<a class="detail-btn dz-cart-add" href="javascript:void(0);"
								   data-cart-id='bm-<%# Eval("Id") %>'
								   data-name='<%# System.Web.HttpUtility.HtmlAttributeEncode(Eval("Name").ToString()) %>'
								   data-price='<%# Eval("Price") %>'
								   data-image='<%# Eval("Image") %>'><i class="fa-solid fa-plus"></i></a>
								</div>
							</div>
						</ItemTemplate>
					</asp:Repeater>
				</div>
			</div>
		</div>
	</section>
	<!-- Browse Our Menu -->

	<!--Today's Special-->
	<section class="bg-[url('../images/background/pic1.png')] bg-fixed sm:pt-[100px] pt-[50px] lg:pb-[70px] sm:pb-10 pb-5 relative z-[1] after:content-[''] after:absolute after:z-[-1] after:bg-black-blur after:opacity-100 after:w-full after:h-full after:top-0 after:left-0 after:backdrop-blur-[6px] 2xl:mx-[100px] 2xl:rounded-[30px] overflow-hidden">
		<div class="container">
			<div class="mb-[30px] sm:mb-[50px] relative mx-auto text-center">
				<h2 class="font-lobster text-white sm:text-4xl text-3xl">Today's Special</h2>
			</div>
			<div class="row">
				<asp:Repeater ID="rptTodaySpecial" runat="server">
					<ItemTemplate>
						<div class="lg:w-1/4 sm:w-2/4 w-full px-[15px]">
							<div class="dz-img-box4 bg-white rounded-[10px] xl:p-[15px] p-2.5 mb-[30px] flex flex-col relative overflow-hidden z-[1] style-5">
								<div class="dz-content mb-[15px]">
									<div class="weight mb-[5px] flex justify-between items-center text-xs text-bodycolor">
										<span><%# Eval("Category") %></span>
										<span><%# Eval("Weight") %></span>
									</div>
									<div class="price mb-[5px] flex justify-between items-center">
										<h6 class="text-[#000] text-sm sm:text-base"><%# Eval("Name") %></h6>
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

	<!-- Our Menu -->
	<section class="content-inner-1 lg:py-[100px] py-[50px] relative">
		<div class="container">
			<div class="mb-[30px] sm:mb-[50px] relative mx-auto text-center">
				<h2 class="title font-lobster text-black2 sm:text-4xl text-3xl">Our Menu</h2>
			</div>
			<div class="row justify-center">
				<div class="w-full px-[15px] text-center">
					<div class="site-filters mb-5 overflow-x-auto">
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
				<ul id="masonry" class="row dlab-gallery-listing gallery">
					<asp:Repeater ID="rptMenuFilter" runat="server">
						<ItemTemplate>
							<li class='card-container md:w-2/4 w-full px-[15px] mb-[5px] <%# Eval("FilterTags") %>'>
								<div class="dz-img-box5 flex flex-row items-start text-start xl:py-5 xl:px-[25px] p-[10px] rounded-[10px] duration-500 relative z-[1]">
									<div class="dz-media mr-3 mb-0 min-w-[70px] w-[70px] sm:min-w-[80px] sm:w-[80px]">
										<img src='<%# Eval("Image") %>' alt="/">
									</div>
									<div class="dz-content w-full">
										<div class="dz-head flex justify-between items-center">
											<span class="header-text sm:text-lg text-sm font-semibold leading-7"><a href="Pages/Menu.aspx" class="text-black2 max-w-[200px] sm:max-w-[280px] text-ellipsis overflow-hidden block whitespace-nowrap hover:text-primary"><%# Eval("Name") %></a></span>
											<span class="img-line sm:block hidden"></span>
											<span class="header-price text-primary font-semibold sm:text-xl text-sm leading-7 ml-2"><%# Eval("Price") %></span>
										</div>
										<p class="dz-body sm:text-[15px] text-xs text-bodycolor leading-[21px] font-normal"><%# Eval("Description") %></p>
									</div>
								</div>
							</li>
						</ItemTemplate>
					</asp:Repeater>
				</ul>
				<div class="w-full text-center mt-[40px]">
					<a href="Pages/Menu.aspx" class="btn btn-md btn-primary btn-hover-1"><span>View All Menu</span></a>
				</div>
			</div>
		</div>
	</section>
	<!-- Our Menu -->

	<!-- Icon Features -->
	<section class="content-inner sm:pb-[70px] pt-[50px] pb-5">
		<div class="container">
			<div class="row justify-center relative icon-wrapper2">
				<asp:Repeater ID="rptIconFeatures" runat="server">
					<ItemTemplate>
						<div class="lg:w-2/6 md:w-6/12 w-full px-[15px] sm:px-[30px] mb-[20px] sm:mb-[30px]">
							<div class="icon-bx-wraper bg-white overflow-hidden flex items-center duration-500 p-3 sm:p-0 rounded-[10px] sm:rounded-none shadow-sm sm:shadow-none">
								<div class="icon-bx duration-500 bg-[var(--rgba-primary-1)] xl:w-[100px] xl:h-[100px] xl:min-w-[100px] w-[70px] h-[70px] min-w-[70px] sm:w-[80px] sm:h-[80px] sm:min-w-[80px] rounded-full text-center mr-4 sm:mr-5 xl:leading-[110px] leading-[70px] sm:leading-[80px] flex-shrink-0">
									<span class="icon-cell text-primary duration-500">
										<i class='<%# Eval("IconClass") %> xl:text-[45px] text-[30px] sm:text-[35px]'></i>
									</span>
								</div>
								<div class="icon-content overflow-hidden">
									<h5 class="dz-title mb-1 sm:mb-2 xl:text-xl text-base sm:text-lg"><a href='<%# Eval("LinkUrl") %>'><%# Eval("Title") %></a></h5>
									<p class="text-sm sm:text-[15px]"><%# Eval("Description") %></p>
								</div>
							</div>
						</div>
					</ItemTemplate>
				</asp:Repeater>
			</div>
		</div>
	</section>
	<!-- Icon Features -->

	<!-- Master Chef -->
	<section class="bg-light sm:content-inner lg:pt-[100px] pt-[50px] lg:pb-[70px] pb-[40px] relative overflow-hidden">
		<div class="container">
			<div class="mb-[30px] sm:mb-[50px] relative mx-auto text-center">
				<h2 class="font-lobster sm:text-4xl text-3xl">Meet The Chef's</h2>
			</div>
			<div class="swiper team-swiper overflow-visible swiper-visible">
				<div class="swiper-wrapper">
					<asp:Repeater ID="rptChefs" runat="server">
						<ItemTemplate>
							<div class="swiper-slide">
								<div class="slide-box mb-[30px]">
									<div class="shadow-[0_15px_55px_rgba(35,35,35,0.15)] rounded-[10px] bg-white overflow-hidden group">
										<div class="relative overflow-hidden z-[1] before:content-[''] before:absolute before:w-[200px] before:h-[200px] before:bg-black2 before:top-[-100px] before:left-[-100px] before:opacity-30 before:z-[1] before:duration-500 before:rounded-full before:scale-50 before:translate-x-[-50%] group-hover:before:scale-[7]">
											<img src='<%# Eval("Image") %>' alt="/" class="group-hover:scale-110 duration-500 block w-full">
										</div>
										<div class="content bg-white flex justify-between items-center py-[15px] px-4 sm:px-5">
											<div class="clearfix">
												<h6 class="text-sm sm:text-base"><a href="team-detail.html"><%# Eval("Name") %></a></h6>
												<span class="font-normal text-xs sm:text-sm leading-5 text-primary"><%# Eval("Role") %></span>
											</div>
											<ul class="team-social">
												<li class="relative">
													<a href="javascript:void(0);" class="text-lg sm:text-xl inline-block h-9 w-9 sm:h-10 sm:w-10 leading-9 sm:leading-10 text-center rounded-lg bg-primary text-white pt-[2px]">
														<i class="flaticon-share"></i>
													</a>
													<ul class="sub-team-social absolute bottom-0 z-[1] w-10 rounded-lg opacity-0 duration-500 hover:opacity-100 hover:pb-[80px]">
														<li class="mb-2 relative">
															<a href='<%# Eval("FacebookUrl") %>' class="text-white duration-500 text-center text-lg bg-[#4867AA] h-10 w-10 flex items-center justify-center rounded-lg">
																<i class="fab fa-facebook-f"></i>
															</a>
														</li>
														<li class="mb-2 relative">
															<a href='<%# Eval("TwitterUrl") %>' class="text-white duration-500 text-center text-lg bg-[#81B2DF] h-10 w-10 flex items-center justify-center rounded-lg">
																<i class="fab fa-twitter"></i>
															</a>
														</li>
														<li class="mb-2 relative">
															<a href='<%# Eval("InstagramUrl") %>' class="text-white duration-500 text-center text-lg bg-[#D74141] h-10 w-10 flex items-center justify-center rounded-lg">
																<i class="fab fa-instagram"></i>
															</a>
														</li>
														<li class="mb-2 relative">
															<a href='<%# Eval("LinkedInUrl") %>' class="text-white duration-500 text-center text-lg bg-[#3A9DF9] h-10 w-10 flex items-center justify-center rounded-lg">
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
						</ItemTemplate>
					</asp:Repeater>
				</div>
			</div>
			<div class="pagination">
				<div class="team-button-prev prev1 btn-prev rounded-full top-[50%] absolute left-[-100px] max-xl:left-[-55px] hidden xl:block"><i class="fa-solid fa-arrow-left"></i></div>
				<div class="team-button-next btn-next next1 rounded-full top-[50%] absolute right-[-100px] max-xl:right-[-55px] hidden xl:block"><i class="fa-solid fa-arrow-right"></i></div>
			</div>
		</div>
	</section>
	<!-- Master Chef End -->

	<!-- Testimonials -->
	<section class="content-inner-2 overflow-hidden lg:pt-[100px] sm:pt-[70px] pt-[50px]">
		<div class="container">
			<div class="mb-[30px] sm:mb-[50px] relative mx-auto text-center">
				<h2 class="font-lobster sm:text-4xl text-3xl">Customer's Comment</h2>
			</div>
			<div class="swiper testimonial-two-swiper swiper-btn-lr swiper-single overflow-visible swiper-visible">
				<div class="swiper-wrapper">
					<asp:Repeater ID="rptTestimonials" runat="server">
						<ItemTemplate>
							<div class="swiper-slide">
								<div class="testimonial-2 flex lg:flex-row flex-col bg-white relative rounded-lg overflow-hidden">
									<div class="dz-media xl:w-[570px] xl:min-w-[570px] lg:w-[450px] lg:min-w-[450px] w-full relative overflow-hidden max-lg:h-[250px] sm:max-lg:h-[300px]">
										<img src='<%# Eval("Image") %>' alt="/" class="w-full h-full object-cover">
									</div>
									<div class="testimonial-1 lg:pt-5 lg:pb-[30px] lg:pl-[30px] p-5 relative w-full flex flex-col">
										<div class="testimonial-text relative mb-[15px] text-base">
											<p class="xl:text-[18px] sm:text-base text-sm leading-[28px] sm:leading-[32px] font-medium text-[#222222]"><%# Eval("ReviewText") %></p>
										</div>
										<div class="testimonial-info pl-[15px] xl:mt-[60px] mt-4 relative z-[1] after:content-[''] after:bg-primary after:rounded after:h-[5px] after:w-[50px] after:absolute after:top-[25px] after:left-[-22px] after:rotate-90">
											<h5 class="testimonial-name font-bold leading-[32px] lg:text-[25px] sm:text-xl text-lg"><%# Eval("ReviewerName") %></h5>
											<span class="testimonial-position leading-[21px] text-sm block text-primary"><%# Eval("ReviewerPosition") %></span>
										</div>
										<i class="flaticon-right-quote quote absolute lg:right-[35px] right-4 bottom-[15px] xl:text-[102px] lg:text-[85px] sm:text-[65px] text-[45px] text-primary inline-flex items-center"></i>
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

	<!-- Our Blog -->
	<section class="content-inner lg:pb-[70px] pb-10 overflow-hidden relative">
		<div class="container">
			<div class="row">
				<div class="xl:w-7/12 w-full px-[15px]">
					<div class="mb-[30px] sm:mb-[50px] relative mx-auto">
						<h2 class="font-lobster text-left sm:text-4xl text-3xl">Recent News & Updates</h2>
					</div>
					<asp:Repeater ID="rptBlogSmall" runat="server">
						<ItemTemplate>
							<div class="dz-card style-2 blog-half rounded-lg overflow-hidden duration-500 bg-[#2222220d] sm:flex relative mb-[20px] sm:mb-[30px]">
								<div class="dz-media overflow-hidden relative sm:w-[220px] sm:min-w-[220px] md:w-[270px] md:min-w-[270px] w-full sm:h-auto h-[200px]">
									<a href="blog-standard.html" class="block h-full"><img src='<%# Eval("Image") %>' alt="/" class="w-full h-full object-cover"></a>
									<div class="dz-date"><%# FormatDate(Eval("PublishedDate")) %></div>
								</div>
								<div class="dz-info flex flex-col relative p-[15px] sm:p-[25px]">
									<h4 class="dz-title mb-[8px] sm:mb-[10px] sm:text-xl text-base"><a href="blog-standard.html"><%# Eval("Title") %></a></h4>
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

</asp:Content>
