using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace JainSanghInformation
{
    public partial class ImageConfiguration : System.Web.UI.Page
    {

        public int UserType;
        public string UserId;
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["JSI"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                UserType = Convert.ToInt32(Session["usertype"].ToString());
                UserId = Session["usrid"].ToString();
                if (UserType != 1)
                {
                    logout(sender, e);
                }
            }
            catch (Exception ex)
            {
                logout(sender, e);
            }
            if (!IsPostBack)
            {
                BindMainMenu();
            }
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

        private void BindMainMenu()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_GetMainMenuListForImage", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        rptMainMenu.DataSource = dt;
                        rptMainMenu.DataBind();
                    }
                }
            }
        }


        protected void btnUpload_Click(object sender, EventArgs e)
        {
            Button btnUpload = (Button)sender;
            int mainMenuId = Convert.ToInt32(btnUpload.CommandArgument);
            RepeaterItem item = (RepeaterItem)btnUpload.NamingContainer;
            FileUpload fileUpload = (FileUpload)item.FindControl("fileUpload");

            if (fileUpload.HasFile)
            {
                // Validate file size (max 2 MB)
                if (fileUpload.PostedFile.ContentLength > 3 * 1024 * 1024)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showWarningNotification", "showWarningNotification('File size exceeds 3 MB.');", true);
                    return;
                }

                // Save file
                string folderPath = Server.MapPath($"~/MenuImages/{mainMenuId}/");
                if (!System.IO.Directory.Exists(folderPath))
                {
                    System.IO.Directory.CreateDirectory(folderPath);
                }

                string originalFileName = Path.GetFileName(fileUpload.PostedFile.FileName);
                string fileExtension = Path.GetExtension(originalFileName);
                string newFileName = $"{mainMenuId}_{DateTime.Now:yyyyMMddHHmmssfff}_{originalFileName}";
                string filePath = Path.Combine(folderPath, newFileName);

                fileUpload.SaveAs(filePath);

                string imageUrl = $"~/MenuImages/{mainMenuId}/{newFileName}";
                SaveImageToDatabase(mainMenuId, imageUrl);
                BindImages(mainMenuId, (GridView)item.FindControl("gvImages"));
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowSuccessNotification",
                        "showSuccessNotification('Image successfully uploaded!');", true);

            }
        }


        private void SaveImageToDatabase(int mainMenuId, string imageUrl)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO MainMenuImages (MainMenuId, ImageURL, ImageSequence, CreatedBy) 
                                 VALUES (@MainMenuId, @ImageURL, @ImageSequence, @CreatedBy)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@MainMenuId", mainMenuId);
                cmd.Parameters.AddWithValue("@ImageURL", imageUrl);
                cmd.Parameters.AddWithValue("@ImageSequence", GetNextSequence(mainMenuId));
                cmd.Parameters.AddWithValue("@CreatedBy", "Admin");

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        private int GetNextSequence(int mainMenuId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT ISNULL(MAX(ImageSequence), 0) + 1 FROM MainMenuImages WHERE MainMenuId = @MainMenuId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@MainMenuId", mainMenuId);

                conn.Open();
                return (int)cmd.ExecuteScalar();
            }
        }

        protected void btnUpdateSequence_Click(object sender, EventArgs e)
        {
            Button btnUpdate = (Button)sender;
            int imageId = Convert.ToInt32(btnUpdate.CommandArgument);
            RepeaterItem item = (RepeaterItem)btnUpdate.NamingContainer;
            TextBox txtSequence = (TextBox)item.FindControl("txtSequence");

            if (int.TryParse(txtSequence.Text, out int sequence))
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "UPDATE MainMenuImages SET ImageSequence = @ImageSequence WHERE Id = @Id";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@ImageSequence", sequence);
                    cmd.Parameters.AddWithValue("@Id", imageId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowSuccessNotification",
                       "showSuccessNotification('Sequence updated successfully!');", true);
                }
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            Button btnDelete = (Button)sender;
            int imageId = Convert.ToInt32(btnDelete.CommandArgument);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT ImageURL FROM MainMenuImages WHERE Id = @Id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", imageId);

                conn.Open();
                string imageUrl = cmd.ExecuteScalar()?.ToString();

                if (!string.IsNullOrEmpty(imageUrl))
                {
                    string filePath = Server.MapPath(imageUrl);
                    if (System.IO.File.Exists(filePath))
                    {
                        System.IO.File.Delete(filePath);
                    }
                }

                query = "DELETE FROM MainMenuImages WHERE Id = @Id";
                cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", imageId);
                cmd.ExecuteNonQuery();
                BindMainMenu();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowSuccessNotification",
                      "showSuccessNotification('Image deleted successfully!');", true);
            }
        }

        protected void rptMainMenu_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                int mainMenuId = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "Id"));
                GridView gvImages = (GridView)e.Item.FindControl("gvImages");
                BindImages(mainMenuId, gvImages);
            }
        }

        private void BindImages(int mainMenuId, GridView gridView)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT Id, ImageURL, ImageSequence FROM MainMenuImages WHERE MainMenuId = @MainMenuId";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                da.SelectCommand.Parameters.AddWithValue("@MainMenuId", mainMenuId);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gridView.DataSource = dt;
                gridView.DataBind();
            }
        }

    }
}