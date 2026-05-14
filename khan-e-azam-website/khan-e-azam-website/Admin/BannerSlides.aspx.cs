using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanEAzam.DAL;
using KhanEAzam.Models;

namespace KhanEAzam.Admin
{
    public partial class BannerSlides : Page
    {
        protected Panel pnlList, pnlForm;
        protected GridView gvSlides;
        protected Label lblMsg, lblFormTitle;
        protected HiddenField hfId;
        protected TextBox txtTagLine, txtHeading, txtDescription, txtBgImage, txtFoodImage;
        protected TextBox txtFoodCardName, txtPrice, txtCardDescription, txtChefName, txtChefRole, txtChefImage, txtSortOrder;
        protected CheckBox chkIsActive;
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
                txtBgImage.Text = s.BgImage;
                txtFoodImage.Text = s.FoodImage;
                txtFoodCardName.Text = s.FoodCardName;
                txtPrice.Text = s.Price;
                txtCardDescription.Text = s.CardDescription;
                txtChefName.Text = s.ChefName;
                txtChefRole.Text = s.ChefRole;
                txtChefImage.Text = s.ChefImage;
                txtSortOrder.Text = s.SortOrder.ToString();
                chkIsActive.Checked = s.IsActive;
                pnlList.Visible = false;
                pnlForm.Visible = true;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            var s = new BannerSlide
            {
                Id = Convert.ToInt32(hfId.Value),
                TagLine = txtTagLine.Text.Trim(),
                Heading = txtHeading.Text.Trim(),
                Description = txtDescription.Text.Trim(),
                BgImage = txtBgImage.Text.Trim(),
                FoodImage = txtFoodImage.Text.Trim(),
                FoodCardName = txtFoodCardName.Text.Trim(),
                Price = txtPrice.Text.Trim(),
                CardDescription = txtCardDescription.Text.Trim(),
                ChefName = txtChefName.Text.Trim(),
                ChefRole = txtChefRole.Text.Trim(),
                ChefImage = txtChefImage.Text.Trim(),
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
            txtTagLine.Text = txtHeading.Text = txtDescription.Text = txtBgImage.Text = "";
            txtFoodImage.Text = txtFoodCardName.Text = txtPrice.Text = txtCardDescription.Text = "";
            txtChefName.Text = txtChefRole.Text = txtChefImage.Text = "";
            txtSortOrder.Text = "0";
            chkIsActive.Checked = true;
        }
    }
}
