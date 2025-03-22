<%@ Page Title="Create New Sangh" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateNewSangh.aspx.cs" Inherits="JainSanghInformation.CreateNewSangh" %>
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
            <h3 class="page-title">Add New Sangh</h3>
        </div>
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="card">
                    <div class="card-body">
                        <form>
                            <div class="row g-3"  style="border: 1px solid #000; color: #000; background-color: #f8f9fa; padding: 10px; font-size: 16px; margin: 10px;">
                                <div class="col-md-6"  >
                                    <label for="txtsname" class="form-label">Sangh Name <span class="text-danger">*</span></label>
                                    <asp:TextBox 
                                        ID="txtsname" 
                                        runat="server" 
                                        class="form-control" 
                                        placeholder="Enter Sangh Name" 
                                        required="required" />
                                </div>
                                <div class="col-md-6"  >
                                    <label for="txtlocn" class="form-label">Location <span class="text-danger">*</span></label>
                                    <asp:TextBox 
                                        ID="txtlocn" 
                                        runat="server" 
                                        class="form-control" 
                                        placeholder="Enter Location" 
                                        required="required" />
                                </div>
                                <div class="col-md-6 mt-4">
                                    <label for="txtpname" class="form-label">President Name</label>
                                    <asp:TextBox 
                                        ID="txtpname" 
                                        runat="server" 
                                        class="form-control" 
                                        placeholder="Enter President Name" />
                                </div>
                                <div class="col-md-6 mt-4">
                                    <label for="txtpmob" class="form-label">President MobileNo.</label>
                                    <asp:TextBox 
                                        ID="txtpmob" 
                                        runat="server" 
                                        class="form-control" 
                                        placeholder="Enter Mobile Number" 
                                        maxlength="10" 
                                        onkeypress="return numeric(event)" />
                                </div>
                                <div class="col-12 text-center mt-4">
                                    <asp:Button 
                                        ID="btninsert" 
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

</asp:Content>
