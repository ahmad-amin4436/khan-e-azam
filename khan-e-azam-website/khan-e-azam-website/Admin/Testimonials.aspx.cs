using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanEAzam.DAL;
using KhanEAzam.Models;

namespace KhanEAzam.Admin
{
    public partial class Testimonials : Page
    {
        protected Panel pnlList, pnlForm;
        protected GridView gv;
        protected Label lblMsg, lblFormTitle;
        protected HiddenField hfId;
        protected TextBox txtName, txtPosition, txtReview, txtImage, txtSortOrder;
        protected CheckBox chkIsActive;
        protected Button btnNew, btnSave, btnCancel;

        private readonly TestimonialRepository _repo = new TestimonialRepository();

        protected void Page_Load(object sender, EventArgs e) { if (!IsPostBack) BindGrid(); }
        private void BindGrid() { gv.DataSource = _repo.GetAll(); gv.DataBind(); }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            hfId.Value = "0"; lblFormTitle.Text = "Add Testimonial"; ClearForm();
            pnlList.Visible = false; pnlForm.Visible = true;
        }

        protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "DeleteRow") { _repo.Delete(id); lblMsg.Text = "Deleted."; lblMsg.Visible = true; BindGrid(); }
            else if (e.CommandName == "EditRow")
            {
                var t = _repo.GetById(id); if (t == null) return;
                hfId.Value = t.Id.ToString(); lblFormTitle.Text = "Edit Testimonial";
                txtName.Text = t.ReviewerName; txtPosition.Text = t.ReviewerPosition;
                txtReview.Text = t.ReviewText; txtImage.Text = t.Image;
                txtSortOrder.Text = t.SortOrder.ToString(); chkIsActive.Checked = t.IsActive;
                pnlList.Visible = false; pnlForm.Visible = true;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            var t = new Testimonial
            {
                Id = Convert.ToInt32(hfId.Value), ReviewerName = txtName.Text.Trim(),
                ReviewerPosition = txtPosition.Text.Trim(), ReviewText = txtReview.Text.Trim(),
                Image = txtImage.Text.Trim(),
                SortOrder = int.TryParse(txtSortOrder.Text, out int so) ? so : 0, IsActive = chkIsActive.Checked
            };
            if (t.Id == 0) _repo.Insert(t); else _repo.Update(t);
            pnlForm.Visible = false; pnlList.Visible = true;
            lblMsg.Text = "Saved successfully."; lblMsg.Visible = true; BindGrid();
        }

        protected void btnCancel_Click(object sender, EventArgs e) { pnlForm.Visible = false; pnlList.Visible = true; BindGrid(); }
        private void ClearForm() { txtName.Text = txtPosition.Text = txtReview.Text = txtImage.Text = ""; txtSortOrder.Text = "0"; chkIsActive.Checked = true; }
    }
}
