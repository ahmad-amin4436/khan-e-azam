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
