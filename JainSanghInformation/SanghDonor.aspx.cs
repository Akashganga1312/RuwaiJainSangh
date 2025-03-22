using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JainSanghInformation
{
    public partial class SanghDonor : System.Web.UI.Page
    {
        public int UserType;
        public string UserId;
        public string ParentMemberId;
        string connectionString = ConfigurationManager.ConnectionStrings["JSI"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int mainMenuId = 6; // Assign the desired MainMenuId
                LoadSanghInformation(mainMenuId);
            }
        }

        private void LoadSanghInformation(int mainMenuId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_GetImagesAndTitleByMenuId", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MainMenuId", mainMenuId);

                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        // Read the first result set (Title)
                        if (reader.Read())
                        {
                            lblTitle.Text = reader["Title"].ToString();
                        }

                        // Read the second result set (Images)
                        if (reader.NextResult())
                        {
                            DataTable dtImages = new DataTable();
                            dtImages.Load(reader);

                            if (dtImages.Rows.Count == 0)
                            {
                                divNoImages.Visible = true;
                                divCarousel.Visible = false;
                                divSingleImage.Visible = false;
                            }
                            else if (dtImages.Rows.Count == 1)
                            {
                                divNoImages.Visible = false;
                                divCarousel.Visible = false;
                                divSingleImage.Visible = true;
                                imgSingle.ImageUrl = ResolveUrl(dtImages.Rows[0]["ImageURL"].ToString());
                            }
                            else
                            {
                                divNoImages.Visible = false;
                                divCarousel.Visible = true;
                                divSingleImage.Visible = false;

                                // Resolve URLs for the carousel images
                                foreach (DataRow row in dtImages.Rows)
                                {
                                    row["ImageURL"] = ResolveUrl(row["ImageURL"].ToString());
                                }

                                rptCarousel.DataSource = dtImages;
                                rptCarousel.DataBind();
                            }
                        }
                    }
                }
            }
        }
    }
}