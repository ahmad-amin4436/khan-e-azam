<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="KhanEAzam.Admin.Users" MasterPageFile="~/Admin/Admin.Master" %>
<asp:Content ContentPlaceHolderID="PageTitle" runat="server">Admin Users</asp:Content>
<asp:Content ContentPlaceHolderID="PageHeading" runat="server">Admin Users</asp:Content>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlList" runat="server">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                Admin Users
                <asp:Button ID="btnNew" runat="server" Text="+ Add New" CssClass="btn btn-primary btn-sm" OnClick="btnNew_Click" />
            </div>
            <div class="card-body p-0">
                <asp:Label ID="lblMsg" runat="server" Visible="false" CssClass="alert alert-success m-3 d-block"></asp:Label>
                <asp:Label ID="lblListError" runat="server" Visible="false" CssClass="alert alert-danger m-3 d-block"></asp:Label>
                <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="false" CssClass="table table-hover mb-0"
                    DataKeyNames="Id" OnRowCommand="gvUsers_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="#" />
                        <asp:BoundField DataField="Username" HeaderText="Username" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:TemplateField HeaderText="Role">
                            <ItemTemplate>
                                <span class='role-badge role-<%# Eval("Role") %>'><%# Eval("Role") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Created">
                            <ItemTemplate><%# ((DateTime)Eval("CreatedAt")).ToString("dd MMM yyyy") %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" CommandName="EditRow" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-warning btn-sm">Edit</asp:LinkButton>
                                <asp:LinkButton runat="server" CommandName="DeleteRow" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-danger btn-sm ml-1"
                                    OnClientClick="return confirm('Delete this admin user?')">Delete</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="text-center text-muted py-4">No admin users found.</div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlForm" runat="server" Visible="false">
        <div class="card">
            <div class="card-header"><asp:Label ID="lblFormTitle" runat="server">Add Admin User</asp:Label></div>
            <div class="card-body">
                <asp:HiddenField ID="hfId" runat="server" Value="0" />
                <div class="row">
                    <div class="col-md-6 form-group"><label>Username</label><asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" /></div>
                    <div class="col-md-6 form-group"><label>Email</label><asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" /></div>
                    <div class="col-md-6 form-group">
                        <label id="lblPasswordLabel" runat="server">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" autocomplete="new-password" />
                        <small id="smPasswordHint" runat="server" class="form-text text-muted" Visible="false">Leave blank to keep the current password.</small>
                    </div>
                    <div class="col-md-6 form-group">
                        <label>Role</label>
                        <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control">
                            <asp:ListItem Value="SuperAdmin" Text="Super Admin — full access, incl. managing admin users" />
                            <asp:ListItem Value="Manager" Text="Manager — manage content &amp; orders" />
                            <asp:ListItem Value="Staff" Text="Staff — view orders &amp; quick requests only" />
                        </asp:DropDownList>
                    </div>
                </div>
                <asp:Label ID="lblFormError" runat="server" Visible="false" CssClass="alert alert-danger d-block mb-2"></asp:Label>
                <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary ml-2" OnClick="btnCancel_Click" CausesValidation="false" />
            </div>
        </div>
    </asp:Panel>

    <style>
        .role-badge { padding: 3px 10px; border-radius: 12px; font-size: .78rem; font-weight: 600; }
        .role-SuperAdmin { background: #d4edda; color: #155724; }
        .role-Manager { background: #cce5ff; color: #004085; }
        .role-Staff { background: #fff3cd; color: #856404; }
    </style>
</asp:Content>
