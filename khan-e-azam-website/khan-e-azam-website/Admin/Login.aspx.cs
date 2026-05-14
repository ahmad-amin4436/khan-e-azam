using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanEAzam.DAL;
using KhanEAzam.Helpers;

namespace KhanEAzam.Admin
{
    public partial class Login : Page
    {
        protected TextBox txtUsername, txtPassword;
        protected Label lblError;
        protected Button btnLogin;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminId"] != null)
                Response.Redirect("~/Admin/Dashboard.aspx");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                lblError.Text = "Please enter username and password.";
                lblError.Visible = true;
                return;
            }

            var repo = new AdminUserRepository();
            var user = repo.GetByUsername(username);

            if (user == null)
            {
                lblError.Text = "Invalid username or password.";
                lblError.Visible = true;
                return;
            }

            // First-time setup: if hash is placeholder, set real hash
            if (user.PasswordHash == "PLACEHOLDER_HASH")
            {
                string newHash = PasswordHelper.HashPassword(password);
                repo.UpdatePasswordHash(username, newHash);
                user.PasswordHash = newHash;
            }

            if (!PasswordHelper.VerifyPassword(password, user.PasswordHash))
            {
                lblError.Text = "Invalid username or password.";
                lblError.Visible = true;
                return;
            }

            Session["AdminId"] = user.Id;
            Session["AdminUsername"] = user.Username;
            Response.Redirect("~/Admin/Dashboard.aspx");
        }
    }
}
