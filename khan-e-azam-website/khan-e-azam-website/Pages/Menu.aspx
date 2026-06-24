<%@ Page Title="Our Menu" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="khan_e_azam_website.Pages.Menu" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<style>
		/* Menu page responsive tweaks */
		.filters { display:flex; gap:8px; flex-wrap:wrap; overflow-x:auto; -webkit-overflow-scrolling:touch; }
		.filters li { flex:0 0 auto; }
		.dz-img-box3 { min-height: auto !important; height: auto !important; padding:14px !important; }
		.dz-img-box3 .dz-media { flex:0 0 60px; min-width:60px; width:60px; height:60px; }
		.dz-img-box3 .dz-media img { width:100%; height:100%; object-fit:cover; display:block; border-radius:8px; min-width:0; }
		.dz-img-box3 .dz-content .title { font-size:1rem; }
		.menu-footer { max-width:120px; }

		@media (max-width: 992px) {
			.card-container { padding-left:10px; padding-right:10px; }
			.card-container .dz-img-box3 { padding:12px; }
		}

		@media (max-width: 768px) {
			/* Stack content if needed and allow price/footer to align */
			.dz-img-box3 { display:flex; flex-direction:row; align-items:flex-start; gap:12px; }
			.dz-img-box3 .dz-content { flex:1 1 auto; }
			.dz-img-box3 .menu-footer { flex:0 0 auto; margin-left:8px; }
			.dz-img-box3 { height:auto !important; }
			.dz-content .title { font-size:1rem; }
		}

		@media (max-width: 480px) {
			.filters { gap:6px; }
			.dz-img-box3 { padding:10px !important; }
			.dz-img-box3 .dz-media { flex:0 0 50px; min-width:50px; width:50px; height:50px; }
			.dz-img-box3 .dz-content .title { font-size:0.95rem; }
			.menu-footer { max-width:100%; margin-top:8px; }
		}
	</style>
	<!-- Page Banner -->
	<div class="bg-primary pt-[70px] pb-[50px] text-center">
		<h1 class="font-lobster text-white" style="font-size:clamp(2rem,5vw,3rem);margin:0;">Our Menu</h1>
		<p class="text-white opacity-85 mt-[10px] text-[15px]">Fresh ingredients &middot; Authentic flavors &middot; Every dish made with love</p>
	</div>

	<!-- Menu Section -->
	<section class="lg:pt-[80px] sm:pt-[60px] pt-[40px] lg:pb-[100px] pb-[50px] overflow-hidden relative bg-white">
		<div class="container">
			<!-- Filter Buttons -->
			<div class="row justify-between mb-[30px] sm:mb-[40px]">
				<div class="xl:w-10/12 lg:w-9/12 w-full px-[15px]">
					<div class="site-filters lg:mb-0 mb-5 sm:text-left text-center">
						<ul class="filters style-1 flex-wrap">
							<li data-filter=".All" class="btn lg:py-2 lg:px-[15px] p-2 lg:mr-[10px] mr-[5px] duration-500 active">
								<a href="javascript:void(0);" class="flex items-center lg:text-[15px] text-[13px]"><span class="mb-0"><i class="flaticon-fast-food text-[25px] lg:mr-[10px] mr-[5px]"></i></span>ALL</a>
							</li>
							<li data-filter=".sandwich" class="btn lg:py-2 lg:px-[15px] p-2 lg:mr-[10px] mr-[5px]">
								<a href="javascript:void(0);" class="flex items-center lg:text-[15px] text-[13px]"><span class="mb-0"><i class="flaticon-burger-1 text-[25px] lg:mr-[10px] mr-[5px]"></i></span>SANDWICH</a>
							</li>
							<li data-filter=".shawarma" class="btn lg:py-2 lg:px-[15px] p-2 lg:mr-[10px] mr-[5px]">
								<a href="javascript:void(0);" class="flex items-center lg:text-[15px] text-[13px]"><span class="mb-0"><i class="flaticon-cuisine text-[25px] lg:mr-[10px] mr-[5px]"></i></span>SHAWARMA</a>
							</li>
							<li data-filter=".burger" class="btn lg:py-2 lg:px-[15px] p-2 lg:mr-[10px] mr-[5px]">
								<a href="javascript:void(0);" class="flex items-center lg:text-[15px] text-[13px]"><span class="mb-0"><i class="flaticon-hamburger-1 text-[25px] lg:mr-[10px] mr-[5px]"></i></span>BURGER</a>
							</li>
							<li data-filter=".pizza" class="btn lg:py-2 lg:px-[15px] p-2 lg:mr-[10px] mr-[5px]">
								<a href="javascript:void(0);" class="flex items-center lg:text-[15px] text-[13px]"><span class="mb-0"><i class="flaticon-pizza-slice text-[25px] lg:mr-[10px] mr-[5px]"></i></span>PIZZA</a>
							</li>
							<li data-filter=".roll" class="btn lg:py-2 lg:px-[15px] p-2 lg:mr-[10px] mr-[5px]">
								<a href="javascript:void(0);" class="flex items-center lg:text-[15px] text-[13px]"><span class="mb-0"><i class="flaticon-fast-food text-[25px] lg:mr-[10px] mr-[5px]"></i></span>RAP ROLL</a>
							</li>
							<li data-filter=".paratha" class="btn lg:py-2 lg:px-[15px] p-2 lg:mr-[10px] mr-[5px]">
								<a href="javascript:void(0);" class="flex items-center lg:text-[15px] text-[13px]"><span class="mb-0"><i class="flaticon-restaurant text-[25px] lg:mr-[10px] mr-[5px]"></i></span>PARATHA ROLL</a>
							</li>
							<li data-filter=".fries" class="btn lg:py-2 lg:px-[15px] p-2 lg:mr-[10px] mr-[5px]">
								<a href="javascript:void(0);" class="flex items-center lg:text-[15px] text-[13px]"><span class="mb-0"><i class="flaticon-fast-food text-[25px] lg:mr-[10px] mr-[5px]"></i></span>FRIES</a>
							</li>
							<li data-filter=".pasta" class="btn lg:py-2 lg:px-[15px] p-2 lg:mr-[10px] mr-[5px]">
								<a href="javascript:void(0);" class="flex items-center lg:text-[15px] text-[13px]"><span class="mb-0"><i class="flaticon-pot text-[25px] lg:mr-[10px] mr-[5px]"></i></span>PASTA</a>
							</li>
							<li data-filter=".wings" class="btn lg:py-2 lg:px-[15px] p-2 lg:mr-[10px] mr-[5px]">
								<a href="javascript:void(0);" class="flex items-center lg:text-[15px] text-[13px]"><span class="mb-0"><i class="flaticon-fast-food text-[25px] lg:mr-[10px] mr-[5px]"></i></span>WINGS</a>
							</li>
							<li data-filter=".broast" class="btn lg:py-2 lg:px-[15px] p-2 lg:mr-[10px] mr-[5px]">
								<a href="javascript:void(0);" class="flex items-center lg:text-[15px] text-[13px]"><span class="mb-0"><i class="flaticon-fast-food text-[25px] lg:mr-[10px] mr-[5px]"></i></span>BROAST</a>
							</li>
							<li data-filter=".salad" class="btn lg:py-2 lg:px-[15px] p-2 lg:mr-[10px] mr-[5px]">
								<a href="javascript:void(0);" class="flex items-center lg:text-[15px] text-[13px]"><span class="mb-0"><i class="flaticon-salad text-[25px] lg:mr-[10px] mr-[5px]"></i></span>SALAD</a>
							</li>
							<li data-filter=".sweet" class="btn lg:py-2 lg:px-[15px] p-2 lg:mr-[10px] mr-[5px]">
								<a href="javascript:void(0);" class="flex items-center lg:text-[15px] text-[13px]"><span class="mb-0"><i class="flaticon-cupcake text-[25px] lg:mr-[10px] mr-[5px]"></i></span>SWEETS</a>
							</li>
						</ul>
					</div>
				</div>
				<div class="xl:w-2/12 lg:w-1/4 w-full px-[15px] lg:text-right">
					<asp:Label ID="lblCount" runat="server" CssClass="text-bodycolor font-medium text-sm"></asp:Label>
				</div>
			</div>

			<!-- Items Grid -->
			<div class="clearfix" id="lightgallery">
				<ul id="masonry" class="row dlab-gallery-listing gallery">
					<asp:Repeater ID="rptMenu" runat="server">
						<ItemTemplate>
							<li class='card-container xl:w-1/4 lg:w-1/3 sm:w-1/2 w-full px-[15px] pb-[30px] <%# Eval("FilterTags") %>'>
								<div class="dz-img-box3 box-hover group style-4 bg-white p-[18px] flex flex-col h-[160px] relative z-[1] overflow-hidden rounded-[10px]">
									<div class="menu-detail flex items-center mb-3">
										<div class="dz-media mr-5 w-[60px] min-w-[60px] h-[60px]">
											<img src='<%# ResolveUrl("~/" + Eval("Image").ToString().TrimStart('/')) %>' alt='<%# System.Web.HttpUtility.HtmlAttributeEncode(Eval("Name").ToString()) %>' style="width:100%;height:100%;object-fit:cover;border-radius:8px;" onerror="this.style.display='none'">
										</div>
										<div class="dz-content">
											<h6 class="title mb-[3px] duration-500"><%# Eval("Name") %></h6>
											<p class="text-sm text-bodycolor"><%# Eval("Description") %></p>
										</div>
									</div>
									<div class="menu-footer max-w-[110px] mt-auto">
										<span class="text-bodycolor text-[13px]">Price</span>
										<span class="price duration-500"><%# Eval("Price") %></span>
									</div>
									<a class="detail-btn dz-cart-add" href="javascript:void(0);"
									   data-cart-id='mf-<%# Eval("Id") %>'
									   data-name='<%# System.Web.HttpUtility.HtmlAttributeEncode(Eval("Name").ToString()) %>'
									   data-price='<%# Eval("Price") %>'
									   data-image='<%# Eval("Image") %>'>
										<i class="fa-solid fa-plus"></i>
									</a>
								</div>
							</li>
						</ItemTemplate>
					</asp:Repeater>
				</ul>

				<!-- Empty State -->
				<asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="w-full text-center py-[80px]">
					<i class="flaticon-fast-food" style="font-size:4rem;color:#ddd;display:block;margin-bottom:20px;"></i>
					<h4 style="color:#999;">No menu items available at the moment.</h4>
					<p style="color:#bbb;">Check back soon - the chef is working on it!</p>
				</asp:Panel>
			</div>
		</div>
	</section>
	<script>
		document.addEventListener('DOMContentLoaded', function () {
			var btns = document.querySelectorAll('.filters li');
			var items = document.querySelectorAll('#masonry .card-container');
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
</asp:Content>
