using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanEAzam.DAL;
using KhanEAzam.Models;
using System.Collections.Generic;
using System.Linq;

namespace khan_e_azam_website
{
    public partial class _Default : Page
    {
        protected Repeater rptBanner, rptBrowseMenu, rptTodaySpecial, rptMenuFilter;
        protected Repeater rptIconFeatures, rptChefs, rptTestimonials;
        protected Repeater rptBlogSmall, rptBlogLarge;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rptBanner.DataSource = new BannerSlideRepository().GetAll().Where(x => x.IsActive).OrderBy(x => x.SortOrder).ToList();
                rptBanner.DataBind();

                rptBrowseMenu.DataSource = new BrowseMenuRepository().GetAll().Where(x => x.IsActive).OrderBy(x => x.SortOrder).ToList();
                rptBrowseMenu.DataBind();

                rptTodaySpecial.DataSource = new TodaysSpecialRepository().GetAll().Where(x => x.IsActive).OrderBy(x => x.SortOrder).ToList();
                rptTodaySpecial.DataBind();

                rptMenuFilter.DataSource = new MenuFilterRepository().GetAll().Where(x => x.IsActive).OrderBy(x => x.SortOrder).ToList();
                rptMenuFilter.DataBind();

                rptIconFeatures.DataSource = new IconFeatureRepository().GetAll().Where(x => x.IsActive).OrderBy(x => x.SortOrder).ToList();
                rptIconFeatures.DataBind();

                rptChefs.DataSource = new ChefRepository().GetAll().Where(x => x.IsActive).OrderBy(x => x.SortOrder).ToList();
                rptChefs.DataBind();

                rptTestimonials.DataSource = new TestimonialRepository().GetAll().Where(x => x.IsActive).OrderBy(x => x.SortOrder).ToList();
                rptTestimonials.DataBind();

                var blogs = new BlogPostRepository().GetAll().Where(x => x.IsActive).OrderBy(x => x.SortOrder).ToList();
                rptBlogSmall.DataSource = blogs.Where(x => !x.IsLarge).ToList();
                rptBlogSmall.DataBind();
                rptBlogLarge.DataSource = blogs.Where(x => x.IsLarge).ToList();
                rptBlogLarge.DataBind();
            }
        }

        protected string FormatDate(object dt)
        {
            if (dt == null || dt == DBNull.Value) return "";
            return ((DateTime)dt).ToString("dd MMM yyyy");
        }
    }
}
