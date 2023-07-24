using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace JainSanghInformation.Utilities
{
    public class DropDownHelper
    {
        private static readonly string connectionString = ConfigurationManager.ConnectionStrings["JSI"].ConnectionString;
        public static readonly string spNameForMemberType = "sp_DropDownListMember_Type";
        public static readonly string spNameForParenMemberName = "sp_DropDownListParentMemberName";

        public static void PopulateDropDownListFromStoredProcedure(DropDownList ddl, string storedProcName, SqlParameter[] parameters = null)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(storedProcName, connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    if (parameters != null && parameters.Length > 0)
                    {
                        command.Parameters.AddRange(parameters);
                    }

                    // Open the connection
                    connection.Open();

                    // Execute the stored procedure and get the data reader
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        // Clear existing items from the DropDownList
                        ddl.Items.Clear();

                        // Loop through the data reader and add items to the DropDownList
                        while (reader.Read())
                        {
                            string value = reader["ValueColumn"].ToString();
                            string text = reader["TextColumn"].ToString();

                            ddl.Items.Add(new ListItem(text, value));
                        }
                    }
                }
            }
        }



    }
}