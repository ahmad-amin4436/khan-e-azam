<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="KhanEAzam.Admin.Orders" MasterPageFile="~/Admin/Admin.Master" %>
<asp:Content ContentPlaceHolderID="PageTitle" runat="server">Orders</asp:Content>
<asp:Content ContentPlaceHolderID="PageHeading" runat="server">Manage Orders</asp:Content>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">

    <!-- List Panel -->
    <asp:Panel ID="pnlList" runat="server" DefaultButton="btnApply">
        <div class="card mb-4">
            <div class="card-header d-flex justify-content-between align-items-center flex-wrap">
                <span>All Orders <asp:Label ID="lblCount" runat="server" CssClass="count-pill" /></span>
                <div class="sort-bar">
                    <label class="filter-label mb-0 mr-1">Sort</label>
                    <asp:DropDownList ID="ddlSort" runat="server" CssClass="form-control form-control-sm" AutoPostBack="true" OnSelectedIndexChanged="Sort_Changed">
                        <asp:ListItem Value="date">Date</asp:ListItem>
                        <asp:ListItem Value="id">Order #</asp:ListItem>
                        <asp:ListItem Value="customer">Customer</asp:ListItem>
                        <asp:ListItem Value="type">Type</asp:ListItem>
                        <asp:ListItem Value="payment">Payment</asp:ListItem>
                        <asp:ListItem Value="total">Total</asp:ListItem>
                        <asp:ListItem Value="status">Status</asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlSortDir" runat="server" CssClass="form-control form-control-sm" AutoPostBack="true" OnSelectedIndexChanged="Sort_Changed">
                        <asp:ListItem Value="desc">Descending</asp:ListItem>
                        <asp:ListItem Value="asc">Ascending</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>

            <!-- Filter bar -->
            <div class="filter-panel">
                <div class="form-row align-items-end">
                    <div class="col-lg-3 col-md-6 mb-2">
                        <label class="filter-label">Search</label>
                        <asp:TextBox ID="txtKeyword" runat="server" CssClass="form-control form-control-sm" placeholder="Name, phone or order #"></asp:TextBox>
                    </div>
                    <div class="col-lg-2 col-md-6 mb-2">
                        <label class="filter-label">Status</label>
                        <asp:DropDownList ID="ddlFilter" runat="server" CssClass="form-control form-control-sm">
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
                    <div class="col-lg-2 col-md-6 mb-2">
                        <label class="filter-label">Order Type</label>
                        <asp:DropDownList ID="ddlType" runat="server" CssClass="form-control form-control-sm"></asp:DropDownList>
                    </div>
                    <div class="col-lg-2 col-md-6 mb-2">
                        <label class="filter-label">Payment</label>
                        <asp:DropDownList ID="ddlPayment" runat="server" CssClass="form-control form-control-sm"></asp:DropDownList>
                    </div>
                    <div class="col-lg-3 col-md-12 mb-2">
                        <label class="filter-label">Date Range</label>
                        <div class="d-flex">
                            <asp:TextBox ID="txtFrom" runat="server" CssClass="form-control form-control-sm mr-1" TextMode="Date"></asp:TextBox>
                            <asp:TextBox ID="txtTo" runat="server" CssClass="form-control form-control-sm" TextMode="Date"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="filter-actions">
                    <asp:Button ID="btnApply" runat="server" Text="Apply Filters" CssClass="btn btn-primary btn-sm" OnClick="btnApply_Click" />
                    <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-outline-secondary btn-sm" OnClick="btnReset_Click" CausesValidation="false" />
                    <asp:Label ID="lblActiveFilters" runat="server" CssClass="text-muted small ml-2"></asp:Label>
                </div>
            </div>

            <div class="card-body p-0">
                <asp:Label ID="lblMsg" runat="server" Visible="false" CssClass="alert alert-success m-3 d-block"></asp:Label>
                <div class="table-responsive-wrap">
                <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="false" CssClass="table table-hover mb-0"
                    DataKeyNames="Id" OnRowCommand="gvOrders_RowCommand" AllowSorting="true" OnSorting="gvOrders_Sorting"
                    OnRowDataBound="gvOrders_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="#" SortExpression="id" />
                        <asp:BoundField DataField="CustomerName" HeaderText="Customer" SortExpression="customer" />
                        <asp:BoundField DataField="CustomerPhone" HeaderText="Phone" />
                        <asp:BoundField DataField="OrderType" HeaderText="Type" SortExpression="type" />
                        <asp:BoundField DataField="PaymentMethod" HeaderText="Payment" SortExpression="payment" />
                        <asp:TemplateField HeaderText="Total" SortExpression="total">
                            <ItemTemplate>Rs. <%# ((decimal)Eval("TotalAmount")).ToString("0") %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status" SortExpression="status">
                            <ItemTemplate>
                                <span class='order-status-badge status-<%# ((string)Eval("Status")).Replace(" ","") %>'><%# Eval("Status") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date" SortExpression="date">
                            <ItemTemplate><%# ((DateTime)Eval("CreatedAt")).ToString("dd MMM yy, hh:mm tt") %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" CommandName="ViewOrder" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-primary btn-sm">View</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="text-center text-muted py-4">No orders match the current filters.</div>
                    </EmptyDataTemplate>
                </asp:GridView>
                </div>
            </div>

            <!-- Server-side pager: only the current page is fetched from SQL. -->
            <div class="pager-bar">
                <div class="pager-range">
                    <asp:Label ID="lblRange" runat="server"></asp:Label>
                </div>
                <div class="pager-controls">
                    <asp:Button ID="btnFirst" runat="server" Text="&laquo;" CssClass="btn btn-outline-secondary btn-sm"
                        OnClick="btnFirst_Click" CausesValidation="false" ToolTip="First page" />
                    <asp:Button ID="btnPrev" runat="server" Text="&lsaquo;" CssClass="btn btn-outline-secondary btn-sm"
                        OnClick="btnPrev_Click" CausesValidation="false" ToolTip="Previous page" />
                    <span class="pager-page"><asp:Label ID="lblPageInfo" runat="server"></asp:Label></span>
                    <asp:Button ID="btnNext" runat="server" Text="&rsaquo;" CssClass="btn btn-outline-secondary btn-sm"
                        OnClick="btnNext_Click" CausesValidation="false" ToolTip="Next page" />
                    <asp:Button ID="btnLast" runat="server" Text="&raquo;" CssClass="btn btn-outline-secondary btn-sm"
                        OnClick="btnLast_Click" CausesValidation="false" ToolTip="Last page" />
                </div>
                <div class="pager-size">
                    <label for="<%= ddlPageSize.ClientID %>">Rows</label>
                    <asp:DropDownList ID="ddlPageSize" runat="server" CssClass="form-control form-control-sm"
                        AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_Changed">
                        <asp:ListItem Value="10">10</asp:ListItem>
                        <asp:ListItem Value="20" Selected="True">20</asp:ListItem>
                        <asp:ListItem Value="50">50</asp:ListItem>
                        <asp:ListItem Value="100">100</asp:ListItem>
                    </asp:DropDownList>
                </div>
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
                            <tr><td class="font-weight-bold text-muted">Order Type</td><td><asp:Label ID="lblDetailType" runat="server" /></td></tr>
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

                        <!-- Shown instead of the controls once an order is cancelled. -->
                        <asp:Panel ID="pnlCancelledBanner" runat="server" Visible="false" CssClass="cancelled-banner mb-3">
                            <i class="fas fa-ban mr-1"></i>
                            This order is <strong>cancelled</strong>.
                            <asp:Label ID="lblCancelledDetail" runat="server" CssClass="d-block mt-1 small"></asp:Label>
                        </asp:Panel>

                        <asp:Panel ID="pnlStatusControls" runat="server">
                            <div class="input-group">
                                <asp:DropDownList ID="ddlNewStatus" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="Pending">Pending</asp:ListItem>
                                    <asp:ListItem Value="Confirmed">Confirmed</asp:ListItem>
                                    <asp:ListItem Value="Preparing">Preparing</asp:ListItem>
                                    <asp:ListItem Value="Ready">Ready</asp:ListItem>
                                    <asp:ListItem Value="Out for Delivery">Out for Delivery</asp:ListItem>
                                    <asp:ListItem Value="Delivered">Delivered</asp:ListItem>
                                </asp:DropDownList>
                                <div class="input-group-append">
                                    <asp:Button ID="btnUpdateStatus" runat="server" Text="Update" CssClass="btn btn-primary" OnClick="btnUpdateStatus_Click" />
                                </div>
                            </div>
                        </asp:Panel>

                        <asp:Label ID="lblStatusMsg" runat="server" Visible="false" CssClass="alert alert-success d-block mt-2 mb-0 py-2"></asp:Label>
                        <asp:Label ID="lblStatusError" runat="server" Visible="false" CssClass="alert alert-danger d-block mt-2 mb-0 py-2"></asp:Label>
                    </div>
                </div>

                <!-- Cancellation (SuperAdmin only; hidden entirely for other roles) -->
                <asp:Panel ID="pnlCancel" runat="server" Visible="false" CssClass="card mb-4 border-danger">
                    <div class="card-header text-danger" style="border-bottom-color:#dc3545;">
                        <i class="fas fa-ban mr-1"></i> <asp:Literal ID="litCancelHeading" runat="server">Cancel Order</asp:Literal>
                    </div>
                    <div class="card-body">
                        <asp:Panel ID="pnlCancelForm" runat="server">
                            <asp:Label ID="lblCancelWarning" runat="server" Visible="false" CssClass="alert alert-warning d-block py-2 small"></asp:Label>
                            <div class="form-group mb-2">
                                <label class="filter-label">Reason for cancellation <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtCancelReason" runat="server" CssClass="form-control form-control-sm"
                                    TextMode="MultiLine" Rows="2" MaxLength="500"
                                    placeholder="e.g. Customer called to cancel; item unavailable"></asp:TextBox>
                                <small class="text-muted">Recorded in the order history against your name.</small>
                            </div>
                            <asp:Button ID="btnCancelOrder" runat="server" Text="Cancel This Order" CssClass="btn btn-danger btn-sm"
                                OnClick="btnCancelOrder_Click" CausesValidation="false"
                                OnClientClick="return confirm('Cancel this order? This is recorded in the order history and the customer will see the cancelled status.');" />
                        </asp:Panel>

                        <!-- Reopen path, so a mistaken cancellation is recoverable. -->
                        <asp:Panel ID="pnlReopen" runat="server" Visible="false">
                            <div class="form-group mb-2">
                                <label class="filter-label">Reason for reopening <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtReopenReason" runat="server" CssClass="form-control form-control-sm"
                                    TextMode="MultiLine" Rows="2" MaxLength="500"
                                    placeholder="e.g. Cancelled by mistake"></asp:TextBox>
                            </div>
                            <div class="d-flex align-items-end" style="gap:8px;">
                                <div style="flex:1 1 auto;">
                                    <label class="filter-label">Reopen as</label>
                                    <asp:DropDownList ID="ddlReopenStatus" runat="server" CssClass="form-control form-control-sm">
                                        <asp:ListItem Value="Pending">Pending</asp:ListItem>
                                        <asp:ListItem Value="Confirmed">Confirmed</asp:ListItem>
                                        <asp:ListItem Value="Preparing">Preparing</asp:ListItem>
                                        <asp:ListItem Value="Ready">Ready</asp:ListItem>
                                        <asp:ListItem Value="Out for Delivery">Out for Delivery</asp:ListItem>
                                        <asp:ListItem Value="Delivered">Delivered</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <asp:Button ID="btnReopenOrder" runat="server" Text="Reopen" CssClass="btn btn-outline-danger btn-sm"
                                    OnClick="btnReopenOrder_Click" CausesValidation="false"
                                    OnClientClick="return confirm('Reopen this cancelled order?');" />
                            </div>
                        </asp:Panel>
                    </div>
                </asp:Panel>
            </div>
        </div>

        <!-- Audit trail -->
        <div class="card mb-4">
            <div class="card-header"><i class="fas fa-history mr-1"></i> Status History</div>
            <div class="card-body p-0">
                <div class="table-responsive-wrap">
                    <asp:GridView ID="gvHistory" runat="server" AutoGenerateColumns="false" CssClass="table table-sm mb-0">
                        <Columns>
                            <asp:TemplateField HeaderText="When">
                                <ItemTemplate><%# ((DateTime)Eval("ChangedAt")).ToString("dd MMM yyyy, hh:mm tt") %></ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Change">
                                <ItemTemplate>
                                    <%# Eval("OldStatus") == null
                                        ? "<span class='text-muted'>Order placed</span>"
                                        : "<span class='order-status-badge status-" + ((string)Eval("OldStatus")).Replace(" ","") + "'>" + Server.HtmlEncode((string)Eval("OldStatus")) + "</span>" %>
                                    <i class="fas fa-arrow-right mx-1 text-muted small"></i>
                                    <span class='order-status-badge status-<%# ((string)Eval("NewStatus")).Replace(" ","") %>'><%# Server.HtmlEncode((string)Eval("NewStatus")) %></span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="ChangedByDisplay" HeaderText="By" />
                            <asp:TemplateField HeaderText="Reason">
                                <ItemTemplate><%# string.IsNullOrEmpty((string)Eval("Reason")) ? "—" : Server.HtmlEncode((string)Eval("Reason")) %></ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <div class="text-center text-muted py-3">No status changes recorded yet.</div>
                        </EmptyDataTemplate>
                    </asp:GridView>
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
        .cancelled-banner { background:#f8d7da; color:#721c24; border:1px solid #f5c6cb; border-radius:6px; padding:10px 12px; font-size:.9rem; }
        /* Cancelled rows are muted in the list so they read as inactive at a glance. */
        .row-cancelled td { opacity:.65; }
        .row-cancelled td:first-child { box-shadow: inset 3px 0 0 #dc3545; }
    </style>
</asp:Content>
