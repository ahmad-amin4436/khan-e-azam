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
        protected Repeater rptIconFeatures, rptTestimonials;
        protected Repeater rptBlogSmall, rptBlogLarge;

        protected TextBox txtQuickName, txtQuickPhone;
        protected DropDownList ddlQuickOrderType;
        protected Button btnQuickSubmit;
        protected Label lblQuickMsg;

        private const int HomepageMenuPreviewCount = 6;

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

                rptMenuFilter.DataSource = new MenuFilterRepository().GetAll().Where(x => x.IsActive).OrderBy(x => x.SortOrder).Take(HomepageMenuPreviewCount).ToList();
                rptMenuFilter.DataBind();

                rptIconFeatures.DataSource = new IconFeatureRepository().GetAll().Where(x => x.IsActive).OrderBy(x => x.SortOrder).ToList();
                rptIconFeatures.DataBind();

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

        protected string RenderBannerVideo(object videoUrl)
        {
            string url = videoUrl as string;
            if (string.IsNullOrWhiteSpace(url)) return "";
            return "<video autoplay loop muted playsinline class=\"absolute top-0 left-0 w-full h-full object-cover z-0\"><source src=\"" +
                System.Web.HttpUtility.HtmlAttributeEncode(url) + "\" type=\"video/mp4\"></video>";
        }

        protected void btnQuickSubmit_Click(object sender, EventArgs e)
        {
            string name = txtQuickName.Text.Trim();
            string phone = txtQuickPhone.Text.Trim();

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(phone))
            {
                lblQuickMsg.CssClass = "kea-quick-alert alert alert-danger";
                lblQuickMsg.Text = "Please fill in your full name and contact number.";
                lblQuickMsg.Visible = true;
                return;
            }

            new QuickRequestRepository().Insert(new QuickRequest
            {
                FullName = name,
                ContactNumber = phone,
                OrderType = ddlQuickOrderType.SelectedValue
            });

            txtQuickName.Text = "";
            txtQuickPhone.Text = "";
            ddlQuickOrderType.SelectedIndex = 0;

            lblQuickMsg.CssClass = "kea-quick-alert alert alert-success";
            lblQuickMsg.Text = "Thanks! We've received your request and will call you back shortly.";
            lblQuickMsg.Visible = true;
        }
    }
}
