<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TableReservations.aspx.cs" Inherits="KhanEAzam.Admin.TableReservations" MasterPageFile="~/Admin/Admin.Master" %>
<asp:Content ContentPlaceHolderID="PageTitle" runat="server">Table Reservations</asp:Content>
<asp:Content ContentPlaceHolderID="PageHeading" runat="server">Table Reservations</asp:Content>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <div class="card">
        <div class="card-header">
            Reservations submitted from the Reservation page form
        </div>
        <div class="card-body p-0">
            <asp:Label ID="lblMsg" runat="server" Visible="false" CssClass="alert alert-success m-3 d-block"></asp:Label>
            <asp:GridView ID="gvReservations" runat="server" AutoGenerateColumns="false" CssClass="table table-hover mb-0"
                DataKeyNames="Id" OnRowCommand="gvReservations_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="#" />
                    <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                    <asp:BoundField DataField="ContactNumber" HeaderText="Contact Number" />
                    <asp:TemplateField HeaderText="Date">
                        <ItemTemplate><%# ((DateTime)Eval("ReservationDate")).ToString("dd MMM yyyy") %></ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="ReservationTime" HeaderText="Time" />
                    <asp:BoundField DataField="PartySize" HeaderText="Guests" />
                    <asp:TemplateField HeaderText="Special Requests">
                        <ItemTemplate><%# string.IsNullOrEmpty((string)Eval("SpecialRequests")) ? "—" : Eval("SpecialRequests") %></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Submitted">
                        <ItemTemplate><%# ((DateTime)Eval("CreatedAt")).ToString("dd MMM yyyy, hh:mm tt") %></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" CommandName="DeleteRow" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-danger btn-sm"
                                OnClientClick="return confirm('Delete this reservation?')">Delete</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="text-center text-muted py-4">No table reservations yet.</div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
