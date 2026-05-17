<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="khan_e_azam_website.Pages.Checkout" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<style>
		.kea-form-input { height:50px; padding:10px 20px; width:100%; font-size:15px; border:1px solid #ddd; border-radius:6px; outline:none; transition:border-color .3s; }
		.kea-form-input:focus { border-color:var(--primary); }
		.kea-textarea { height:auto; resize:none; }
		.kea-pay-option { display:flex; align-items:center; padding:14px 16px; border:2px solid #eee; border-radius:10px; margin-bottom:10px; cursor:pointer; transition:all .2s; }
		.kea-pay-option:hover { border-color:var(--primary); background:#fffbf5; }
		.kea-pay-option input[type=radio] { margin-right:12px; accent-color:var(--primary); width:18px; height:18px; }
		.kea-pay-option.selected { border-color:var(--primary); background:#fffbf5; }
		.kea-pay-label { font-weight:600; font-size:15px; }
		.kea-pay-sub { font-size:12px; color:#888; }
		.kea-summary-row { display:flex; justify-content:space-between; padding:6px 0; font-size:14px; border-bottom:1px dashed rgba(0,0,0,.08); }
		.kea-summary-row:last-child { border-bottom:none; font-weight:700; font-size:16px; padding-top:12px; }
		.kea-section-title { font-size:18px; font-weight:700; margin-bottom:20px; padding-bottom:10px; border-bottom:2px solid #f5f5f5; }
	</style>

	<section style="padding:60px 0 80px;background:#fff;">
		<div class="container">

			<asp:Label ID="lblError" runat="server" Visible="false" CssClass="alert alert-danger d-block mb-4" style="border-radius:8px;"></asp:Label>

			<asp:HiddenField ID="hfCartJson" runat="server" />

			<div class="row">
				<!-- Left: Customer Details -->
				<div class="lg:w-1/2 w-full px-[15px] mb-8">
					<div class="card" style="border-radius:12px;box-shadow:0 2px 20px rgba(0,0,0,.07);padding:28px;">
						<div class="kea-section-title">Customer Details</div>

						<div style="margin-bottom:16px;">
							<label style="font-size:13px;font-weight:600;color:#555;display:block;margin-bottom:6px;">Full Name <span style="color:#e74c3c;">*</span></label>
							<asp:TextBox ID="txtName" runat="server" CssClass="kea-form-input" placeholder="Enter your full name" MaxLength="100" />
						</div>

						<div style="margin-bottom:16px;">
							<label style="font-size:13px;font-weight:600;color:#555;display:block;margin-bottom:6px;">Phone Number <span style="color:#e74c3c;">*</span></label>
							<asp:TextBox ID="txtPhone" runat="server" CssClass="kea-form-input" placeholder="03xx-xxxxxxx" MaxLength="20" />
						</div>

						<div style="margin-bottom:16px;">
							<label style="font-size:13px;font-weight:600;color:#555;display:block;margin-bottom:6px;">Delivery Address <span style="color:#e74c3c;">*</span></label>
							<asp:TextBox ID="txtAddress" runat="server" CssClass="kea-form-input kea-textarea" TextMode="MultiLine" Rows="3" placeholder="House #, Street, Area, City" MaxLength="500" />
						</div>

						<div style="margin-bottom:8px;">
							<label style="font-size:13px;font-weight:600;color:#555;display:block;margin-bottom:6px;">Special Notes <span style="color:#aaa;font-weight:400;">(optional)</span></label>
							<asp:TextBox ID="txtNotes" runat="server" CssClass="kea-form-input kea-textarea" TextMode="MultiLine" Rows="2" placeholder="Any special instructions for the kitchen or delivery" MaxLength="500" />
						</div>
					</div>
				</div>

				<!-- Right: Order Summary + Payment -->
				<div class="lg:w-1/2 w-full px-[15px] mb-8">
					<!-- Order Summary -->
					<div class="card" style="border-radius:12px;box-shadow:0 2px 20px rgba(0,0,0,.07);padding:28px;margin-bottom:20px;">
						<div class="kea-section-title">Order Summary</div>
						<div id="checkoutSummary">
							<div style="text-align:center;padding:20px;color:#bbb;">Loading cart...</div>
						</div>
					</div>

					<!-- Payment Method -->
					<div class="card" style="border-radius:12px;box-shadow:0 2px 20px rgba(0,0,0,.07);padding:28px;">
						<div class="kea-section-title">Payment Method</div>

						<label class="kea-pay-option selected" id="pay_cod">
							<input type="radio" name="payMethod" value="Cash on Delivery" checked onchange="selectPay(this)" />
							<div>
								<div class="kea-pay-label"><i class="fa-solid fa-money-bill-wave" style="color:var(--primary);margin-right:8px;"></i>Cash on Delivery</div>
								<div class="kea-pay-sub">Pay when your order arrives</div>
							</div>
						</label>

						<label class="kea-pay-option" id="pay_jazzcash">
							<input type="radio" name="payMethod" value="JazzCash" onchange="selectPay(this)" />
							<div>
								<div class="kea-pay-label"><i class="fa-solid fa-mobile-screen" style="color:#c8102e;margin-right:8px;"></i>JazzCash</div>
								<div class="kea-pay-sub">Mobile wallet payment</div>
							</div>
						</label>

						<label class="kea-pay-option" id="pay_easypaisa">
							<input type="radio" name="payMethod" value="EasyPaisa" onchange="selectPay(this)" />
							<div>
								<div class="kea-pay-label"><i class="fa-solid fa-mobile-screen" style="color:#4CAF50;margin-right:8px;"></i>EasyPaisa</div>
								<div class="kea-pay-sub">Mobile wallet payment</div>
							</div>
						</label>

						<label class="kea-pay-option" id="pay_bank">
							<input type="radio" name="payMethod" value="Bank Transfer" onchange="selectPay(this)" />
							<div>
								<div class="kea-pay-label"><i class="fa-solid fa-building-columns" style="color:#1a237e;margin-right:8px;"></i>Bank Transfer</div>
								<div class="kea-pay-sub">Direct bank account transfer</div>
							</div>
						</label>

						<asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" CssClass="btn btn-primary btn-hover-1 w-full" style="width:100%;margin-top:16px;height:52px;font-size:16px;" OnClick="btnPlaceOrder_Click" OnClientClick="return validateCheckout();" />
					</div>
				</div>
			</div>
		</div>
	</section>

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
				var _pm = (item.price + '').replace(/,/g, '').match(/\d+(\.\d+)?/); var p = _pm ? parseFloat(_pm[0]) : 0;
				var line = p * item.qty;
				total += line;
				var dp = item.priceStr || item.price;
				html += '<div class="kea-summary-row">'
					+ '<span>' + item.name + ' &times;' + item.qty + '</span>'
					+ '<span>' + dp + ' &times;' + item.qty + ' = Rs. ' + line.toFixed(0) + '</span>'
					+ '</div>';
			});
			html += '<div class="kea-summary-row">'
				+ '<span>Total</span>'
				+ '<span style="color:var(--primary);">Rs. ' + total.toFixed(0) + '</span>'
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
