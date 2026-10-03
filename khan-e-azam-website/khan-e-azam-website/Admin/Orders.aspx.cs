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

        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id;
            if (e.CommandName == "ViewOrder" && int.TryParse(e.CommandArgument.ToString(), out id))
            {
                LoadDetail(id);
            }
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
        }

        protected void btnUpdateStatus_Click(object sender, EventArgs e)
        {
            int id;
            if (!int.TryParse(hfDetailOrderId.Value, out id)) return;
            string newStatus = ddlNewStatus.SelectedValue;
            _repo.UpdateStatus(id, newStatus);

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
