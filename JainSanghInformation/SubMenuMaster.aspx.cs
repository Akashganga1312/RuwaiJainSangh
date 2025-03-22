using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using JainSanghInformation.Utilities;
using System.Text;

namespace JainSanghInformation
{
    public partial class SubMenuMaster : System.Web.UI.Page
    {
        public int UserType;
        public string UserId;

        string connectionString = ConfigurationManager.ConnectionStrings["JSI"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                UserType = Convert.ToInt32(Session["usertype"].ToString());
                UserId = Session["usrid"].ToString();

            }
            catch (Exception ex)
            {

            }

            if (!this.IsPostBack)
            {
                BindGridview();
            }
        }


        private void BindGridview()
        {
            GridView2.Visible = false;
            var table = new DataTable();
            using (var connection = new SqlConnection(connectionString))
            {
                using (var command = new SqlCommand("sp_GetSubMenuData", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    using (var adapter = new SqlDataAdapter(command))
                    {
                        connection.Open();
                        adapter.Fill(table);
                        connection.Close();
                    }
                }
            }
            GridView2.DataSource = table;
            GridView2.DataBind();
            GridView2.UseAccessibleHeader = true;
            if (GridView2.Rows.Count > 0)
            {
                GridView2.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
            GridView2.Visible = true;
        }

        private void LoadMainMenuDropdown()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT Id, MenuName FROM MainMenuMaster WHERE IsDelete = 0", conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    ddlMainMenu.DataSource = reader;
                    ddlMainMenu.DataTextField = "MenuName";
                    ddlMainMenu.DataValueField = "Id";
                    ddlMainMenu.DataBind();
                }
            }
        }

        protected void GridViewData_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ShowPopup")
            {

                int rowIndex = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = GridView2.Rows[rowIndex];
                LoadMainMenuDropdown();

                lblid.Text = HttpUtility.HtmlDecode(row.Cells[1].Text);
                txtSubMenuName.Text = HttpUtility.HtmlDecode(row.Cells[5].Text);
                txtSubMenuLevel.Text = HttpUtility.HtmlDecode(row.Cells[4].Text);
                txtSubMenuIcon.Text = HttpUtility.HtmlDecode(row.Cells[6].Text);
                txtSubMenuDescription.Text = HttpUtility.HtmlDecode(row.Cells[7].Text);
                txtSubMenuURL.Text = HttpUtility.HtmlDecode(row.Cells[8].Text);
                txtSubMenuSequence.Text = HttpUtility.HtmlDecode(row.Cells[9].Text);
                ddlMainMenu.SelectedValue = HttpUtility.HtmlDecode(row.Cells[2].Text);

                Popup(true);
            }
        }


        void Popup(bool isDisplay)
        {
            StringBuilder builder = new StringBuilder();
            if (isDisplay)
            {
                builder.Append("<script language=JavaScript> ShowPopup(); </script>\n");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowPopup", builder.ToString());
            }
            else
            {
                builder.Append("<script language=JavaScript> HidePopup(); </script>\n");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "HidePopup", builder.ToString());
            }
        }
        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            StringBuilder builder = new StringBuilder();

            if (UserType == 2)
            {
                var listOfColumnsToHide = new List<int> { 0, 1, 2, 3 };

                foreach (var columnIndex in listOfColumnsToHide)
                {
                    if (columnIndex < e.Row.Cells.Count)
                    {
                        e.Row.Cells[columnIndex].Visible = false;
                    }
                }
            }
            else
            {
                var listOfColumnsToHide = new List<int> { 1 };

                foreach (var columnIndex in listOfColumnsToHide)
                {
                    if (columnIndex < e.Row.Cells.Count)
                    {
                        e.Row.Cells[columnIndex].Visible = false;
                    }
                }
            }
        }

        [System.Web.Services.WebMethod]
        public static string DeleteRecord(string autoId)
        {
            try
            {
                string user_Id = HttpContext.Current.Session["usrid"]?.ToString();
                if (!string.IsNullOrEmpty(user_Id))
                {
                    SqlParameter[] parameters = new SqlParameter[]
                  {
                 new SqlParameter("@AutoId", autoId),
                 new SqlParameter("@UserId", user_Id)
                  };
                    if (DatabaseHelper.deleteDataFromSubMenuMaster(parameters))
                    {

                        return "Data deleted successfully";
                    }
                    else
                    {
                        return "delete operation not performed";
                    }
                }
                else
                {
                    return "You need to login with authorized account for the functionality";
                }
            }
            catch (Exception ex)
            {
                var stringMessage = ex.Message;
                stringMessage = stringMessage.Replace("'", "").Replace("\"", "");
                return stringMessage;
            }
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            BindGridview();
            Popup(false);
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                string user_Id = HttpContext.Current.Session["usrid"]?.ToString();
                if (!string.IsNullOrEmpty(user_Id))
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {

                        // Create a SqlCommand object to call the stored procedure
                        using (SqlCommand cmd = new SqlCommand("sp_UpdateSubMenuMaster", connection))
                        {
                            connection.Open();
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@AutoId", lblid.Text.Trim());
                            cmd.Parameters.AddWithValue("@SubMenuName", txtSubMenuName.Text.Trim());
                            cmd.Parameters.AddWithValue("@SubMenuLevel", Convert.ToInt32(txtSubMenuLevel.Text.Trim()));
                            cmd.Parameters.AddWithValue("@SubMenuIcon", txtSubMenuIcon.Text.Trim());
                            cmd.Parameters.AddWithValue("@SubMenuDescription", txtSubMenuDescription.Text.Trim());
                            cmd.Parameters.AddWithValue("@SubMenuURL", txtSubMenuURL.Text.Trim());
                            cmd.Parameters.AddWithValue("@SubMenuSequence", Convert.ToInt32(txtSubMenuSequence.Text.Trim()));
                            cmd.Parameters.AddWithValue("@MainMenu_Id", Convert.ToInt32(ddlMainMenu.SelectedValue));
                            cmd.Parameters.AddWithValue("@CreatedBy", UserId);
                            cmd.ExecuteNonQuery();
                            connection.Close();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowSuccessNotification",
                          "showSuccessNotification('Member update successful!');", true);
                            BindGridview();
                        }
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showErrorNotification",
                     "showErrorNotification('You need to login with authorized account for the functionality!');", true);
                }
            }

            catch (Exception ex)
            {
                Library.WriteErrorLog("Update of Edit Menu Error using sp_UpdateSubMenuMaster = " + ex.ToString());
                var stringMessage = ex.Message;
                stringMessage = stringMessage.Replace("'", "").Replace("\"", "");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowErrorNotification",
$"showErrorNotification('An error occurred: {stringMessage}');", true);
                BindGridview();
            }
        }
    }
}