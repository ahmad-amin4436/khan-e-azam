using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanEAzam.DAL;
using KhanEAzam.Helpers;
using KhanEAzam.Models;

namespace KhanEAzam.Admin
{
    public partial class Chefs : Page
    {
        protected Panel pnlList, pnlForm;
        protected GridView gv;
        protected Label lblMsg, lblFormTitle, lblUploadError;
        protected HiddenField hfId, hfImagePath;
        protected TextBox txtName, txtRole, txtFacebook, txtTwitter, txtInstagram, txtLinkedIn, txtSortOrder;
        protected CheckBox chkIsActive;
        protected FileUpload fuImage;
        protected System.Web.UI.WebControls.Image imgPreview;
        protected Button btnNew, btnSave, btnCancel;

        private readonly ChefRepository _repo = new ChefRepository();

        protected void Page_Load(object sender, EventArgs e) { if (!IsPostBack) BindGrid(); }
        private void BindGrid() { gv.DataSource = _repo.GetAll(); gv.DataBind(); }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            hfId.Value = "0"; lblFormTitle.Text = "Add Chef"; ClearForm();
            pnlList.Visible = false; pnlForm.Visible = true;
        }

        protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "DeleteRow") { _repo.Delete(id); lblMsg.Text = "Deleted."; lblMsg.Visible = true; BindGrid(); }
            else if (e.CommandName == "EditRow")
            {
                var c = _repo.GetById(id); if (c == null) return;
                hfId.Value = c.Id.ToString(); lblFormTitle.Text = "Edit Chef";
                txtName.Text = c.Name; txtRole.Text = c.Role;
                txtFacebook.Text = c.FacebookUrl; txtTwitter.Text = c.TwitterUrl;
                txtInstagram.Text = c.InstagramUrl; txtLinkedIn.Text = c.LinkedInUrl;
                hfImagePath.Value = c.Image;
                if (!string.IsNullOrEmpty(c.Image)) { imgPreview.ImageUrl = "~/" + c.Image; imgPreview.Visible = true; }
                else imgPreview.Visible = false;
                txtSortOrder.Text = c.SortOrder.ToString(); chkIsActive.Checked = c.IsActive;
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
            var c = new Chef
            {
                Id = Convert.ToInt32(hfId.Value), Name = txtName.Text.Trim(), Role = txtRole.Text.Trim(),
                Image = imagePath, FacebookUrl = txtFacebook.Text.Trim(), TwitterUrl = txtTwitter.Text.Trim(),
                InstagramUrl = txtInstagram.Text.Trim(), LinkedInUrl = txtLinkedIn.Text.Trim(),
                SortOrder = int.TryParse(txtSortOrder.Text, out int so) ? so : 0, IsActive = chkIsActive.Checked
            };
            if (c.Id == 0) _repo.Insert(c); else _repo.Update(c);
            pnlForm.Visible = false; pnlList.Visible = true;
            lblMsg.Text = "Saved successfully."; lblMsg.Visible = true; BindGrid();
        }

        protected void btnCancel_Click(object sender, EventArgs e) { pnlForm.Visible = false; pnlList.Visible = true; BindGrid(); }

        private void ClearForm()
        {
            txtName.Text = txtRole.Text = "";
            txtFacebook.Text = txtTwitter.Text = txtInstagram.Text = txtLinkedIn.Text = "#";
            txtSortOrder.Text = "0"; chkIsActive.Checked = true;
            hfImagePath.Value = ""; imgPreview.Visible = false; lblUploadError.Visible = false;
        }
    }
}
