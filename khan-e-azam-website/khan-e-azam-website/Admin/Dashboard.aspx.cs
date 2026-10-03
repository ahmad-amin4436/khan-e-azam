using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanEAzam.DAL;

namespace KhanEAzam.Admin
{
    public partial class Dashboard : Page
    {
        protected Label lblBannerCount, lblMenuCount, lblChefCount, lblBlogCount;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Master page also blocks this, but guard here so the page is never rendered for
            // a Manager/Staff session even if the nav changes.
            if ((Session["AdminRole"] as string) != "SuperAdmin")
            {
                Response.Redirect(AdminMaster.DefaultPageForRestrictedRoles);
                return;
            }

            if (!IsPostBack)
            {
                lblBannerCount.Text = new BannerSlideRepository().GetAll().Count.ToString();
                lblMenuCount.Text = new BrowseMenuRepository().GetAll().Count.ToString();
                lblChefCount.Text = new ChefRepository().GetAll().Count.ToString();
                lblBlogCount.Text = new BlogPostRepository().GetAll().Count.ToString();
            }
        }
    }
}
