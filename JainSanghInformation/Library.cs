using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace JainSanghInformation
{
    public class Library
    {

        public static void WriteErrorLog(Exception ex, string msg = null)
        {
            StreamWriter sw = null;
            try
            {
                sw = new StreamWriter(System.Web.Hosting.HostingEnvironment.MapPath("~/ErrorLog/ErrorLog.txt"), true);
                sw.WriteLine(msg + DateTime.Now.ToString() + ": " + ex.Source.ToString().Trim() + "; " + ex.Message.ToString().Trim());
                sw.Flush();
                sw.Close();
            }
            catch
            {
            }
        }

        public static void WriteErrorLog(string Message)
        {
            StreamWriter sw = null;
            try
            {
                //sw = new StreamWriter(AppDomain.CurrentDomain.BaseDirectory + "\\LogFile.txt", true);
                sw = new StreamWriter(System.Web.Hosting.HostingEnvironment.MapPath("~/ErrorLog/ErrorLog.txt"), true);
                sw.WriteLine(DateTime.Now.ToString() + ": " + Message);
                sw.Flush();
                sw.Close();
            }
            catch
            {
            }
        }
    }
}