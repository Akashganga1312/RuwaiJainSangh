using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JainSanghInformation
{
    public partial class VerifyOTP : System.Web.UI.Page
    {
        public string logoUrl;

        protected void Page_Load(object sender, EventArgs e)
        {
                welcomeLabel.InnerText = Constants.WelcomeText;
                titleLabel.InnerText = Constants.TitleText;
                //eventLabel.InnerText = Constants.EventText;
                logoUrl = "assets/images/sangh.png";


        }

        protected void VerifyOTPCode(object sender, EventArgs e)
        {
            string generatedOTP = Session["GeneratedOTP"].ToString();
            if (string.IsNullOrEmpty(generatedOTP))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowWarningNotification",
                   "showErrorNotification('Please fill the OTP fields.');", true);
            }
            if (otpInput.Text == generatedOTP)
            {
                Session["UserId"] = Session["usrid1"].ToString();
                Session["usrid"] = Session["usrid1"].ToString();
                Session["UserType"] = Session["usertype1"].ToString();
                Session["usertype"] = Session["usertype1"].ToString();
                Session["Name"] = Session["Name1"].ToString();
                Session["autoid"] = Session["autoid1"].ToString();
                Response.Redirect("Default.aspx");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowErrorNotification",
                   "showWarningNotification('Invalid OTP! Please try again.');", true);
            }
        }

    }
}