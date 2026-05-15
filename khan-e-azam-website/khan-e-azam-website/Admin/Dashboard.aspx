<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="KhanEAzam.Admin.Dashboard" MasterPageFile="~/Admin/Admin.Master" %>
<asp:Content ContentPlaceHolderID="PageTitle" runat="server">Dashboard</asp:Content>
<asp:Content ContentPlaceHolderID="PageHeading" runat="server">Dashboard</asp:Content>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="card text-center py-3">
                <div style="font-size:2rem;color:#1F4D2C;"><i class="fas fa-images"></i></div>
                <div style="font-size:1.8rem;font-weight:700;color:#1F4D2C;"><asp:Label ID="lblBannerCount" runat="server">0</asp:Label></div>
                <div class="text-muted small">Banner Slides</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center py-3">
                <div style="font-size:2rem;color:#F5B82E;"><i class="fas fa-hamburger"></i></div>
                <div style="font-size:1.8rem;font-weight:700;color:#1F4D2C;"><asp:Label ID="lblMenuCount" runat="server">0</asp:Label></div>
                <div class="text-muted small">Browse Menu Items</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center py-3">
                <div style="font-size:2rem;color:#E87722;"><i class="fas fa-user-chef"></i></div>
                <div style="font-size:1.8rem;font-weight:700;color:#1F4D2C;"><asp:Label ID="lblChefCount" runat="server">0</asp:Label></div>
                <div class="text-muted small">Chefs</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center py-3">
                <div style="font-size:2rem;color:#28a745;"><i class="fas fa-newspaper"></i></div>
                <div style="font-size:1.8rem;font-weight:700;color:#1F4D2C;"><asp:Label ID="lblBlogCount" runat="server">0</asp:Label></div>
                <div class="text-muted small">Blog Posts</div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="card mb-4">
                <div class="card-header">Quick Links</div>
                <div class="card-body">
                    <a href="BannerSlides.aspx" class="btn btn-outline-secondary btn-sm mb-2 mr-2"><i class="fas fa-images mr-1"></i>Banner Slides</a>
                    <a href="BrowseMenu.aspx" class="btn btn-outline-secondary btn-sm mb-2 mr-2"><i class="fas fa-hamburger mr-1"></i>Browse Menu</a>
                    <a href="TodaysSpecials.aspx" class="btn btn-outline-secondary btn-sm mb-2 mr-2"><i class="fas fa-star mr-1"></i>Today's Specials</a>
                    <a href="MenuFilter.aspx" class="btn btn-outline-secondary btn-sm mb-2 mr-2"><i class="fas fa-list-ul mr-1"></i>Our Menu</a>
                    <a href="IconFeatures.aspx" class="btn btn-outline-secondary btn-sm mb-2 mr-2"><i class="fas fa-icons mr-1"></i>Icon Features</a>
                    <a href="Chefs.aspx" class="btn btn-outline-secondary btn-sm mb-2 mr-2"><i class="fas fa-user-chef mr-1"></i>Chefs</a>
                    <a href="Testimonials.aspx" class="btn btn-outline-secondary btn-sm mb-2 mr-2"><i class="fas fa-comment-dots mr-1"></i>Testimonials</a>
                    <a href="BlogPosts.aspx" class="btn btn-outline-secondary btn-sm mb-2 mr-2"><i class="fas fa-newspaper mr-1"></i>Blog Posts</a>
                    <a href="Orders.aspx" class="btn btn-outline-secondary btn-sm mb-2 mr-2"><i class="fas fa-receipt mr-1"></i>Manage Orders</a>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card mb-4">
                <div class="card-header">Website</div>
                <div class="card-body">
                    <a href="../Default.aspx" target="_blank" class="btn btn-warning btn-sm"><i class="fas fa-external-link-alt mr-1"></i>View Live Website</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
