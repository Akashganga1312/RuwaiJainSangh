using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Configuration;

namespace JainSanghInformation.Utilities
{
    public class GridViewHelper
    {
        private static readonly string connectionString = ConfigurationManager.ConnectionStrings["CIBT"].ConnectionString;
        public static readonly string queryForProductMasterGridView = "select * from view_ProductMasterGridView";
        public static readonly string queryForPartyMasterGridView = "SELECT [PartyCode] [PartyCode],FirmName [Firm Name],[Address],[District],[State],[PinCode],ContactPerson [Contact Person],LandlineNo [Landline No],MobileNo [Mobile No],[GSTNo],PanNo [PAN No] FROM [CIBT_SKEPL].[dbo].[PartyMaster] where IsDelete=0";
        public static readonly string queryForBOMMasterGridView = "select * from view_BOM_COMP";
        public static readonly string queryForBOMMasterWIPGridView = "select * from view_BOM_WIP";
        public static readonly string queryForBOMFinishGoodsGridView = "select * from view_BOM_FinishGoods where FinishGoods = @Param1";
        public static DataTable GetGridViewData(string queryForDatabase)
        {
            DataTable dataTable = new DataTable();

            // Set up your database connection string
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Set up your SQL query

                using (SqlCommand command = new SqlCommand(queryForDatabase, connection))
                {

                    connection.Open();

                    // Execute the query and populate the DataTable
                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        adapter.Fill(dataTable);
                    }
                }
            }

            return dataTable;
        }

        public static DataTable GetGridViewDataWithParameter(string queryForDatabase, SqlParameter[] parameters)
        {
            DataTable dataTable = new DataTable();

            // Set up your database connection string
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Set up your SQL query

                using (SqlCommand command = new SqlCommand(queryForDatabase, connection))
                {

                    if (parameters != null)
                    {
                        // Add the parameters to the command if they are provided
                        command.Parameters.AddRange(parameters);
                    }
                    connection.Open();

                    // Execute the query and populate the DataTable
                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        adapter.Fill(dataTable);
                    }
                }
            }

            return dataTable;
        }
    }
}