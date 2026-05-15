<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="KhanEAzam.Admin.Orders" MasterPageFile="~/Admin/Admin.Master" %>
<asp:Content ContentPlaceHolderID="PageTitle" runat="server">Orders</asp:Content>
<asp:Content ContentPlaceHolderID="PageHeading" runat="server">Manage Orders</asp:Content>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">

    <!-- List Panel -->
    <asp:Panel ID="pnlList" runat="server">
        <div class="card mb-4">
            <div class="card-header d-flex justify-content-between align-items-center">
                All Orders
                <div>
                    <asp:DropDownList ID="ddlFilter" runat="server" CssClass="form-control form-control-sm d-inline-block" style="width:auto;" AutoPostBack="true" OnSelectedIndexChanged="ddlFilter_Changed">
                        <asp:ListItem Value="">All Statuses</asp:ListItem>
                        <asp:ListItem Value="Pending">Pending</asp:ListItem>
                        <asp:ListItem Value="Confirmed">Confirmed</asp:ListItem>
                        <asp:ListItem Value="Preparing">Preparing</asp:ListItem>
                        <asp:ListItem Value="Ready">Ready</asp:ListItem>
                        <asp:ListItem Value="Out for Delivery">Out for Delivery</asp:ListItem>
                        <asp:ListItem Value="Delivered">Delivered</asp:ListItem>
                        <asp:ListItem Value="Cancelled">Cancelled</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="card-body p-0">
                <asp:Label ID="lblMsg" runat="server" Visible="false" CssClass="alert alert-success m-3 d-block"></asp:Label>
                <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="false" CssClass="table table-hover mb-0"
                    DataKeyNames="Id" OnRowCommand="gvOrders_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="#" />
                        <asp:BoundField DataField="CustomerName" HeaderText="Customer" />
                        <asp:BoundField DataField="CustomerPhone" HeaderText="Phone" />
                        <asp:BoundField DataField="PaymentMethod" HeaderText="Payment" />
                        <asp:TemplateField HeaderText="Total">
                            <ItemTemplate>Rs. <%# ((decimal)Eval("TotalAmount")).ToString("0") %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <span class='order-status-badge status-<%# ((string)Eval("Status")).Replace(" ","") %>'><%# Eval("Status") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date">
                            <ItemTemplate><%# ((DateTime)Eval("CreatedAt")).ToString("dd MMM yy, hh:mm tt") %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" CommandName="ViewOrder" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-primary btn-sm">View</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="text-center text-muted py-4">No orders found.</div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </asp:Panel>

    <!-- Detail Panel -->
    <asp:Panel ID="pnlDetail" runat="server" Visible="false">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h5 class="mb-0">Order Details — #<asp:Label ID="lblDetailId" runat="server" /></h5>
            <asp:Button ID="btnBackToList" runat="server" Text="&larr; Back to Orders" CssClass="btn btn-outline-secondary btn-sm" OnClick="btnBackToList_Click" CausesValidation="false" />
        </div>

        <div class="row">
            <!-- Customer Info -->
            <div class="col-md-6">
                <div class="card mb-4">
                    <div class="card-header">Customer Information</div>
                    <div class="card-body">
                        <table class="table table-sm table-borderless mb-0">
                            <tr><td class="font-weight-bold text-muted" style="width:120px;">Name</td><td><asp:Label ID="lblDetailName" runat="server" /></td></tr>
                            <tr><td class="font-weight-bold text-muted">Phone</td><td><asp:Label ID="lblDetailPhone" runat="server" /></td></tr>
                            <tr><td class="font-weight-bold text-muted">Address</td><td><asp:Label ID="lblDetailAddress" runat="server" /></td></tr>
                            <tr><td class="font-weight-bold text-muted">Payment</td><td><asp:Label ID="lblDetailPayment" runat="server" /></td></tr>
                            <tr><td class="font-weight-bold text-muted">Date</td><td><asp:Label ID="lblDetailDate" runat="server" /></td></tr>
                            <tr><td class="font-weight-bold text-muted">Notes</td><td><asp:Label ID="lblDetailNotes" runat="server" /></td></tr>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Status Update -->
            <div class="col-md-6">
                <div class="card mb-4">
                    <div class="card-header">Update Order Status</div>
                    <div class="card-body">
                        <p class="text-muted small mb-2">Current Status: <strong><asp:Label ID="lblDetailStatus" runat="server" /></strong></p>
                        <asp:HiddenField ID="hfDetailOrderId" runat="server" />
                        <div class="input-group">
                            <asp:DropDownList ID="ddlNewStatus" runat="server" CssClass="form-control">
                                <asp:ListItem Value="Pending">Pending</asp:ListItem>
                                <asp:ListItem Value="Confirmed">Confirmed</asp:ListItem>
                                <asp:ListItem Value="Preparing">Preparing</asp:ListItem>
                                <asp:ListItem Value="Ready">Ready</asp:ListItem>
                                <asp:ListItem Value="Out for Delivery">Out for Delivery</asp:ListItem>
                                <asp:ListItem Value="Delivered">Delivered</asp:ListItem>
                                <asp:ListItem Value="Cancelled">Cancelled</asp:ListItem>
                            </asp:DropDownList>
                            <div class="input-group-append">
                                <asp:Button ID="btnUpdateStatus" runat="server" Text="Update" CssClass="btn btn-primary" OnClick="btnUpdateStatus_Click" />
                            </div>
                        </div>
                        <asp:Label ID="lblStatusMsg" runat="server" Visible="false" CssClass="alert alert-success d-block mt-2 mb-0 py-2"></asp:Label>
                    </div>
                </div>
            </div>
        </div>

        <!-- Order Items -->
        <div class="card">
            <div class="card-header">Ordered Items</div>
            <div class="card-body p-0">
                <asp:GridView ID="gvItems" runat="server" AutoGenerateColumns="false" CssClass="table table-hover mb-0">
                    <Columns>
                        <asp:BoundField DataField="ItemName" HeaderText="Item" />
                        <asp:TemplateField HeaderText="Price">
                            <ItemTemplate>Rs. <%# ((decimal)Eval("ItemPrice")).ToString("0") %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Quantity" HeaderText="Qty" />
                        <asp:TemplateField HeaderText="Line Total">
                            <ItemTemplate>Rs. <%# ((decimal)Eval("LineTotal")).ToString("0") %></ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate><div class="text-center text-muted py-3">No items.</div></EmptyDataTemplate>
                </asp:GridView>
            </div>
            <div class="card-footer text-right font-weight-bold">
                Total: Rs. <asp:Label ID="lblDetailTotal" runat="server" />
            </div>
        </div>
    </asp:Panel>

    <style>
        .order-status-badge { padding:3px 10px; border-radius:12px; font-size:.78rem; font-weight:600; }
        .status-Pending { background:#fff3cd; color:#856404; }
        .status-Confirmed { background:#cce5ff; color:#004085; }
        .status-Preparing { background:#fff3cd; color:#856404; }
        .status-Ready { background:#d4edda; color:#155724; }
        .status-OutForDelivery { background:#cce5ff; color:#004085; }
        .status-Delivered { background:#d4edda; color:#155724; }
        .status-Cancelled { background:#f8d7da; color:#721c24; }
    </style>
</asp:Content>
