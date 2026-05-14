using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanEAzam.DAL;
using KhanEAzam.Models;

namespace KhanEAzam.Admin
{
    public partial class MenuFilter : Page
    {
        protected Panel pnlList, pnlForm;
        protected GridView gv;
        protected Label lblMsg, lblFormTitle;
        protected HiddenField hfId;
        protected TextBox txtName, txtDescription, txtPrice, txtImage, txtFilterTags, txtSortOrder;
        protected CheckBox chkIsActive;
        protected Button btnNew, btnSave, btnCancel;

        private readonly MenuFilterRepository _repo = new MenuFilterRepository();

        protected void Page_Load(object sender, EventArgs e) { if (!IsPostBack) BindGrid(); }
        private void BindGrid() { gv.DataSource = _repo.GetAll(); gv.DataBind(); }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            hfId.Value = "0"; lblFormTitle.Text = "Add Menu Item"; ClearForm();
            pnlList.Visible = false; pnlForm.Visible = true;
        }

        protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "DeleteRow") { _repo.Delete(id); lblMsg.Text = "Deleted."; lblMsg.Visible = true; BindGrid(); }
            else if (e.CommandName == "EditRow")
            {
                var m = _repo.GetById(id); if (m == null) return;
                hfId.Value = m.Id.ToString(); lblFormTitle.Text = "Edit Menu Item";
                txtName.Text = m.Name; txtDescription.Text = m.Description; txtPrice.Text = m.Price;
                txtImage.Text = m.Image; txtFilterTags.Text = m.FilterTags;
                txtSortOrder.Text = m.SortOrder.ToString(); chkIsActive.Checked = m.IsActive;
                pnlList.Visible = false; pnlForm.Visible = true;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            var m = new MenuFilterItem
            {
                Id = Convert.ToInt32(hfId.Value), Name = txtName.Text.Trim(), Description = txtDescription.Text.Trim(),
                Price = txtPrice.Text.Trim(), Image = txtImage.Text.Trim(), FilterTags = txtFilterTags.Text.Trim(),
                SortOrder = int.TryParse(txtSortOrder.Text, out int so) ? so : 0, IsActive = chkIsActive.Checked
            };
            if (m.Id == 0) _repo.Insert(m); else _repo.Update(m);
            pnlForm.Visible = false; pnlList.Visible = true;
            lblMsg.Text = "Saved successfully."; lblMsg.Visible = true; BindGrid();
        }

        protected void btnCancel_Click(object sender, EventArgs e) { pnlForm.Visible = false; pnlList.Visible = true; BindGrid(); }
        private void ClearForm() { txtName.Text = txtDescription.Text = txtPrice.Text = txtImage.Text = txtFilterTags.Text = ""; txtSortOrder.Text = "0"; chkIsActive.Checked = true; }
    }
}
