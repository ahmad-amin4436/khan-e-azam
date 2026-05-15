using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanEAzam.DAL;
using KhanEAzam.Helpers;
using KhanEAzam.Models;

namespace KhanEAzam.Admin
{
    public partial class BannerSlides : Page
    {
        protected Panel pnlList, pnlForm;
        protected GridView gvSlides;
        protected Label lblMsg, lblFormTitle, lblUploadError;
        protected HiddenField hfId, hfBgImagePath, hfFoodImagePath, hfChefImagePath;
        protected TextBox txtTagLine, txtHeading, txtDescription;
        protected TextBox txtFoodCardName, txtPrice, txtCardDescription, txtChefName, txtChefRole, txtSortOrder;
        protected CheckBox chkIsActive;
        protected FileUpload fuBgImage, fuFoodImage, fuChefImage;
        protected System.Web.UI.WebControls.Image imgBgPreview, imgFoodPreview, imgChefPreview;
        protected Button btnNew, btnSave, btnCancel;

        private readonly BannerSlideRepository _repo = new BannerSlideRepository();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindGrid();
        }

        private void BindGrid()
        {
            gvSlides.DataSource = _repo.GetAll();
            gvSlides.DataBind();
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            hfId.Value = "0";
            lblFormTitle.Text = "Add Banner Slide";
            ClearForm();
            pnlList.Visible = false;
            pnlForm.Visible = true;
        }

        protected void gvSlides_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "DeleteRow")
            {
                _repo.Delete(id);
                lblMsg.Text = "Slide deleted successfully.";
                lblMsg.Visible = true;
                BindGrid();
            }
            else if (e.CommandName == "EditRow")
            {
                var s = _repo.GetById(id);
                if (s == null) return;
                hfId.Value = s.Id.ToString();
                lblFormTitle.Text = "Edit Banner Slide";
                txtTagLine.Text = s.TagLine;
                txtHeading.Text = s.Heading;
                txtDescription.Text = s.Description;
                txtFoodCardName.Text = s.FoodCardName;
                txtPrice.Text = s.Price;
                txtCardDescription.Text = s.CardDescription;
                txtChefName.Text = s.ChefName;
                txtChefRole.Text = s.ChefRole;
                txtSortOrder.Text = s.SortOrder.ToString();
                chkIsActive.Checked = s.IsActive;

                hfBgImagePath.Value = s.BgImage;
                if (!string.IsNullOrEmpty(s.BgImage)) { imgBgPreview.ImageUrl = "~/" + s.BgImage; imgBgPreview.Visible = true; }
                else imgBgPreview.Visible = false;

                hfFoodImagePath.Value = s.FoodImage;
                if (!string.IsNullOrEmpty(s.FoodImage)) { imgFoodPreview.ImageUrl = "~/" + s.FoodImage; imgFoodPreview.Visible = true; }
                else imgFoodPreview.Visible = false;

                hfChefImagePath.Value = s.ChefImage;
                if (!string.IsNullOrEmpty(s.ChefImage)) { imgChefPreview.ImageUrl = "~/" + s.ChefImage; imgChefPreview.Visible = true; }
                else imgChefPreview.Visible = false;

                pnlList.Visible = false;
                pnlForm.Visible = true;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            lblUploadError.Visible = false;
            string uploadDir = Server.MapPath("~/assets/images/uploads/");

            string bgImage = hfBgImagePath.Value;
            if (fuBgImage.HasFile)
            {
                string up = ImageUploadHelper.Save(fuBgImage.PostedFile, uploadDir);
                if (up != null) bgImage = up;
                else { lblUploadError.Text = "Background image invalid. Use JPG/PNG/GIF/WEBP under 5 MB."; lblUploadError.Visible = true; return; }
            }

            string foodImage = hfFoodImagePath.Value;
            if (fuFoodImage.HasFile)
            {
                string up = ImageUploadHelper.Save(fuFoodImage.PostedFile, uploadDir);
                if (up != null) foodImage = up;
                else { lblUploadError.Text = "Food image invalid. Use JPG/PNG/GIF/WEBP under 5 MB."; lblUploadError.Visible = true; return; }
            }

            string chefImage = hfChefImagePath.Value;
            if (fuChefImage.HasFile)
            {
                string up = ImageUploadHelper.Save(fuChefImage.PostedFile, uploadDir);
                if (up != null) chefImage = up;
                else { lblUploadError.Text = "Chef image invalid. Use JPG/PNG/GIF/WEBP under 5 MB."; lblUploadError.Visible = true; return; }
            }

            var s = new BannerSlide
            {
                Id = Convert.ToInt32(hfId.Value),
                TagLine = txtTagLine.Text.Trim(),
                Heading = txtHeading.Text.Trim(),
                Description = txtDescription.Text.Trim(),
                BgImage = bgImage,
                FoodImage = foodImage,
                FoodCardName = txtFoodCardName.Text.Trim(),
                Price = txtPrice.Text.Trim(),
                CardDescription = txtCardDescription.Text.Trim(),
                ChefName = txtChefName.Text.Trim(),
                ChefRole = txtChefRole.Text.Trim(),
                ChefImage = chefImage,
                SortOrder = int.TryParse(txtSortOrder.Text, out int so) ? so : 0,
                IsActive = chkIsActive.Checked
            };

            if (s.Id == 0) _repo.Insert(s);
            else _repo.Update(s);

            pnlForm.Visible = false;
            pnlList.Visible = true;
            lblMsg.Text = "Saved successfully.";
            lblMsg.Visible = true;
            BindGrid();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pnlForm.Visible = false;
            pnlList.Visible = true;
            BindGrid();
        }

        private void ClearForm()
        {
            txtTagLine.Text = txtHeading.Text = txtDescription.Text = "";
            txtFoodCardName.Text = txtPrice.Text = txtCardDescription.Text = "";
            txtChefName.Text = txtChefRole.Text = "";
            txtSortOrder.Text = "0";
            chkIsActive.Checked = true;
            hfBgImagePath.Value = hfFoodImagePath.Value = hfChefImagePath.Value = "";
            imgBgPreview.Visible = imgFoodPreview.Visible = imgChefPreview.Visible = false;
            lblUploadError.Visible = false;
        }
    }
}
