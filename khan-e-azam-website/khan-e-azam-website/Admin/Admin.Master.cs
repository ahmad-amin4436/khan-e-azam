using System;
using System.Linq;
using System.Web.UI;

namespace KhanEAzam.Admin
{
    public partial class AdminMaster : MasterPage
    {
        // Dashboard and all content management belong to SuperAdmin only.
        // Manager and Staff share the operational pages below; Admin Users stays SuperAdmin-only.
        private static readonly string[] SuperAdminOnlyPages =
        {
            "Dashboard", "Users",
            "BannerSlides", "BrowseMenu", "TodaysSpecials", "MenuFilter",
            "IconFeatures", "Chefs", "Testimonials", "BlogPosts"
        };

        // Where a Manager/Staff session lands instead of the Dashboard.
        public const string DefaultPageForRestrictedRoles = "~/Admin/Orders.aspx";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminId"] == null)
            {
                Response.Redirect("~/Admin/Login.aspx");
                return;
            }

            string current = System.IO.Path.GetFileNameWithoutExtension(Request.AppRelativeCurrentExecutionFilePath ?? "");

            if (!IsSuperAdmin && SuperAdminOnlyPages.Contains(current, StringComparer.OrdinalIgnoreCase))
            {
                Response.Redirect(DefaultPageForRestrictedRoles);
            }
        }

        public string GetActiveClass(string page)
        {
            string current = System.IO.Path.GetFileNameWithoutExtension(Request.AppRelativeCurrentExecutionFilePath ?? "");
            return current.Equals(page, StringComparison.OrdinalIgnoreCase) ? "active" : "";
        }

        public bool IsSuperAdmin => (Session["AdminRole"] as string) == "SuperAdmin";

        // Dashboard and content management are both SuperAdmin-only, so they share this gate.
        public bool CanManageContent => IsSuperAdmin;
        public bool CanViewDashboard => IsSuperAdmin;
    }
}
