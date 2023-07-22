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
    public partial class LogIn : System.Web.UI.Page
    {

        public static int UserType;
        public static string UserId;
        public static string PassWord;
        public static string IsDelete;
        public static string IsActive;

        string constr = ConfigurationManager.ConnectionStrings["JSI"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Login(object sender, EventArgs e)
        {
            if (username.Text != "" && password.Text != "")
            {
                SqlConnection scon = new SqlConnection(constr);
                scon.Open();
                string quey = "Select UserId, UserTypeId,IsDelete,IsActive from LoginMaster where UserId='" + username.Text + "' and Password = '" + password.Text + "'";
                SqlCommand cmd = new SqlCommand(quey, scon);
                SqlDataAdapter adapt = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                adapt.Fill(ds);
                int count = ds.Tables[0].Rows.Count;

                if (count == 1)
                {
                    Session["UserId"] = ds.Tables[0].Rows[0]["UserId"];
                    UserType = Convert.ToInt32(ds.Tables[0].Rows[0]["UserTypeId"]);
                    UserId = ds.Tables[0].Rows[0]["UserId"].ToString();
                    PassWord = password.Text;
                    IsDelete = ds.Tables[0].Rows[0]["IsDelete"].ToString();
                    IsActive = ds.Tables[0].Rows[0]["IsActive"].ToString();

                    if (IsDelete == "True")
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ClientScript", "alert('Account is Deleted'); document.location.href='LogIn.aspx';", true);

                    }
                    else if (IsDelete == "False")
                    {
                        if (IsActive == "False")
                        {
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ClientScript", "alert('Account is Suspended'); document.location.href='LogIn.aspx';", true);
                        }
                        else if (IsActive == "True")
                        {
                            Session.Add("usertype", UserType);
                            Session.Add("usrid", UserId);
                            if (Session["usertype"].ToString() == "1")
                            {
                                Response.Redirect("SanghMaster.aspx");
                            }
                            if (Session["usertype"].ToString() == "2")
                            {
                                Response.Redirect("SanghMaster.aspx");
                            }
                        }

                    }

                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ClientScript", "alert('Invalid Credentials!!'); document.location.href='LogIn.aspx';", true);
                }
                scon.Close();
            }
            else if (username.Text == "" && password.Text == "")
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ClientScript", "alert('Please Enter Username and Password'); document.location.href='LogIn.aspx';", true);
            }

            else if (username.Text == "" && password.Text != "")
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ClientScript", "alert('Please Enter Username'); document.location.href='LogIn.aspx';", true);
            }

            else if (username.Text != "" && password.Text == "")
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ClientScript", "alert('Please Enter Password'); document.location.href='LogIn.aspx';", true);
            }


        }
    }
}