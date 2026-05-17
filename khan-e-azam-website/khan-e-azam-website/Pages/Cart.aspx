<%@ Page Title="Your Cart" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="khan_e_azam_website.Pages.Cart" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<style>
		.kea-cart-item { display:flex; align-items:center; border-bottom:1px solid rgba(0,0,0,.08); padding:16px 0; }
		.kea-cart-item:last-child { border-bottom:none; }
		.kea-cart-img { width:80px; min-width:80px; height:80px; border-radius:10px; object-fit:cover; }
		.kea-qty-wrap { display:flex; align-items:center; gap:8px; }
		.kea-qty-btn { width:28px; height:28px; border:1px solid #ddd; border-radius:6px; background:#f5f5f5; cursor:pointer; font-size:16px; line-height:1; display:flex; align-items:center; justify-content:center; transition:all .2s; }
		.kea-qty-btn:hover { background:var(--primary); border-color:var(--primary); color:#fff; }
		.kea-qty-num { min-width:28px; text-align:center; font-weight:600; font-size:15px; }
		.kea-remove-btn { background:none; border:none; cursor:pointer; color:#ccc; font-size:18px; padding:4px 8px; transition:color .2s; }
		.kea-remove-btn:hover { color:#e74c3c; }
		.kea-bill-row { display:flex; justify-content:space-between; padding:6px 0; font-size:14px; }
		.kea-bill-total { border-top:2px solid #222; margin-top:8px; padding-top:10px; font-weight:700; font-size:16px; }
	</style>



	<section style="padding:60px 0 80px;background:#fff;">
		<div class="container">

			<!-- Empty State -->
			<div id="cartEmpty" style="display:none;text-align:center;padding:80px 20px;">
				<i class="fa-solid fa-cart-shopping" style="font-size:4rem;color:#ddd;display:block;margin-bottom:20px;"></i>
				<h4 style="color:#999;">Your cart is empty</h4>
				<p style="color:#bbb;margin-bottom:24px;">Browse our menu and add something delicious!</p>
				<a href="Menu.aspx" class="btn btn-primary btn-hover-1"><span class="z-[2] relative block">Browse Menu &nbsp;<i class="fa-solid fa-arrow-right"></i></span></a>
			</div>

			<!-- Cart Content -->
			<div id="cartContent" style="display:none;" class="row">
				<!-- Items list -->
				<div class="lg:w-2/3 w-full px-[15px]">
					<div class="card" style="border-radius:12px;box-shadow:0 2px 20px rgba(0,0,0,.07);padding:24px;">
						<div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:16px;">
							<h5 style="margin:0;">Cart Items <span id="cartItemCount" class="text-primary"></span></h5>
							<button onclick="DzCart.clear();renderCart();" style="background:none;border:none;color:#999;cursor:pointer;font-size:13px;">
								<i class="fa-solid fa-trash-can"></i> Clear All
							</button>
						</div>
						<div id="cartItemsList"></div>
					</div>
					<div style="margin-top:16px;">
						<a href="Menu.aspx" style="color:#666;font-size:14px;"><i class="fa-solid fa-arrow-left" style="margin-right:6px;"></i>Continue Shopping</a>
					</div>
				</div>

				<!-- Bill summary -->
				<div class="lg:w-1/3 w-full px-[15px]">
					<div class="card" style="border-radius:12px;box-shadow:0 2px 20px rgba(0,0,0,.07);padding:24px;position:sticky;top:100px;">
						<h5 style="margin-bottom:16px;">Bill Details</h5>
						<div id="billDetails"></div>
						<a href="Checkout.aspx" class="btn btn-primary block text-center btn-hover-1" style="margin-top:16px;">
							<span class="z-[2] relative block">Proceed to Checkout &nbsp;<i class="fa-solid fa-arrow-right"></i></span>
						</a>
					</div>
				</div>
			</div>

		</div>
	</section>

	<script>
		function renderCart() {
			var items = DzCart.get();
			var empty = document.getElementById('cartEmpty');
			var content = document.getElementById('cartContent');

			if (!items || items.length === 0) {
				empty.style.display = 'block';
				content.style.display = 'none';
				return;
			}

			empty.style.display = 'none';
			content.style.display = '';

			document.getElementById('cartItemCount').textContent = '(' + items.length + ')';

			// Render items
			var html = '';
			items.forEach(function(item) {
				var _pm = (item.price + '').replace(/,/g, '').match(/\d+(\.\d+)?/); var priceNum = _pm ? parseFloat(_pm[0]) : 0;
				var lineTotal = (priceNum * item.qty).toFixed(0);
				var displayPrice = item.priceStr || item.price;
				var imgHtml = item.image
					? '<img src="../' + item.image + '" class="kea-cart-img" onerror="this.style.display=\'none\'" />'
					: '<div class="kea-cart-img" style="background:#f5f5f5;display:flex;align-items:center;justify-content:center;"><i class="flaticon-fast-food" style="font-size:28px;color:#ccc;"></i></div>';

				html += '<div class="kea-cart-item" data-id="' + item.id + '">'
					+ '<div style="margin-right:16px;">' + imgHtml + '</div>'
					+ '<div style="flex:1;">'
					+   '<h6 style="margin:0 0 6px;font-size:15px;">' + item.name + '</h6>'
					+   '<div style="color:var(--primary);font-weight:600;font-size:14px;">' + displayPrice + ' each</div>'
					+   '<div class="kea-qty-wrap" style="margin-top:10px;">'
					+     '<button class="kea-qty-btn" onclick="changeQty(\'' + item.id + '\',-1)">&#8722;</button>'
					+     '<span class="kea-qty-num">' + item.qty + '</span>'
					+     '<button class="kea-qty-btn" onclick="changeQty(\'' + item.id + '\',1)">&#43;</button>'
					+   '</div>'
					+ '</div>'
					+ '<div style="text-align:right;min-width:80px;">'
					+   '<div style="font-weight:700;font-size:16px;color:var(--primary);">Rs. ' + lineTotal + '</div>'
					+   '<button class="kea-remove-btn" onclick="removeItem(\'' + item.id + '\')" title="Remove"><i class="fa-solid fa-xmark"></i></button>'
					+ '</div>'
					+ '</div>';
			});
			document.getElementById('cartItemsList').innerHTML = html;

			// Render bill
			var subtotal = DzCart.total();
			var billHtml = '';
			items.forEach(function(item) {
				var _pm2 = (item.price + '').replace(/,/g, '').match(/\d+(\.\d+)?/); var p = _pm2 ? parseFloat(_pm2[0]) : 0;
				var dp = item.priceStr || item.price;
				billHtml += '<div class="kea-bill-row"><span>' + item.name + ' x' + item.qty + '</span><span>' + dp + ' x' + item.qty + ' = Rs. ' + (p * item.qty).toFixed(0) + '</span></div>';
			});
			billHtml += '<div class="kea-bill-row kea-bill-total"><span>Total</span><span style="color:var(--primary);">Rs. ' + subtotal.toFixed(0) + '</span></div>';
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
