<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="khan_e_azam_website.Pages.Checkout" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

	<!-- Page Banner -->
	<div class="bg-primary pt-[70px] pb-[50px] text-center">
		<h1 class="font-lobster text-white" style="font-size:clamp(2rem,5vw,3rem);margin:0;">Checkout</h1>
		<p class="text-white opacity-85 mt-[10px] text-[15px]">Almost there! Fill in your details and place your order</p>
	</div>

	<section class="lg:pt-[80px] sm:pt-[60px] pt-[40px] lg:pb-[100px] pb-[50px] bg-white">
		<div class="container">

			<asp:Label ID="lblError" runat="server" Visible="false" CssClass="alert alert-danger d-block mb-4 rounded-[8px]"></asp:Label>
			<asp:HiddenField ID="hfCartJson" runat="server" />

			<div class="row">
				<!-- Left: Customer Details -->
				<div class="lg:w-1/2 w-full px-[15px] mb-8">
					<div class="card rounded-[12px] shadow-[0_2px_20px_rgba(0,0,0,.07)] p-7">
						<h5 class="text-[18px] font-bold mb-5 pb-[10px] border-b-2 border-[#f5f5f5]">Customer Details</h5>

						<div class="mb-4">
							<label class="block text-[13px] font-semibold text-[#555] mb-1.5">Full Name <span class="text-[#e74c3c]">*</span></label>
							<asp:TextBox ID="txtName" runat="server" CssClass="h-[50px] py-[10px] px-5 w-full text-[15px] rounded-[6px] focus:border-primary duration-500 border border-[#ddd] outline-none" placeholder="Enter your full name" MaxLength="100" />
						</div>

						<div class="mb-4">
							<label class="block text-[13px] font-semibold text-[#555] mb-1.5">Phone Number <span class="text-[#e74c3c]">*</span></label>
							<asp:TextBox ID="txtPhone" runat="server" CssClass="h-[50px] py-[10px] px-5 w-full text-[15px] rounded-[6px] focus:border-primary duration-500 border border-[#ddd] outline-none" placeholder="03xx-xxxxxxx" MaxLength="20" />
						</div>

						<div class="mb-4">
							<label class="block text-[13px] font-semibold text-[#555] mb-1.5">Delivery Address <span class="text-[#e74c3c]">*</span></label>
							<asp:TextBox ID="txtAddress" runat="server" CssClass="py-[10px] px-5 w-full text-[15px] rounded-[6px] focus:border-primary duration-500 border border-[#ddd] outline-none" TextMode="MultiLine" Rows="3" placeholder="House #, Street, Area, City" MaxLength="500" />
						</div>

						<div class="mb-2">
							<label class="block text-[13px] font-semibold text-[#555] mb-1.5">Special Notes <span class="text-[13px] font-normal text-[#aaa]">(optional)</span></label>
							<asp:TextBox ID="txtNotes" runat="server" CssClass="py-[10px] px-5 w-full text-[15px] rounded-[6px] focus:border-primary duration-500 border border-[#ddd] outline-none" TextMode="MultiLine" Rows="2" placeholder="Any special instructions for the kitchen or delivery" MaxLength="500" />
						</div>
					</div>
				</div>

				<!-- Right: Order Summary + Payment -->
				<div class="lg:w-1/2 w-full px-[15px] mb-8">
					<!-- Order Summary -->
					<div class="card rounded-[12px] shadow-[0_2px_20px_rgba(0,0,0,.07)] p-7 mb-5">
						<h5 class="text-[18px] font-bold mb-5 pb-[10px] border-b-2 border-[#f5f5f5]">Order Summary</h5>
						<div id="checkoutSummary">
							<div class="text-center py-5 text-[#bbb]">Loading cart...</div>
						</div>
					</div>

					<!-- Payment Method -->
					<div class="card rounded-[12px] shadow-[0_2px_20px_rgba(0,0,0,.07)] p-7">
						<h5 class="text-[18px] font-bold mb-5 pb-[10px] border-b-2 border-[#f5f5f5]">Payment Method</h5>

						<label class="kea-pay-option flex items-center p-[14px_16px] border-2 border-primary bg-[#fffbf5] rounded-[10px] mb-2.5 cursor-pointer duration-200" id="pay_cod">
							<input type="radio" name="payMethod" value="Cash on Delivery" checked onchange="selectPay(this)" class="mr-3 accent-primary w-[18px] h-[18px]" />
							<div>
								<div class="font-semibold text-[15px]"><i class="fa-solid fa-money-bill-wave text-primary mr-2"></i>Cash on Delivery</div>
								<div class="text-xs text-[#888]">Pay when your order arrives</div>
							</div>
						</label>

						<label class="kea-pay-option flex items-center p-[14px_16px] border-2 border-[#eee] rounded-[10px] mb-2.5 cursor-pointer duration-200" id="pay_jazzcash">
							<input type="radio" name="payMethod" value="JazzCash" onchange="selectPay(this)" class="mr-3 accent-primary w-[18px] h-[18px]" />
							<div>
								<div class="font-semibold text-[15px]"><i class="fa-solid fa-mobile-screen text-[#c8102e] mr-2"></i>JazzCash</div>
								<div class="text-xs text-[#888]">Mobile wallet payment</div>
							</div>
						</label>

						<label class="kea-pay-option flex items-center p-[14px_16px] border-2 border-[#eee] rounded-[10px] mb-2.5 cursor-pointer duration-200" id="pay_easypaisa">
							<input type="radio" name="payMethod" value="EasyPaisa" onchange="selectPay(this)" class="mr-3 accent-primary w-[18px] h-[18px]" />
							<div>
								<div class="font-semibold text-[15px]"><i class="fa-solid fa-mobile-screen text-[#4CAF50] mr-2"></i>EasyPaisa</div>
								<div class="text-xs text-[#888]">Mobile wallet payment</div>
							</div>
						</label>

						<label class="kea-pay-option flex items-center p-[14px_16px] border-2 border-[#eee] rounded-[10px] mb-2.5 cursor-pointer duration-200" id="pay_bank">
							<input type="radio" name="payMethod" value="Bank Transfer" onchange="selectPay(this)" class="mr-3 accent-primary w-[18px] h-[18px]" />
							<div>
								<div class="font-semibold text-[15px]"><i class="fa-solid fa-building-columns text-[#1a237e] mr-2"></i>Bank Transfer</div>
								<div class="text-xs text-[#888]">Direct bank account transfer</div>
							</div>
						</label>

						<asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" CssClass="btn btn-primary btn-hover-1 w-full mt-4" style="width:100%;height:52px;font-size:16px;" OnClick="btnPlaceOrder_Click" OnClientClick="return validateCheckout();" />
					</div>
				</div>
			</div>
		</div>
	</section>

	<style>
		.kea-pay-option.selected { border-color:var(--primary); background:#fffbf5; }
	</style>

	<script>
		function selectPay(radio) {
			document.querySelectorAll('.kea-pay-option').forEach(function(el) { el.classList.remove('selected'); });
			radio.closest('.kea-pay-option').classList.add('selected');
		}

		function renderCheckoutSummary(items) {
			if (!items || items.length === 0) {
				window.location.href = 'Cart.aspx';
				return;
			}
			var html = '';
			var total = 0;
			items.forEach(function(item) {
				var _pm = (item.price + '').replace(/,/g, '').match(/\d+(\.\d+)?/);
				var p = _pm ? parseFloat(_pm[0]) : 0;
				var line = p * item.qty;
				total += line;
				var dp = item.priceStr || item.price;
				html += '<div class="flex justify-between py-1.5 text-sm border-b border-dashed border-black/[.08]">'
					+ '<span>' + item.name + ' &times;' + item.qty + '</span>'
					+ '<span>Rs. ' + line.toFixed(0) + '</span>'
					+ '</div>';
			});
			html += '<div class="flex justify-between pt-3 font-bold text-base">'
				+ '<span>Total</span>'
				+ '<span class="text-primary">Rs. ' + total.toFixed(0) + '</span>'
				+ '</div>';
			document.getElementById('checkoutSummary').innerHTML = html;
		}

		function validateCheckout() {
			var name = document.getElementById('<%= txtName.ClientID %>').value.trim();
			var phone = document.getElementById('<%= txtPhone.ClientID %>').value.trim();
			var address = document.getElementById('<%= txtAddress.ClientID %>').value.trim();
			if (!name || !phone || !address) {
				alert('Please fill in Name, Phone, and Address.');
				return false;
			}
			return true;
		}

		document.addEventListener('DOMContentLoaded', function() {
			var cart = DzCart.get();
			document.getElementById('<%= hfCartJson.ClientID %>').value = JSON.stringify(cart);
			renderCheckoutSummary(cart);
		});
	</script>
</asp:Content>
