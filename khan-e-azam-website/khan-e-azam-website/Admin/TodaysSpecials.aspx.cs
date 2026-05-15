using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanEAzam.DAL;
using KhanEAzam.Helpers;
using KhanEAzam.Models;

namespace KhanEAzam.Admin
{
    public partial class TodaysSpecials : Page
    {
        protected Panel pnlList, pnlForm;
        protected GridView gv;
        protected Label lblMsg, lblFormTitle, lblUploadError;
        protected HiddenField hfId, hfImagePath;
        protected TextBox txtName, txtCategory, txtWeight, txtPrice, txtSortOrder;
        protected CheckBox chkIsActive;
        protected FileUpload fuImage;
        protected System.Web.UI.WebControls.Image imgPreview;
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
                txtName.Text = s.Name; txtCategory.Text = s.Category; txtWeight.Text = s.Weight; txtPrice.Text = s.Price;
                hfImagePath.Value = s.Image;
                if (!string.IsNullOrEmpty(s.Image)) { imgPreview.ImageUrl = "~/" + s.Image; imgPreview.Visible = true; }
                else imgPreview.Visible = false;
                txtSortOrder.Text = s.SortOrder.ToString(); chkIsActive.Checked = s.IsActive;
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
            var s = new TodaysSpecial
            {
                Id = Convert.ToInt32(hfId.Value), Name = txtName.Text.Trim(), Category = txtCategory.Text.Trim(),
                Weight = txtWeight.Text.Trim(), Price = txtPrice.Text.Trim(), Image = imagePath,
                SortOrder = int.TryParse(txtSortOrder.Text, out int so) ? so : 0, IsActive = chkIsActive.Checked
            };
            if (s.Id == 0) _repo.Insert(s); else _repo.Update(s);
            pnlForm.Visible = false; pnlList.Visible = true;
            lblMsg.Text = "Saved successfully."; lblMsg.Visible = true; BindGrid();
        }

        protected void btnCancel_Click(object sender, EventArgs e) { pnlForm.Visible = false; pnlList.Visible = true; BindGrid(); }

        private void ClearForm()
        {
            txtName.Text = txtCategory.Text = txtWeight.Text = txtPrice.Text = "";
            txtSortOrder.Text = "0"; chkIsActive.Checked = true;
            hfImagePath.Value = ""; imgPreview.Visible = false; lblUploadError.Visible = false;
        }
    }
}
