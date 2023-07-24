<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateNewMember.aspx.cs" Inherits="JainSanghInformation.CreateNewMember" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

   
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
            <div class="col-md-8" style="background: #fff;"">
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
    </div>
        </div>
        </div>
    <br />
    <div class="col-lg-12 grid-margin stretch-card">
        <div class="card">
            <div style="width: 100%;">
                <div class="form-row align-items-center">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Select Sangh<label style="color:red;">*</label></label>
                                            <div class="col-sm-7">
                                                <asp:DropDownList ID="ddlsangh"  CssClass="form-control" autocompletemode="Suggest" runat="server" required="required"></asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Member Type<label style="color:red;">*</label></label>
                                            <div class="col-sm-7">
                                                <asp:DropDownList ID="DropDownListMemberType"  CssClass="form-control" autocompletemode="Suggest" runat="server" required="required" onchange="handleDropDownChange(this);"></asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                     <div class="col-md-4" id="divForMemberNameOfParent">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Parent Member Name<label style="color:red;">*</label></label>
                                            <div class="col-sm-7">
                                                <asp:DropDownList ID="DropDownListParentMember"  CssClass="form-control" autocompletemode="Suggest" runat="server" required="required"></asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                   
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Member Name<label style="color:red;">*</label></label>
                                            <div class="col-sm-7">
                                                <asp:TextBox type="text" ID="txtmembername" runat="server" class="form-control" placeholder="Enter Member Name" autocomplete="off" required="required"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">BirthDate</label>
                                            <div class="col-sm-7">
                                                <asp:TextBox type="date" ID="txtbdate" runat="server" class="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Education</label>
                                            <div class="col-sm-7">
                                                <asp:TextBox type="text" ID="txteducation" runat="server" class="form-control" placeholder="Enter Education" autocomplete="off"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Marriage Status</label>
                                            <div class="col-sm-7">
                                                <asp:TextBox type="text" ID="txtmarriagestatus" runat="server" class="form-control" placeholder="Enter Marriage Status" autocomplete="off"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Occupation</label>
                                            <div class="col-sm-7">
                                                <asp:TextBox type="text" ID="txtoccupation" runat="server" class="form-control" placeholder="Enter Occupation" autocomplete="off"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                     <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Village Name</label>
                                            <div class="col-sm-7">
                                                <asp:TextBox type="text" ID="txtvillagename" runat="server" class="form-control" placeholder="Enter Village Name" autocomplete="off"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Address</label>
                                            <div class="col-sm-7">
                                                <textarea id="txtaddress" cols="20" rows="3" runat="server" class="form-control" placeholder="Enter Address" autocomplete="off"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Mobile Number(Primary)</label>
                                            <div class="col-sm-7">
                                                <asp:TextBox type="text" ID="textBoxMobileNumber1" runat="server" class="form-control" placeholder="Enter 10digit MobileNo" MaxLength="10" max="10" onkeypress="return numeric(event)" autocomplete="off"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                     <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Mobile Number(Secondary)</label>
                                            <div class="col-sm-7">
                                                <asp:TextBox type="text" ID="textBoxMobileNumber2" runat="server" class="form-control" placeholder="Enter 10digit MobileNo" MaxLength="10" max="10" onkeypress="return numeric(event)" autocomplete="off"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">BloodGroup</label>
                                            <div class="col-sm-7">
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
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function numeric(evt) {
            var charCode = (evt.which) ? evt.which : eventkeyCode
            if (charCode > 31 && ((charCode >= 48 && charCode <= 57) || charCode == 46))
                return true;
            else {
                alert('Please Enter Numeric values.');
                return false;
            }
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
        $(document).ready(function () {            $("#divForMemberNameOfParent").hide();
        });
    </script>
</asp:Content>
