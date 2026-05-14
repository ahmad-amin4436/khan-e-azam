using System;
using System.Web.UI;

namespace KhanEAzam.Admin
{
    public partial class Logout : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Admin/Login.aspx");
        }
    }
}
