<%@ Page Title="Track Your Order" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderTracking.aspx.cs" Inherits="khan_e_azam_website.Pages.OrderTracking" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<style>
		.kea-tracker-step { display:flex; flex-direction:column; align-items:center; flex:1; position:relative; }
		.kea-tracker-step::before { content:''; position:absolute; top:22px; left:calc(-50% + 22px); right:calc(50% + 22px); height:3px; background:#e0e0e0; z-index:0; }
		.kea-tracker-step:first-child::before { display:none; }
		.kea-step-icon { width:44px; height:44px; border-radius:50%; background:#e0e0e0; display:flex; align-items:center; justify-content:center; font-size:18px; color:#aaa; z-index:1; transition:all .3s; border:3px solid #fff; box-shadow:0 2px 8px rgba(0,0,0,.1); }
		.kea-step-label { font-size:11px; font-weight:600; color:#aaa; margin-top:8px; text-align:center; line-height:1.3; text-transform:uppercase; letter-spacing:.5px; }
		.kea-tracker-step.done .kea-step-icon { background:#28a745; color:#fff; }
		.kea-tracker-step.done .kea-step-label { color:#28a745; }
		.kea-tracker-step.done::before { background:#28a745; }
		.kea-tracker-step.active .kea-step-icon { background:var(--primary); color:#fff; box-shadow:0 0 0 6px rgba(254,159,16,.3); }
		.kea-tracker-step.active .kea-step-label { color:var(--primary); }
		.kea-tracker-step.active::before { background:#28a745; }
		.kea-tracker-step.cancelled .kea-step-icon { background:#e74c3c; color:#fff; }
		.kea-tracker-step.cancelled .kea-step-label { color:#e74c3c; }
		.kea-info-row { display:flex; padding:10px 0; border-bottom:1px solid #f0f0f0; }
		.kea-info-row:last-child { border-bottom:none; }
		.kea-info-label { min-width:140px; font-weight:600; font-size:13px; color:#888; }
		.kea-info-value { font-size:14px; color:#333; }
		.kea-status-badge { display:inline-block; padding:4px 14px; border-radius:20px; font-size:12px; font-weight:700; letter-spacing:.5px; text-transform:uppercase; }
		.kea-status-Pending { background:#fff3cd; color:#856404; }
		.kea-status-Confirmed { background:#cce5ff; color:#004085; }
		.kea-status-Preparing { background:#fff3cd; color:#856404; }
		.kea-status-Ready { background:#d4edda; color:#155724; }
		.kea-status-OutForDelivery { background:#cce5ff; color:#004085; }
		.kea-status-Delivered { background:#d4edda; color:#155724; }
		.kea-status-Cancelled { background:#f8d7da; color:#721c24; }
	</style>

	<!-- Page Banner -->
	<div class="bg-primary pt-[70px] pb-[50px] text-center">
		<h1 class="font-lobster text-white" style="font-size:clamp(2rem,5vw,3rem);margin:0;">Track Your Order</h1>
		<p class="text-white opacity-85 mt-[10px] text-[15px]">Enter your Order ID to see live status updates</p>
	</div>

	<section style="padding:60px 0 80px;background:#fff;">
		<div class="container" style="max-width:760px;">

			<!-- Search Form -->
			<asp:Panel ID="pnlSearch" runat="server">
				<div class="card" style="border-radius:14px;box-shadow:0 4px 24px rgba(0,0,0,.08);padding:36px;text-align:center;">
					<i class="fa-solid fa-magnifying-glass" style="font-size:2.5rem;color:var(--primary);margin-bottom:16px;display:block;"></i>
					<h4 style="margin-bottom:8px;">Track Your Order</h4>
					<p style="color:#888;margin-bottom:24px;">Enter your Order ID below to check the status</p>
					<div style="display:flex;gap:10px;max-width:420px;margin:0 auto;">
						<asp:TextBox ID="txtSearchId" runat="server" CssClass="h-[50px] py-[10px] px-5 w-full text-[15px] rounded-[6px] focus:border-primary duration-500" placeholder="Order ID (e.g. 42)" style="border:1px solid #ddd;flex:1;" />
						<asp:Button ID="btnSearch" runat="server" Text="Track" CssClass="btn btn-primary" style="height:50px;padding:0 24px;white-space:nowrap;" OnClick="btnSearch_Click" CausesValidation="false" />
					</div>
					<asp:Label ID="lblNotFound" runat="server" Visible="false" CssClass="alert alert-warning d-block mt-3" style="border-radius:8px;max-width:420px;margin:12px auto 0;"></asp:Label>
				</div>
			</asp:Panel>

			<!-- Order Detail -->
			<asp:Panel ID="pnlOrder" runat="server" Visible="false">

				<!-- Order ID Banner -->
				<div style="background:#fff9f0;border:2px solid var(--primary);border-radius:14px;padding:20px 24px;margin-bottom:20px;text-align:center;">
					<p style="margin:0 0 4px;font-size:12px;color:#aaa;text-transform:uppercase;letter-spacing:1px;">Your Order ID</p>
					<div style="font-size:2.4rem;font-weight:800;color:var(--primary);line-height:1;">#<asp:Label ID="lblOrderId" runat="server" /></div>
					<p style="margin:6px 0 0;font-size:12px;color:#888;">Save this number &mdash; use it to track your order anytime</p>
				</div>

				<!-- Status Timeline -->
				<div class="card" style="border-radius:14px;box-shadow:0 4px 24px rgba(0,0,0,.08);padding:32px;margin-bottom:20px;">
					<div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:24px;">
						<h5 style="margin:0;">Order Status</h5>
						<asp:Label ID="lblStatusBadge" runat="server" />
					</div>

					<!-- Tracker steps -->
					<div style="display:flex;padding:10px 0 20px;" id="trackerSteps">
						<div class="kea-tracker-step" id="step_pending">
							<div class="kea-step-icon"><i class="fa-solid fa-clock-rotate-left"></i></div>
							<div class="kea-step-label">Order<br/>Placed</div>
						</div>
						<div class="kea-tracker-step" id="step_confirmed">
							<div class="kea-step-icon"><i class="fa-solid fa-circle-check"></i></div>
							<div class="kea-step-label">Confirmed</div>
						</div>
						<div class="kea-tracker-step" id="step_preparing">
							<div class="kea-step-icon"><i class="fa-solid fa-fire-burner"></i></div>
							<div class="kea-step-label">Preparing</div>
						</div>
						<div class="kea-tracker-step" id="step_ready">
							<div class="kea-step-icon"><i class="fa-solid fa-bag-shopping"></i></div>
							<div class="kea-step-label">Ready</div>
						</div>
						<div class="kea-tracker-step" id="step_outfordelivery">
							<div class="kea-step-icon"><i class="flaticon-scooter" style="font-size:20px;"></i></div>
							<div class="kea-step-label">Out for<br/>Delivery</div>
						</div>
						<div class="kea-tracker-step" id="step_delivered">
							<div class="kea-step-icon"><i class="fa-solid fa-house-chimney-window"></i></div>
							<div class="kea-step-label">Delivered</div>
						</div>
					</div>

					<asp:HiddenField ID="hfStatus" runat="server" />
				</div>

				<!-- Order Info -->
				<div class="card" style="border-radius:14px;box-shadow:0 4px 24px rgba(0,0,0,.08);padding:28px;margin-bottom:20px;">
					<h6 style="margin-bottom:16px;font-size:16px;border-bottom:2px solid #f5f5f5;padding-bottom:10px;">Delivery Details</h6>
					<div class="kea-info-row"><span class="kea-info-label">Name</span><span class="kea-info-value"><asp:Label ID="lblCustomerName" runat="server" /></span></div>
					<div class="kea-info-row"><span class="kea-info-label">Phone</span><span class="kea-info-value"><asp:Label ID="lblPhone" runat="server" /></span></div>
					<div class="kea-info-row"><span class="kea-info-label">Address</span><span class="kea-info-value"><asp:Label ID="lblAddress" runat="server" /></span></div>
					<div class="kea-info-row"><span class="kea-info-label">Payment</span><span class="kea-info-value"><asp:Label ID="lblPayment" runat="server" /></span></div>
					<div class="kea-info-row"><span class="kea-info-label">Ordered On</span><span class="kea-info-value"><asp:Label ID="lblDate" runat="server" /></span></div>
					<asp:Panel ID="pnlNotes" runat="server" Visible="false">
						<div class="kea-info-row"><span class="kea-info-label">Notes</span><span class="kea-info-value"><asp:Label ID="lblNotes" runat="server" /></span></div>
					</asp:Panel>
				</div>

				<!-- Order Items -->
				<div class="card" style="border-radius:14px;box-shadow:0 4px 24px rgba(0,0,0,.08);padding:28px;">
					<h6 style="margin-bottom:16px;font-size:16px;border-bottom:2px solid #f5f5f5;padding-bottom:10px;">Ordered Items</h6>
					<asp:Repeater ID="rptItems" runat="server">
						<ItemTemplate>
							<div style="display:flex;align-items:center;justify-content:space-between;padding:10px 0;border-bottom:1px solid #f5f5f5;">
								<div style="display:flex;align-items:center;gap:12px;">
									<div>
										<div style="font-weight:600;font-size:14px;"><%# Eval("ItemName") %></div>
										<div style="font-size:12px;color:#888;">Qty: <%# Eval("Quantity") %></div>
									</div>
								</div>
								<div style="font-weight:700;color:var(--primary);">Rs. <%# ((decimal)Eval("LineTotal")).ToString("0") %></div>
							</div>
						</ItemTemplate>
					</asp:Repeater>
					<div style="display:flex;justify-content:space-between;padding-top:14px;font-weight:700;font-size:16px;">
						<span>Total</span>
						<span style="color:var(--primary);">Rs. <asp:Label ID="lblTotal" runat="server" /></span>
					</div>
				</div>

				<div style="margin-top:20px;text-align:center;">
					<a href="Menu.aspx" class="btn btn-primary btn-hover-1" style="margin-right:10px;"><span class="z-[2] relative block">Order More</span></a>
					<asp:Button ID="btnBackToSearch" runat="server" Text="Track Another Order" CssClass="btn btn-outline-secondary" OnClick="btnBackToSearch_Click" CausesValidation="false" />
				</div>
			</asp:Panel>

		</div>
	</section>

	<script>
		// Clear the cart if we arrived here directly from checkout (query string id present)
		(function() {
			if (window.location.search.indexOf('id=') !== -1 && typeof DzCart !== 'undefined') {
				DzCart.clear();
			}
		})();

		window.keaPostUpdate = function() {
			var hf = document.getElementById('<%= hfStatus.ClientID %>');
			if (!hf || !hf.value) return;
			var status = hf.value.trim();

			var stages = ['pending','confirmed','preparing','ready','outfordelivery','delivered'];
			var statusMap = {
				'Pending':'pending','Confirmed':'confirmed','Preparing':'preparing',
				'Ready':'ready','Out for Delivery':'outfordelivery','Delivered':'delivered'
			};

			// Reset all step classes before re-applying
			stages.forEach(function(s) {
				var el = document.getElementById('step_' + s);
				if (el) el.classList.remove('done','active','cancelled');
			});

			var currentIndex = stages.indexOf(statusMap[status] || '');

			if (status === 'Cancelled') {
				stages.forEach(function(s) {
					var el = document.getElementById('step_' + s);
					if (el) el.classList.add('cancelled');
				});
				return;
			}

			stages.forEach(function(s, i) {
				var el = document.getElementById('step_' + s);
				if (!el) return;
				if (i < currentIndex) el.classList.add('done');
				else if (i === currentIndex) el.classList.add('active');
			});
		};
		window.keaPostUpdate();
	</script>
</asp:Content>
