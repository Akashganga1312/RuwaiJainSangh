using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JainSanghInformation
{
    public partial class LabelPrint : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["JSI"].ConnectionString;
        public int UserType;
        public string UserId;
        protected void Page_Load(object sender, EventArgs e)
        {
            try { 
            UserType = Convert.ToInt32(Session["usertype"].ToString());
            UserId = Session["usrid"].ToString();
            if (UserType != 1)
            {
                logout(sender, e);
            }
            }
            catch {
                logout(sender, e);
            }

            if (!IsPostBack)
            {
                BindSanghDropdown();
                BindMemberTypeDropdown();
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

        private void BindSanghDropdown()
        {
            try
            {
                DataTable dt = ExecuteStoredProcedure("sp_DropDownListSanghList");

                if (dt.Rows.Count > 0)
                {
                    ddlSanghName.DataSource = dt;
                    ddlSanghName.DataTextField = "SanghName";
                    ddlSanghName.DataValueField = "AutoId";
                    ddlSanghName.DataBind();
                }
                ddlSanghName.Items.Insert(0, new ListItem("All", "0"));
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error in BindSanghDropdown: {ex.Message}");
            }
        }

        private void BindMemberTypeDropdown()
        {
            try
            {
                DataTable dt = ExecuteStoredProcedure("sp_DropDownListMember_Type");
                if (dt.Rows.Count > 0)
                {
                    ddlMemberType.DataSource = dt;
                    ddlMemberType.DataTextField = "TextColumn";
                    ddlMemberType.DataValueField = "ValueColumn";
                    ddlMemberType.DataBind();
                }

                ListItem pleaseSelectItem = ddlMemberType.Items.FindByText("--Please Select--");
                if (pleaseSelectItem != null)
                {
                    ddlMemberType.Items.Remove(pleaseSelectItem);
                }


                ddlMemberType.Items.Insert(0, new ListItem("All", "0"));
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error in BindMemberTypeDropdown: {ex.Message}");
            }
        }
        /*
                protected void GridViewData_PageIndexChanging(object sender, GridViewPageEventArgs e)
                {
                    GridViewData.PageIndex = e.NewPageIndex;
                    btnShowData_Click(sender, e); 
                }*/

        protected void btnShowData_Click(object sender, EventArgs e)
        {
            try
            {
                // Initialize query base
                string query = "SELECT SM.SanghName,MM.MemberName,isnull((Select MemberName from MemberMaster where AutoId = MM.ParentRelationId),'') as ParentMemberName,MemberType,Address,isnull(VillageName,'') VillageName FROM MemberMaster MM left Join SanghMaster SM on MM.SanghMasterId = SM.AutoId WHERE 1=1";

                // Handle Sangh selection
                List<string> selectedSanghList = ddlSanghName.Items.Cast<ListItem>()
                    .Where(i => i.Selected).Select(i => i.Value).ToList();
                if (selectedSanghList.Contains("0"))
                {
                    // If "All" is selected, include all Sanghs (no filter applied)
                }
                else if (selectedSanghList.Count > 0)
                {
                    // Filter by selected Sanghs
                    query += " AND MM.SanghMasterId IN (" + string.Join(",", selectedSanghList.Select(id => $"'{id}'")) + ")";
                }

                // Handle Village selection
                string selectedVillages = hfSelectedVillages.Value;
                if (!string.IsNullOrEmpty(selectedVillages) && !selectedVillages.Contains("All"))
                {
                    query += " AND VillageName IN (" + string.Join(",", selectedVillages.Split(',').Select(v => $"'{v}'")) + ")";
                }

                // Handle Member Type selection
                List<string> selectedMemberTypeList = ddlMemberType.Items.Cast<ListItem>()
                    .Where(i => i.Selected).Select(i => i.Text).ToList();
                if (selectedMemberTypeList.Contains("0") || selectedMemberTypeList.Contains("All"))
                {
                    // If "All" is selected, include all Member Types (no filter applied)
                }
                else if (selectedMemberTypeList.Count > 0)
                {
                    // Filter by selected Member Types
                    query += " AND MM.MemberType IN (" + string.Join(",", selectedMemberTypeList.Select(mt => $"'{mt}'")) + ")";
                }
                query += " order by SanghName,VillageName;";
                // Execute the query
                DataTable dt = ExecuteQueryWithParameters(query, null); // No parameters are required as query is built dynamically

                // Bind data to the GridView
                if (dt != null && dt.Rows.Count > 0)
                {
                    string jsonData = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                    ScriptManager.RegisterStartupScript(this, GetType(), "populateTable", $"populateDataTable({jsonData});", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "populateTable", "populateDataTable([]);", true);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error in btnShowData_Click: {ex.Message}");
            }
        }

        public DataTable ExecuteStoredProcedure(string procedureName, SqlParameter[] parameters = null)
        {
            DataTable dt = new DataTable();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(procedureName, conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        if (parameters != null)
                        {
                            cmd.Parameters.AddRange(parameters);
                        }

                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dt);
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                Console.WriteLine($"SQL Exception: {ex.Message}");
                throw;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Exception: {ex.Message}");
                throw;
            }
            return dt;
        }

        public DataTable ExecuteQueryWithParameters(string query, SqlParameter[] parameters)
        {
            DataTable dt = new DataTable();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        if (parameters != null)
                        {
                            cmd.Parameters.AddRange(parameters);
                        }
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dt);
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                Console.WriteLine($"SQL Exception: {ex.Message}");
                throw;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Exception: {ex.Message}");
                throw;
            }
            return dt;
        }


        [System.Web.Services.WebMethod]
        public static List<ListItem> GetVillagesBySangh(List<string> sanghIds)
        {
            List<ListItem> villages = new List<ListItem>();
            string connectionString = ConfigurationManager.ConnectionStrings["JSI"].ConnectionString;
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_GetVillagesBySangh", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@SanghIds", string.Join(",", sanghIds));
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            villages.Add(new ListItem
                            {
                                Value = reader["VillageName"].ToString(),
                                Text = reader["VillageName"].ToString()
                            });
                        }
                        villages.Insert(0, new ListItem("All", "All"));
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error fetching villages: {ex.Message}");
            }
            return villages;
        }

        protected void btnPrintLabels_Click(object sender, EventArgs e)
        {

            // Initialize query base
            string query = "SELECT MM.MemberName,MM.MobileNumber1,Address FROM MemberMaster MM left Join SanghMaster SM on MM.SanghMasterId = SM.AutoId WHERE 1=1";

            // Handle Sangh selection
            List<string> selectedSanghList = ddlSanghName.Items.Cast<ListItem>()
    .Where(i => i.Selected).Select(i => i.Value).ToList();
            if (selectedSanghList.Contains("0"))
            {
                // If "All" is selected, include all Sanghs (no filter applied)
            }
            else if (selectedSanghList.Count > 0)
            {
                // Filter by selected Sanghs
                query += " AND MM.SanghMasterId IN (" + string.Join(",", selectedSanghList.Select(id => $"'{id}'")) + ")";
            }

            // Handle Village selection
            string selectedVillages = hfSelectedVillages.Value;
            if (!string.IsNullOrEmpty(selectedVillages) && !selectedVillages.Contains("All"))
            {
                query += " AND VillageName IN (" + string.Join(",", selectedVillages.Split(',').Select(v => $"'{v}'")) + ")";
            }

            // Handle Member Type selection
            List<string> selectedMemberTypeList = ddlMemberType.Items.Cast<ListItem>()
                .Where(i => i.Selected).Select(i => i.Text).ToList();
            if (selectedMemberTypeList.Contains("0") || selectedMemberTypeList.Contains("All"))
            {
                // If "All" is selected, include all Member Types (no filter applied)
            }
            else if (selectedMemberTypeList.Count > 0)
            {
                // Filter by selected Member Types
                query += " AND MM.MemberType IN (" + string.Join(",", selectedMemberTypeList.Select(mt => $"'{mt}'")) + ")";
            }
            query += " order by SanghName,VillageName;";
            // Execute the query
            DataTable dt = ExecuteQueryWithParameters(query, null);
            // Execute the query

            if (dt != null && dt.Rows.Count > 0)
            {
                GeneratePDF(dt);
            }
            else
            {
                // No data message
                ScriptManager.RegisterStartupScript(this, GetType(), "noDataAlert", "alert('No data found for the selected filters.');", true);
            }

        }


        private void GeneratePDF(DataTable dt)
        {
            try
            {
                // File name and path
                string directoryPath = Server.MapPath("~/GeneratedFiles/");
                string fileName = "AddressLabels.pdf";
                string filePath = Path.Combine(directoryPath, fileName);

                // Ensure the directory exists; create it if not
                if (!Directory.Exists(directoryPath))
                {
                    Directory.CreateDirectory(directoryPath);
                }

                // Create PDF document
                using (FileStream fs = new FileStream(filePath, FileMode.Create, FileAccess.Write, FileShare.None))
                using (iTextSharp.text.Document pdfDoc = new iTextSharp.text.Document(iTextSharp.text.PageSize.A4, 20f, 20f, 20f, 20f))
                using (PdfWriter writer = PdfWriter.GetInstance(pdfDoc, fs))
                {
                    pdfDoc.Open();

                    var boldFont = iTextSharp.text.FontFactory.GetFont(iTextSharp.text.FontFactory.HELVETICA_BOLD, 12, iTextSharp.text.BaseColor.BLACK);
                    var normalFont = iTextSharp.text.FontFactory.GetFont(iTextSharp.text.FontFactory.HELVETICA, 10, iTextSharp.text.BaseColor.BLACK);

                    pdfDoc.Add(new iTextSharp.text.Paragraph("Address Labels", boldFont) { Alignment = iTextSharp.text.Element.ALIGN_CENTER });
                    pdfDoc.Add(new iTextSharp.text.Paragraph("\n")); 

                    PdfPTable table = new PdfPTable(3); // Two columns
                    table.WidthPercentage = 100; // Full width
                    table.DefaultCell.Border = PdfPCell.BODY;
                    table.SpacingBefore = 10f;
                    table.SpacingAfter = 10f;

                    // Add data to the table
                    foreach (DataRow row in dt.Rows)
                    {
                        string memberName = row.Table.Columns.Contains("MemberName") ? row["MemberName"].ToString() : "";
                        string mobileNumber = row.Table.Columns.Contains("MobileNumber1") ? row["MobileNumber1"].ToString() : "";
                        string address = row["Address"].ToString();

                        // Build content
                        var paragraph = new iTextSharp.text.Paragraph();
                        if (!string.IsNullOrEmpty(memberName))
                        {
                            paragraph.Add(new iTextSharp.text.Chunk("Name: ", boldFont));
                            paragraph.Add(new iTextSharp.text.Chunk(memberName + "\n", normalFont));
                        }
                        if (!string.IsNullOrEmpty(mobileNumber))
                        {
                            paragraph.Add(new iTextSharp.text.Chunk("Mob. No.: ", boldFont));
                            paragraph.Add(new iTextSharp.text.Chunk(mobileNumber + "\n", normalFont));
                        }

                        if (!string.IsNullOrEmpty(address))
                        {
                            paragraph.Add(new iTextSharp.text.Chunk("Address.: ", boldFont));
                            paragraph.Add(new iTextSharp.text.Chunk("\n" + address, normalFont));
                        }
                       

                        // Add content to cell
                        PdfPCell cell = new PdfPCell(paragraph)
                        {
                            Border = PdfPCell.BOX, // Single box border
                            Padding = 10,
                            BorderWidth = 1.5f, // Double border simulation
                            PaddingTop = 10,
                            PaddingBottom = 10,
                            PaddingLeft = 10,
                            PaddingRight = 10,
                            BackgroundColor = iTextSharp.text.BaseColor.WHITE
                        };
                        table.AddCell(cell);
                    }

                    // Ensure even columns (add empty cell if needed)
                    if (dt.Rows.Count % 3 != 0)
                    {
                        PdfPCell emptyCell = new PdfPCell(new iTextSharp.text.Paragraph(""))
                        {
                            Border = PdfPCell.NO_BORDER
                        };
                        table.AddCell(emptyCell);
                    }

                    // Add the table to the document
                    pdfDoc.Add(table);

                    pdfDoc.Close();
                }


                // Serve the PDF to the user for download
                Response.ContentType = "application/pdf";
                Response.AppendHeader("Content-Disposition", $"attachment; filename={fileName}");
                Response.TransmitFile(filePath);
                Response.End();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error generating PDF: {ex.Message}");
            }
        }

    }
}