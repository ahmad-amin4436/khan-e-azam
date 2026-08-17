using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanEAzam.DAL;

namespace khan_e_azam_website
{
    public partial class about : System.Web.UI.Page
    {
        protected Repeater rptAboutTestimonials;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rptAboutTestimonials.DataSource = new TestimonialRepository().GetAll().Where(x => x.IsActive).OrderBy(x => x.SortOrder).ToList();
                rptAboutTestimonials.DataBind();
            }
        }
    }
}