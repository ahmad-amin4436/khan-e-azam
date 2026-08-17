using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using KhanEAzam.DAL;
using KhanEAzam.Helpers;
using KhanEAzam.Models;

namespace KhanEAzam.Admin
{
    public partial class Users : Page
    {
        protected Panel pnlList, pnlForm;
        protected GridView gvUsers;
        protected Label lblMsg, lblListError, lblFormTitle, lblFormError;
        protected HiddenField hfId;
        protected TextBox txtUsername, txtEmail, txtPassword;
        protected DropDownList ddlRole;
        protected HtmlGenericControl lblPasswordLabel, smPasswordHint;
        protected Button btnNew, btnSave, btnCancel;

        private readonly AdminUserRepository _repo = new AdminUserRepository();

        protected void Page_Load(object sender, EventArgs e)
        {
            if ((Session["AdminRole"] as string) != "SuperAdmin")
            {
                Response.Redirect("~/Admin/Dashboard.aspx");
                return;
            }

            if (!IsPostBack) BindGrid();
        }

        private void BindGrid()
        {
            gvUsers.DataSource = _repo.GetAll();
            gvUsers.DataBind();
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            hfId.Value = "0";
            lblFormTitle.Text = "Add Admin User";
            ClearForm();
            lblPasswordLabel.InnerText = "Password";
            smPasswordHint.Visible = false;
            pnlList.Visible = false;
            pnlForm.Visible = true;
        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            int currentAdminId = Convert.ToInt32(Session["AdminId"]);

            if (e.CommandName == "DeleteRow")
            {
                if (id == currentAdminId)
                {
                    lblListError.Text = "You can't delete your own account while logged in.";
                    lblListError.Visible = true;
                    BindGrid();
                    return;
                }

                var target = _repo.GetById(id);
                if (target != null && target.Role == "SuperAdmin")
                {
                    int superAdminCount = _repo.GetAll().Count(u => u.Role == "SuperAdmin");
                    if (superAdminCount <= 1)
                    {
                        lblListError.Text = "Can't delete the last Super Admin account.";
                        lblListError.Visible = true;
                        BindGrid();
                        return;
                    }
                }

                _repo.Delete(id);
                lblMsg.Text = "Admin user deleted.";
                lblMsg.Visible = true;
                BindGrid();
            }
            else if (e.CommandName == "EditRow")
            {
                var u = _repo.GetById(id);
                if (u == null) return;
                hfId.Value = u.Id.ToString();
                lblFormTitle.Text = "Edit Admin User";
                txtUsername.Text = u.Username;
                txtEmail.Text = u.Email;
                txtPassword.Text = "";
                ddlRole.SelectedValue = u.Role;
                lblPasswordLabel.InnerText = "New Password";
                smPasswordHint.Visible = true;
                lblFormError.Visible = false;

                pnlList.Visible = false;
                pnlForm.Visible = true;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(hfId.Value);
            string username = txtUsername.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(email))
            {
                lblFormError.Text = "Username and Email are required.";
                lblFormError.Visible = true;
                return;
            }

            if (id == 0 && string.IsNullOrEmpty(password))
            {
                lblFormError.Text = "Password is required for a new admin user.";
                lblFormError.Visible = true;
                return;
            }

            var existing = _repo.GetByUsername(username);
            if (existing != null && existing.Id != id)
            {
                lblFormError.Text = "That username is already taken.";
                lblFormError.Visible = true;
                return;
            }

            var u = new AdminUser
            {
                Id = id,
                Username = username,
                Email = email,
                Role = ddlRole.SelectedValue
            };

            if (id == 0)
            {
                u.PasswordHash = PasswordHelper.HashPassword(password);
                _repo.Insert(u);
            }
            else
            {
                bool updatePassword = !string.IsNullOrEmpty(password);
                if (updatePassword) u.PasswordHash = PasswordHelper.HashPassword(password);
                _repo.Update(u, updatePassword);
            }

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
            txtUsername.Text = txtEmail.Text = txtPassword.Text = "";
            ddlRole.SelectedValue = "Staff";
            lblFormError.Visible = false;
        }
    }
}
