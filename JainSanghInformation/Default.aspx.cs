using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JainSanghInformation
{
    public partial class _Default : Page
    {
        public int UserType;
        public string UserId;
        string connectionString = ConfigurationManager.ConnectionStrings["JSI"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                UserType = Convert.ToInt32(Session["usertype"].ToString());
                UserId = Session["usrid"].ToString();
                if (!IsPostBack)
                {
                    int mainMenuId = 1;
                    LoadSanghInformation(mainMenuId);
                }
            }
            catch (Exception ex)
            {
                
            }
            BindDynamicGroupedData();
            Summary();
        }

        private void BindDynamicGroupedData()
        {
            string userType = Session["usertype"]?.ToString();
            string userId = Session["usrid"]?.ToString();
            var cardData = new List<dynamic>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_GetDashboardData", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    // Add parameters
                    cmd.Parameters.AddWithValue("@UserId", string.IsNullOrEmpty(userId) ? (object)DBNull.Value : userId);
                    cmd.Parameters.AddWithValue("@UserType", string.IsNullOrEmpty(userType) ? (object)DBNull.Value : userType);
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            cardData.Add(new
                            {
                                MainTitle = reader["MainTitle"].ToString(),
                                CardTitle = reader["CardTitle"].ToString(),
                                SubTitle1 = reader["SubTitle1"].ToString(),
                                Number1 = Convert.ToInt32(reader["Number1"]),
                                SubTitle2 = reader["SubTitle2"].ToString(),
                                Number2 = Convert.ToInt32(reader["Number2"]),
                                BackgroundColor = reader["BackgroundColor"].ToString(),
                                TextColor = reader["TextColor"].ToString(),
                                IconClass = reader["IconClass"].ToString()
                            });
                        }
                    }
                }
            }

            // Group by MainTitle
            var groupedData = cardData
                .GroupBy(x => x.MainTitle)
                .Select(group => new
                {
                    MainTitle = group.Key,
                    Cards = group.ToList()
                })
                .ToList();

            // Bind to outer repeater
            rptSections.DataSource = groupedData;
            rptSections.DataBind();
        }

        

        protected void logout(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Session.RemoveAll();
            UserType = 0;
            UserId = string.Empty;
            Response.Redirect("Default.aspx");
        }


        private void Summary()
        {
            string constr = ConfigurationManager.ConnectionStrings["JSI"].ConnectionString;
            SqlConnection sqlCon = new SqlConnection(constr);
            sqlCon.Open();

            string query1 = "select COUNT(*) from SanghMaster where IsDelete = 0";
            SqlCommand sqlCmd1 = new SqlCommand(query1, sqlCon);
            Int32 sanghcount = (Int32)sqlCmd1.ExecuteScalar();
            totalsangh.Text = sanghcount.ToString();

            string query2 = "select count(MemberName) from MemberMaster where MemberType='Self' AND IsDelete=0";
            SqlCommand sqlCmd2 = new SqlCommand(query2, sqlCon);
            Int32 membercount = (Int32)sqlCmd2.ExecuteScalar();
            totalmember.Text = membercount.ToString();

            string query3 = "select COUNT(*) from MemberMaster where IsDelete = 0";
            SqlCommand sqlCmd3 = new SqlCommand(query3, sqlCon);
            Int32 sabhyocount = (Int32)sqlCmd3.ExecuteScalar();
            totalsabhyo.Text = sabhyocount.ToString();
            
            sqlCon.Close();
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