using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Collections.Specialized.BitVector32;
using System.Diagnostics;
using System.Web.Security;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.HtmlControls;
using System.IO;

namespace JainSanghInformation
{
    public partial class SiteMaster : MasterPage
    {
        public string UserId = string.Empty;
        public int UserType { get; set; }
        public string logoUrl;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (UserId == "")
                {
                    UserType = Convert.ToInt32(Session["usertype"].ToString());
                    UserId = Session["usrid"].ToString();
                }
            }
            catch (Exception ex)
            {
            }
            titleLabel.InnerText = Constants.TitleText;
            logoUrl = "assets/images/sangh.png";
            LoadMenus();
        }

        private void LoadMenus()
        {

            object dbUserId;
            if (string.IsNullOrEmpty(UserId))
            {
                dbUserId = DBNull.Value;
            }
            else
            {
                dbUserId = UserId;
            }

            object dbUserType;
            if (UserType == 0)
            {
                dbUserType = DBNull.Value;
            }
            else
            {
                dbUserType = UserType;
            }

            // Convert UserType to a suitable object for the database
            string connectionString = ConfigurationManager.ConnectionStrings["JSI"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("sp_GetMenuAndSubMenu", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@UserId", dbUserId);
                    command.Parameters.AddWithValue("@UserType_Id", dbUserType);
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable menuTable = new DataTable();
                    adapter.Fill(menuTable);

                    GenerateMenuHtml(menuTable);
                }
            }
        }

        private void GenerateMenuHtml(DataTable menuTable)
        {
            HtmlGenericControl ulMenu = new HtmlGenericControl("ul");
            ulMenu.Attributes["class"] = "nav";

            // Separate main menus and submenus using traditional loop
            var mainMenus = new List<DataRow>();
            var subMenus = new Dictionary<string, List<DataRow>>();

            for (int i = 0; i < menuTable.Rows.Count; i++)
            {
                DataRow row = menuTable.Rows[i];
                mainMenus.Add(row);
                // Check if it's a main menu (SubMenuId is DBNull)
                if (row["SubMenuId"] == DBNull.Value)
                {

                }
                else
                {
                    // Submenu logic
                    string mainMenuId = row["MainMenu_Id"].ToString();
                    if (!subMenus.ContainsKey(mainMenuId))
                    {
                        subMenus[mainMenuId] = new List<DataRow>();
                    }
                    subMenus[mainMenuId].Add(row);
                }
            }
            // Track processed main menus
            var processedMenus = new HashSet<string>();
            // Generate HTML for main menus and their submenus
            foreach (var mainMenu in mainMenus)
            {
                string mainMenuId = mainMenu["MainMenuId"].ToString();

                // Skip if already processed
                if (processedMenus.Contains(mainMenuId))
                {
                    continue;
                }

                // Mark as processed
                processedMenus.Add(mainMenuId);

                HtmlGenericControl liMain = new HtmlGenericControl("li");
                liMain.Attributes["class"] = "nav-item";

                HtmlGenericControl aMain = new HtmlGenericControl("a");
                aMain.Attributes["class"] = "nav-link";
                aMain.Attributes["href"] = mainMenu["MenuURL"]?.ToString() ?? "#";

                HtmlGenericControl spanMain = new HtmlGenericControl("span");
                spanMain.Attributes["class"] = "menu-title";
                spanMain.InnerText = mainMenu["MenuName"].ToString();

                HtmlGenericControl iMain = new HtmlGenericControl("i");
                iMain.Attributes["class"] = $"mdi {mainMenu["MenuIcon"]} menu-icon";

                aMain.Controls.Add(spanMain);
                aMain.Controls.Add(iMain);
                liMain.Controls.Add(aMain);

                // Check and add submenus
                if (subMenus.ContainsKey(mainMenuId))
                {
                    HtmlGenericControl ulSub = new HtmlGenericControl("ul");
                    ulSub.Attributes["class"] = "nav flex-column sub-menu";
                    ulSub.Attributes["id"] = "submenu-" + mainMenuId;

                    aMain.Attributes["data-toggle"] = "submenu";
                    aMain.Attributes["data-target"] = "submenu-" + mainMenuId;

                    foreach (var subMenu in subMenus[mainMenuId])
                    {
                        HtmlGenericControl liSub = new HtmlGenericControl("li");
                        liSub.Attributes["class"] = "nav-item";

                        HtmlGenericControl aSub = new HtmlGenericControl("a");
                        aSub.Attributes["class"] = "nav-link";
                        aSub.Attributes["href"] = subMenu["SubMenuURL"].ToString();
                        aSub.InnerText = subMenu["SubMenuName"].ToString();

                        liSub.Controls.Add(aSub);
                        ulSub.Controls.Add(liSub);
                    }

                    liMain.Controls.Add(ulSub);
                }


                ulMenu.Controls.Add(liMain);
            }

            PlaceHolderMenu.Controls.Add(ulMenu);

        }

        protected void logout(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Session.RemoveAll();
            UserType = 0;
            UserId = string.Empty;
            Response.Redirect("Default.aspx");
        }
    }
}