using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace CBT.Utilities
{
    public class DropDownHelper
    {
        private static readonly string connectionString = ConfigurationManager.ConnectionStrings["CIBT"].ConnectionString;
        public static readonly string spNameForBOMType = "sp_DropDownListBOM_Type";
        public static readonly string spNameForProduct = "sp_DropDownListProduct";
        public static readonly string spNameForParty = "sp_DropDownListParty";
        public static readonly string spNameForWIP = "sp_DropDownListWIP";
        public static readonly string spNameForCOMP = "sp_DropDownListCOMP";
        public static readonly string spNameForGetSuggesstion = "sp_GetFirmNameSuggestions";

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

        public static List<string> GetFirmNameSuggestion(string inputText)
        {
            // Call the stored procedure to get suggestions
            List<string> suggestions = new List<string>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(spNameForGetSuggesstion, connection);
                command.CommandType = CommandType.StoredProcedure;

                // Add the parameter for the inputText
                command.Parameters.AddWithValue("@InputText", inputText);

                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        string suggestion = reader["FirmName"].ToString(); // Replace "FirmNameColumn" with the appropriate column name
                        suggestions.Add(suggestion);
                    }

                    reader.Close();
                }
                catch (Exception ex)
                {
                    // Handle any exceptions that may occur during the database operation
                    // For example, log the error or display an error message to the user
                    // ...
                }
            }

            return suggestions;
        }


    }
}