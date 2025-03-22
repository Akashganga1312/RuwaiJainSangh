using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace JainSanghInformation
{
    public partial class ActivitiesPerformed : System.Web.UI.Page
    {

        string connectionString = ConfigurationManager.ConnectionStrings["JSI"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadActivities();
            }
        }

        private void LoadActivities()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("sp_GetActivities", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    connection.Open();

                    SqlDataReader reader = command.ExecuteReader();
                    DataTable activities = new DataTable();
                    activities.Load(reader);

                    // Process data to ensure valid URLs
                    foreach (DataRow row in activities.Rows)
                    {
                        // Resolve relative URL for images
                        string imageUrl = row["BackgroundImageUrl"].ToString();
                        row["BackgroundImageUrl"] = ResolveUrl(imageUrl);

                        // Validate Link URL
                        string linkUrl = row["LinkUrl"].ToString();
                        if (!Uri.IsWellFormedUriString(linkUrl, UriKind.Absolute))
                        {
                            row["LinkUrl"] = "#"; // Default to '#' if the URL is invalid
                        }
                    }

                    // Bind data to Repeater
                    ActivitiesRepeater.DataSource = activities;
                    ActivitiesRepeater.DataBind();
                }
            }
        }
    }
}