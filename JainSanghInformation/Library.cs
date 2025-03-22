using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace JainSanghInformation
{
    public class Library
    {
        private static readonly string LogDirectoryPath = System.Web.Hosting.HostingEnvironment.MapPath("~/ErrorLog");
        private static readonly string LogFilePath = System.Web.Hosting.HostingEnvironment.MapPath("~/ErrorLog/ErrorLog.txt");
        // Ensure the directory and file exist
        private static void EnsureLogFileExists()
        {
            try
            {
                if (!Directory.Exists(LogDirectoryPath))
                {
                    Directory.CreateDirectory(LogDirectoryPath);
                }

                if (!File.Exists(LogFilePath))
                {
                    File.Create(LogFilePath).Dispose(); // Dispose ensures the file handle is released immediately
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions related to file or directory creation, if necessary
                Console.WriteLine("Error creating log file or directory: " + ex.Message);
            }
        }
        public static void WriteErrorLog(Exception ex, string msg = null)
        {
            StreamWriter sw = null;
            try
            {
                EnsureLogFileExists();
                sw = new StreamWriter(LogFilePath, true);
                sw.WriteLine($"{msg} {DateTime.Now}: {ex.Source?.Trim()}; {ex.Message?.Trim()}");
                sw.Flush();
                sw.Close();
            }
            catch
            {
                // Optionally handle logging failures, e.g., log to another system or suppress errors
            }
        }
        public static void WriteErrorLog(string message)
        {
            StreamWriter sw = null;
            try
            {
                EnsureLogFileExists();
                sw = new StreamWriter(LogFilePath, true);
                sw.WriteLine($"{DateTime.Now}: {message}");
                sw.Flush();
                sw.Close();
            }
            catch
            {
            }
        }
    }
}