using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using AjaxControlToolkit.HtmlEditor.ToolbarButtons;
using System.Net.Mail;

namespace JainSanghInformation
{
    public partial class LogIn : System.Web.UI.Page
    {

        public static int UserType;
        public static string UserId;
        public static string Name;
        public static string PassWord;
        public static string IsDelete;
        public static string IsActive;
        public string logoUrl;

        string constr = ConfigurationManager.ConnectionStrings["JSI"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            welcomeLabel.InnerText = Constants.WelcomeText;
            titleLabel.InnerText = Constants.TitleText;
            logoUrl = "assets/images/sangh.png";
        }

        protected void Login(object sender, EventArgs e)
        {

            try
            {
                if (loginType.SelectedValue == "admin") // For admin login
                {
                    if (!string.IsNullOrWhiteSpace(usernamemain.Text) && !string.IsNullOrWhiteSpace(passwordmain.Text))
                    {
                        using (SqlConnection scon = new SqlConnection(constr))
                        {
                            scon.Open();
                            SqlCommand cmd = new SqlCommand("sp_LoginUser", scon);
                            cmd.CommandType = CommandType.StoredProcedure;

                            // Pass the username and password as parameters to the stored procedure
                            cmd.Parameters.AddWithValue("@UserId", usernamemain.Text);
                            cmd.Parameters.AddWithValue("@Password", passwordmain.Text);

                            SqlDataAdapter adapt = new SqlDataAdapter(cmd);
                            DataSet ds = new DataSet();
                            adapt.Fill(ds);
                            int count = ds.Tables[0].Rows.Count;

                            if (count == 1)
                            {
                                // Extract user details
                                string mobileNo = ds.Tables[0].Rows[0]["MobileNo"].ToString();
                                Session["UserId"] = ds.Tables[0].Rows[0]["UserId"];
                                UserType = Convert.ToInt32(ds.Tables[0].Rows[0]["UserTypeId"]);
                                UserId = ds.Tables[0].Rows[0]["UserId"].ToString();
                                Name = ds.Tables[0].Rows[0]["Name"].ToString();
                                PassWord = passwordmain.Text;
                                IsDelete = ds.Tables[0].Rows[0]["IsDelete"].ToString();
                                IsActive = ds.Tables[0].Rows[0]["IsActive"].ToString();

                                if (IsDelete == "True")
                                {
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowWarningNotification",
                  "showWarningNotification('Account is deleted.');", true);
                                }
                                else if (IsDelete == "False")
                                {
                                    if (IsActive == "False")
                                    {
                                        ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowWarningNotification",
                   "showWarningNotification('Account is suspended.');", true);
                                    }
                                    else if (IsActive == "True")
                                    {
                                        ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowSuccessNotification",
                         "showSuccessNotification('Login successful! Redirecting to the dashboard.');", true);
                                        Session.Add("usertype", UserType);
                                        Session.Add("usrid", UserId);
                                        Session.Add("name", Name);
                                        Session.Add("autoid", 0);
                                        Response.Redirect("Default.aspx");
                                    }
                                }
                                else
                                {
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowErrorNotification",
                           "showErrorNotification('Invalid username or password. Please try again.');", true);
                                }
                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowErrorNotification",
"showWarningNotification('Invalid Credential! Please enter valid credential.');", true);
                            }

                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowWarningNotification",
                    "showWarningNotification('Please fill in all required fields.');", true);
                        // Handle empty fields
                    }
                }
                else if (loginType.SelectedValue == "member") // For member login
                {
                    if (!string.IsNullOrWhiteSpace(mobilemain.Text))
                    {
                        string mobileNo = mobilemain.Text;
                        try
                        {
                            using (SqlConnection scon = new SqlConnection(constr))
                            {
                                scon.Open();
                                SqlCommand cmd = new SqlCommand("sp_CheckMobileNumber", scon);
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.Parameters.AddWithValue("@MobileNo", mobileNo);

                                SqlDataAdapter adapt = new SqlDataAdapter(cmd);
                                DataSet ds = new DataSet();
                                adapt.Fill(ds);
                                int count = ds.Tables[0].Rows.Count;

                                if (count == 1)
                                {
                                    UserType = Convert.ToInt32(ds.Tables[0].Rows[0]["UserTypeId"]);
                                    UserId = ds.Tables[0].Rows[0]["UserId"].ToString();
                                    Name = ds.Tables[0].Rows[0]["Name"].ToString();
                                    PassWord = passwordmain.Text;
                                    IsDelete = ds.Tables[0].Rows[0]["IsDelete"].ToString();
                                    IsActive = ds.Tables[0].Rows[0]["IsActive"].ToString();
                                    var OTP = GenerateOTP();
                                    Session["GeneratedOTP"] = OTP;
                                    Session["MobileNo"] = mobileNo;
                                    SendOtpToUser(mobileNo, OTP);
                                    if (IsActive == "1" && IsDelete == "0")
                                    {
                                        Session.Add("usertype1", UserType);
                                        Session.Add("usrid1", UserId);
                                        Session.Add("Name1", Name);
                                        Session.Add("autoid1", ds.Tables[0].Rows[0]["AutoId"].ToString());
                                    }
                                    Response.Redirect("VerifyOTP.aspx");
                                }
                                else
                                {
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowErrorNotification",
"showWarningNotification('Mobile number not found. Please enter a valid mobile number.');", true);
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            var stringMessage = ex.Message;
                            stringMessage = stringMessage.Replace("'", "").Replace("\"", "");
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowErrorNotification",
          $"showErrorNotification('An error occurred: {stringMessage}');", true);
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowWarningNotification",
"showWarningNotification('Please enter your Mobile Number.');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowWarningNotification",
"showWarningNotification('Please select valid user type.');", true);
                }

            }
            catch (Exception ex)
            {
                var stringMessage = ex.Message;
                stringMessage = stringMessage.Replace("'", "").Replace("\"", "");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowErrorNotification",
            $"showErrorNotification('An error occurred: {stringMessage}');", true);
            }

        }


        protected void SendOtpToUser(string mobileNo, string otp)
        {
            try
            {
                string apiUrl = $"http://rtl.akgsms.in/app/rtsmsapi/index.php?key=5b62a85dbaf73&type=text&contacts=91{mobileNo}&senderid=AGASAN&msg= OTP for Registration is {otp}. It will be valid for 10 Minutes. KAMDHENU&tid=1407161734802899497";
                string response;
                using (WebClient client = new WebClient())
                {
                    response = client.DownloadString(apiUrl);
                    System.Diagnostics.Debug.WriteLine($"SMS API Response: {response}");
                }
                LogOtpDetails(mobileNo, otp, "Success", response);

            }
            catch (Exception ex)
            {
                // Handle any errors that occur during the API call
                // You can log the exception or show a message to the user
                var stringMessage = ex.Message;
                stringMessage = stringMessage.Replace("'", "").Replace("\"", "");
                System.Diagnostics.Debug.WriteLine($"Error sending OTP: {stringMessage}");
                LogOtpDetails(mobileNo, otp, "Failure", stringMessage);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowErrorNotification",
            $"showErrorNotification('Failed to send OTP. Please try again: {stringMessage}');", true);
            }
        }

        private void LogOtpDetails(string mobileNo, string otp, string status, string response)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(constr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_LogOtpDetails", connection))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@MobileNo", mobileNo);
                        cmd.Parameters.AddWithValue("@Otp", otp);
                        cmd.Parameters.AddWithValue("@Status", status);
                        cmd.Parameters.AddWithValue("@Response", response);
                        cmd.Parameters.AddWithValue("@CreatedDate", DateTime.Now);

                        connection.Open();
                        cmd.ExecuteNonQuery();
                        connection.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error logging OTP details: {ex.Message}");
            }
        }


        public string GenerateOTP()
        {
            Random random = new Random();
            return random.Next(1000, 9999).ToString(); // Generate a 4-digit OTP
        }

        public void SendEmail(string toEmail, string subject, string body)
        {

            try
            {
                string fromEmail = "ruwaignatitrust@gmail.com";
                string smtpServer = "smtp.gmail.com";
                string password = "zpot qqek lryv skdw";
                int smtpPort = 587;

                using (MailMessage mail = new MailMessage())
                {
                    mail.From = new MailAddress(fromEmail);
                    mail.To.Add(toEmail);
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

        private string GetEmailBody(string otp)
        {
            return $@"
        <html>
        <head>
            <style>
                body {{
                    font-family: 'Poppins', sans-serif;
                    background-color: #f9f9f9;
                    color: #333;
                }}
                .container {{
                    max-width: 600px;
                    margin: 0 auto;
                    padding: 20px;
                    background: #fff;
                    border-radius: 10px;
                    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                }}
                .header {{
                    text-align: center;
                    padding-bottom: 20px;
                }}
                .header img {{
                    max-width: 150px;
                    height: auto;
                }}
                .content {{
                    font-size: 16px;
                    line-height: 1.5;
                }}
                .otp {{
                    font-size: 24px;
                    font-weight: bold;
                    color: #ff5733;
                    text-align: center;
                    margin: 20px 0;
                }}
                .footer {{
                    font-size: 12px;
                    color: #777;
                    text-align: center;
                    padding-top: 20px;
                }}
            </style>
        </head>
        <body>
            <div class='container'>
                <div class='header'>
                    <img src='http://www.ruwaijain.com/assets/images/sangh.png' alt='Organization Logo' />
                </div>
                <div class='content'>
                    <p>Dear User,</p>
                    <p>We received a request to log in using this email address. Please use the OTP below to complete your login process:</p>
                    <div class='otp'>{otp}</div>
                    <p>If you did not request this, please ignore this email or contact our support team for assistance.</p>
                </div>
                <div class='footer'>
                    <p>&copy; {DateTime.Now.Year} {Constants.TitleText}. All rights reserved.</p>
                </div>
            </div>
        </body>
        </html>";
        }




        private void ShowAlertAndRedirect(string message, string redirectUrl)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ClientScript", $"alert('{message}'); document.location.href='{redirectUrl}';", true);
        }

        protected void GenerateEmailOTP(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(emailmain.Text))
            {
                string email = emailmain.Text;
                try
                {
                    using (SqlConnection scon = new SqlConnection(constr))
                    {
                        scon.Open();
                        SqlCommand cmd = new SqlCommand("sp_CheckEmail", scon);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Email", email);

                        SqlDataAdapter adapt = new SqlDataAdapter(cmd);
                        DataSet ds = new DataSet();
                        adapt.Fill(ds);
                        int count = ds.Tables[0].Rows.Count;

                        if (count == 1)
                        {
                            string otp = GenerateOTP();
                            UserType = Convert.ToInt32(ds.Tables[0].Rows[0]["UserTypeId"]);
                            UserId = ds.Tables[0].Rows[0]["UserId"].ToString();
                            Name = ds.Tables[0].Rows[0]["Name"].ToString();
                            IsDelete = ds.Tables[0].Rows[0]["IsDelete"].ToString();
                            IsActive = ds.Tables[0].Rows[0]["IsActive"].ToString();
                            Session["GeneratedOTP"] = otp;
                            if (IsActive == "1" && IsDelete == "0")
                            {
                                Session.Add("usertype1", UserType);
                                Session.Add("usrid1", UserId);
                                Session.Add("Name1", Name);
                                Session.Add("autoid1", ds.Tables[0].Rows[0]["AutoId"].ToString());
                            }
                            var subject = Constants.Verification + Constants.TitleText;
                            // Send OTP to email
                            SendEmail(email, subject, GetEmailBody(otp));
                            Response.Redirect("VerifyOTP.aspx");
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowErrorNotification",
                            "showWarningNotification('Email not registered. Please enter a valid email.');", true);
                        }
                    }
                }
                catch (Exception ex)
                {
                    var stringMessage = ex.Message.Replace("'", "").Replace("\"", "");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowErrorNotification",
                    $"showErrorNotification('An error occurred: {stringMessage}');", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowWarningNotification",
                "showWarningNotification('Please enter your Email Address.');", true);
            }
        }


        protected void GenerateOTP(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(mobilemain.Text) && mobilemain.Text.Count() == 10)
            {
                // Generate OTP
                // string otp = GenerateOTP(); // Implement your OTP generation logic
                string mobileNo = mobilemain.Text;

                // Send OTP to user's mobile number
                // SendOtpToUser(mobileNo, otp);SS

                // Store OTP in session for verification later
                //Session["GeneratedOTP"] = otp;
                //Session["GeneratedOTP"] = mobileNo.Substring(6, 4);
                Login(sender, e);
                // Redirect to OTP verification page
                //Response.Redirect("VerifyOTP.aspx");
            }
            else
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowWarningNotification",
"showErrorNotification('Please enter valid Mobile Number.');", true);
                // Handle case where mobile number is not provided
            }
        }


    }
}