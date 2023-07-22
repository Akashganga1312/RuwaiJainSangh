<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateNewSangh.aspx.cs" Inherits="JainSanghInformation.CreateNewSangh" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <div class="page-header">
        <h3 class="page-title">Add New Sangh</h3>
    </div>
   
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
                                            <label class="col-sm-4 col-form-label text-right">Sangh Name<sup style="color:red;">*</sup></label>
                                            <div class="col-sm-8">
                                                 <asp:TextBox type="text" ID="txtsname" runat="server" class="form-control" placeholder="Enter sname" autocomplete="off" required="required"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-4 col-form-label text-right">Location<label style="color:red;">*</label></label>
                                            <div class="col-sm-8">
                                               <asp:TextBox type="text" ID="txtlocn" runat="server" class="form-control" placeholder="Enter Location" autocomplete="off" required="required"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                      <div class="col-md-4">
                            <div class="form-group row">
                                <label class="col-sm-4 col-form-label text-right">President Name</label>
                                <div class="col-sm-8">
                                    <asp:TextBox type="text" ID="txtpname" runat="server" class="form-control" placeholder="Enter President Name" autocomplete="off"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group row">
                                <label class="col-sm-4 col-form-label text-right">President MobileNo.</label>
                                <div class="col-sm-8">
                                    <asp:TextBox type="text" ID="txtpmob" runat="server" class="form-control" placeholder="Enter President MobileNo." autocomplete="off" MaxLength="10" onkeypress="return numeric(event)"></asp:TextBox>
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
   </script>
</asp:Content>
