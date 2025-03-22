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
using DocumentFormat.OpenXml.Spreadsheet;

namespace JainSanghInformation
{
    public partial class ActivityPage : System.Web.UI.Page
    {
        public int UserType;
        public string UserId;
        string connectionString = ConfigurationManager.ConnectionStrings["JSI"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            UserType = Convert.ToInt32(Session["usertype"].ToString());
            UserId = Session["usrid"].ToString();
            if (UserType != 1)
            {
                logout(sender, e);
            }
            if (!IsPostBack)
            {
                BindGrid();
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

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_GetAllActivities", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string backgroundImageUrl = "";

            if (fileBackgroundImage.HasFile)
            {
                // Validate file size (max 3 MB)
                if (fileBackgroundImage.PostedFile.ContentLength > 3 * 1024 * 1024)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showWarningNotification", "showWarningNotification('File size exceeds 3 MB.');", true);
                    return;
                }
                // Save file
                string folderPath = Server.MapPath("~/UploadedImages/");
                if (!System.IO.Directory.Exists(folderPath))
                {
                    System.IO.Directory.CreateDirectory(folderPath);
                }

                string fileName = Path.GetFileName(fileBackgroundImage.PostedFile.FileName);
                string filePath = Path.Combine(folderPath, fileName);
                fileBackgroundImage.SaveAs(filePath);

                backgroundImageUrl = "~/UploadedImages/" + fileName;

            }

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_InsertActivity", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@BackgroundColor", txtBackgroundColor.Text);
                    cmd.Parameters.AddWithValue("@TitleColor", txtTitleColor.Text);
                    cmd.Parameters.AddWithValue("@BackgroundImageUrl", backgroundImageUrl);
                    cmd.Parameters.AddWithValue("@LinkUrl", txtLinkUrl.Text);
                    cmd.Parameters.AddWithValue("@Title", txtTitle.Text);
                    cmd.Parameters.AddWithValue("@Icon", txtIcon.Text);
                    cmd.Parameters.AddWithValue("@CreatedBy", "superadmin");
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowSuccessNotification", "showSuccessNotification('Successfully saved!');", true);
            BindGrid();
        }
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_DeleteActivity", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ID", id);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            BindGrid();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            if (GridView1.DataKeys[e.RowIndex] == null)
            {
                throw new Exception("DataKeys is null at the specified index. Check DataKeyNames in GridView.");
            }

            int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            GridViewRow row = GridView1.Rows[e.RowIndex];

            string backgroundColor = (row.Cells[1].Controls[0] as TextBox)?.Text.Trim();
            string titleColor = (row.Cells[2].Controls[0] as TextBox)?.Text.Trim();
            string linkUrl = (row.Cells[4].Controls[0] as TextBox)?.Text.Trim();
            string title = (row.Cells[5].Controls[0] as TextBox)?.Text.Trim();
            string icon = (row.Cells[6].Controls[0] as TextBox)?.Text.Trim() ?? "default-icon"; 

            string oldBackgroundImageUrl = (row.FindControl("lblOldImageUrl") as Label)?.Text;
            string newBackgroundImageUrl = oldBackgroundImageUrl;

            FileUpload fileUpload = row.FindControl("fileUploadControl") as FileUpload;
            if (fileUpload != null && fileUpload.HasFile)
            {
                if (fileUpload.PostedFile.ContentLength > 3 * 1024 * 1024)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showWarningNotification", "showWarningNotification('File size exceeds 3 MB.');", true);
                    return;
                }

                string folderPath = Server.MapPath("~/UploadedImages/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string newFileName = Path.GetFileName(fileUpload.PostedFile.FileName);
                string newFilePath = Path.Combine(folderPath, newFileName);

                fileUpload.SaveAs(newFilePath);

                newBackgroundImageUrl = "~/UploadedImages/" + newFileName;

                if (!string.IsNullOrEmpty(oldBackgroundImageUrl))
                {
                    string oldFilePath = Server.MapPath(oldBackgroundImageUrl);
                    if (File.Exists(oldFilePath))
                    {
                        File.Delete(oldFilePath);
                    }
                }
            }

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_UpdateActivity", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@ID", id);
                    cmd.Parameters.AddWithValue("@BackgroundColor", backgroundColor);
                    cmd.Parameters.AddWithValue("@TitleColor", titleColor);
                    cmd.Parameters.AddWithValue("@BackgroundImageUrl", newBackgroundImageUrl);
                    cmd.Parameters.AddWithValue("@LinkUrl", linkUrl);
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Icon", icon);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowSuccessNotification", "showSuccessNotification('Successfully saved!');", true);
                    con.Close();
                }
            }

            GridView1.EditIndex = -1;
            BindGrid();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            BindGrid();
        }
        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            BindGrid();
        }

    }
}