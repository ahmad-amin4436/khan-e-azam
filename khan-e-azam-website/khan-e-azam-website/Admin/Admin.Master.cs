using System;
using System.Linq;
using System.Web.UI;

namespace KhanEAzam.Admin
{
    public partial class AdminMaster : MasterPage
    {
        // Pages the "Staff" role may open. Everything else (content management, Admin Users)
        // needs at least "Manager"; Admin Users itself needs "SuperAdmin" (checked below too).
        private static readonly string[] StaffAllowedPages = { "Dashboard", "Orders", "QuickRequests", "Logout" };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminId"] == null)
            {
                Response.Redirect("~/Admin/Login.aspx");
                return;
            }

            string role = Session["AdminRole"] as string ?? "Staff";
            string current = System.IO.Path.GetFileNameWithoutExtension(Request.AppRelativeCurrentExecutionFilePath ?? "");

            if (current.Equals("Users", StringComparison.OrdinalIgnoreCase) && role != "SuperAdmin")
            {
                Response.Redirect("~/Admin/Dashboard.aspx");
                return;
            }

            if (role == "Staff" && !StaffAllowedPages.Contains(current, StringComparer.OrdinalIgnoreCase))
            {
                Response.Redirect("~/Admin/Dashboard.aspx");
            }
        }

        public string GetActiveClass(string page)
        {
            string current = System.IO.Path.GetFileNameWithoutExtension(Request.AppRelativeCurrentExecutionFilePath ?? "");
            return current.Equals(page, StringComparison.OrdinalIgnoreCase) ? "active" : "";
        }

        public bool IsSuperAdmin => (Session["AdminRole"] as string) == "SuperAdmin";
        public bool CanManageContent => (Session["AdminRole"] as string) != "Staff";
    }
}
