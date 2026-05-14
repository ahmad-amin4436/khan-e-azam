<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BannerSlides.aspx.cs" Inherits="KhanEAzam.Admin.BannerSlides" MasterPageFile="~/Admin/Admin.Master" ValidateRequest="false" %>
<asp:Content ContentPlaceHolderID="PageTitle" runat="server">Banner Slides</asp:Content>
<asp:Content ContentPlaceHolderID="PageHeading" runat="server">Banner Slides</asp:Content>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlList" runat="server">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                Banner Slides
                <asp:Button ID="btnNew" runat="server" Text="+ Add New" CssClass="btn btn-primary btn-sm" OnClick="btnNew_Click" />
            </div>
            <div class="card-body p-0">
                <asp:Label ID="lblMsg" runat="server" Visible="false" CssClass="alert alert-success m-3 d-block"></asp:Label>
                <asp:GridView ID="gvSlides" runat="server" AutoGenerateColumns="false" CssClass="table table-hover mb-0"
                    DataKeyNames="Id" OnRowCommand="gvSlides_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="#" />
                        <asp:BoundField DataField="TagLine" HeaderText="Tag Line" />
                        <asp:BoundField DataField="FoodCardName" HeaderText="Food Card" />
                        <asp:BoundField DataField="ChefName" HeaderText="Chef" />
                        <asp:BoundField DataField="Price" HeaderText="Price" />
                        <asp:BoundField DataField="SortOrder" HeaderText="Order" />
                        <asp:TemplateField HeaderText="Active">
                            <ItemTemplate>
                                <span class='<%# (bool)Eval("IsActive") ? "badge-active" : "badge-inactive" %>'><%# (bool)Eval("IsActive") ? "Yes" : "No" %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" CommandName="EditRow" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-warning btn-sm">Edit</asp:LinkButton>
                                <asp:LinkButton runat="server" CommandName="DeleteRow" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-danger btn-sm ml-1"
                                    OnClientClick="return confirm('Delete this slide?')">Delete</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlForm" runat="server" Visible="false">
        <div class="card">
            <div class="card-header"><asp:Label ID="lblFormTitle" runat="server">Add Banner Slide</asp:Label></div>
            <div class="card-body">
                <asp:HiddenField ID="hfId" runat="server" Value="0" />
                <div class="row">
                    <div class="col-md-6 form-group"><label>Tag Line</label><asp:TextBox ID="txtTagLine" runat="server" CssClass="form-control" /></div>
                    <div class="col-md-6 form-group"><label>Heading (HTML allowed)</label><asp:TextBox ID="txtHeading" runat="server" CssClass="form-control" /></div>
                    <div class="col-md-12 form-group"><label>Description</label><asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" /></div>
                    <div class="col-md-6 form-group"><label>Background Image Path</label><asp:TextBox ID="txtBgImage" runat="server" CssClass="form-control" placeholder="assets/images/hero/hero-1.jpg" /></div>
                    <div class="col-md-6 form-group"><label>Food Image Path</label><asp:TextBox ID="txtFoodImage" runat="server" CssClass="form-control" placeholder="assets/images/hero/food-1.png" /></div>
                    <div class="col-md-6 form-group"><label>Food Card Name</label><asp:TextBox ID="txtFoodCardName" runat="server" CssClass="form-control" /></div>
                    <div class="col-md-6 form-group"><label>Price</label><asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" placeholder="Rs.900" /></div>
                    <div class="col-md-12 form-group"><label>Card Description</label><asp:TextBox ID="txtCardDescription" runat="server" CssClass="form-control" /></div>
                    <div class="col-md-4 form-group"><label>Chef Name</label><asp:TextBox ID="txtChefName" runat="server" CssClass="form-control" /></div>
                    <div class="col-md-4 form-group"><label>Chef Role</label><asp:TextBox ID="txtChefRole" runat="server" CssClass="form-control" /></div>
                    <div class="col-md-4 form-group"><label>Chef Image Path</label><asp:TextBox ID="txtChefImage" runat="server" CssClass="form-control" placeholder="assets/images/hero/chef-1.jpg" /></div>
                    <div class="col-md-4 form-group"><label>Sort Order</label><asp:TextBox ID="txtSortOrder" runat="server" CssClass="form-control" Text="0" /></div>
                    <div class="col-md-4 form-group"><label>Active</label><br />
                        <asp:CheckBox ID="chkIsActive" runat="server" Checked="true" Text=" Active" />
                    </div>
                </div>
                <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary ml-2" OnClick="btnCancel_Click" CausesValidation="false" />
            </div>
        </div>
    </asp:Panel>
</asp:Content>
