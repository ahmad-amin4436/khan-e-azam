using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanEAzam.DAL;
using KhanEAzam.Models;

namespace KhanEAzam.Admin
{
    public partial class TableReservations : Page
    {
        protected Panel pnlList;
        protected GridView gvReservations;
        protected Label lblMsg, lblCount, lblActiveFilters, lblRange, lblPageInfo;
        protected DropDownList ddlSort, ddlSortDir, ddlPartySize, ddlPageSize;
        protected TextBox txtKeyword, txtFrom, txtTo;
        protected CheckBox chkUpcoming;
        protected Button btnApply, btnReset, btnFirst, btnPrev, btnNext, btnLast;

        private readonly TableReservationRepository _repo = new TableReservationRepository();

        // Reservations read best in chronological order, so this list defaults to ascending.
        private string SortBy
        {
            get { return (string)(ViewState["SortBy"] ?? "date"); }
            set { ViewState["SortBy"] = value; }
        }

        private bool SortDescending
        {
            get { return (bool)(ViewState["SortDesc"] ?? false); }
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
            if (!IsPostBack) BindGrid();
        }

        private void BindGrid()
        {
            DateTime? from = ParseDate(txtFrom.Text);
            DateTime? to = ParseDate(txtTo.Text);
            if (from.HasValue && to.HasValue && from > to) { var t = from; from = to; to = t; }

            int size;
            int? minParty = int.TryParse(ddlPartySize.SelectedValue, out size) ? size : (int?)null;

            var page = _repo.Search(from, to, minParty, txtKeyword.Text, chkUpcoming.Checked,
                                    SortBy, SortDescending, PageIndex, PageSize);

            // The repository clamps an out-of-range page (e.g. after a delete); adopt it.
            PageIndex = page.PageIndex;

            gvReservations.DataSource = page.Items;
            gvReservations.DataBind();

            lblCount.Text = page.TotalRows + (page.TotalRows == 1 ? " reservation" : " reservations");
            UpdatePager(page);
            SyncSortDropdowns();
            ShowActiveFilters(from, to, minParty);
        }

        /// <summary>Row-range readout, page number and pager button states.</summary>
        private void UpdatePager(PagedResult<KhanEAzam.Models.TableReservation> page)
        {
            lblRange.Text = Server.HtmlEncode(page.RangeText("reservation", "reservations"));
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

        private void ShowActiveFilters(DateTime? from, DateTime? to, int? minParty)
        {
            var parts = new List<string>();
            if (chkUpcoming.Checked) parts.Add("Upcoming only");
            if (!string.IsNullOrWhiteSpace(txtKeyword.Text)) parts.Add("Search: \"" + txtKeyword.Text.Trim() + "\"");
            if (from.HasValue) parts.Add("From: " + from.Value.ToString("dd MMM yyyy"));
            if (to.HasValue) parts.Add("To: " + to.Value.ToString("dd MMM yyyy"));
            if (minParty.HasValue) parts.Add("Guests: " + minParty.Value + "+");

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
            txtKeyword.Text = "";
            txtFrom.Text = "";
            txtTo.Text = "";
            ddlPartySize.SelectedIndex = 0;
            chkUpcoming.Checked = false;
            SortBy = "date";
            SortDescending = false;
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

        /// <summary>Column-header sorting: same column toggles direction, a new column starts ascending.</summary>
        protected void gvReservations_Sorting(object sender, GridViewSortEventArgs e)
        {
            if (SortBy == e.SortExpression) SortDescending = !SortDescending;
            else { SortBy = e.SortExpression; SortDescending = false; }

            PageIndex = 0;
            BindGrid();
        }

        protected void gvReservations_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteRow")
            {
                int id;
                if (!int.TryParse(e.CommandArgument.ToString(), out id)) return;
                _repo.Delete(id);
                lblMsg.Text = "Reservation deleted.";
                lblMsg.Visible = true;
                BindGrid();
            }
        }
    }
}
