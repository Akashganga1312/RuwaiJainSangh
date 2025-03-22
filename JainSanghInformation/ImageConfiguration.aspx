<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ImageConfiguration.aspx.cs" Inherits="JainSanghInformation.ImageConfiguration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Image Configuration</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css" />
    <style>
        .image-card {
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            border: none;
            border-radius: 8px;
            margin-bottom: 16px;
        }
        .card-header {
            background-color: #007bff;
            color: #000000;
            font-weight: bold;
        }
        .note {
            font-size: 0.85rem;
            color: #FF0000;
            margin-top: 10px;
        }
        .grid-container {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }
        .upload-section {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .upload-section .form-control {
            flex: 1;
        }
    </style>
    <script type="text/javascript">
        function validateFileUpload(fileUploadId) {
            const fileUpload = document.getElementById(fileUploadId);
            if (!fileUpload || !fileUpload.files || fileUpload.files.length === 0) {
                alert("Please select an image before clicking Upload.");
                return false;
            }
            return true;
        }

        function confirmDelete() {
            return confirm("Are you sure you want to delete this image?");
        }

        function showSuccessNotification(message) {
            toastr.success(message, "Success", { timeOut: 5000, closeButton: true, progressBar: true });
        }

        function showErrorNotification(message) {
            toastr.error(message, "Error", { timeOut: 5000, closeButton: true, progressBar: true });
        }

        function showInfoNotification(message) {
            toastr.info(message, "Info", { timeOut: 5000, closeButton: true, progressBar: true });
        }

        function showWarningNotification(message) {
            toastr.warning(message, "Warning", { timeOut: 5000, closeButton: true, progressBar: true });
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server"></asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <h2 class="mb-4">Image Configuration</h2>
        <div class="grid-container">
            <asp:Repeater ID="rptMainMenu" runat="server" OnItemDataBound="rptMainMenu_ItemDataBound">
                <ItemTemplate>
                    <div class="card image-card">
                        <div class="card-header text-center">
                            <%# Eval("MenuName") %>
                        </div>
                        <div class="card-body">
                            <div class="upload-section mb-3">
                                <asp:FileUpload ID="fileUpload" runat="server" CssClass="form-control" />
                                <asp:Button ID="btnUpload" runat="server" Text="Upload" CssClass="btn btn-primary" CommandArgument='<%# Eval("Id") %>' OnClientClick='<%# "return validateFileUpload(\"" + ((FileUpload)Container.FindControl("fileUpload")).ClientID + "\");" %>' OnClick="btnUpload_Click" />
                            </div>
                            <div class="note">
                                <%# Eval("MenuNoteImage").ToString().Replace("\\n", "<br/>") %>
                            </div>
                            <asp:GridView ID="gvImages" runat="server" CssClass="table table-bordered table-hover table-primary" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="Id" HeaderText="Image ID"/>
                                    <asp:ImageField DataImageUrlField="ImageURL" HeaderText="Image" ControlStyle-Width="100px" ControlStyle-Height="75px" />
                                    <asp:TemplateField HeaderText="Sequence">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtSequence" runat="server" Text='<%# Eval("ImageSequence") %>' CssClass="form-control form-control-sm" Width="50px" />
                                            <asp:Button ID="btnUpdateSequence" runat="server" Text="Update" CssClass="btn btn-success btn-sm mt-1" CommandArgument='<%# Eval("Id") %>' OnClick="btnUpdateSequence_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Actions">
                                        <ItemTemplate>
                                            <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm" CommandArgument='<%# Eval("Id") %>' OnClientClick="return confirmDelete();" OnClick="btnDelete_Click" />
                                            <asp:HyperLink ID="hlDownload" runat="server" NavigateUrl='<%# Eval("ImageURL") %>' Text="View full" CssClass="btn btn-info btn-sm" Target="_blank" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
