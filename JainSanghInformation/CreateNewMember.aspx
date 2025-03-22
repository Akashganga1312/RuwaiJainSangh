<%@ Page Title="Create New Member" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateNewMember.aspx.cs" Inherits="JainSanghInformation.CreateNewMember" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
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
            background-image: linear-gradient(white, white), linear-gradient(to right, #6a11cb, #2575fc);
            background-origin: border-box;
            background-clip: padding-box, border-box;
            padding: 8px 12px;
            border-radius: 4px;
            font-size: 16px;
            outline: none;
            margin-left: 15px;
            margin-right: 15px;
            transition: box-shadow 0.3s ease, border-color 0.3s ease;
            color: black !important;
        }

            .form-control:focus {
                border-color: transparent;
                box-shadow: 0 0 5px rgba(58, 123, 213, 0.6);
                background-image: linear-gradient(white, white), linear-gradient(to right, #ff512f, #dd2476);
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="page-header">
        <h3 class="page-title">Add New Member</h3>
    </div>
     <div class="col-12">
    <div class="card">
        <div class="card-body">
            <div class="col-12" style="background: #fff;"">
                <div class="row" style="justify-content:space-between;display:flex;">
                    <div class="column">
                    <span style="border-left: 5px solid #4e73df;padding-left: 15px;height:20px;">Download Excel Format:</span>
                      
                      <a href="excelfile/MemberMaster.xlsx" download=""><img src="assets/images/excel.png" style="margin-top:-8px;" width="40" height="40" title="Download Excel format" alt="excel"></a>
                          </div>
                    <div class="column">
                    <span style="border-left: 5px solid #4e73df;padding-left: 15px;height:20px;">Upload Excel File:</span>
                    <asp:FileUpload ID="filupl" runat="server" accept=".xlsx"/>
                        </div>
                    <div class="column">
                    <asp:Button ID="btnupload" runat="server" Text="Upload" Class="btn btn-lg btn-primary  font font-weight-medium auth-form-btn" OnClick="btnupload_Click" UseSubmitBehavior="false" />
                        </div>
                </div>
             </div>
                               <div class="row "  style="border: 1px solid #000; color: #000; background-color: #f8f9fa; padding: 10px; font-size: 16px; margin: 10px; margin-top:50px!important">
                     <div class="col-md-4">
                       <div class="form-group row">
                           <label for="ddlsangh" class="form-label">Select Sangh<label style="color:red;">*</label></label>
                           <asp:DropDownList ID="ddlsangh"  CssClass="form-control" autocompletemode="Suggest" runat="server" required="required"></asp:DropDownList>
                       </div>
                      </div>
                        <div class="col-md-4">
                            <div class="form-group row">
                                <label for="DropDownListMemberType"  class="form-label">Member Type<label style="color:red;">*</label></label>
                                    <asp:DropDownList ID="DropDownListMemberType"  CssClass="form-control" autocompletemode="Suggest" runat="server" required="required" onchange="handleDropDownChange(this);"></asp:DropDownList>
                            </div>
                        </div>
                         <div class="col-md-4" id="divForMemberNameOfParent" >
                            <div class="form-group row">
                                <label for="DropDownListParentMember"  class="form-label">Parent Member Name<label style="color:red;">*</label></label>
                                    <asp:DropDownList ID="DropDownListParentMember"  CssClass="form-control" autocompletemode="Suggest" runat="server" required="required"></asp:DropDownList>
                            </div>
                        </div>

                        <div class="col-md-4" >
                            <div class="form-group row">
                                <label class="form-label">Member Name<label style="color:red;">*</label></label>
                                    <asp:TextBox type="text" ID="txtmembername" runat="server" class="form-control" placeholder="Enter Member Name" autocomplete="off" required="required"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group row">
                                <label class="form-label">Gender<span class="text-danger">*</span></label>
                                <asp:DropDownList ID="ddlGender" runat="server" class="form-control">
                                    <asp:ListItem Text="Male" Selected="true"></asp:ListItem>
                                    <asp:ListItem Text="Female"></asp:ListItem>
                                    <asp:ListItem Text="Other"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group row">
                                <label class="form-label">BirthDate</label>
                                    <asp:TextBox type="date" ID="txtbdate" runat="server" class="form-control"></asp:TextBox>
                            </div>
                        </div>
                                   <div class="col-md-4">
    <div class="form-group row">
        <label class="form-label">Email</label>
            <asp:TextBox type="email" ID="txtEmailAddress"  placeholder="Enter valid email address" runat="server" class="form-control"></asp:TextBox>
         <span id="emailError" style="color: red; display: none;">Please enter a valid email address.</span>
    </div>
</div>
                        <div class="col-md-4">
                            <div class="form-group row">
                                <label class="form-label">Education</label>
                                    <asp:TextBox type="text" ID="txteducation" runat="server" class="form-control" placeholder="Enter Education" autocomplete="off"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group row">
                                <label class="form-label">Marriage Status</label>
                                    <asp:TextBox type="text" ID="txtmarriagestatus" runat="server" class="form-control" placeholder="Enter Marriage Status" autocomplete="off"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group row">
                                <label class="form-label">Occupation</label>
                                    <asp:TextBox type="text" ID="txtoccupation" runat="server" class="form-control" placeholder="Enter Occupation" autocomplete="off"></asp:TextBox>
                            </div>
                        </div>
                                     <div class="col-md-4">
      <div class="form-group row">
          <label class="form-label">Occupation Address</label>
              <textarea id="txtOccupationAddress" cols="20" rows="3" runat="server" class="form-control" placeholder="Enter occupation address" autocomplete="off"></textarea>
      </div>
  </div>
                         <div class="col-md-4">
                            <div class="form-group row">
                                <label class="form-label">Native Place</label>
                                    <asp:TextBox type="text" ID="txtvillagename" runat="server" class="form-control" placeholder="Enter Native Name" autocomplete="off"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group row">
                                <label class="form-label">Address</label>
                                    <textarea id="txtaddress" cols="20" rows="3" runat="server" class="form-control" placeholder="Enter Address" autocomplete="off"></textarea>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group row">
                                <label class="form-label">Mobile Number(Primary)</label>
                                    <asp:TextBox type="text" ID="textBoxMobileNumber1" runat="server" class="form-control" placeholder="Enter MobileNo" MaxLength="25" onkeypress="return validatePhoneNumber(event)" autocomplete="off"></asp:TextBox>
                            </div>
                        </div>
                         <div class="col-md-4">
                            <div class="form-group row">
                                <label class="form-label">Mobile Number(Secondary)</label>
                                    <asp:TextBox type="text" ID="textBoxMobileNumber2" runat="server" class="form-control" placeholder="Enter MobileNo" MaxLength="25" onkeypress="return validatePhoneNumber(event)"  autocomplete="off"></asp:TextBox>
                            </div>
                        </div>
<div class="col-md-4">
    <div class="form-group row">
        <label class="form-label">Blood Group</label>
            <asp:DropDownList ID="ddlbloodgrup" runat="server" class="form-control">
 <asp:ListItem Text="--Please select--"></asp:ListItem>
 <asp:ListItem Text="A+"></asp:ListItem>
 <asp:ListItem Text="A-"></asp:ListItem>
 <asp:ListItem Text="B+"></asp:ListItem>
 <asp:ListItem Text="B-"></asp:ListItem>
 <asp:ListItem Text="O+"></asp:ListItem>
 <asp:ListItem Text="O-"></asp:ListItem>
 <asp:ListItem Text="AB+"></asp:ListItem>
 <asp:ListItem Text="AB-"></asp:ListItem>
            </asp:DropDownList>
    </div>
</div>
<div class="form-group col-md-12">
    <div class="col-md-offset-2 col-md-12" align="center">
        <asp:Button ID="btninsert" runat="server" Text="Save" Class="btn btn-lg btn-primary col-sm-2 font font-weight-medium auth-form-btn" OnClick="btninsert_Click" />
    </div>
</div>
               </div>
    </div>
        </div>
         </div>


     <script>
         document.getElementById('<%= txtEmailAddress.ClientID %>').addEventListener('blur', function () {
             const emailInput = this.value.trim();
             const errorSpan = document.getElementById('emailError');
             const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

             if (!emailInput || !emailPattern.test(emailInput)) {
                 errorSpan.style.display = 'inline';
             } else {
                 errorSpan.style.display = 'none';
             }
         });
     </script>

    <script type="text/javascript">
        function validatePhoneNumber(evt) {
            var input = String.fromCharCode(evt.which || evt.keyCode);

            // Regular expression to allow valid phone number characters
            var phoneNumberPattern = /^[0-9()+\s]*$/;

            // Allow backspace, delete, and arrow keys
            if (evt.key === "Backspace" || evt.key === "Delete" || evt.key.startsWith("Arrow")) {
                return true;
            }

            // Check if the input matches the pattern for valid characters
            if (!phoneNumberPattern.test(input)) {
                alert("Please enter a valid phone number (digits, +, (), and spaces are allowed).");
                return false;
            }

            return true;
        }


        function showSuccessNotification(message) {
            toastr.success(message, "Success", { timeOut: 8000, closeButton: true, progressBar: true });
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

        function handleDropDownChange(dropDownList) {
            var selectedValue = dropDownList.value;

            // Hide all divs
            $("#divForMemberNameOfParent").hide();

            // Show the selected div based on the selected value
            if (selectedValue === "0") {
                $("#divForMemberNameOfParent").hide();
            } else if (selectedValue === "1") {
                $("#divForMemberNameOfParent").hide();
            } else {
                $("#divForMemberNameOfParent").show();
            }
        }
    </script>
    
    <script type="text/javascript">
        $(document).ready(function () {
            $("#divForMemberNameOfParent").hide();
        });
    </script>
</asp:Content>
