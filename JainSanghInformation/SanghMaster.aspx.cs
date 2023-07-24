using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using JainSanghInformation.Utilities;

namespace JainSanghInformation
{
    public partial class SanghMaster : System.Web.UI.Page
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
                BindGridview();
            }
        }

        private void BindGridview()
        {
            GridView2.Visible = false;
            string query = "SELECT AutoId,SanghName,Location, PresidentName, PresidentMobile FROM SanghMaster where IsDelete=0";

            var table = new DataTable();

            using (var connection = new SqlConnection(connectionString))
            {
                using (var command = new SqlCommand(query, connection))
                {
                    using (var a = new SqlDataAdapter(command))
                    {
                        connection.Open();
                        a.Fill(table);
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
                txtsname.Text = HttpUtility.HtmlDecode(row.Cells[2].Text);
                txtlocn.Text = HttpUtility.HtmlDecode(row.Cells[3].Text);
                txtpname.Text = HttpUtility.HtmlDecode(row.Cells[4].Text);
                txtpmob.Text = HttpUtility.HtmlDecode(row.Cells[5].Text);

                // int rowIndex = Convert.ToInt32(e.CommandArgument);

                //Reference the GridView Row.
                // GridViewRow row = GridView2.Rows[rowIndex];

                // txtid.Text = (row.FindControl("Id") as ).Text;
                // txtcode.Text = (row.FindControl("SocietyCode") as Label).Text;
                //txtcname.Text = (row.FindControl("SocietyName") as Label).Text;
                //txtsender1.Text = (row.FindControl("SenderId") as Label).Text;
                //txtkey1.Text = (row.FindControl("SenderKey") as Label).Text;
                //txtdlt1.Text = (row.FindControl("DLTId") as Label).Text;
                //txttemplate1.Text = (row.FindControl("Template") as Label).Text;

                Popup(true);
            }
        }


        [System.Web.Services.WebMethod]
        public static string DeleteRecord(string autoId)
        {
            string user_Id = HttpContext.Current.Session["usrid"]?.ToString();
            SqlParameter[] parameters = new SqlParameter[]
          {
                 new SqlParameter("@AutoId", autoId),
                 new SqlParameter("@UserId", user_Id)
          };
            if (DatabaseHelper.deleteDataFromSanghMaster(parameters))
            {

                return "Data deleted successfully";
            }
            else
            {
                return "delete operation not performed";
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

        protected void btnClose_Click(object sender, EventArgs e)
        {
            BindGridview();
        }


        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtsname.Text.Trim() == "" && txtlocn.Text.Trim() == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Please enter SanghName and Location!');", true);

                }
                else if (txtsname.Text.Trim() == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Please enter SanghName!');", true);

                }
                else if (txtlocn.Text.Trim() == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Please enter Location!');", true);
                }
                else
                {
                    SqlConnection con = new SqlConnection(connectionString);
                    SqlCommand cmd = new SqlCommand("update SanghMaster set SanghName = @SanghName, Location = @Location,  PresidentName = Case when @PresidentName='' then Null else @PresidentName End, PresidentMobile = Case when @PresidentMobile='' then Null else @PresidentMobile End where AutoId=" + lblid.Text, con);

                    cmd.Parameters.AddWithValue("@SanghName", txtsname.Text);
                    cmd.Parameters.AddWithValue("@Location", txtlocn.Text);
                    cmd.Parameters.AddWithValue("@PresidentName", txtpname.Text);
                    cmd.Parameters.AddWithValue("@PresidentMobile", txtpmob.Text);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    //MessageBox.Show("Record Inserted!","Insert Responce", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Successfully Updated!');", true);
                    BindGridview();
                }
              

            }
            catch (Exception exception)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Error in Updated!');" + exception.Message, true);
            }
        }

    }
}