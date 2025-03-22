using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JainSanghInformation
{
    public partial class CreateNewSubmenu : System.Web.UI.Page
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
                LoadMainMenuDropdown();
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

        protected void btninsert_Click(object sender, EventArgs e)
        {
            try
            {

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_InsertSubMenuMaster", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@SubMenuName", txtSubMenuName.Text.Trim());
                        cmd.Parameters.AddWithValue("@SubMenuLevel", Convert.ToInt32(txtSubMenuLevel.Text.Trim()));
                        cmd.Parameters.AddWithValue("@SubMenuIcon", txtSubMenuIcon.Text.Trim());
                        cmd.Parameters.AddWithValue("@SubMenuDescription", txtSubMenuDescription.Text.Trim());
                        cmd.Parameters.AddWithValue("@SubMenuURL", txtSubMenuURL.Text.Trim());
                        cmd.Parameters.AddWithValue("@SubMenuSequence", Convert.ToInt32(txtSubMenuSequence.Text.Trim()));
                        cmd.Parameters.AddWithValue("@MainMenu_Id", Convert.ToInt32(ddlMainMenu.SelectedValue));
                        cmd.Parameters.AddWithValue("@CreatedBy", UserId);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowSuccessNotification","showSuccessNotification(Submenu added successfully!');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                var stringMessage = ex.Message;
                stringMessage = stringMessage.Replace("'", "").Replace("\"", "");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowErrorNotification",$"showErrorNotification('An error occurred: {stringMessage}');", true);
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
