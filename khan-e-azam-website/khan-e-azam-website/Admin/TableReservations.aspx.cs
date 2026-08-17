using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanEAzam.DAL;

namespace KhanEAzam.Admin
{
    public partial class TableReservations : Page
    {
        protected GridView gvReservations;
        protected Label lblMsg;

        private readonly TableReservationRepository _repo = new TableReservationRepository();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindGrid();
        }

        private void BindGrid()
        {
            gvReservations.DataSource = _repo.GetAll();
            gvReservations.DataBind();
        }

        protected void gvReservations_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteRow")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                _repo.Delete(id);
                lblMsg.Text = "Reservation deleted.";
                lblMsg.Visible = true;
                BindGrid();
            }
        }
    }
}
