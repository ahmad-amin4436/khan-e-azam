using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanEAzam.DAL;
using KhanEAzam.Models;

namespace KhanEAzam.Admin
{
    public partial class QuickRequests : Page
    {
        protected Panel pnlList;
        protected GridView gvRequests;
        protected Label lblMsg, lblCount, lblActiveFilters, lblRange, lblPageInfo;
        protected DropDownList ddlSort, ddlSortDir, ddlType, ddlPageSize;
        protected TextBox txtKeyword, txtFrom, txtTo;
        protected Button btnApply, btnReset, btnFirst, btnPrev, btnNext, btnLast;

        private readonly QuickRequestRepository _repo = new QuickRequestRepository();

        private string SortBy
        {
            get { return (string)(ViewState["SortBy"] ?? "submitted"); }
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

        private int TotalPages
        {
            get { return (int)(ViewState["TotalPages"] ?? 0); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFilterOptions();
                BindGrid();
            }
        }

        private void LoadFilterOptions()
        {
            string selected = ddlType.SelectedValue;
            ddlType.Items.Clear();
            ddlType.Items.Add(new ListItem("All Types", ""));
            foreach (string t in _repo.GetOrderTypes()) ddlType.Items.Add(new ListItem(t, t));
            if (!string.IsNullOrEmpty(selected) && ddlType.Items.FindByValue(selected) != null)
                ddlType.SelectedValue = selected;
        }

        private void BindGrid()
        {
            DateTime? from = ParseDate(txtFrom.Text);
            DateTime? to = ParseDate(txtTo.Text);
            if (from.HasValue && to.HasValue && from > to) { var t = from; from = to; to = t; }

            var page = _repo.Search(ddlType.SelectedValue, from, to, txtKeyword.Text,
                                    SortBy, SortDescending, PageIndex, PageSize);

            // The repository clamps an out-of-range page (e.g. after a delete); adopt it.
            PageIndex = page.PageIndex;

            gvRequests.DataSource = page.Items;
            gvRequests.DataBind();

            lblCount.Text = page.TotalRows + (page.TotalRows == 1 ? " request" : " requests");
            UpdatePager(page);
            SyncSortDropdowns();
            ShowActiveFilters(from, to);
        }

        /// <summary>Row-range readout, page number and pager button states.</summary>
        private void UpdatePager(PagedResult<KhanEAzam.Models.QuickRequest> page)
        {
            lblRange.Text = Server.HtmlEncode(page.RangeText("request", "requests"));
            lblPageInfo.Text = page.TotalPages == 0
                ? "Page 0 of 0"
                : string.Format("Page {0} of {1}", page.PageIndex + 1, page.TotalPages);

            bool first = page.PageIndex <= 0;
            bool last = page.PageIndex >= page.TotalPages - 1;
            btnFirst.Enabled = btnPrev.Enabled = !first;
            btnNext.Enabled = btnLast.Enabled = !last;
            ViewState["TotalPages"] = page.TotalPages;
        }

        protected void btnFirst_Click(object sender, EventArgs e) { PageIndex = 0; BindGrid(); }
        protected void btnPrev_Click(object sender, EventArgs e) { PageIndex = PageIndex - 1; BindGrid(); }
        protected void btnNext_Click(object sender, EventArgs e) { PageIndex = PageIndex + 1; BindGrid(); }
        protected void btnLast_Click(object sender, EventArgs e) { PageIndex = Math.Max(0, TotalPages - 1); BindGrid(); }

        protected void ddlPageSize_Changed(object sender, EventArgs e)
        {
            PageIndex = 0;
            BindGrid();
        }

        private static DateTime? ParseDate(string text)
        {
            DateTime d;
            return DateTime.TryParse(text, out d) ? d : (DateTime?)null;
        }

        private void SyncSortDropdowns()
        {
            if (ddlSort.Items.FindByValue(SortBy) != null) ddlSort.SelectedValue = SortBy;
            ddlSortDir.SelectedValue = SortDescending ? "desc" : "asc";
        }

        private void ShowActiveFilters(DateTime? from, DateTime? to)
        {
            var parts = new List<string>();
            if (!string.IsNullOrEmpty(ddlType.SelectedValue)) parts.Add("Type: " + ddlType.SelectedValue);
            if (!string.IsNullOrWhiteSpace(txtKeyword.Text)) parts.Add("Search: \"" + txtKeyword.Text.Trim() + "\"");
            if (from.HasValue) parts.Add("From: " + from.Value.ToString("dd MMM yyyy"));
            if (to.HasValue) parts.Add("To: " + to.Value.ToString("dd MMM yyyy"));

            lblActiveFilters.Text = parts.Count == 0
                ? ""
                : Server.HtmlEncode("Filtered by — " + string.Join(" | ", parts));
        }

        protected void btnApply_Click(object sender, EventArgs e)
        {
            PageIndex = 0;   // a new filter starts at page 1
            BindGrid();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            ddlType.SelectedIndex = 0;
            txtKeyword.Text = "";
            txtFrom.Text = "";
            txtTo.Text = "";
            SortBy = "submitted";
            SortDescending = true;
            PageIndex = 0;
            BindGrid();
        }

        protected void Sort_Changed(object sender, EventArgs e)
        {
            SortBy = ddlSort.SelectedValue;
            SortDescending = ddlSortDir.SelectedValue == "desc";
            PageIndex = 0;   // re-sorting changes what page 1 means
            BindGrid();
        }

        /// <summary>Column-header sorting: same column toggles direction, a new column starts descending.</summary>
        protected void gvRequests_Sorting(object sender, GridViewSortEventArgs e)
        {
            if (SortBy == e.SortExpression) SortDescending = !SortDescending;
            else { SortBy = e.SortExpression; SortDescending = true; }

            PageIndex = 0;
            BindGrid();
        }

        protected void gvRequests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteRow")
            {
                int id;
                if (!int.TryParse(e.CommandArgument.ToString(), out id)) return;
                _repo.Delete(id);
                lblMsg.Text = "Request deleted.";
                lblMsg.Visible = true;
                LoadFilterOptions();
                BindGrid();
            }
        }
    }
}
