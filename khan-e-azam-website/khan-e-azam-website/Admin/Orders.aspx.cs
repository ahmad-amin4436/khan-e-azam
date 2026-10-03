using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanEAzam.DAL;
using KhanEAzam.Models;

namespace KhanEAzam.Admin
{
    public partial class Orders : Page
    {
        private readonly OrderRepository _repo = new OrderRepository();

        // Current sort, kept in ViewState so it survives postbacks and the detail round-trip.
        private string SortBy
        {
            get { return (string)(ViewState["SortBy"] ?? "date"); }
            set { ViewState["SortBy"] = value; }
        }

        private bool SortDescending
        {
            get { return (bool)(ViewState["SortDesc"] ?? true); }
            set { ViewState["SortDesc"] = value; }
        }

        // Zero-based page index for server-side paging.
        private int PageIndex
        {
            get { return (int)(ViewState["PageIndex"] ?? 0); }
            set { ViewState["PageIndex"] = value < 0 ? 0 : value; }
        }

        private int PageSize
        {
            get
            {
                int n;
                return int.TryParse(ddlPageSize.SelectedValue, out n) && n > 0 ? n : 20;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFilterOptions();
                BindOrders();
            }
        }

        /// <summary>Fills the Order Type / Payment dropdowns from values actually present in the data.</summary>
        private void LoadFilterOptions()
        {
            FillDropDown(ddlType, _repo.GetDistinct("OrderType"), "All Types");
            FillDropDown(ddlPayment, _repo.GetDistinct("PaymentMethod"), "All Payments");
        }

        private static void FillDropDown(DropDownList ddl, List<string> values, string allText)
        {
            string selected = ddl.SelectedValue;
            ddl.Items.Clear();
            ddl.Items.Add(new ListItem(allText, ""));
            foreach (string v in values) ddl.Items.Add(new ListItem(v, v));
            if (!string.IsNullOrEmpty(selected) && ddl.Items.FindByValue(selected) != null)
                ddl.SelectedValue = selected;
        }

        private void BindOrders()
        {
            var filter = new OrderFilter
            {
                Status = ddlFilter.SelectedValue,
                OrderType = ddlType.SelectedValue,
                PaymentMethod = ddlPayment.SelectedValue,
                Keyword = txtKeyword.Text,
                FromDate = ParseDate(txtFrom.Text),
                ToDate = ParseDate(txtTo.Text),
                SortBy = SortBy,
                SortDescending = SortDescending,
                PageIndex = PageIndex,
                PageSize = PageSize
            };

            // A reversed range returns nothing, which looks like a bug — swap instead.
            if (filter.FromDate.HasValue && filter.ToDate.HasValue && filter.FromDate > filter.ToDate)
            {
                var tmp = filter.FromDate;
                filter.FromDate = filter.ToDate;
                filter.ToDate = tmp;
            }

            var page = _repo.Search(filter);

            // The repository clamps an out-of-range page (e.g. after a filter change); adopt it.
            PageIndex = page.PageIndex;

            gvOrders.DataSource = page.Items;
            gvOrders.DataBind();

            lblCount.Text = page.TotalRows + (page.TotalRows == 1 ? " order" : " orders");
            UpdatePager(page);
            SyncSortDropdowns();
            ShowActiveFilters(filter);
        }

        /// <summary>Row-range readout, page number and pager button states.</summary>
        private void UpdatePager(PagedResult<Order> page)
        {
            lblRange.Text = Server.HtmlEncode(page.RangeText("order", "orders"));
            lblPageInfo.Text = page.TotalPages == 0
                ? "Page 0 of 0"
                : string.Format("Page {0} of {1}", page.PageIndex + 1, page.TotalPages);

            bool first = page.PageIndex <= 0;
            bool last = page.PageIndex >= page.TotalPages - 1;
            btnFirst.Enabled = btnPrev.Enabled = !first;
            btnNext.Enabled = btnLast.Enabled = !last;
            ViewState["TotalPages"] = page.TotalPages;
        }

        private int TotalPages
        {
            get { return (int)(ViewState["TotalPages"] ?? 0); }
        }

        private static DateTime? ParseDate(string text)
        {
            DateTime d;
            return DateTime.TryParse(text, out d) ? d : (DateTime?)null;
        }

        /// <summary>Keeps the sort dropdowns in step when sorting is driven by a column header.</summary>
        private void SyncSortDropdowns()
        {
            if (ddlSort.Items.FindByValue(SortBy) != null) ddlSort.SelectedValue = SortBy;
            ddlSortDir.SelectedValue = SortDescending ? "desc" : "asc";
        }

        private void ShowActiveFilters(OrderFilter f)
        {
            var parts = new List<string>();
            if (!string.IsNullOrEmpty(f.Status)) parts.Add("Status: " + f.Status);
            if (!string.IsNullOrEmpty(f.OrderType)) parts.Add("Type: " + f.OrderType);
            if (!string.IsNullOrEmpty(f.PaymentMethod)) parts.Add("Payment: " + f.PaymentMethod);
            if (!string.IsNullOrWhiteSpace(f.Keyword)) parts.Add("Search: \"" + f.Keyword.Trim() + "\"");
            if (f.FromDate.HasValue) parts.Add("From: " + f.FromDate.Value.ToString("dd MMM yyyy"));
            if (f.ToDate.HasValue) parts.Add("To: " + f.ToDate.Value.ToString("dd MMM yyyy"));

            lblActiveFilters.Text = parts.Count == 0
                ? ""
                : Server.HtmlEncode("Filtered by — " + string.Join(" | ", parts));
        }

        protected void btnApply_Click(object sender, EventArgs e)
        {
            PageIndex = 0;   // a new filter starts at page 1
            BindOrders();
        }

        protected void btnFirst_Click(object sender, EventArgs e) { PageIndex = 0; BindOrders(); }
        protected void btnPrev_Click(object sender, EventArgs e) { PageIndex = PageIndex - 1; BindOrders(); }
        protected void btnNext_Click(object sender, EventArgs e) { PageIndex = PageIndex + 1; BindOrders(); }
        protected void btnLast_Click(object sender, EventArgs e) { PageIndex = Math.Max(0, TotalPages - 1); BindOrders(); }

        protected void ddlPageSize_Changed(object sender, EventArgs e)
        {
            PageIndex = 0;   // keep the user near the top when the page size changes
            BindOrders();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            ddlFilter.SelectedIndex = 0;
            ddlType.SelectedIndex = 0;
            ddlPayment.SelectedIndex = 0;
            txtKeyword.Text = "";
            txtFrom.Text = "";
            txtTo.Text = "";
            SortBy = "date";
            SortDescending = true;
            PageIndex = 0;
            BindOrders();
        }

        protected void Sort_Changed(object sender, EventArgs e)
        {
            SortBy = ddlSort.SelectedValue;
            SortDescending = ddlSortDir.SelectedValue == "desc";
            PageIndex = 0;   // re-sorting changes what page 1 means
            BindOrders();
        }

        /// <summary>Column-header sorting: same column toggles direction, a new column starts descending.</summary>
        protected void gvOrders_Sorting(object sender, GridViewSortEventArgs e)
        {
            if (SortBy == e.SortExpression) SortDescending = !SortDescending;
            else { SortBy = e.SortExpression; SortDescending = true; }

            PageIndex = 0;
            BindOrders();
        }

        /// <summary>Mutes cancelled rows in the list so they read as inactive at a glance.</summary>
        protected void gvOrders_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow) return;

            var order = e.Row.DataItem as Order;
            if (order != null && OrderStatus.IsCancelled(order.Status))
                e.Row.CssClass = (e.Row.CssClass + " row-cancelled").Trim();
        }

        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id;
            if (e.CommandName == "ViewOrder" && int.TryParse(e.CommandArgument.ToString(), out id))
            {
                LoadDetail(id);
            }
        }

        /// <summary>Role of the signed-in admin, used for the cancellation permission checks.</summary>
        private string CurrentRole
        {
            get { return Session["AdminRole"] as string; }
        }

        private string CurrentUsername
        {
            get { return Session["AdminUsername"] as string; }
        }

        private void LoadDetail(int id)
        {
            Order order = _repo.GetById(id);
            if (order == null) return;

            pnlList.Visible = false;
            pnlDetail.Visible = true;

            hfDetailOrderId.Value = id.ToString();
            lblDetailId.Text = id.ToString();
            lblDetailName.Text = Server.HtmlEncode(order.CustomerName);
            lblDetailPhone.Text = Server.HtmlEncode(order.CustomerPhone);
            lblDetailType.Text = Server.HtmlEncode(order.OrderType);
            lblDetailAddress.Text = Server.HtmlEncode(order.CustomerAddress);
            lblDetailPayment.Text = Server.HtmlEncode(order.PaymentMethod);
            lblDetailDate.Text = order.CreatedAt.ToString("dd MMM yyyy, hh:mm tt");
            lblDetailNotes.Text = string.IsNullOrEmpty(order.Notes) ? "—" : Server.HtmlEncode(order.Notes);
            lblDetailStatus.Text = order.Status;
            lblDetailTotal.Text = order.TotalAmount.ToString("0");

            if (ddlNewStatus.Items.FindByValue(order.Status) != null)
                ddlNewStatus.SelectedValue = order.Status;

            gvItems.DataSource = order.Items;
            gvItems.DataBind();

            ConfigureCancellationUi(order);
            BindHistory(id);
        }

        /// <summary>
        /// Shows the cancel or reopen affordance according to the order's state and the
        /// signed-in role. Hiding is presentation only — the click handlers re-check.
        /// </summary>
        private void ConfigureCancellationUi(Order order)
        {
            bool cancelled = OrderStatus.IsCancelled(order.Status);
            bool mayCancel = OrderStatus.CanCancel(CurrentRole);

            // A cancelled order is locked: hide the normal status controls and say why.
            pnlStatusControls.Visible = !cancelled;
            pnlCancelledBanner.Visible = cancelled;

            if (cancelled)
            {
                var last = _repo.GetStatusHistory(order.Id)
                                .FindLast(h => OrderStatus.IsCancelled(h.NewStatus));
                lblCancelledDetail.Text = last == null
                    ? "Reopen it below to make further status changes."
                    : Server.HtmlEncode(string.Format("Cancelled by {0} on {1}{2}",
                        last.ChangedByDisplay,
                        last.ChangedAt.ToString("dd MMM yyyy, hh:mm tt"),
                        string.IsNullOrEmpty(last.Reason) ? "." : " — " + last.Reason));
            }

            // The whole cancellation card is hidden from anyone who cannot use it.
            pnlCancel.Visible = mayCancel;
            if (!mayCancel) return;

            pnlCancelForm.Visible = !cancelled;
            pnlReopen.Visible = cancelled;
            litCancelHeading.Text = cancelled ? "Reopen Cancelled Order" : "Cancel Order";

            if (!cancelled)
            {
                // Cancelling after the food has gone out usually means money must move.
                bool sensitive = OrderStatus.IsRefundSensitiveCancellation(order.Status);
                lblCancelWarning.Visible = sensitive;
                if (sensitive)
                    lblCancelWarning.Text = "This order is already <strong>" + Server.HtmlEncode(order.Status)
                        + "</strong>. Cancelling it now may require a refund — check with the customer first.";
            }
        }

        private void BindHistory(int orderId)
        {
            gvHistory.DataSource = _repo.GetStatusHistory(orderId);
            gvHistory.DataBind();
        }

        /// <summary>Re-renders the detail panel after a status change, keeping messages visible.</summary>
        private void ReloadDetailPreservingMessages(int id)
        {
            bool msg = lblStatusMsg.Visible, err = lblStatusError.Visible;
            string msgText = lblStatusMsg.Text, errText = lblStatusError.Text;

            LoadDetail(id);

            lblStatusMsg.Visible = msg; lblStatusMsg.Text = msgText;
            lblStatusError.Visible = err; lblStatusError.Text = errText;
        }

        protected void btnUpdateStatus_Click(object sender, EventArgs e)
        {
            int id;
            if (!int.TryParse(hfDetailOrderId.Value, out id)) return;

            Order order = _repo.GetById(id);
            if (order == null) return;

            string newStatus = ddlNewStatus.SelectedValue;

            // Server-side gate: the dropdown no longer offers Cancelled, and a cancelled
            // order hides these controls, but neither is a security boundary on its own.
            string refusal;
            if (!OrderStatus.CanTransition(CurrentRole, order.Status, newStatus, out refusal))
            {
                ShowError(refusal);
                ReloadDetailPreservingMessages(id);
                return;
            }

            if (_repo.UpdateStatus(id, newStatus, CurrentUsername, CurrentRole, null))
                ShowSuccess("Status updated to <strong>" + Server.HtmlEncode(newStatus) + "</strong>.");
            else
                ShowError("The status could not be updated. Please reload and try again.");

            ReloadDetailPreservingMessages(id);
        }

        /// <summary>
        /// Cancels an order. This is not a separate mechanism — it goes through the same
        /// UpdateStatus path as every other transition, which writes the audit row.
        /// </summary>
        protected void btnCancelOrder_Click(object sender, EventArgs e)
        {
            int id;
            if (!int.TryParse(hfDetailOrderId.Value, out id)) return;

            Order order = _repo.GetById(id);
            if (order == null) return;

            if (!OrderStatus.CanCancel(CurrentRole))
            {
                ShowError("Only a Super Admin can cancel an order.");
                ReloadDetailPreservingMessages(id);
                return;
            }

            string reason = (txtCancelReason.Text ?? "").Trim();
            if (reason.Length == 0)
            {
                ShowError("Please give a reason for the cancellation — it is kept in the order history.");
                ReloadDetailPreservingMessages(id);
                return;
            }

            string refusal;
            if (!OrderStatus.CanTransition(CurrentRole, order.Status, OrderStatus.Cancelled, out refusal))
            {
                ShowError(refusal);
                ReloadDetailPreservingMessages(id);
                return;
            }

            if (_repo.UpdateStatus(id, OrderStatus.Cancelled, CurrentUsername, CurrentRole, reason))
            {
                txtCancelReason.Text = "";
                ShowSuccess("Order <strong>#" + id + "</strong> has been cancelled. "
                          + "The customer will see this status when tracking the order.");
            }
            else
            {
                ShowError("The order could not be cancelled. Please reload and try again.");
            }

            ReloadDetailPreservingMessages(id);
        }

        /// <summary>Moves a cancelled order back to an active status, recorded like any other change.</summary>
        protected void btnReopenOrder_Click(object sender, EventArgs e)
        {
            int id;
            if (!int.TryParse(hfDetailOrderId.Value, out id)) return;

            Order order = _repo.GetById(id);
            if (order == null) return;

            if (!OrderStatus.CanCancel(CurrentRole))
            {
                ShowError("Only a Super Admin can reopen a cancelled order.");
                ReloadDetailPreservingMessages(id);
                return;
            }

            string reason = (txtReopenReason.Text ?? "").Trim();
            if (reason.Length == 0)
            {
                ShowError("Please give a reason for reopening this order.");
                ReloadDetailPreservingMessages(id);
                return;
            }

            string newStatus = ddlReopenStatus.SelectedValue;
            string refusal;
            if (!OrderStatus.CanTransition(CurrentRole, order.Status, newStatus, out refusal))
            {
                ShowError(refusal);
                ReloadDetailPreservingMessages(id);
                return;
            }

            if (_repo.UpdateStatus(id, newStatus, CurrentUsername, CurrentRole, reason))
            {
                txtReopenReason.Text = "";
                ShowSuccess("Order <strong>#" + id + "</strong> reopened as <strong>"
                          + Server.HtmlEncode(newStatus) + "</strong>.");
            }
            else
            {
                ShowError("The order could not be reopened. Please reload and try again.");
            }

            ReloadDetailPreservingMessages(id);
        }

        private void ShowSuccess(string html)
        {
            lblStatusMsg.Text = html;
            lblStatusMsg.Visible = true;
            lblStatusError.Visible = false;
        }

        private void ShowError(string html)
        {
            lblStatusError.Text = html;
            lblStatusError.Visible = true;
            lblStatusMsg.Visible = false;
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
