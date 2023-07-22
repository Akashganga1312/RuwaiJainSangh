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
using System.Net;
using System.Reflection;

namespace JainSanghInformation
{
    public partial class MemberMaster : System.Web.UI.Page
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
            string query = "SELECT SanghMasterId [Id],concat(SM.SanghName,'-',SM.Location) [Sangh Name],VillageName [Village Name],MemberName [Member Name],MemberType [Member Type],Format(Birthdate,'dd/MM/yyyy') [DOB],Education,MarriageStatus [Marriage Status],Occupation,Address,MobileNumber1 [Primary Mobile],MobileNumber2 [Secondary Mobile],BloodGroup FROM MemberMaster MM, SanghMaster SM where MM.IsDelete=0 and SM.AutoId = MM.SanghMasterId";

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
                textBoxSanghName.Text = HttpUtility.HtmlDecode(row.Cells[2].Text);
                txtvillagename.Text = HttpUtility.HtmlDecode(row.Cells[3].Text);
                txtmembername.Text = HttpUtility.HtmlDecode(row.Cells[4].Text);
                txtmtype.Text = HttpUtility.HtmlDecode(row.Cells[5].Text);
                txtbdate.Text = row.Cells[6].Text;

                if (HttpUtility.HtmlDecode(row.Cells[6].Text).Trim() != "")
                {
                    txtbdate.Text = DateTime.Parse(row.Cells[6].Text).ToString("yyyy-MM-dd");
                }
                
                txteducation.Text = HttpUtility.HtmlDecode(row.Cells[7].Text);
                txtmarriagestatus.Text = HttpUtility.HtmlDecode(row.Cells[8].Text);
                txtoccupation.Text = HttpUtility.HtmlDecode(row.Cells[9].Text);
                txtaddress.InnerText = HttpUtility.HtmlDecode(row.Cells[10].Text);
                textBoxMobileNumber1.Text = HttpUtility.HtmlDecode(row.Cells[11].Text);
                textBoxMobileNumber2.Text = HttpUtility.HtmlDecode(row.Cells[12].Text);
                ddlbloodgrup.SelectedIndex = 0;
                if (HttpUtility.HtmlDecode(row.Cells[13].Text).Trim() != "")
                {
                    ddlbloodgrup.SelectedValue = HttpUtility.HtmlDecode(row.Cells[13].Text);
                } 

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

        protected void btnClose_Click(object sender, EventArgs e)
        {
            BindGridview();
        }


        protected void btnUpdate_Click(object sender, EventArgs e)
        {

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {

                    // Create a SqlCommand object to call the stored procedure
                    using (SqlCommand cmd = new SqlCommand("sp_insertDataMemberMaster", connection))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        var BloodGroup = ddlbloodgrup.Text;
                        if (BloodGroup.Contains("Select"))
                        {
                            BloodGroup = string.Empty;
                        }
                        cmd.Parameters.AddWithValue("@SanghName", textBoxSanghName.Text);
                        cmd.Parameters.AddWithValue("@VillageName", txtvillagename.Text);
                        cmd.Parameters.AddWithValue("@MemberName", txtmembername.Text);
                        cmd.Parameters.AddWithValue("@MemberType", txtmtype.Text);
                        cmd.Parameters.AddWithValue("@Birthdate", txtbdate.Text);
                        cmd.Parameters.AddWithValue("@Education", txteducation.Text);
                        cmd.Parameters.AddWithValue("@MarriageStatus", txtmarriagestatus.Text);
                        cmd.Parameters.AddWithValue("@Occupation", txtoccupation.Text);
                        cmd.Parameters.AddWithValue("@Address", txtaddress.InnerText);
                        cmd.Parameters.AddWithValue("@MobileNumber1", textBoxMobileNumber1.Text);
                        cmd.Parameters.AddWithValue("@MobileNumber2", textBoxMobileNumber2.Text);
                        cmd.Parameters.AddWithValue("@BloodGroup", BloodGroup);
                        cmd.Parameters.AddWithValue("@CreatedBy", UserId);
                        connection.Open();
                        cmd.ExecuteNonQuery();
                        connection.Close();
                    }
                }
                BindGridview();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Failed = " + ex.Message + "!')", true);

                BindGridview();
            }


        }
    }
}