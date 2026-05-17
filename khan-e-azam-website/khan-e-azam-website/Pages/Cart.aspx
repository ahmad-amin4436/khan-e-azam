<%@ Page Title="Your Cart" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="khan_e_azam_website.Pages.Cart" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

	<!-- Page Banner -->
	<div class="bg-primary pt-[70px] pb-[50px] text-center">
		<h1 class="font-lobster text-white" style="font-size:clamp(2rem,5vw,3rem);margin:0;">Your Cart</h1>
		<p class="text-white opacity-85 mt-[10px] text-[15px]">Review your items before placing the order</p>
	</div>

	<section class="lg:pt-[80px] sm:pt-[60px] pt-[40px] lg:pb-[100px] pb-[50px] bg-white">
		<div class="container">

			<!-- Empty State -->
			<div id="cartEmpty" class="hidden text-center py-[80px] px-5">
				<i class="fa-solid fa-cart-shopping text-[4rem] text-[#ddd] block mb-5"></i>
				<h4 class="text-[#999]">Your cart is empty</h4>
				<p class="text-[#bbb] mb-6">Browse our menu and add something delicious!</p>
				<a href="/Pages/Menu.aspx" class="btn btn-primary btn-hover-1"><span class="z-[2] relative block">Browse Menu &nbsp;<i class="fa-solid fa-arrow-right"></i></span></a>
			</div>

			<!-- Cart Content -->
			<div id="cartContent" class="hidden row">
				<!-- Items list -->
				<div class="lg:w-2/3 w-full px-[15px] mb-6">
					<div class="card rounded-[12px] shadow-[0_2px_20px_rgba(0,0,0,.07)] p-6">
						<div class="flex justify-between items-center mb-4">
							<h5 class="mb-0">Cart Items <span id="cartItemCount" class="text-primary"></span></h5>
							<button onclick="DzCart.clear();renderCart();" class="text-[#999] text-[13px] bg-transparent border-0 cursor-pointer">
								<i class="fa-solid fa-trash-can"></i> Clear All
							</button>
						</div>
						<div id="cartItemsList"></div>
					</div>
					<div class="mt-4">
						<a href="/Pages/Menu.aspx" class="text-[#666] text-sm"><i class="fa-solid fa-arrow-left mr-1"></i>Continue Shopping</a>
					</div>
				</div>

				<!-- Bill summary -->
				<div class="lg:w-1/3 w-full px-[15px] mb-6">
					<div class="card rounded-[12px] shadow-[0_2px_20px_rgba(0,0,0,.07)] p-6 lg:sticky lg:top-[100px]">
						<h5 class="mb-4">Bill Details</h5>
						<div id="billDetails"></div>
						<a href="/Pages/Checkout.aspx" class="btn btn-primary block text-center btn-hover-1 mt-4">
							<span class="z-[2] relative block">Proceed to Checkout &nbsp;<i class="fa-solid fa-arrow-right"></i></span>
						</a>
					</div>
				</div>
			</div>

		</div>
	</section>

	<style>
		.kea-qty-btn:hover { background:var(--primary); border-color:var(--primary); color:#fff; }
		.kea-remove-btn:hover { color:#e74c3c; }
	</style>

	<script>
		function renderCart() {
			var items = DzCart.get();
			var empty = document.getElementById('cartEmpty');
			var content = document.getElementById('cartContent');

			if (!items || items.length === 0) {
				empty.classList.remove('hidden');
				content.classList.add('hidden');
				return;
			}

			empty.classList.add('hidden');
			content.classList.remove('hidden');

			document.getElementById('cartItemCount').textContent = '(' + items.length + ')';

			var html = '';
			items.forEach(function(item) {
				var _pm = (item.price + '').replace(/,/g, '').match(/\d+(\.\d+)?/);
				var priceNum = _pm ? parseFloat(_pm[0]) : 0;
				var lineTotal = (priceNum * item.qty).toFixed(0);
				var displayPrice = item.priceStr || item.price;
				var imgHtml = item.image
					? '<img src="../' + item.image + '" class="w-[80px] min-w-[80px] h-[80px] rounded-[10px] object-cover" onerror="this.style.display=\'none\'" />'
					: '<div class="w-[80px] min-w-[80px] h-[80px] rounded-[10px] bg-[#f5f5f5] flex items-center justify-center"><i class="flaticon-fast-food text-[28px] text-[#ccc]"></i></div>';

				html += '<div class="flex items-center gap-4 py-4 border-b border-[#eee]" data-id="' + item.id + '">'
					+ '<div>' + imgHtml + '</div>'
					+ '<div class="flex-1">'
					+   '<h6 class="mb-1 text-[15px]">' + item.name + '</h6>'
					+   '<div class="text-primary font-semibold text-sm">' + displayPrice + ' each</div>'
					+   '<div class="flex items-center gap-2 mt-2">'
					+     '<button class="kea-qty-btn w-7 h-7 border border-[#ddd] rounded-md bg-[#f5f5f5] cursor-pointer text-base flex items-center justify-center duration-200" onclick="changeQty(\'' + item.id + '\',-1)">&#8722;</button>'
					+     '<span class="min-w-[28px] text-center font-semibold text-[15px]">' + item.qty + '</span>'
					+     '<button class="kea-qty-btn w-7 h-7 border border-[#ddd] rounded-md bg-[#f5f5f5] cursor-pointer text-base flex items-center justify-center duration-200" onclick="changeQty(\'' + item.id + '\',1)">&#43;</button>'
					+   '</div>'
					+ '</div>'
					+ '<div class="text-right min-w-[80px]">'
					+   '<div class="font-bold text-[16px] text-primary">Rs. ' + lineTotal + '</div>'
					+   '<button class="kea-remove-btn bg-transparent border-0 cursor-pointer text-[#ccc] text-lg px-2 py-1 duration-200" onclick="removeItem(\'' + item.id + '\')" title="Remove"><i class="fa-solid fa-xmark"></i></button>'
					+ '</div>'
					+ '</div>';
			});
			document.getElementById('cartItemsList').innerHTML = html;

			var subtotal = DzCart.total();
			var billHtml = '';
			items.forEach(function(item) {
				var _pm2 = (item.price + '').replace(/,/g, '').match(/\d+(\.\d+)?/);
				var p = _pm2 ? parseFloat(_pm2[0]) : 0;
				var dp = item.priceStr || item.price;
				billHtml += '<div class="flex justify-between py-1.5 text-sm"><span>' + item.name + ' x' + item.qty + '</span><span>Rs. ' + (p * item.qty).toFixed(0) + '</span></div>';
			});
			billHtml += '<div class="flex justify-between pt-2.5 mt-2 border-t-2 border-[#222] font-bold text-base"><span>Total</span><span class="text-primary">Rs. ' + subtotal.toFixed(0) + '</span></div>';
			document.getElementById('billDetails').innerHTML = billHtml;
		}

		function changeQty(id, delta) {
			var items = DzCart.get();
			var item = items.find(function(x) { return x.id === id; });
			if (!item) return;
			var newQty = (item.qty || 1) + delta;
			if (newQty < 1) { DzCart.remove(id); }
			else { DzCart.setQty(id, newQty); }
			renderCart();
		}

		function removeItem(id) {
			DzCart.remove(id);
			renderCart();
		}

		document.addEventListener('DOMContentLoaded', renderCart);
	</script>
</asp:Content>
