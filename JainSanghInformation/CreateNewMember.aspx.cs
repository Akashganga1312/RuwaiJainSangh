using ExcelDataReader;
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
        public string MemberType;
        public string Birthdate;
        public string Education;
        public string MarriageStatus;
        public string Occupation;
        public string Address;
        public string MobileNumber1;
        public string MobileNumber2;
        public string BloodGroup;
        public int totalrows = 0;
        public int Success = 0;
        public int Failed = 0;


        protected void Page_Load(object sender, EventArgs e)
        {
            UserType = Convert.ToInt32(Session["usertype"].ToString());
            UserId = Session["usrid"].ToString();
            if (!this.IsPostBack)
            {
                combobox();
            }
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
                            MemberType = txtmtype.Text;
                            Birthdate = txtbdate.Text;
                            Education = txteducation.Text;
                            MarriageStatus = txtmarriagestatus.Text;
                            Occupation = txtoccupation.Text;
                            Address = txtaddress.InnerText;
                            MobileNumber1 = textBoxMobileNumber1.Text;
                            MobileNumber2 = textBoxMobileNumber2.Text;
                            BloodGroup = ddlbloodgrup.Text;
                            if (BloodGroup.Contains("Select"))
                            {
                                BloodGroup = string.Empty;
                            }

                        }

                        command.Parameters.AddWithValue("@SanghName", sanghname);
                        command.Parameters.AddWithValue("@VillageName", VillageName);
                        command.Parameters.AddWithValue("@MemberName", MemberName);
                        command.Parameters.AddWithValue("@MemberType", MemberType);
                        command.Parameters.AddWithValue("@Birthdate", Birthdate);
                        command.Parameters.AddWithValue("@Education", Education);
                        command.Parameters.AddWithValue("@MarriageStatus", MarriageStatus);
                        command.Parameters.AddWithValue("@Occupation", Occupation);
                        command.Parameters.AddWithValue("@Address", Address);
                        command.Parameters.AddWithValue("@MobileNumber1", MobileNumber1);
                        command.Parameters.AddWithValue("@MobileNumber2", MobileNumber2);
                        command.Parameters.AddWithValue("@BloodGroup", BloodGroup);
                        command.Parameters.AddWithValue("@CreatedBy", UserType);

                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                        Success++;
                    }
                }
            }
            catch (Exception ex)
            {
                Failed++;
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Failed = " + Failed + "!')", true); //Successs Data
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
        }

        protected void btnupload_Click(object sender, EventArgs e)
        {
            method = true;
            ExcelRead();
        }

        public void ExcelRead()
        {
            try
            {
                while (true)
                {
                    string file = Path.GetFileName(filupl.FileName);
                    var path = Server.MapPath("~/uploadedexcel/" + file);
                    SaveFile(filupl.PostedFile);
                    var filePath = Path.Combine("C:\\Program Files\\IIS Express\\uploadedexcel", file);
                    FileStream stream = File.Open(filePath, FileMode.Open, FileAccess.Read);
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

                    

                    foreach (DataRow row in dt.Rows)
                    {

                        sanghname = row["SanghName"].ToString().Trim();
                        VillageName = row["VillageName"].ToString().Trim();
                        MemberName = row["MemberName"].ToString().Trim();
                         MemberType = row["MemberType"].ToString().Trim();
                         Birthdate = row["Birthdate"].ToString().Trim();
                         Education = row["Education"].ToString().Trim();
                         MarriageStatus = row["MarriageStatus"].ToString().Trim();
                         Occupation = row["Occupation"].ToString().Trim();
                         Address = row["Address"].ToString().Trim();
                         MobileNumber1 = row["MobileNumber1"].ToString().Trim();
                         MobileNumber2 = row["MobileNumber2"].ToString().Trim();
                         BloodGroup = row["BloodGroup"].ToString().Trim();

                        insetupdatedata();
                       
                    }
                    stream.Close();
                    break;

                }
                
            }
          
            catch
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Error Occured,Try Again');", true);
            }
            clearAllField();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Total Success = " + Success + " & Failed = " + Failed + "')", true); //Successs Data

        }

       public void SaveFile(HttpPostedFile file)
        {
            string savePath = "c:\\temp\\uploads\\";
            string fileName = filupl.FileName;
            string pathToCheck = savePath + fileName;
            string tempfileName = "";
            if (System.IO.File.Exists(pathToCheck))
            {
                int counter = 2;
                while (System.IO.File.Exists(pathToCheck))
                {
                    tempfileName = counter.ToString() + fileName;
                    pathToCheck = savePath + tempfileName;
                    counter++;
                }

                fileName = tempfileName;
            }
            else
            {
            }
            savePath += fileName;
            filupl.SaveAs(savePath);

        }


    }
}