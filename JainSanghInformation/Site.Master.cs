using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Collections.Specialized.BitVector32;
using System.Diagnostics;
using System.Web.Security;

namespace JainSanghInformation
{
    public partial class SiteMaster : MasterPage
    {
        public int UserType;
        public string UserId = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            try { 
            if (UserId == "")
            {
                UserType = Convert.ToInt32(Session["usertype"].ToString());
                UserId = Session["usrid"].ToString();
            }
            }
            catch(Exception ex)
            {
                logout(sender, e);
            }

        }

        protected void logout(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Session.RemoveAll();

            //if (Request.Cookies["ASP.NET_SessionId"] != null)
            //{
            //    Response.Cookies["ASP.NET_SessionId"].Value = string.Empty;
            //    Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddMonths(-20);
            //}

            //if (Request.Cookies["AuthToken"] != null)
            //{
            //    Response.Cookies["AuthToken"].Value = string.Empty;
            //    Response.Cookies["AuthToken"].Expires = DateTime.Now.AddMonths(-20);
            //}
            UserType = 0;
            UserId = string.Empty;
            Response.Redirect("LogIn.aspx");
        }
    }
}