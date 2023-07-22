using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace CBT
{
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {

        }

        protected void Session_Start(object sender, EventArgs e)
        {
            if (Session["UserId"] != null)
            {
                if (Session["usertype"].ToString() == "1")
                {
                    //Redirect to Welcome Page if Session is not null    
                    Response.Redirect("SanghMaster.aspx");
                }

                else if (Session["usertype"].ToString() == "2")
                {
                    //Redirect to Welcome Page if Session is not null    
                    Response.Redirect("SanghMaster.aspx");
                }
            }

            //if (Session["UserId"] != null)
            //{
            //    //Redirect to Welcome Page if Session is not null    
            //    Response.Redirect("Dashboard.aspx");
            //}
            else
            {
                //Redirect to Login Page if Session is null & Expires     
                Response.Redirect("LogIn.aspx");
            }
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }

}