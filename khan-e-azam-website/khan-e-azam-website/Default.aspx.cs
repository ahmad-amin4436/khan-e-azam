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

                rptMenuFilter.DataSource = GetMenuPreviewItems();
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

        // The homepage "Our Menu" filter pills only make sense if every non-"All" category has
        // at least one item to show — picking the first N items by SortOrder (as before) meant
        // they were all "sandwich", so every other filter button always showed an empty grid.
        // One representative item per filter category guarantees each button has a match.
        private List<MenuFilterItem> GetMenuPreviewItems()
        {
            string[] previewCategories = { "drink", "pizza", "salad", "sweet", "spicy", "burger" };
            var allItems = new MenuFilterRepository().GetAll().Where(x => x.IsActive).OrderBy(x => x.SortOrder).ToList();

            var preview = new List<MenuFilterItem>();
            foreach (var category in previewCategories)
            {
                var match = allItems.FirstOrDefault(x =>
                    (x.FilterTags ?? "").Split(' ').Contains(category) && !preview.Contains(x));
                if (match != null) preview.Add(match);
            }

            return preview.OrderBy(x => x.SortOrder).ToList();
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
