using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanEAzam.DAL;
using KhanEAzam.Helpers;
using KhanEAzam.Models;

namespace KhanEAzam.Admin
{
    public partial class BlogPosts : Page
    {
        protected Panel pnlList, pnlForm;
        protected GridView gv;
        protected Label lblMsg, lblFormTitle, lblUploadError;
        protected HiddenField hfId, hfImagePath;
        protected TextBox txtTitle, txtAuthor, txtDate, txtVideo, txtComments, txtSortOrder;
        protected CheckBox chkIsLarge, chkIsActive;
        protected FileUpload fuImage;
        protected System.Web.UI.WebControls.Image imgPreview;
        protected Button btnNew, btnSave, btnCancel;

        private readonly BlogPostRepository _repo = new BlogPostRepository();

        protected void Page_Load(object sender, EventArgs e) { if (!IsPostBack) BindGrid(); }
        private void BindGrid() { gv.DataSource = _repo.GetAll(); gv.DataBind(); }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            hfId.Value = "0"; lblFormTitle.Text = "Add Blog Post"; ClearForm();
            pnlList.Visible = false; pnlForm.Visible = true;
        }

        protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "DeleteRow") { _repo.Delete(id); lblMsg.Text = "Deleted."; lblMsg.Visible = true; BindGrid(); }
            else if (e.CommandName == "EditRow")
            {
                var p = _repo.GetById(id); if (p == null) return;
                hfId.Value = p.Id.ToString(); lblFormTitle.Text = "Edit Blog Post";
                txtTitle.Text = p.Title; txtAuthor.Text = p.Author;
                txtDate.Text = p.PublishedDate.HasValue ? p.PublishedDate.Value.ToString("yyyy-MM-dd") : "";
                txtVideo.Text = p.VideoUrl;
                txtComments.Text = p.CommentCount.ToString(); txtSortOrder.Text = p.SortOrder.ToString();
                hfImagePath.Value = p.Image;
                if (!string.IsNullOrEmpty(p.Image)) { imgPreview.ImageUrl = "~/" + p.Image; imgPreview.Visible = true; }
                else imgPreview.Visible = false;
                chkIsLarge.Checked = p.IsLarge; chkIsActive.Checked = p.IsActive;
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
            DateTime? dt = null;
            if (DateTime.TryParse(txtDate.Text, out DateTime parsedDt)) dt = parsedDt;

            var p = new BlogPost
            {
                Id = Convert.ToInt32(hfId.Value), Title = txtTitle.Text.Trim(), Author = txtAuthor.Text.Trim(),
                PublishedDate = dt, Image = imagePath, VideoUrl = txtVideo.Text.Trim(),
                CommentCount = int.TryParse(txtComments.Text, out int cc) ? cc : 0,
                SortOrder = int.TryParse(txtSortOrder.Text, out int so) ? so : 0,
                IsLarge = chkIsLarge.Checked, IsActive = chkIsActive.Checked
            };
            if (p.Id == 0) _repo.Insert(p); else _repo.Update(p);
            pnlForm.Visible = false; pnlList.Visible = true;
            lblMsg.Text = "Saved successfully."; lblMsg.Visible = true; BindGrid();
        }

        protected void btnCancel_Click(object sender, EventArgs e) { pnlForm.Visible = false; pnlList.Visible = true; BindGrid(); }

        private void ClearForm()
        {
            txtTitle.Text = txtAuthor.Text = txtDate.Text = txtVideo.Text = "";
            txtComments.Text = txtSortOrder.Text = "0"; chkIsLarge.Checked = false; chkIsActive.Checked = true;
            hfImagePath.Value = ""; imgPreview.Visible = false; lblUploadError.Visible = false;
        }
    }
}
