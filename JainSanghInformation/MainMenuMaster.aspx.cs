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
using System.EnterpriseServices;

namespace JainSanghInformation
{
    public partial class MainMenuMaster : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["JSI"].ConnectionString;
        public int UserType;
        public string UserId;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                UserType = Convert.ToInt32(Session["usertype"].ToString());
                UserId = Session["usrid"].ToString();
                if (UserType != 1)
                {
                    logout(sender, e);
                }
            }
            catch (Exception ex)
            {
                logout(sender, e);
            }
            if (!this.IsPostBack)
            {
                BindGridview();
            }
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

        private void BindGridview()
        {
            GridView2.Visible = false;
            var table = new DataTable();
            using (var connection = new SqlConnection(connectionString))
            {
                using (var command = new SqlCommand("sp_GetMenuData", connection))
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

        protected void GridViewData_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ShowPopup")
            {
               
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = GridView2.Rows[rowIndex];

                // And you respective cell's value
                lblid.Text = HttpUtility.HtmlDecode(row.Cells[1].Text);
                txtmenuname.Text = HttpUtility.HtmlDecode(row.Cells[2].Text);
                txtMenuIcon.Text = HttpUtility.HtmlDecode(row.Cells[3].Text);
                txtMenuDescription.Text = HttpUtility.HtmlDecode(row.Cells[4].Text);
                txtpmob.Text = HttpUtility.HtmlDecode(row.Cells[5].Text);
                txtMenuSequence.Text = HttpUtility.HtmlDecode(row.Cells[6].Text);
                
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
        }

        [System.Web.Services.WebMethod]
        public static string DeleteRecord(string autoId)
        {
            try {
                string user_Id = HttpContext.Current.Session["usrid"]?.ToString();
                if (!string.IsNullOrEmpty(user_Id))
                {
                    SqlParameter[] parameters = new SqlParameter[]
                  {
                 new SqlParameter("@AutoId", autoId),
                 new SqlParameter("@UserId", user_Id)
                  };
                    if (DatabaseHelper.deleteDataFromMainMenuMaster(parameters))
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
                if (txtmenuname.Text.Trim() == "" && txtMenuIcon.Text.Trim() == "" && txtMenuDescription.Text.Trim() == "" && txtMenuSequence.Text.Trim() == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showErrorNotification",
"showErrorNotification('Please enter all Required Feild!');", true);

                }
                else
                {
                    try
                    {
                        var UserId = Session["usrid"].ToString();
                        using (SqlConnection connection = new SqlConnection(connectionString))
                        {
                         // Create a SqlCommand object to call the stored procedure
                            using (SqlCommand cmd = new SqlCommand("sp_UpdateMainMenuMaster", connection))
                            {
                                cmd.CommandType = CommandType.StoredProcedure;

                                cmd.Parameters.AddWithValue("@AutoId", lblid.Text);
                                cmd.Parameters.AddWithValue("@MenuName", txtmenuname.Text);
                                cmd.Parameters.AddWithValue("@MenuIcon", txtMenuIcon.Text);
                                cmd.Parameters.AddWithValue("@MenuDescription", txtMenuDescription.Text);
                                cmd.Parameters.AddWithValue("@MenuUrl", txtpmob.Text);
                                cmd.Parameters.AddWithValue("@MenuSequence", txtMenuSequence.Text);
                                cmd.Parameters.AddWithValue("@CreatedBy", UserId);
                                connection.Open();
                                cmd.ExecuteNonQuery();
                                connection.Close();
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowSuccessNotification",
                       "showSuccessNotification('Main menu successfully updated!');", true);
                                BindGridview();
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Library.WriteErrorLog("Update of Menu Master Error using sp_UpdateMainMenuMaster = " + ex.ToString());
                        var stringMessage = ex.Message;
                        stringMessage = stringMessage.Replace("'", "").Replace("\"", "");
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowErrorNotification",
        $"showErrorNotification('An error occurred: {stringMessage}');", true);
                        BindGridview();
                    }
                }
            }
            catch (Exception exception)
            {
                Library.WriteErrorLog("Update of Sangh master Error = " + exception.ToString());
                var stringMessage = exception.Message;
                stringMessage = stringMessage.Replace("'", "").Replace("\"", "");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowErrorNotification",
$"showErrorNotification('An error occurred: {stringMessage}');", true);
            }
        }
    }
}