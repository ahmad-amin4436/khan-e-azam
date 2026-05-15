using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanEAzam.DAL;
using KhanEAzam.Helpers;
using KhanEAzam.Models;

namespace KhanEAzam.Admin
{
    public partial class MenuFilter : Page
    {
        protected Panel pnlList, pnlForm;
        protected GridView gv;
        protected Label lblMsg, lblFormTitle, lblUploadError;
        protected HiddenField hfId, hfImagePath;
        protected TextBox txtName, txtDescription, txtPrice, txtFilterTags, txtSortOrder;
        protected CheckBox chkIsActive;
        protected FileUpload fuImage;
        protected System.Web.UI.WebControls.Image imgPreview;
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
                txtFilterTags.Text = m.FilterTags;
                hfImagePath.Value = m.Image;
                if (!string.IsNullOrEmpty(m.Image)) { imgPreview.ImageUrl = "~/" + m.Image; imgPreview.Visible = true; }
                else imgPreview.Visible = false;
                txtSortOrder.Text = m.SortOrder.ToString(); chkIsActive.Checked = m.IsActive;
                pnlList.Visible = false; pnlForm.Visible = true;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            lblUploadError.Visible = false;
            string imagePath = hfImagePath.Value;
            if (fuImage.HasFile)
            {
                string uploaded = ImageUploadHelper.Save(fuImage.PostedFile, Server.MapPath("~/assets/images/uploads/"));
                if (uploaded != null) imagePath = uploaded;
                else { lblUploadError.Text = "Invalid file. Use JPG/PNG/GIF/WEBP under 5 MB."; lblUploadError.Visible = true; return; }
            }
            var m = new MenuFilterItem
            {
                Id = Convert.ToInt32(hfId.Value), Name = txtName.Text.Trim(), Description = txtDescription.Text.Trim(),
                Price = txtPrice.Text.Trim(), Image = imagePath, FilterTags = txtFilterTags.Text.Trim(),
                SortOrder = int.TryParse(txtSortOrder.Text, out int so) ? so : 0, IsActive = chkIsActive.Checked
            };
            if (m.Id == 0) _repo.Insert(m); else _repo.Update(m);
            pnlForm.Visible = false; pnlList.Visible = true;
            lblMsg.Text = "Saved successfully."; lblMsg.Visible = true; BindGrid();
        }

        protected void btnCancel_Click(object sender, EventArgs e) { pnlForm.Visible = false; pnlList.Visible = true; BindGrid(); }

        private void ClearForm()
        {
            txtName.Text = txtDescription.Text = txtPrice.Text = txtFilterTags.Text = "";
            txtSortOrder.Text = "0"; chkIsActive.Checked = true;
            hfImagePath.Value = ""; imgPreview.Visible = false; lblUploadError.Visible = false;
        }
    }
}
