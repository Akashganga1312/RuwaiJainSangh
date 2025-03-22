<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateNewMainMenu.aspx.cs" Inherits="JainSanghInformation.CreateNewMainMenu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
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

        .form-label{
            margin-left:20px;
        }
         .form-control {
     border: 1px solid !important;
         }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
        <div class="page-header text-center">
            <h3 class="page-title">Add New Main Menu</h3>
        </div>
        <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card">
                <div class="card-body">
                    <form>
                        <div class="row g-3"  style="border: 1px; color: #000; background-color: #f8f9fa; padding: 10px; font-size: 16px; margin: 10px;">
                            <div class="col-md-4"  >
                                <label for="txtmenuname" class="form-label">Main Menu Name <span class="text-danger">*</span></label>
                                <asp:TextBox 
                                    ID="txtmenuname" 
                                    runat="server" 
                                    class="form-control" 
                                    placeholder="Enter menu name" 
                                    required="required" />
                            </div>
                            <div class="col-md-4"  >
                                <label for="txtMenuIcon" class="form-label">Menu Icon<span class="text-danger">*</span></label>
                                <asp:TextBox 
                                    ID="txtMenuIcon" 
                                    runat="server" 
                                    class="form-control" 
                                    placeholder="Enter icon (ex. mdi-store)" 
                                    required="required" />
                            </div>
                            <div class="col-md-4 ">
                                <label for="txtMenuDescription" class="form-label">Menu Description Name<span class="text-danger">*</span></label>
                                <asp:TextBox 
                                    ID="txtMenuDescription" 
                                    runat="server" 
                                    class="form-control" 
                                    placeholder="Enter menu description" />
                            </div>
                            <div class="col-md-4 mt-4">
                                <label for="txtpmob" class="form-label">Menu Url</label>
                                <asp:TextBox 
                                    ID="txtpmob" 
                                    runat="server" 
                                    class="form-control" 
                                    placeholder="Enter Url (ex. SanghInformation.aspx)" 
                                    />
                            </div>
                              <div class="col-md-4 mt-4">
                                  <label for="txtMenuSequence" class="form-label">Menu Sequence<span class="text-danger">*</span></label>
                                  <asp:TextBox 
                                      ID="txtMenuSequence" 
                                      runat="server" 
                                      class="form-control" 
                                      placeholder="Enter Menu Sequence (ex. int)" 
                                      />
                              </div>
                            <div class="col-12 text-center mt-4">
                                <asp:Button  ID="btninsert" 
                                    runat="server" 
                                    Text="Save" 
                                    class="btn btn-primary btn-lg px-4" 
                                    OnClick="btninsert_Click" />
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
