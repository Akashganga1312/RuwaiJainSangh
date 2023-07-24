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
using JainSanghInformation.Utilities;
using System.Web.UI.HtmlControls;

namespace JainSanghInformation
{
    public partial class MemberMaster : System.Web.UI.Page
    {
        public int UserType;
        public string UserId;
        public string ParentMemberId;
        string connectionString = ConfigurationManager.ConnectionStrings["JSI"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            UserType = Convert.ToInt32(Session["usertype"].ToString());
            UserId = Session["usrid"].ToString();

            if (!this.IsPostBack)
            {
                dropDownMemberType();
                dropDownParentMemberName();
                combobox();
                BindGridview();
            }
        }
        private void dropDownMemberType()
        {
            // Call the method to populate the DropDownList
            DropDownHelper.PopulateDropDownListFromStoredProcedure(DropDownListMemberType, DropDownHelper.spNameForMemberType, null);
        }

        private void dropDownParentMemberName()
        {
            // Call the method to populate the DropDownList
            DropDownHelper.PopulateDropDownListFromStoredProcedure(DropDownListParentMember, DropDownHelper.spNameForParenMemberName, null);
        }

        public void combobox()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT '0' AS AutoId, '--Select Item--' AS SanghName UNION ALL SELECT AutoId, concat(SanghName,'-',Location) SanghName FROM SanghMaster where IsDelete=0"))
                {

                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    con.Open();
                    ddlsangh.DataSource = cmd.ExecuteReader();
                    ddlsangh.DataValueField = "SanghName";
                    ddlsangh.DataBind();
                    con.Close();
                }
            }
        }

        private void BindGridview()
        {
            GridView2.Visible = false;
            string query = "SELECT MM.AutoId,concat(SM.SanghName,'-',SM.Location) [Sangh Name],VillageName [Village Name],(select MemberName From MemberMaster where AutoId = Case when MM.ParentRelationId IS NULL and MM.MemberType = 'Self' then MM.AutoId else MM.ParentRelationId end) as [Relation With],MemberName [Member Name],MemberType [Member Type],Format(Birthdate,'dd/MM/yyyy') [DOB],Education,MarriageStatus [Marriage Status],Occupation,Address,MobileNumber1 [Primary Mobile],MobileNumber2 [Secondary Mobile],BloodGroup FROM MemberMaster MM, SanghMaster SM where MM.IsDelete=0 and SM.AutoId = MM.SanghMasterId order by ParentRelationId,AutoId";

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

        [System.Web.Services.WebMethod]
        public static string DeleteRecord(string autoId)
        {
            string user_Id = HttpContext.Current.Session["usrid"]?.ToString();
            SqlParameter[] parameters = new SqlParameter[]
          {
                 new SqlParameter("@AutoId", autoId),
                 new SqlParameter("@UserId", user_Id)
          };
            if (DatabaseHelper.deleteDataFromMemberMaster(parameters))
            {
                return "Data deleted successfully";
            }
            else
            {
                return "Deletion was not successful. May the member is already mapped as Parent with other Member(s)";

            }
        }


        public void clearSelectionOfDropdown()
        {
            DropDownListMemberType.ClearSelection();
            ddlsangh.ClearSelection();
            ddlbloodgrup.ClearSelection();
            DropDownListParentMember.ClearSelection();
        }
        protected void GridViewData_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ShowPopup")
            {
                int autoIdIndex = GetColumnIndexByName(GridView2, "AutoId");
                int sanghNameIndex = GetColumnIndexByName(GridView2, "Sangh Name");
                int villageNameIndex = GetColumnIndexByName(GridView2, "Village Name");
                int memberNameIndex = GetColumnIndexByName(GridView2, "Member Name");
                int memberTypeIndex = GetColumnIndexByName(GridView2, "Member Type");
                int dobIndex = GetColumnIndexByName(GridView2, "DOB");
                int educationIndex = GetColumnIndexByName(GridView2, "Education");
                int marriageStatusIndex = GetColumnIndexByName(GridView2, "Marriage Status");
                int occupationIndex = GetColumnIndexByName(GridView2, "Occupation");
                int addressIndex = GetColumnIndexByName(GridView2, "Address");
                int primaryMobileIndex = GetColumnIndexByName(GridView2, "Primary Mobile");
                int secondaryMobileIndex = GetColumnIndexByName(GridView2, "Secondary Mobile");
                int bloodGroupIndex = GetColumnIndexByName(GridView2, "BloodGroup");
                int relationWithIndex = GetColumnIndexByName(GridView2, "Relation With");

                int rowIndex = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = GridView2.Rows[rowIndex];
                clearSelectionOfDropdown();
                // And you respective cell's value
                if (HttpUtility.HtmlDecode(row.Cells[sanghNameIndex].Text).Trim() != "")
                {
                    ddlsangh.SelectedValue = HttpUtility.HtmlDecode(row.Cells[sanghNameIndex].Text);
                }
                txtvillagename.Text = HttpUtility.HtmlDecode(row.Cells[villageNameIndex].Text);
                txtmembername.Text = HttpUtility.HtmlDecode(row.Cells[memberNameIndex].Text);
                var nameOfMemberType = HttpUtility.HtmlDecode(row.Cells[memberTypeIndex].Text).Trim();

                if (HttpUtility.HtmlDecode(row.Cells[memberTypeIndex].Text).Trim() != "")
                {
                    DropDownListMemberType.SelectedItem.Text = HttpUtility.HtmlDecode(row.Cells[memberTypeIndex].Text);
                }
                foreach (ListItem item in DropDownListMemberType.Items)
                {
                    if (item.Value == nameOfMemberType)
                    {
                        item.Selected = true;
                        break;
                    }
                }
                txtbdate.Text = row.Cells[dobIndex].Text;

                if (HttpUtility.HtmlDecode(row.Cells[dobIndex].Text).Trim() != "")
                {
                    txtbdate.Text = DateTime.Parse(row.Cells[dobIndex].Text).ToString("yyyy-MM-dd");
                }

                txteducation.Text = HttpUtility.HtmlDecode(row.Cells[educationIndex].Text);
                txtmarriagestatus.Text = HttpUtility.HtmlDecode(row.Cells[marriageStatusIndex].Text);
                txtoccupation.Text = HttpUtility.HtmlDecode(row.Cells[occupationIndex].Text);
                txtaddress.InnerText = HttpUtility.HtmlDecode(row.Cells[addressIndex].Text);
                textBoxMobileNumber1.Text = HttpUtility.HtmlDecode(row.Cells[primaryMobileIndex].Text);
                textBoxMobileNumber2.Text = HttpUtility.HtmlDecode(row.Cells[secondaryMobileIndex].Text);
                ddlbloodgrup.SelectedIndex = 0;
                if (HttpUtility.HtmlDecode(row.Cells[bloodGroupIndex].Text).Trim() != "")
                {
                    ddlbloodgrup.SelectedValue = HttpUtility.HtmlDecode(row.Cells[bloodGroupIndex].Text);
                }
                if (HttpUtility.HtmlDecode(row.Cells[relationWithIndex].Text).Trim() != "")
                {
                    DropDownListParentMember.SelectedItem.Text = HttpUtility.HtmlDecode(row.Cells[relationWithIndex].Text);
                }
                foreach (ListItem item in DropDownListParentMember.Items)
                {
                    if (item.Value == HttpUtility.HtmlDecode(row.Cells[relationWithIndex].Text))
                    {
                        item.Selected = true;
                        break;
                    }
                }
                //TODO check If 
               
              
                string isItRalatedOrNot =  GetValueHelperFromDatabase.GetRateForProduct(HttpUtility.HtmlDecode(row.Cells[autoIdIndex].Text), GetValueHelperFromDatabase.queryForGetValueOfRelation);
                /*
                else
                {
                    divForMemberNameOfParent.Visible = true;
                    if (DropDownListMemberType.SelectedItem.ToString() == "Self")
                    {
                        divForMemberNameOfParent.Visible = false;
                    }
                   
                }*/
                ScriptManager.RegisterStartupScript(this, GetType(), "CallHandleDropDownChange", "handleDropDownChange();", true);
                if (DropDownListMemberType.SelectedItem.ToString() == "Self" && isItRalatedOrNot == "1")
                {
                    DropDownListMemberType.Enabled = false;
                }



                Popup(true);
            }
        }

        public static int GetColumnIndexByName(GridView gridView, string columnName)
        {
            if (gridView.HeaderRow != null)
            {
                for (int i = 0; i < gridView.HeaderRow.Cells.Count; i++)
                {
                    if (gridView.HeaderRow.Cells[i].Text.Equals(columnName, StringComparison.OrdinalIgnoreCase))
                    {
                        return i;
                    }
                }
            }

            return -1; // Column with the specified name not found
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
                        if (!DropDownListMemberType.SelectedItem.ToString().Equals("Self"))
                        {
                            ParentMemberId = DropDownListParentMember.SelectedItem.ToString();
                        }
                        cmd.Parameters.AddWithValue("@SanghName", ddlsangh.SelectedItem.ToString());
                        cmd.Parameters.AddWithValue("@VillageName", txtvillagename.Text);
                        cmd.Parameters.AddWithValue("@MemberName", txtmembername.Text);
                        cmd.Parameters.AddWithValue("@MemberType", DropDownListMemberType.SelectedItem.ToString());
                        cmd.Parameters.AddWithValue("@Birthdate", txtbdate.Text);
                        cmd.Parameters.AddWithValue("@Education", txteducation.Text);
                        cmd.Parameters.AddWithValue("@MarriageStatus", txtmarriagestatus.Text);
                        cmd.Parameters.AddWithValue("@Occupation", txtoccupation.Text);
                        cmd.Parameters.AddWithValue("@Address", txtaddress.InnerText);
                        cmd.Parameters.AddWithValue("@MobileNumber1", textBoxMobileNumber1.Text);
                        cmd.Parameters.AddWithValue("@MobileNumber2", textBoxMobileNumber2.Text);
                        cmd.Parameters.AddWithValue("@BloodGroup", BloodGroup);
                        cmd.Parameters.AddWithValue("@CreatedBy", UserId);
                        if (ParentMemberId != null || ParentMemberId != "")
                        {
                            cmd.Parameters.AddWithValue("@MemberNameParent", ParentMemberId);
                        }
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

        protected void DropDownListMemberType_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedValue = DropDownListMemberType.SelectedValue;

            // Perform actions based on the selected value
            if (selectedValue == "Husband")
            {
                // Code to show the div or perform other actions when "Husband" is selected
                divForMemberNameOfParent.Visible = true;
            }
            else
            {
                // Code to hide the div or perform other actions for other selections
                divForMemberNameOfParent.Visible = false;
            }
        }
    }
}