using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanEAzam.DAL;
using KhanEAzam.Models;

namespace KhanEAzam.Admin
{
    public partial class TodaysSpecials : Page
    {
        protected Panel pnlList, pnlForm;
        protected GridView gv;
        protected Label lblMsg, lblFormTitle;
        protected HiddenField hfId;
        protected TextBox txtName, txtCategory, txtWeight, txtPrice, txtImage, txtSortOrder;
        protected CheckBox chkIsActive;
        protected Button btnNew, btnSave, btnCancel;

        private readonly TodaysSpecialRepository _repo = new TodaysSpecialRepository();

        protected void Page_Load(object sender, EventArgs e) { if (!IsPostBack) BindGrid(); }
        private void BindGrid() { gv.DataSource = _repo.GetAll(); gv.DataBind(); }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            hfId.Value = "0"; lblFormTitle.Text = "Add Today's Special"; ClearForm();
            pnlList.Visible = false; pnlForm.Visible = true;
        }

        protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "DeleteRow") { _repo.Delete(id); lblMsg.Text = "Deleted."; lblMsg.Visible = true; BindGrid(); }
            else if (e.CommandName == "EditRow")
            {
                var s = _repo.GetById(id); if (s == null) return;
                hfId.Value = s.Id.ToString(); lblFormTitle.Text = "Edit Today's Special";
                txtName.Text = s.Name; txtCategory.Text = s.Category; txtWeight.Text = s.Weight;
                txtPrice.Text = s.Price; txtImage.Text = s.Image;
                txtSortOrder.Text = s.SortOrder.ToString(); chkIsActive.Checked = s.IsActive;
                pnlList.Visible = false; pnlForm.Visible = true;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            var s = new TodaysSpecial
            {
                Id = Convert.ToInt32(hfId.Value), Name = txtName.Text.Trim(), Category = txtCategory.Text.Trim(),
                Weight = txtWeight.Text.Trim(), Price = txtPrice.Text.Trim(), Image = txtImage.Text.Trim(),
                SortOrder = int.TryParse(txtSortOrder.Text, out int so) ? so : 0, IsActive = chkIsActive.Checked
            };
            if (s.Id == 0) _repo.Insert(s); else _repo.Update(s);
            pnlForm.Visible = false; pnlList.Visible = true;
            lblMsg.Text = "Saved successfully."; lblMsg.Visible = true; BindGrid();
        }

        protected void btnCancel_Click(object sender, EventArgs e) { pnlForm.Visible = false; pnlList.Visible = true; BindGrid(); }
        private void ClearForm() { txtName.Text = txtCategory.Text = txtWeight.Text = txtPrice.Text = txtImage.Text = ""; txtSortOrder.Text = "0"; chkIsActive.Checked = true; }
    }
}
