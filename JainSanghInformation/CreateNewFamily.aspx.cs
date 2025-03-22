using JainSanghInformation.Utilities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JainSanghInformation
{
    public partial class CreateNewFamily : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["JSI"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                combobox();
                PopulateRelationToHeadDropdown();
            }
        }

        protected void btnSaveFamily_Click(object sender, EventArgs e)
        {
        }

        public DataTable GetMemberTypeDropdown()
        {
            DataTable dataTable = new DataTable();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_DropDownListMember_Type", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        con.Open();
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dataTable);
                        }
                    }
                    catch (Exception ex)
                    {
                        throw new Exception("Error fetching member type dropdown", ex);
                    }
                }
            }
            return dataTable;
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

        private void PopulateRelationToHeadDropdown()
        {
            try
            {
                DataTable relationData = GetMemberTypeDropdown();

                DataRow[] rowsToRemove = relationData.Select("ValueColumn IN (0, 1)");
                foreach (DataRow row in rowsToRemove)
                {
                    relationData.Rows.Remove(row);
                }
                relationData.AcceptChanges(); // Finalize changes to the DataTable

                // Bind the filtered data to the dropdown
                hiddenRelationDropdown.DataSource = relationData;
                hiddenRelationDropdown.DataTextField = "TextColumn";
                hiddenRelationDropdown.DataValueField = "ValueColumn";
                hiddenRelationDropdown.DataBind();
            }
            catch (Exception ex)
            {
                throw new Exception("Error populating Relation to Head dropdown", ex);
            }
        }


        [WebMethod]
        public static string SaveFamily(FamilyViewModel familyData)
        {
            Library.WriteErrorLog("Received Data: " + new JavaScriptSerializer().Serialize(familyData));
            try
            {

                string connectionString = ConfigurationManager.ConnectionStrings["JSI"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Insert Family Head
                    using (SqlCommand command = new SqlCommand("sp_insertDataMemberMaster", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        string originalSanghName = familyData.FamilyHead.SanghName;
                        string processedSanghName = originalSanghName.Contains("-")
                            ? originalSanghName.Substring(0, originalSanghName.IndexOf('-'))
                            : originalSanghName;
                        command.Parameters.AddWithValue("@SanghName", processedSanghName);
                        command.Parameters.AddWithValue("@VillageName", familyData.FamilyHead.VillageName);
                        command.Parameters.AddWithValue("@MemberName", familyData.FamilyHead.Name);
                        command.Parameters.AddWithValue("@MemberType", "Self");
                        command.Parameters.AddWithValue("@Birthdate", familyData.FamilyHead.Birthdate);
                        command.Parameters.AddWithValue("@Education", familyData.FamilyHead.Education);
                        command.Parameters.AddWithValue("@MarriageStatus", familyData.FamilyHead.MarriageStatus);
                        command.Parameters.AddWithValue("@Occupation", familyData.FamilyHead.Occupation);
                        command.Parameters.AddWithValue("@OccupationAddress", familyData.FamilyHead.OccupationAddress);
                        command.Parameters.AddWithValue("@Email", familyData.FamilyHead.Email);
                        command.Parameters.AddWithValue("@Gender", familyData.FamilyHead.Gender);
                        command.Parameters.AddWithValue("@Address", familyData.FamilyHead.Address);
                        command.Parameters.AddWithValue("@MobileNumber1", familyData.FamilyHead.Mobile1);
                        command.Parameters.AddWithValue("@MobileNumber2", familyData.FamilyHead.Mobile2);
                        command.Parameters.AddWithValue("@BloodGroup", familyData.FamilyHead.BloodGroup);
                        command.Parameters.AddWithValue("@ApprovalStatus", "Pending");
                        command.Parameters.AddWithValue("@AdminRemarks", "Direct from link");
                        command.Parameters.AddWithValue("@CreatedBy", "guest");

                        command.ExecuteNonQuery();
                    }

                    // Insert Family Members
                    foreach (var member in familyData.FamilyMembers)
                    {
                        using (SqlCommand command = new SqlCommand("sp_insertDataMemberMaster", connection))
                        {
                            command.CommandType = CommandType.StoredProcedure;

                            string originalSanghName = familyData.FamilyHead.SanghName;
                            string processedSanghName = originalSanghName.Contains("-")
                                ? originalSanghName.Substring(0, originalSanghName.IndexOf('-'))
                                : originalSanghName;
                            command.Parameters.AddWithValue("@SanghName", processedSanghName);
                            command.Parameters.AddWithValue("@VillageName", member.VillageName);
                            command.Parameters.AddWithValue("@MemberName", member.Name);
                            command.Parameters.AddWithValue("@MemberNameParent", familyData.FamilyHead.Name);
                            command.Parameters.AddWithValue("@MemberType", member.Relation); // Relation to Head
                            command.Parameters.AddWithValue("@Birthdate", member.Birthdate);
                            command.Parameters.AddWithValue("@Education", member.Education);
                            command.Parameters.AddWithValue("@MarriageStatus", member.MarriageStatus);
                            command.Parameters.AddWithValue("@Occupation", member.Occupation);
                            command.Parameters.AddWithValue("@OccupationAddress", member.OccupationAddress);
                            command.Parameters.AddWithValue("@Email", member.Email);
                            command.Parameters.AddWithValue("@Gender", member.Gender);
                            command.Parameters.AddWithValue("@Address", member.Address);
                            command.Parameters.AddWithValue("@MobileNumber1", member.Mobile1);
                            command.Parameters.AddWithValue("@MobileNumber2", member.Mobile2);
                            command.Parameters.AddWithValue("@BloodGroup", member.BloodGroup);
                            command.Parameters.AddWithValue("@ApprovalStatus", "Pending");
                            command.Parameters.AddWithValue("@AdminRemarks", "Direct from link");
                            command.Parameters.AddWithValue("@CreatedBy", "guest");
                            command.ExecuteNonQuery();
                        }
                    }
                }

                string emailBody = GenerateEmailBody(familyData);

                SendEmailSelf("ruwaignatitrust@gmail.com", "Approval Request for Family Registration", emailBody);

                return new JavaScriptSerializer().Serialize(new { success = true, message = "Family data saved successfully." });
            }
            catch (Exception ex)
            {
                return new JavaScriptSerializer().Serialize(new { success = false, message = ex.Message });
            }
        }


        public static string GenerateEmailBody(FamilyViewModel familyData)
        {
            string familyMembersHtml = string.Join("", familyData.FamilyMembers.Select(member => $@"
        <tr>
            <td>{member.Name}</td>
            <td>{member.Relation}</td>
            <td>{member.Birthdate}</td>
            <td>{member.Gender}</td>
            <td>{member.Mobile1}</td>
        </tr>
    "));

            return $@"
        <div style='font-family: Arial, sans-serif; font-size: 14px;'>
            <h2>Approval Request for Family Registration</h2>
            <p>Dear Admin,</p>
            <p>The following family has been registered and requires your approval:</p>
            <h3>Family Head Details</h3>
            <table border='1' cellpadding='10' cellspacing='0' style='border-collapse: collapse;'>
                <tr>
                    <th>Name</th>
                    <td>{familyData.FamilyHead.Name}</td>
                </tr>
                <tr>
                    <th>Gender</th>
                    <td>{familyData.FamilyHead.Gender}</td>
                </tr>
                <tr>
                    <th>Birthdate</th>
                    <td>{familyData.FamilyHead.Birthdate}</td>
                </tr>
                <tr>
                    <th>Mobile</th>
                    <td>{familyData.FamilyHead.Mobile1}</td>
                </tr>
                <tr>
                    <th>Email</th>
                    <td>{familyData.FamilyHead.Email}</td>
                </tr>
            </table>
            <h3>Family Members</h3>
            <table border='1' cellpadding='10' cellspacing='0' style='border-collapse: collapse;'>
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Relation</th>
                        <th>Birthdate</th>
                        <th>Gender</th>
                        <th>Mobile</th>
                    </tr>
                </thead>
                <tbody>
                    {familyMembersHtml}
                </tbody>
            </table>
            <p>Thank you,<br>Jain Sangh Information System</p>
        </div>";
        }

        public static void SendEmailSelf (string toEmail, string subject, string body)
        {
            try
            {
                string fromEmail = "ruwaignatitrust@gmail.com";
                toEmail = "ruwaignatitrust@gmail.com";
                string ccEmail = "parth@akashganga.in";
                string smtpServer = "smtp.gmail.com";
                string password = "zpot qqek lryv skdw";
                int smtpPort = 587;

                using (MailMessage mail = new MailMessage())
                {
                    mail.From = new MailAddress(fromEmail);
                    mail.To.Add(toEmail);
                    mail.CC.Add(ccEmail);
                    mail.Subject = subject;
                    mail.Body = body;
                    mail.IsBodyHtml = true;

                    using (SmtpClient smtp = new SmtpClient(smtpServer, smtpPort))
                    {
                        smtp.Credentials = new NetworkCredential(fromEmail, password);
                        smtp.EnableSsl = true; // Ensure SSL is enabled
                        smtp.Send(mail);
                    }
                }
            }
            catch (Exception ex)
            {
                throw; // Re-throw to log the error higher up
            }
        }

        public class FamilyViewModel
        {
            public FamilyHeadViewModel FamilyHead { get; set; }
            public List<FamilyMemberViewModel> FamilyMembers { get; set; }
        }

        public class FamilyHeadViewModel
        {
            public string Name { get; set; }
            public string Gender { get; set; }
            public string Birthdate { get; set; }
            public string Education { get; set; }
            public string MarriageStatus { get; set; }
            public string Mobile1 { get; set; }
            public string Mobile2 { get; set; }
            public string Address { get; set; }
            public string Occupation { get; set; }
            public string OccupationAddress { get; set; }
            public string VillageName { get; set; }
            public string BloodGroup { get; set; }
            public string Email { get; set; }
            public string SanghName { get; set; }
        }

        public class FamilyMemberViewModel
        {
            public string Name { get; set; }
            public string Gender { get; set; }
            public string Birthdate { get; set; }
            public string Relation { get; set; }
            public string Education { get; set; }
            public string MarriageStatus { get; set; }
            public string Mobile1 { get; set; }
            public string Mobile2 { get; set; }
            public string Address { get; set; }
            public string Occupation { get; set; }
            public string OccupationAddress { get; set; }
            public string VillageName { get; set; }
            public string BloodGroup { get; set; }
            public string Email { get; set; }
        }


    }
}