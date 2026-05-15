using System;
using System.Linq;
using System.Web.UI;
using KhanEAzam.DAL;

namespace khan_e_azam_website.Pages
{
    public partial class Menu : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindMenu();
        }

        private void BindMenu()
        {
            var items = new MenuFilterRepository().GetAll()
                .Where(x => x.IsActive)
                .OrderBy(x => x.SortOrder)
                .ToList();

            if (items.Count == 0)
            {
                pnlEmpty.Visible = true;
                return;
            }

            rptMenu.DataSource = items;
            rptMenu.DataBind();
            lblCount.Text = items.Count + " item" + (items.Count == 1 ? "" : "s");
        }
    }
}
