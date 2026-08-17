using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanEAzam.DAL;

namespace KhanEAzam.Admin
{
    public partial class QuickRequests : Page
    {
        protected GridView gvRequests;
        protected Label lblMsg;

        private readonly QuickRequestRepository _repo = new QuickRequestRepository();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindGrid();
        }

        private void BindGrid()
        {
            gvRequests.DataSource = _repo.GetAll();
            gvRequests.DataBind();
        }

        protected void gvRequests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteRow")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                _repo.Delete(id);
                lblMsg.Text = "Request deleted.";
                lblMsg.Visible = true;
                BindGrid();
            }
        }
    }
}
