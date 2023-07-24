using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace JainSanghInformation.Utilities
{
    public class GetValueHelperFromDatabase
    {
        private static readonly string connectionString = ConfigurationManager.ConnectionStrings["JSI"].ConnectionString;
        public static readonly string queryForGetRate = "select Rate From ProductMaster where ProductCode = @Parameter";
        public static readonly string queryForGetRateForWIP = "select SUM(TotalRate) As Rate from BOMMaster_WIP where BOMName = @Parameter";
        public static readonly string queryForGetValueOfRelation = "select 1 from MemberMaster where ParentRelationId = @Parameter";
        public static string GetRateForProduct(string parameter,string query)
        {
            string rate = string.Empty;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Parameter", parameter);
                    connection.Open();
                    object result = command.ExecuteScalar();
                    rate = result != null ? result.ToString() : string.Empty;
                }
            }

            return rate;
        }
    }
}