<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="khan_e_azam_website.Pages.Checkout" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<style>
		.kea-form-input { height:50px; padding:10px 20px; width:100%; font-size:15px; border:1px solid var(--dark-border); border-radius:6px; outline:none; transition:border-color .3s; background:var(--dark-1); color:var(--light-text); }
		.kea-form-input:focus { border-color:var(--primary); }
		.kea-form-input::placeholder { color:var(--muted-text); }
		.kea-textarea { height:auto; resize:none; }
		.kea-pay-option { display:flex; align-items:center; padding:14px 16px; border:2px solid var(--dark-border); border-radius:10px; margin-bottom:10px; cursor:pointer; transition:all .2s; }
		.kea-pay-option:hover { border-color:var(--primary); background:var(--rgba-primary-1); }
		.kea-pay-option input[type=radio] { margin-right:12px; accent-color:var(--primary); width:18px; height:18px; }
		.kea-pay-option.selected { border-color:var(--primary); background:var(--rgba-primary-1); }
		.kea-pay-label { font-weight:600; font-size:15px; color:var(--light-text); }
		.kea-pay-sub { font-size:12px; color:var(--muted-text); }
		.kea-summary-row { display:flex; justify-content:space-between; padding:6px 0; font-size:14px; border-bottom:1px dashed var(--dark-border); color:var(--muted-text); }
		.kea-summary-row:last-child { border-bottom:none; font-weight:700; font-size:16px; padding-top:12px; color:var(--light-text); }
		.kea-section-title { font-size:18px; font-weight:700; margin-bottom:20px; padding-bottom:10px; border-bottom:2px solid var(--dark-border); color:var(--light-text); }
		.kea-type-row { display:flex; gap:10px; margin-bottom:24px; flex-wrap:wrap; }
		.kea-type-option { flex:1 1 140px; display:flex; flex-direction:column; align-items:center; text-align:center; padding:16px 10px; border:2px solid var(--dark-border); border-radius:10px; cursor:pointer; transition:all .2s; color:var(--light-text); }
		.kea-type-option:hover { border-color:var(--primary); background:var(--rgba-primary-1); }
		.kea-type-option.selected { border-color:var(--primary); background:var(--rgba-primary-1); }
		.kea-type-option input[type=radio] { position:absolute; opacity:0; pointer-events:none; }
		.kea-type-option i { font-size:22px; color:var(--primary); margin-bottom:8px; }
		.kea-type-option span { font-weight:600; font-size:13px; }
		.kea-checkout-card { border-radius:12px; box-shadow:0 2px 20px rgba(0,0,0,.3); padding:28px; background:var(--dark-card); border:1px solid var(--dark-border); }
	</style>

	<section class="kea-stars" style="padding:60px 0 80px; background-color:var(--dark-1);">
		<div class="container">

			<asp:Label ID="lblError" runat="server" Visible="false" CssClass="alert alert-danger d-block mb-4" style="border-radius:8px;"></asp:Label>

			<asp:HiddenField ID="hfCartJson" runat="server" />

			<div class="row">
				<!-- Left: Customer Details -->
				<div class="lg:w-1/2 w-full px-[15px] mb-8">
					<div class="kea-checkout-card">
						<div class="kea-section-title">Order Type</div>

						<div class="kea-type-row">
							<label class="kea-type-option selected" id="type_dinein">
								<input type="radio" name="orderType" value="Dine-In" checked onchange="selectType(this)" />
								<i class="fa-solid fa-utensils"></i>
								<span>Dine-In</span>
							</label>
							<label class="kea-type-option" id="type_takeaway">
								<input type="radio" name="orderType" value="Takeaway" onchange="selectType(this)" />
								<i class="fa-solid fa-bag-shopping"></i>
								<span>Takeaway</span>
							</label>
							<label class="kea-type-option" id="type_delivery">
								<input type="radio" name="orderType" value="Fast Delivery" onchange="selectType(this)" />
								<i class="fa-solid fa-truck-fast"></i>
								<span>Fast Delivery</span>
							</label>
						</div>

						<div class="kea-section-title">Customer Details</div>

						<div style="margin-bottom:16px;">
							<label style="font-size:13px;font-weight:600;color:var(--muted-text);display:block;margin-bottom:6px;">Full Name <span style="color:#e74c3c;">*</span></label>
							<asp:TextBox ID="txtName" runat="server" CssClass="kea-form-input" placeholder="Enter your full name" MaxLength="100" />
						</div>

						<div style="margin-bottom:16px;">
							<label style="font-size:13px;font-weight:600;color:var(--muted-text);display:block;margin-bottom:6px;">Phone Number <span style="color:#e74c3c;">*</span></label>
							<asp:TextBox ID="txtPhone" runat="server" CssClass="kea-form-input" placeholder="03xx-xxxxxxx" MaxLength="20" />
						</div>

						<div id="addressField" style="margin-bottom:16px;display:none;">
							<label id="addressLabel" style="font-size:13px;font-weight:600;color:var(--muted-text);display:block;margin-bottom:6px;">Delivery Address <span style="color:#e74c3c;">*</span></label>
							<asp:TextBox ID="txtAddress" runat="server" CssClass="kea-form-input kea-textarea" TextMode="MultiLine" Rows="3" placeholder="House #, Street, Area, City" MaxLength="500" />
						</div>
						<div id="addressNote" style="margin-bottom:16px;padding:12px 16px;background:var(--rgba-primary-1);border-radius:8px;font-size:13px;color:var(--muted-text);">
							No address needed for dine-in &mdash; just let our host know your name when you arrive.
						</div>

						<div style="margin-bottom:8px;">
							<label style="font-size:13px;font-weight:600;color:var(--muted-text);display:block;margin-bottom:6px;">Special Notes <span style="color:var(--muted-text);font-weight:400;">(optional)</span></label>
							<asp:TextBox ID="txtNotes" runat="server" CssClass="kea-form-input kea-textarea" TextMode="MultiLine" Rows="2" placeholder="Any special instructions for the kitchen or delivery" MaxLength="500" />
						</div>
					</div>
				</div>

				<!-- Right: Order Summary + Payment -->
				<div class="lg:w-1/2 w-full px-[15px] mb-8">
					<!-- Order Summary -->
					<div class="kea-checkout-card" style="margin-bottom:20px;">
						<div class="kea-section-title">Order Summary</div>
						<div id="checkoutSummary">
							<div style="text-align:center;padding:20px;color:var(--muted-text);">Loading cart...</div>
						</div>
					</div>

					<!-- Payment Method -->
					<div class="kea-checkout-card">
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

		var addressNotes = {
			'Dine-In': 'No address needed for dine-in &mdash; just let our host know your name when you arrive.',
			'Takeaway': 'No address needed for takeaway &mdash; your order will be ready for pickup at the counter.'
		};

		function selectType(radio) {
			document.querySelectorAll('.kea-type-option').forEach(function(el) { el.classList.remove('selected'); });
			radio.closest('.kea-type-option').classList.add('selected');
			updateAddressVisibility(radio.value);
		}

		function updateAddressVisibility(orderType) {
			var addressField = document.getElementById('addressField');
			var addressNote = document.getElementById('addressNote');
			if (orderType === 'Fast Delivery') {
				addressField.style.display = '';
				addressNote.style.display = 'none';
			} else {
				addressField.style.display = 'none';
				addressNote.style.display = '';
				addressNote.innerHTML = addressNotes[orderType] || '';
			}
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
			var orderType = (document.querySelector('input[name="orderType"]:checked') || {}).value || 'Dine-In';
			if (!name || !phone) {
				alert('Please fill in Name and Phone.');
				return false;
			}
			if (orderType === 'Fast Delivery') {
				var address = document.getElementById('<%= txtAddress.ClientID %>').value.trim();
				if (!address) {
					alert('Please fill in your Delivery Address.');
					return false;
				}
			}
			return true;
		}

		document.addEventListener('DOMContentLoaded', function() {
			var cart = DzCart.get();
			document.getElementById('<%= hfCartJson.ClientID %>').value = JSON.stringify(cart);
			renderCheckoutSummary(cart);

			// Pre-select order type if the homepage "Order Now" cards set one
			try {
				var preferredType = localStorage.getItem('kea_order_type');
				if (preferredType) {
					var match = document.querySelector('input[name="orderType"][value="' + preferredType + '"]');
					if (match) { match.checked = true; selectType(match); }
					localStorage.removeItem('kea_order_type');
				} else {
					updateAddressVisibility('Dine-In');
				}
			} catch (err) { updateAddressVisibility('Dine-In'); }
		});
	</script>
</asp:Content>
