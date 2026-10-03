<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuickRequests.aspx.cs" Inherits="KhanEAzam.Admin.QuickRequests" MasterPageFile="~/Admin/Admin.Master" %>
<asp:Content ContentPlaceHolderID="PageTitle" runat="server">Quick Requests</asp:Content>
<asp:Content ContentPlaceHolderID="PageHeading" runat="server">Quick Order Requests</asp:Content>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlList" runat="server" DefaultButton="btnApply">
    <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center flex-wrap">
            <span>Requests from the homepage "Quick Order Request" form <asp:Label ID="lblCount" runat="server" CssClass="count-pill" /></span>
            <div class="sort-bar">
                <label class="filter-label mb-0 mr-1">Sort</label>
                <asp:DropDownList ID="ddlSort" runat="server" CssClass="form-control form-control-sm" AutoPostBack="true" OnSelectedIndexChanged="Sort_Changed">
                    <asp:ListItem Value="submitted">Submitted</asp:ListItem>
                    <asp:ListItem Value="id">Request #</asp:ListItem>
                    <asp:ListItem Value="name">Full Name</asp:ListItem>
                    <asp:ListItem Value="contact">Contact Number</asp:ListItem>
                    <asp:ListItem Value="type">Order Type</asp:ListItem>
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
                <div class="col-lg-4 col-md-6 mb-2">
                    <label class="filter-label">Search</label>
                    <asp:TextBox ID="txtKeyword" runat="server" CssClass="form-control form-control-sm" placeholder="Name or contact number"></asp:TextBox>
                </div>
                <div class="col-lg-3 col-md-6 mb-2">
                    <label class="filter-label">Order Type</label>
                    <asp:DropDownList ID="ddlType" runat="server" CssClass="form-control form-control-sm"></asp:DropDownList>
                </div>
                <div class="col-lg-5 col-md-12 mb-2">
                    <label class="filter-label">Submitted Between</label>
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
            <asp:GridView ID="gvRequests" runat="server" AutoGenerateColumns="false" CssClass="table table-hover mb-0"
                DataKeyNames="Id" OnRowCommand="gvRequests_RowCommand" AllowSorting="true" OnSorting="gvRequests_Sorting">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="#" SortExpression="id" />
                    <asp:BoundField DataField="FullName" HeaderText="Full Name" SortExpression="name" />
                    <asp:BoundField DataField="ContactNumber" HeaderText="Contact Number" SortExpression="contact" />
                    <asp:TemplateField HeaderText="Order Type" SortExpression="type">
                        <ItemTemplate>
                            <span class='qr-type-badge'><%# Eval("OrderType") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Submitted" SortExpression="submitted">
                        <ItemTemplate><%# ((DateTime)Eval("CreatedAt")).ToString("dd MMM yyyy, hh:mm tt") %></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" CommandName="DeleteRow" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-danger btn-sm"
                                OnClientClick="return confirm('Delete this request?')">Delete</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="text-center text-muted py-4">No quick requests match the current filters.</div>
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

    <style>
        .qr-type-badge { padding: 3px 10px; border-radius: 12px; font-size: .78rem; font-weight: 600; background: #cce5ff; color: #004085; }
    </style>
</asp:Content>
