<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BrowseMenu.aspx.cs" Inherits="KhanEAzam.Admin.BrowseMenu" MasterPageFile="~/Admin/Admin.Master" ValidateRequest="false" %>
<asp:Content ContentPlaceHolderID="PageTitle" runat="server">Browse Menu</asp:Content>
<asp:Content ContentPlaceHolderID="PageHeading" runat="server">Browse Menu Items</asp:Content>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlList" runat="server">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                Browse Menu Items
                <asp:Button ID="btnNew" runat="server" Text="+ Add New" CssClass="btn btn-primary btn-sm" OnClick="btnNew_Click" />
            </div>
            <div class="card-body p-0">
                <asp:Label ID="lblMsg" runat="server" Visible="false" CssClass="alert alert-success m-3 d-block"></asp:Label>
                <asp:GridView ID="gv" runat="server" AutoGenerateColumns="false" CssClass="table table-hover mb-0"
                    DataKeyNames="Id" OnRowCommand="gv_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="#" />
                        <asp:BoundField DataField="Name" HeaderText="Name" />
                        <asp:BoundField DataField="SubTitle" HeaderText="Subtitle" />
                        <asp:BoundField DataField="Price" HeaderText="Price" />
                        <asp:BoundField DataField="SortOrder" HeaderText="Order" />
                        <asp:TemplateField HeaderText="Image">
                            <ItemTemplate>
                                <img src='<%# ResolveUrl("~/" + Eval("Image")) %>' style="height:40px;width:40px;object-fit:cover;border-radius:4px;" onerror="this.style.display='none'" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Active">
                            <ItemTemplate><span class='<%# (bool)Eval("IsActive") ? "badge-active" : "badge-inactive" %>'><%# (bool)Eval("IsActive") ? "Yes" : "No" %></span></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" CommandName="EditRow" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-warning btn-sm">Edit</asp:LinkButton>
                                <asp:LinkButton runat="server" CommandName="DeleteRow" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-danger btn-sm ml-1" OnClientClick="return confirm('Delete?')">Delete</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="pnlForm" runat="server" Visible="false">
        <div class="card">
            <div class="card-header"><asp:Label ID="lblFormTitle" runat="server">Add Item</asp:Label></div>
            <div class="card-body">
                <asp:HiddenField ID="hfId" runat="server" Value="0" />
                <div class="row">
                    <div class="col-md-6 form-group"><label>Name</label><asp:TextBox ID="txtName" runat="server" CssClass="form-control" /></div>
                    <div class="col-md-6 form-group"><label>Subtitle</label><asp:TextBox ID="txtSubTitle" runat="server" CssClass="form-control" /></div>
                    <div class="col-md-6 form-group"><label>Price</label><asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" placeholder="Rs.450" /></div>
                    <div class="col-md-4 form-group"><label>Sort Order</label><asp:TextBox ID="txtSortOrder" runat="server" CssClass="form-control" Text="0" /></div>
                    <div class="col-md-2 form-group"><label>Active</label><br /><asp:CheckBox ID="chkIsActive" runat="server" Checked="true" Text=" Active" /></div>
                    <div class="col-md-12 form-group">
                        <label>Image</label>
                        <asp:HiddenField ID="hfImagePath" runat="server" />
                        <asp:Image ID="imgPreview" runat="server" Visible="false" CssClass="d-block img-thumbnail mb-2" style="max-height:100px;max-width:150px;" />
                        <asp:FileUpload ID="fuImage" runat="server" CssClass="form-control-file" accept=".jpg,.jpeg,.png,.gif,.webp" />
                        <small class="form-text text-muted">JPG, PNG, GIF or WEBP · Max 5 MB. Leave blank to keep existing image.</small>
                    </div>
                </div>
                <asp:Label ID="lblUploadError" runat="server" Visible="false" CssClass="alert alert-danger d-block mb-2"></asp:Label>
                <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary ml-2" OnClick="btnCancel_Click" CausesValidation="false" />
            </div>
        </div>
    </asp:Panel>
</asp:Content>
