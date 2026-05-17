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
	</style>

	<!-- Page Banner -->
	<div class="bg-primary pt-[70px] pb-[50px] text-center">
		<h1 class="font-lobster text-white" style="font-size:clamp(2rem,5vw,3rem);margin:0;">Track Your Order</h1>
		<p class="text-white opacity-85 mt-[10px] text-[15px]">Enter your Order ID to see live status updates</p>
	</div>

	<section class="lg:pt-[80px] sm:pt-[60px] pt-[40px] lg:pb-[100px] pb-[50px] bg-white">
		<div class="container" style="max-width:760px;">

			<!-- Search Form -->
			<asp:Panel ID="pnlSearch" runat="server">
				<div class="card rounded-[14px] shadow-[0_4px_24px_rgba(0,0,0,.08)] p-9 text-center">
					<i class="fa-solid fa-magnifying-glass text-[2.5rem] text-primary block mb-4"></i>
					<h4 class="mb-2">Track Your Order</h4>
					<p class="text-[#888] mb-6">Enter your Order ID below to check the status</p>
					<div class="flex gap-2.5 max-w-[420px] mx-auto">
						<asp:TextBox ID="txtSearchId" runat="server" CssClass="h-[50px] py-[10px] px-5 w-full text-[15px] rounded-[6px] focus:border-primary duration-500 border border-[#ddd] outline-none flex-1" placeholder="Order ID (e.g. 42)" />
						<asp:Button ID="btnSearch" runat="server" Text="Track" CssClass="btn btn-primary h-[50px] px-6 whitespace-nowrap" OnClick="btnSearch_Click" CausesValidation="false" />
					</div>
					<asp:Label ID="lblNotFound" runat="server" Visible="false" CssClass="alert alert-warning d-block mt-3 rounded-[8px] max-w-[420px] mx-auto"></asp:Label>
				</div>
			</asp:Panel>

			<!-- Order Detail -->
			<asp:Panel ID="pnlOrder" runat="server" Visible="false">

				<!-- Order ID Banner -->
				<div class="bg-[#fff9f0] border-2 border-primary rounded-[14px] p-5 mb-5 text-center">
					<p class="mb-1 text-xs text-[#aaa] uppercase tracking-[1px]">Your Order ID</p>
					<div class="text-[2.4rem] font-extrabold text-primary leading-none">#<asp:Label ID="lblOrderId" runat="server" /></div>
					<p class="mt-1.5 text-xs text-[#888]">Save this number &mdash; use it to track your order anytime</p>
				</div>

				<!-- Status Timeline -->
				<div class="card rounded-[14px] shadow-[0_4px_24px_rgba(0,0,0,.08)] p-8 mb-5">
					<div class="flex items-center justify-between mb-6">
						<h5 class="mb-0">Order Status</h5>
						<asp:Label ID="lblStatusBadge" runat="server" />
					</div>

					<div class="flex py-2.5 pb-5" id="trackerSteps">
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
							<div class="kea-step-icon"><i class="flaticon-scooter text-[20px]"></i></div>
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
				<div class="card rounded-[14px] shadow-[0_4px_24px_rgba(0,0,0,.08)] p-7 mb-5">
					<h6 class="text-[16px] mb-4 pb-2.5 border-b-2 border-[#f5f5f5]">Delivery Details</h6>
					<div class="flex py-2.5 border-b border-[#f0f0f0]"><span class="min-w-[140px] font-semibold text-[13px] text-[#888]">Name</span><span class="text-[14px] text-[#333]"><asp:Label ID="lblCustomerName" runat="server" /></span></div>
					<div class="flex py-2.5 border-b border-[#f0f0f0]"><span class="min-w-[140px] font-semibold text-[13px] text-[#888]">Phone</span><span class="text-[14px] text-[#333]"><asp:Label ID="lblPhone" runat="server" /></span></div>
					<div class="flex py-2.5 border-b border-[#f0f0f0]"><span class="min-w-[140px] font-semibold text-[13px] text-[#888]">Address</span><span class="text-[14px] text-[#333]"><asp:Label ID="lblAddress" runat="server" /></span></div>
					<div class="flex py-2.5 border-b border-[#f0f0f0]"><span class="min-w-[140px] font-semibold text-[13px] text-[#888]">Payment</span><span class="text-[14px] text-[#333]"><asp:Label ID="lblPayment" runat="server" /></span></div>
					<div class="flex py-2.5 border-b border-[#f0f0f0]"><span class="min-w-[140px] font-semibold text-[13px] text-[#888]">Ordered On</span><span class="text-[14px] text-[#333]"><asp:Label ID="lblDate" runat="server" /></span></div>
					<asp:Panel ID="pnlNotes" runat="server" Visible="false">
						<div class="flex py-2.5"><span class="min-w-[140px] font-semibold text-[13px] text-[#888]">Notes</span><span class="text-[14px] text-[#333]"><asp:Label ID="lblNotes" runat="server" /></span></div>
					</asp:Panel>
				</div>

				<!-- Order Items -->
				<div class="card rounded-[14px] shadow-[0_4px_24px_rgba(0,0,0,.08)] p-7">
					<h6 class="text-[16px] mb-4 pb-2.5 border-b-2 border-[#f5f5f5]">Ordered Items</h6>
					<asp:Repeater ID="rptItems" runat="server">
						<ItemTemplate>
							<div class="flex items-center justify-between py-2.5 border-b border-[#f5f5f5]">
								<div>
									<div class="font-semibold text-sm"><%# Eval("ItemName") %></div>
									<div class="text-xs text-[#888]">Qty: <%# Eval("Quantity") %></div>
								</div>
								<div class="font-bold text-primary">Rs. <%# ((decimal)Eval("LineTotal")).ToString("0") %></div>
							</div>
						</ItemTemplate>
					</asp:Repeater>
					<div class="flex justify-between pt-3.5 font-bold text-[16px]">
						<span>Total</span>
						<span class="text-primary">Rs. <asp:Label ID="lblTotal" runat="server" /></span>
					</div>
				</div>

				<div class="mt-5 text-center">
					<a href="/Pages/Menu.aspx" class="btn btn-primary btn-hover-1 mr-2.5"><span class="z-[2] relative block">Order More</span></a>
					<asp:Button ID="btnBackToSearch" runat="server" Text="Track Another Order" CssClass="btn btn-outline-secondary" OnClick="btnBackToSearch_Click" CausesValidation="false" />
				</div>
			</asp:Panel>

		</div>
	</section>

	<script>
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
