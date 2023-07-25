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
            if (!this.IsPostBack)
            {
                
            }
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
                //MessageBox.Show("Record Inserted!","Insert Responce", MessageBoxButtons.OK, MessageBoxIcon.Information);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Successfully Inserted!');", true);
                clearAllField();
            }
            catch (Exception ex)
            {
                Library.WriteErrorLog("Insert of sangh Master Error = " + ex.ToString());
                //MessageBox.Show("Insertion of record failed. Please try again");
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