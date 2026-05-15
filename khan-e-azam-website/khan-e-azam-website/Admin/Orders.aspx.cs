using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanEAzam.DAL;
using KhanEAzam.Models;

namespace KhanEAzam.Admin
{
    public partial class Orders : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindOrders();
        }

        private void BindOrders()
        {
            var repo = new OrderRepository();
            string filter = ddlFilter.SelectedValue;
            var list = string.IsNullOrEmpty(filter) ? repo.GetAll() : repo.GetByStatus(filter);
            gvOrders.DataSource = list;
            gvOrders.DataBind();
        }

        protected void ddlFilter_Changed(object sender, EventArgs e)
        {
            BindOrders();
        }

        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewOrder" && int.TryParse(e.CommandArgument.ToString(), out int id))
            {
                LoadDetail(id);
            }
        }

        private void LoadDetail(int id)
        {
            Order order = new OrderRepository().GetById(id);
            if (order == null) return;

            pnlList.Visible = false;
            pnlDetail.Visible = true;

            hfDetailOrderId.Value = id.ToString();
            lblDetailId.Text = id.ToString();
            lblDetailName.Text = Server.HtmlEncode(order.CustomerName);
            lblDetailPhone.Text = Server.HtmlEncode(order.CustomerPhone);
            lblDetailAddress.Text = Server.HtmlEncode(order.CustomerAddress);
            lblDetailPayment.Text = Server.HtmlEncode(order.PaymentMethod);
            lblDetailDate.Text = order.CreatedAt.ToString("dd MMM yyyy, hh:mm tt");
            lblDetailNotes.Text = string.IsNullOrEmpty(order.Notes) ? "—" : Server.HtmlEncode(order.Notes);
            lblDetailStatus.Text = order.Status;
            lblDetailTotal.Text = order.TotalAmount.ToString("0");

            ddlNewStatus.SelectedValue = order.Status;

            gvItems.DataSource = order.Items;
            gvItems.DataBind();
        }

        protected void btnUpdateStatus_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(hfDetailOrderId.Value, out int id)) return;
            string newStatus = ddlNewStatus.SelectedValue;
            new OrderRepository().UpdateStatus(id, newStatus);

            lblDetailStatus.Text = newStatus;
            lblStatusMsg.Text = "Status updated to <strong>" + Server.HtmlEncode(newStatus) + "</strong>.";
            lblStatusMsg.Visible = true;
        }

        protected void btnBackToList_Click(object sender, EventArgs e)
        {
            pnlDetail.Visible = false;
            pnlList.Visible = true;
            lblMsg.Visible = false;
            BindOrders();
        }
    }
}
