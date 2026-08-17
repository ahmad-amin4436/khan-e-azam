<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuickRequests.aspx.cs" Inherits="KhanEAzam.Admin.QuickRequests" MasterPageFile="~/Admin/Admin.Master" %>
<asp:Content ContentPlaceHolderID="PageTitle" runat="server">Quick Requests</asp:Content>
<asp:Content ContentPlaceHolderID="PageHeading" runat="server">Quick Order Requests</asp:Content>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <div class="card">
        <div class="card-header">
            Requests submitted from the homepage "Quick Order Request" form
        </div>
        <div class="card-body p-0">
            <asp:Label ID="lblMsg" runat="server" Visible="false" CssClass="alert alert-success m-3 d-block"></asp:Label>
            <asp:GridView ID="gvRequests" runat="server" AutoGenerateColumns="false" CssClass="table table-hover mb-0"
                DataKeyNames="Id" OnRowCommand="gvRequests_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="#" />
                    <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                    <asp:BoundField DataField="ContactNumber" HeaderText="Contact Number" />
                    <asp:TemplateField HeaderText="Order Type">
                        <ItemTemplate>
                            <span class='qr-type-badge'><%# Eval("OrderType") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Submitted">
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
                    <div class="text-center text-muted py-4">No quick requests yet.</div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

    <style>
        .qr-type-badge { padding: 3px 10px; border-radius: 12px; font-size: .78rem; font-weight: 600; background: #cce5ff; color: #004085; }
    </style>
</asp:Content>
