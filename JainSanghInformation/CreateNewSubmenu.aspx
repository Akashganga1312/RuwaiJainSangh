<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateNewSubmenu.aspx.cs" Inherits="JainSanghInformation.CreateNewSubmenu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .btn-primary {
            background-color: #4e73df;
            border: none;
            transition: background-color 0.3s ease;
        }

            .btn-primary:hover {
                background-color: #3751ab;
            }

        .form-control:focus {
            border-color: #4e73df;
            box-shadow: 0 0 5px rgba(78, 115, 223, 0.5);
        }

        .form-label {
            margin-left: 20px;
        }

        .form-control {
            border: 1px solid !important;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
        <div class="page-header text-center">
        <h3 class="page-title">Add New Submenu</h3>
        </div>
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="card">
                    <div class="card-body">
                        <form>
                            <div class="row g-3" style="border: 1px; color: #000; background-color: #f8f9fa; padding: 10px; font-size: 16px; margin: 10px;">
                               <div class="col-md-4">
                                    <label for="txtSubMenuName" class="form-label">Submenu Name <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtSubMenuName" runat="server" class="form-control" placeholder="Enter submenu name" required="required" />
                                </div>
                                <div class="col-md-4">
                                    <label for="txtSubMenuLevel" class="form-label">Submenu Level <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtSubMenuLevel" runat="server" class="form-control" placeholder="Enter submenu level" required="required" />
                                </div>
                                <div class="col-md-4">
                                    <label for="txtSubMenuIcon" class="form-label">Submenu Icon <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtSubMenuIcon" runat="server" class="form-control" placeholder="Enter icon (e.g., mdi-settings)" required="required" />
                                </div>
                                <div class="col-md-4">
                                    <label for="txtSubMenuDescription" class="form-label">Submenu Description<span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtSubMenuDescription" runat="server" class="form-control" placeholder="Enter description" />
                                </div>
                                <div class="col-md-4">
                                    <label for="txtSubMenuURL" class="form-label">Submenu URL<span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtSubMenuURL" runat="server" class="form-control" placeholder="Enter URL (e.g., SubMenuPage.aspx)" />
                                </div>
                                <div class="col-md-4">
                                    <label for="ddlMainMenu" class="form-label">Main Menu <span class="text-danger">*</span></label>
                                    <asp:DropDownList ID="ddlMainMenu" runat="server" class="form-control" />
                                </div>
                                <div class="col-md-4">
                                    <label for="txtSubMenuSequence" class="form-label">Submenu Sequence <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtSubMenuSequence" runat="server" class="form-control" placeholder="Enter sequence number" />
                                </div>
                                <div class="col-12 text-center mt-4">
                                    <asp:Button ID="btnInsert" runat="server" Text="Save" class="btn btn-primary btn-lg px-4" OnClick="btninsert_Click" />
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript">
        function numeric(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode;
            if (charCode > 31 && (charCode >= 48 && charCode <= 57)) {
                return true;
            } else {
                alert('Please Enter Numeric values.');
                return false;
            }
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

    <script type="text/javascript">
        $(document).ready(function () {
        });
    </script>
</asp:Content>
