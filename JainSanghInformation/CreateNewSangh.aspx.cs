using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace JainSanghInformation
{
    public partial class CreateNewSangh : System.Web.UI.Page
    {
        public int UserType;
        public string UserId;
        string connectionString = ConfigurationManager.ConnectionStrings["JSI"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            UserType = Convert.ToInt32(Session["usertype"].ToString());
            UserId = Session["usrid"].ToString();
            if (UserType != 1)
            {
                logout(sender, e);
            }
            if (!this.IsPostBack)
            {
                
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

        protected void btninsert_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection con = new SqlConnection(connectionString);
                SqlCommand cmd = new SqlCommand("insert into SanghMaster(SanghName,Location,PresidentName,PresidentMobile,CreatedBy)  values  (@SanghName,@Location,Case when @PresidentName='' then Null else @PresidentName End,Case when @PresidentMobile='' then Null else @PresidentMobile End,@CreatedBy)", con);
                cmd.Parameters.AddWithValue("@SanghName", txtsname.Text);
                cmd.Parameters.AddWithValue("@Location", txtlocn.Text);
                cmd.Parameters.AddWithValue("@PresidentName", txtpname.Text);
                cmd.Parameters.AddWithValue("@PresidentMobile", txtpmob.Text);
                cmd.Parameters.AddWithValue("@CreatedBy", UserType);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowSuccessNotification",
                        "showSuccessNotification('Sangh insert successful!');", true);
                clearAllField();
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

    }
}