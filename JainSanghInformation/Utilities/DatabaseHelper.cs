using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace JainSanghInformation.Utilities
{
    public class DatabaseHelper
    {
        private static readonly string connectionString = ConfigurationManager.ConnectionStrings["JSI"].ConnectionString;
        private static readonly string deleteDataInSangh_Master = "sp_SanghDelete";
        private static readonly string deleteDataInMember_Master = "sp_MemberMaster_Delete";
        private static readonly string insertDataInMemberMaster = "sp_insertDataMemberMaster";


        public static bool deleteDataFromSanghMaster(SqlParameter[] parameters)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand command = new SqlCommand(deleteDataInSangh_Master, connection);
                    command.CommandType = CommandType.StoredProcedure;

                    if (parameters != null)
                    {
                        command.Parameters.AddRange(parameters);
                    }

                    connection.Open();
                    command.ExecuteNonQuery();
                    return true;
                }
            }
            catch (Exception e)
            {

                return false;
            }
        }

        public static bool deleteDataFromMemberMaster(SqlParameter[] parameters)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand command = new SqlCommand(deleteDataInMember_Master, connection);
                    command.CommandType = CommandType.StoredProcedure;

                    if (parameters != null)
                    {
                        command.Parameters.AddRange(parameters);
                    }

                    connection.Open();
                    command.ExecuteNonQuery();
                    return true;
                }
            }
            catch (SqlException sql)
            {

                return false;
            }
            catch (Exception e)
            {
                return false;
            }
        }
        public static bool InsertDataInMemberMaster(SqlParameter[] parameters)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand command = new SqlCommand(insertDataInMemberMaster, connection);
                    command.CommandType = CommandType.StoredProcedure;

                    if (parameters != null)
                    {
                        command.Parameters.AddRange(parameters);
                    }

                    connection.Open();
                    command.ExecuteNonQuery();
                    return true;
                }
            }
            catch (Exception e)
            {

                return false;
            }
        }


    }
}