using System;
using System.Web.UI;

namespace KhanEAzam.Admin
{
    public partial class AdminMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminId"] == null)
                Response.Redirect("~/Admin/Login.aspx");
        }

        public string GetActiveClass(string page)
        {
            string current = System.IO.Path.GetFileNameWithoutExtension(Request.AppRelativeCurrentExecutionFilePath ?? "");
            return current.Equals(page, StringComparison.OrdinalIgnoreCase) ? "active" : "";
        }
    }
}
