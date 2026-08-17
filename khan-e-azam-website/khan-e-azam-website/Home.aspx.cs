using System;
using System.Web.UI;

namespace khan_e_azam_website
{
    public partial class Home : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.ContentEncoding = System.Text.Encoding.UTF8;
            Response.HeaderEncoding = System.Text.Encoding.UTF8;
            Response.Charset = "utf-8";
        }
        
    }
}
