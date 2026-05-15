using System;
using System.Web.UI;
using KhanEAzam.DAL;
using KhanEAzam.Models;

namespace khan_e_azam_website.Pages
{
    public partial class OrderTracking : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string idStr = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(idStr) && int.TryParse(idStr, out int orderId))
                {
                    try { LoadOrder(orderId); }
                    catch (Exception ex)
                    {
                        lblNotFound.Text = "Unable to load order details. (" + ex.Message + ")";
                        lblNotFound.Visible = true;
                    }
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string idStr = txtSearchId.Text.Trim();
            if (string.IsNullOrEmpty(idStr) || !int.TryParse(idStr, out int orderId) || orderId < 1)
            {
                lblNotFound.Text = "Please enter a valid numeric Order ID.";
                lblNotFound.Visible = true;
                return;
            }
            try
            {
                LoadOrder(orderId);
            }
            catch (Exception ex)
            {
                lblNotFound.Text = "Unable to retrieve order. Please try again. (" + ex.Message + ")";
                lblNotFound.Visible = true;
            }
        }

        protected void btnBackToSearch_Click(object sender, EventArgs e)
        {
            pnlOrder.Visible = false;
            pnlSearch.Visible = true;
            txtSearchId.Text = "";
            lblNotFound.Visible = false;
        }

        private void LoadOrder(int orderId)
        {
            Order order = new OrderRepository().GetById(orderId);
            if (order == null)
            {
                lblNotFound.Text = "No order found with ID #" + orderId + ". Please check and try again.";
                lblNotFound.Visible = true;
                pnlSearch.Visible = true;
                pnlOrder.Visible = false;
                return;
            }

            pnlSearch.Visible = false;
            pnlOrder.Visible = true;

            lblOrderId.Text = order.Id.ToString();
            hfStatus.Value = order.Status;

            string cssStatus = order.Status.Replace(" ", "");
            lblStatusBadge.Text = string.Format(
                "<span class=\"kea-status-badge kea-status-{0}\">{1}</span>",
                cssStatus, order.Status);

            lblCustomerName.Text = Server.HtmlEncode(order.CustomerName);
            lblPhone.Text = Server.HtmlEncode(order.CustomerPhone);
            lblAddress.Text = Server.HtmlEncode(order.CustomerAddress);
            lblPayment.Text = Server.HtmlEncode(order.PaymentMethod);
            lblDate.Text = order.CreatedAt.ToString("dd MMM yyyy, hh:mm tt");
            lblTotal.Text = order.TotalAmount.ToString("0");

            if (!string.IsNullOrEmpty(order.Notes))
            {
                pnlNotes.Visible = true;
                lblNotes.Text = Server.HtmlEncode(order.Notes);
            }

            rptItems.DataSource = order.Items;
            rptItems.DataBind();
        }
    }
}
