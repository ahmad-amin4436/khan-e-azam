using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanEAzam.DAL;
using KhanEAzam.Models;

namespace KhanEAzam.Admin
{
    public partial class IconFeatures : Page
    {
        protected Panel pnlList, pnlForm;
        protected GridView gv;
        protected Label lblMsg, lblFormTitle;
        protected HiddenField hfId;
        protected TextBox txtIconClass, txtTitle, txtDescription, txtLinkUrl, txtSortOrder;
        protected CheckBox chkIsActive;
        protected Button btnNew, btnSave, btnCancel;

        private readonly IconFeatureRepository _repo = new IconFeatureRepository();

        protected void Page_Load(object sender, EventArgs e) { if (!IsPostBack) BindGrid(); }
        private void BindGrid() { gv.DataSource = _repo.GetAll(); gv.DataBind(); }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            hfId.Value = "0"; lblFormTitle.Text = "Add Icon Feature"; ClearForm();
            pnlList.Visible = false; pnlForm.Visible = true;
        }

        protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "DeleteRow") { _repo.Delete(id); lblMsg.Text = "Deleted."; lblMsg.Visible = true; BindGrid(); }
            else if (e.CommandName == "EditRow")
            {
                var f = _repo.GetById(id); if (f == null) return;
                hfId.Value = f.Id.ToString(); lblFormTitle.Text = "Edit Icon Feature";
                txtIconClass.Text = f.IconClass; txtTitle.Text = f.Title; txtDescription.Text = f.Description;
                txtLinkUrl.Text = f.LinkUrl; txtSortOrder.Text = f.SortOrder.ToString(); chkIsActive.Checked = f.IsActive;
                pnlList.Visible = false; pnlForm.Visible = true;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            var f = new IconFeature
            {
                Id = Convert.ToInt32(hfId.Value), IconClass = txtIconClass.Text.Trim(), Title = txtTitle.Text.Trim(),
                Description = txtDescription.Text.Trim(), LinkUrl = txtLinkUrl.Text.Trim(),
                SortOrder = int.TryParse(txtSortOrder.Text, out int so) ? so : 0, IsActive = chkIsActive.Checked
            };
            if (f.Id == 0) _repo.Insert(f); else _repo.Update(f);
            pnlForm.Visible = false; pnlList.Visible = true;
            lblMsg.Text = "Saved successfully."; lblMsg.Visible = true; BindGrid();
        }

        protected void btnCancel_Click(object sender, EventArgs e) { pnlForm.Visible = false; pnlList.Visible = true; BindGrid(); }
        private void ClearForm() { txtIconClass.Text = txtTitle.Text = txtDescription.Text = txtLinkUrl.Text = ""; txtSortOrder.Text = "0"; chkIsActive.Checked = true; }
    }
}
