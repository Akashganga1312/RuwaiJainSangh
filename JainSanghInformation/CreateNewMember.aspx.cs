using ClosedXML.Excel;
using ExcelDataReader;
using JainSanghInformation.Utilities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Reflection;
using System.Runtime.InteropServices.ComTypes;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JainSanghInformation
{
    public partial class CreateNewMember : System.Web.UI.Page
    {
        public int UserType;
        public string UserId;
        string connectionString = ConfigurationManager.ConnectionStrings["JSI"].ConnectionString;
        public bool method = false;
        public string sanghname;
        public string VillageName;
        public string MemberName;
        public string ParentMemberId;
        public string MemberType;
        public string Birthdate;
        public string Education;
        public string MarriageStatus;
        public string Occupation;
        public string Address;
        public string MobileNumber1;
        public string MobileNumber2;
        public string BloodGroup;
        public string Gender;
        public string Email;
        public string OccupationAddress;
        public int totalrows = 0;
        public int Success = 0;
        public int Failed = 0;


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
                dropDownMemberType();
                dropDownParentMemberName();
                combobox();
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

        protected void logout(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Session.RemoveAll();
            UserType = 0;
            UserId = string.Empty;
            Response.Redirect("Default.aspx");
        }

        public void insetupdatedata()
        {

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {

                    // Create a SqlCommand object to call the stored procedure
                    using (SqlCommand command = new SqlCommand("sp_insertDataMemberMaster", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;


                        if (!method)
                        {
                            sanghname = ddlsangh.SelectedValue;
                            VillageName = txtvillagename.Text;
                            MemberName = txtmembername.Text;
                            MemberType = DropDownListMemberType.SelectedItem.ToString();
                            Birthdate = txtbdate.Text;
                            Education = txteducation.Text;
                            MarriageStatus = txtmarriagestatus.Text;
                            Occupation = txtoccupation.Text;
                            Address = txtaddress.InnerText;
                            MobileNumber1 = textBoxMobileNumber1.Text;
                            MobileNumber2 = textBoxMobileNumber2.Text;
                            BloodGroup = ddlbloodgrup.Text;
                            Gender = ddlGender.Text;
                            OccupationAddress = txtOccupationAddress.InnerText;
                            Email = txtEmailAddress.Text;
                            if (BloodGroup.Contains("--"))
                            {
                                BloodGroup = string.Empty;
                            }
                            if (Gender.Contains("--"))
                            {
                                Gender = string.Empty;
                            }


                        }
                        if (!MemberType.Equals("Self"))
                        {
                            ParentMemberId = DropDownListParentMember.SelectedItem.ToString();
                        }

                        command.Parameters.AddWithValue("@SanghName", sanghname);
                        command.Parameters.AddWithValue("@VillageName", VillageName);
                        command.Parameters.AddWithValue("@MemberName", MemberName);
                        command.Parameters.AddWithValue("@MemberType", MemberType);
                        command.Parameters.AddWithValue("@Birthdate", Birthdate);
                        command.Parameters.AddWithValue("@Education", Education);
                        command.Parameters.AddWithValue("@MarriageStatus", MarriageStatus);
                        command.Parameters.AddWithValue("@Occupation", Occupation);
                        command.Parameters.AddWithValue("@OccupationAddress", OccupationAddress);
                        command.Parameters.AddWithValue("@Email", Email);
                        command.Parameters.AddWithValue("@Gender", Gender);
                        command.Parameters.AddWithValue("@Address", Address);
                        command.Parameters.AddWithValue("@MobileNumber1", MobileNumber1);
                        command.Parameters.AddWithValue("@MobileNumber2", MobileNumber2);
                        command.Parameters.AddWithValue("@BloodGroup", BloodGroup);
                        command.Parameters.AddWithValue("@CreatedBy", UserType);
                        if (ParentMemberId != null || ParentMemberId != "")
                        {
                            command.Parameters.AddWithValue("@MemberNameParent", ParentMemberId);
                        }
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                        Success++;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowSuccessNotification","showSuccessNotification('Successfully Inserted or Updated!');", true);
                        clearAllField();
                    }
                }
            }
            catch (Exception ex)
            {
                Failed++;
                Library.WriteErrorLog("Insert Data of Member Error = " + ex.ToString());
                var stringMessage = ex.Message;
                stringMessage = stringMessage.Replace("'", "").Replace("\"", "");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowErrorNotification",
                $"showErrorNotification('An error occurred: {stringMessage}');", true);
            }

        }

        protected void btninsert_Click(object sender, EventArgs e)
        {
            method = false;
            insetupdatedata();
            clearAllField();

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
            DropDownListMemberType.ClearSelection();
            ddlbloodgrup.ClearSelection();
            ddlsangh.ClearSelection();
            txtOccupationAddress.InnerText = string.Empty;
            txtaddress.InnerText = string.Empty;
            ddlGender.ClearSelection();
        }

        protected void btnupload_Click(object sender, EventArgs e)
        {
            method = true;

            if (filupl.HasFile)
            {
                string fileExtension = Path.GetExtension(filupl.FileName);
                if (fileExtension == ".xlsx" || fileExtension == ".xlx")
                {
                    string fileName = Path.GetFileName(filupl.FileName);
                    string uploadDir = Server.MapPath("~/Uploads/");
                    if (!Directory.Exists(uploadDir))
                    {
                        Directory.CreateDirectory(uploadDir);
                    }
                    string filePath = Path.Combine(uploadDir, fileName);
                    filupl.SaveAs(filePath);
                    InsertDataFromExcel(filePath);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showErrorNotification",
$"showErrorNotification('Only .xlsx and .xlx files are allowed.');", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showErrorNotification",
$"showErrorNotification('Please select a file to upload.');", true);
            }
        }

        private void InsertDataFromExcel(string filePath)
        {
            int insertRowOrAffectedRow = 0;
            int failedRowOFinsertion = 0;
            int totalrows = 0;
            DataTable failedRecords = new DataTable();
            try
            {
                failedRecords.Columns.Add("SanghName-SanghLocation*");
                failedRecords.Columns.Add("MemberType*");
                failedRecords.Columns.Add("ParentMemberName*");
                failedRecords.Columns.Add("MemberName*");
                failedRecords.Columns.Add("Birthdate");
                failedRecords.Columns.Add("Education");
                failedRecords.Columns.Add("MarriageStatus");
                failedRecords.Columns.Add("Occupation");
                failedRecords.Columns.Add("NativePlace");
                failedRecords.Columns.Add("Address");
                failedRecords.Columns.Add("Occupation Address");
                failedRecords.Columns.Add("MobileNumberPrimary");
                failedRecords.Columns.Add("MobileNumberSecondary");
                failedRecords.Columns.Add("BloodGroup");
                failedRecords.Columns.Add("Gender*");
                failedRecords.Columns.Add("Email");
                failedRecords.Columns.Add("ErrorReason");

                string file = filePath;
                FileStream stream = System.IO.File.Open(file, FileMode.Open, FileAccess.Read);
                IExcelDataReader excelReader = ExcelReaderFactory.CreateOpenXmlReader(stream);
                DataSet result = excelReader.AsDataSet(new ExcelDataSetConfiguration()
                {
                    ConfigureDataTable = (_) => new ExcelDataTableConfiguration()
                    {
                        UseHeaderRow = true
                    }
                });
                DataTable dt = result.Tables[0];
                totalrows = dt.Rows.Count;
                insertRowOrAffectedRow = 0;
                failedRowOFinsertion = 0;

                foreach (DataRow row in dt.Rows)
                {
                    try
                    {
                        string sanghName = row["SanghName-SanghLocation*"].ToString().Trim();
                        string memberType = row["MemberType*"].ToString().Trim();
                        string parentMemberName = row["ParentMemberName*"].ToString().Trim();
                        string memberName = row["MemberName*"].ToString().Trim();
                        string birthdate = row["Birthdate"].ToString().Trim();
                        if (birthdate != "")
                        {
                            try { 
                                birthdate = Convert.ToDateTime(birthdate).ToString("yyyy-MM-dd");
                            }catch(Exception ex)
                            {

                            }
                        }
                        else
                        {
                            birthdate = "1900-01-01";
                        }
                        string education = row["Education"].ToString().Trim();
                        string marriageStatus = row["MarriageStatus"].ToString().Trim();
                        string occupation = row["Occupation"].ToString().Trim();
                        string villageName = row["NativePlace"].ToString().Trim();
                        string address = row["Address"].ToString().Trim();
                        string occupationAddress = row["Occupation Address"].ToString().Trim();
                        string mobileNumberPrimary = row["MobileNumberPrimary"].ToString().Trim();
                        string mobileNumberSecondary = row["MobileNumberSecondary"].ToString().Trim();
                        string bloodGroup = row["BloodGroup"].ToString().Trim();
                        string gender = row["Gender*"].ToString().Trim();
                        string email = row["Email"].ToString().Trim();

                        SqlParameter[] parameters = new SqlParameter[]
                        {
                    new SqlParameter("@SanghName",sanghName),
                    new SqlParameter("@VillageName", villageName),
                    new SqlParameter("@MemberName", memberName),
                    new SqlParameter("@MemberNameParent", parentMemberName),
                    new SqlParameter("@MemberType", memberType),
                    new SqlParameter("@Birthdate", birthdate),
                    new SqlParameter("@Education", education),
                    new SqlParameter("@MarriageStatus", marriageStatus),
                    new SqlParameter("@Occupation", occupation),
                    new SqlParameter("@Address", address),
                    new SqlParameter("@MobileNumber1", mobileNumberPrimary),
                    new SqlParameter("@MobileNumber2", mobileNumberSecondary),
                    new SqlParameter("@Email", email),
                    new SqlParameter("@OccupationAddress", occupationAddress),
                    new SqlParameter("@Gender", gender),
                    new SqlParameter("@BloodGroup",bloodGroup ),
                    new SqlParameter("@CreatedBy", UserId)
                        };

                        try
                        {
                            using (SqlConnection connection = new SqlConnection(connectionString))
                            {
                                SqlCommand command = new SqlCommand("sp_insertDataMemberMaster", connection);
                                command.CommandType = CommandType.StoredProcedure;

                                if (parameters != null)
                                {
                                    command.Parameters.AddRange(parameters);
                                }

                                connection.Open();
                                command.ExecuteNonQuery();
                                insertRowOrAffectedRow++;
                            }
                        }
                        catch (Exception e)
                        {
                            failedRowOFinsertion++;
                            AddFailedRecord(failedRecords, row, e.Message);
                        }
                    }
                    catch (Exception ex)
                    {
                        failedRowOFinsertion++;
                        AddFailedRecord(failedRecords, row, ex.Message);
                    }
                }
                excelReader.Dispose();
            }
            catch (Exception ex)
            {
                failedRowOFinsertion++;
                Library.WriteErrorLog("Upload File Of Member Error = " + ex.ToString());
            }

            string resultMessage = "Total data = " + totalrows + ", Successfully Affected or Inserted = " + insertRowOrAffectedRow + ", Failed record of = " + failedRowOFinsertion;

            if (failedRowOFinsertion > 0)
            {
                string failedFilePath = Server.MapPath("~/Uploads/FailedRecords_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xlsx");
                ExportFailedRecordsToExcel(failedRecords, failedFilePath);

                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowInfoNotification",
                    $"showInfoNotification('{resultMessage}. <a href=\"{failedFilePath}\" target=\"_blank\">Download Failed Records</a>');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowInfoNotification",
                    $"showInfoNotification('{resultMessage}');", true);
            }
        }


        private void AddFailedRecord(DataTable failedRecords, DataRow originalRow, string errorReason)
        {
            DataRow failedRow = failedRecords.NewRow();
            foreach (DataColumn column in failedRecords.Columns)
            {
                if (originalRow.Table.Columns.Contains(column.ColumnName))
                {
                    failedRow[column.ColumnName] = originalRow[column.ColumnName];
                }
            }
            failedRow["ErrorReason"] = errorReason;
            failedRecords.Rows.Add(failedRow);
        }

        private void ExportFailedRecordsToExcel(DataTable dataTable, string filePath)
        {
            using (XLWorkbook workbook = new XLWorkbook())
            {
                workbook.Worksheets.Add(dataTable, "FailedRecords");
                workbook.SaveAs(filePath);
            }
        }
    }
}