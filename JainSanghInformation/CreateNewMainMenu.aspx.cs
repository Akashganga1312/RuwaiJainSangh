using JainSanghInformation.Utilities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JainSanghInformation
{
    public partial class CreateNewMainMenu : System.Web.UI.Page
    {

        public int UserType;
        public string UserId;
        string connectionString = ConfigurationManager.ConnectionStrings["JSI"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                UserId = Session["usrid"].ToString();
                UserType = Convert.ToInt32(Session["UserType"].ToString());
                if (UserType != 1)
                {
                    logout(sender, e);
                }
            }
            catch (Exception ex)
            {
                logout(sender, e);
            }

        }
        protected void btninsert_Click(object sender, EventArgs e)
        {
            try
            {

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_InsertMainMenuMaster", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@MenuName", txtmenuname.Text.Trim());
                        cmd.Parameters.AddWithValue("@MenuIcon", txtMenuIcon.Text.Trim());
                        cmd.Parameters.AddWithValue("@MenuDescription", txtMenuDescription.Text.Trim());
                        cmd.Parameters.AddWithValue("@MenuURL", txtpmob.Text.Trim());
                        cmd.Parameters.AddWithValue("@MenuSequence", string.IsNullOrWhiteSpace(txtMenuSequence.Text) ? (object)DBNull.Value : Convert.ToInt32(txtMenuSequence.Text.Trim()));
                        cmd.Parameters.AddWithValue("@CreatedBy", UserId);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowSuccessNotification",
                      "showSuccessNotification(Main menu inserted successfully!');", true);
                        clearAllField();
                    }
                }
            }
            catch (Exception ex)
            {
                var stringMessage = ex.Message;
                stringMessage = stringMessage.Replace("'", "").Replace("\"", "");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowErrorNotification",
$"showErrorNotification('An error occurred: {stringMessage}');", true);
            }
        }

        public void ClearTextBoxes(System.Web.UI.Control parent)
        {
            foreach (System.Web.UI.Control control in parent.Controls)
            {
                if (control is System.Web.UI.WebControls.TextBox)
                {
                    System.Web.UI.WebControls.TextBox textBox = (System.Web.UI.WebControls.TextBox)control;
                    textBox.Text = string.Empty;
                }

                if (control.HasControls())
                {
                    ClearTextBoxes(control);
                }
            }
        }

        protected void clearAllField()
        {
            ClearTextBoxes(this);
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