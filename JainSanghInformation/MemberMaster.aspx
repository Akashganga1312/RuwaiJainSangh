<%@ Page Title="સભ્યો ની માહિતી" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MemberMaster.aspx.cs" Inherits="JainSanghInformation.MemberMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }

        .page-title {
            font-size: 1.8rem;
            font-weight: bold;
            color: #4e73df;
            margin-bottom: 20px;
        }

        .card {
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .card-body {
            padding: 20px;
        }

        .btn {
            background-color: #4e73df;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 0.9rem;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

            .btn:hover {
                background-color: #3751ab;
            }

        .form-control {
            border: 1px solid #ced4da;
            border-radius: 5px;
            padding: 10px;
            font-size: 0.9rem;
            color: #495057;
        }

            .form-control:focus {
                border-color: #4e73df;
                box-shadow: 0 0 5px rgba(78, 115, 223, 0.5);
            }

        .table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

            .table th, .table td {
                text-align: left;
                padding: 12px;
                border: 1px solid #ddd;
            }

            .table th {
                background-color: #707da3;
                color: white;
            }

        .mask {
            position: fixed;
            left: 0;
            top: 0;
            z-index: 10000;
            background-color: rgba(0, 0, 0, 0.8);
            width: 100%;
            height: 100%;
            display: none;
        }


        .panelDesign {
            z-index: 14000;
            position: relative;
            top: 0%;
            right: 0%;
            left: 0%;
            display: none;
            width: auto;
            background: white;
            overflow: auto;
            border-radius: 8px;
            margin: 20px;
            box-shadow: 0 3px 5px rgb(51 83 229 / 91%);
        }

        @media (max-width: 768px) {
            .page-title {
                font-size: 1.5rem;
            }

            .btn {
                font-size: 0.8rem;
                padding: 8px 15px;
            }

            .form-control {
                font-size: 0.8rem;
                padding: 8px;
            }

            .table th, .table td {
                font-size: 0.8rem;
                padding: 8px;
            }
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
        <h3 class="page-title">સભ્યો ની માહિતી</h3>
    </div>
    <div class="col-12" id="maindiv" runat="server">
        <div class="card">
            <div class="card-body">
                <div class="col-md-8">
                    <div class="row" style="justify-content: space-between;">
                        <a href="CreateNewMember.aspx" class="btn">Create New</a>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <br />
    <div class="col-lg-12 grid-margin stretch-card">
        <div class="card" id="gridViewMainData">
            <div style="width: 100%; height: auto;">
                <div class="card">
                    <div class="card-body">
                        <div style="width: 100%;">
                            <asp:GridView ID="GridView2" runat="server" DataKeyNames="AutoId" class="table table-bordered" OnRowCommand="GridViewData_RowCommand" Style="width: 100% !important;" OnRowDataBound="GridView2_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="Actions">
                                        <ItemTemplate>
                                            <asp:LinkButton Text="Edit" runat="server" CssClass="Edit font-weight-bold btn btn-xs btn-primary" CommandName="ShowPopup" CommandArgument="<%# Container.DataItemIndex %>" />
                                            |
                                             <asp:LinkButton Text="Delete" runat="server" CssClass="Delete font-weight-bold btn btn-xs btn-danger" OnClientClick='<%# "confirmDelete(\"" + Container.DataItemIndex + "\", \"" + Eval("AutoId") + "\"); return false;" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div style="width: 100%">
    </div>

    <div id="mask" class="mask">
    </div>

    <asp:Panel ID="pnlpopup" runat="server" class="panelDesign" style="margin-top: -50px;">
        <div class="container">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title text-center">Update Member Details</h4>
                    <asp:Label ID="id" runat="server" Style="display: none"></asp:Label>
                    <form>
                        <div class="row g-3">
                            <div class= "col-md-4">
                                <label for="ddlsangh" class="form-label">Select Sangh<span class="text-danger">*</span></label>
                                <asp:DropDownList ID="ddlsangh" CssClass="form-control" runat="server" required="required"></asp:DropDownList>
                            </div>
                            <div class="col-md-4">
                                <label for="DropDownListMemberType" class="form-label">Member Type <span class="text-danger">*</span></label>
                                <asp:DropDownList ID="DropDownListMemberType" CssClass="form-control" runat="server" onchange="handleDropDownChange();" required="required"></asp:DropDownList>
                            </div>
                            <div class="col-md-4" id="divForMemberNameOfParent" runat="server">
                                <label for="DropDownListParentMember" class="form-label">Parent Member Name <span class="text-danger">*</span></label>
                                <asp:DropDownList ID="DropDownListParentMember" CssClass="form-control" runat="server" required="required"></asp:DropDownList>
                            </div>
                            <div class="col-md-4">
                                <label for="txtmembername" class="form-label">Member Name</label>
                               <asp:TextBox type="text" ID="txtmembername" runat="server" class="form-control" placeholder="Enter Member Name" autocomplete="off" required="required"></asp:TextBox>
                            </div>
                             <div class="col-md-4">
         <label class="form-label">Gender<span class="text-danger">*</span></label>
         <asp:DropDownList ID="ddlGender" runat="server" class="form-control">
             <asp:ListItem Text="Male" Selected="true"></asp:ListItem>
             <asp:ListItem Text="Female"></asp:ListItem>
             <asp:ListItem Text="Other"></asp:ListItem>
         </asp:DropDownList>
 </div>
                             <div class="col-md-4">
                                 <label for="txtbdate" class="form-label">BirthDate</label>
                                  <asp:TextBox type="date" ID="txtbdate" runat="server" class="form-control"></asp:TextBox>
                             </div>
                                                               <div class="col-md-4">
        <label class="form-label">Email</label>
            <asp:TextBox type="email" ID="txtEmailAddress"  placeholder="Enter valid email address" runat="server" class="form-control"></asp:TextBox>
         <span id="emailError" style="color: red; display: none;">Please enter a valid email address.</span>
</div>
                            <div class="col-md-4">
                                <label for="txteducation" class="form-label">Education</label>
                                <asp:TextBox ID="txteducation" runat="server" class="form-control" placeholder="E mt-4nter Education"></asp:TextBox>
                            </div>
                            <div class="col-md-4">
                                <label for="txtmarriagestatus" class="form-label">Marriage Status</label>
                                <asp:TextBox type="text" ID="txtmarriagestatus" runat="server" class="form-control" placeholder="Enter Marriage Status" autocomplete="off"></asp:TextBox>
                            </div>
                            <div class="col-md-4">
                                     <label class="form-label">Occupation</label>
                                     <asp:TextBox type="text" ID="txtoccupation" runat="server" class="form-control" placeholder="Enter Occupation" autocomplete="off"></asp:TextBox>
                              </div>
                            <div class="col-md-4">
                                    <label class="form-label">Occupation Address</label>
                                    <textarea id="txtOccupationAddress" cols="20" rows="3" 6 runat="server" class="form-control" placeholder="Enter occupation address" autocomplete="off"></textarea>
                            </div>
                            <div class="col-md-4">
                                <label for="txtvillagename" class="form-label">Native Place</label>
                                <asp:TextBox ID="txtvillagename" runat="server" class="form-control" placeholder="Enter Native Name"></asp:TextBox>
                            </div>
                            <div class="col-md-4">
                                <label for="txtaddress" class="form-label">Address</label>
                                <textarea id="txtaddress" runat="server" class="form-control" rows="3" placeholder="Enter Address"></textarea>
                            </div>
                            <div class="col-md-4">
                                <label for="textBoxMobileNumber1" class="form-label">Mobile Number (Primary)</label>
                                <asp:TextBox ID="textBoxMobileNumber1" runat="server" class="form-control" MaxLength="25" placeholder="Enter 10-digi mt-4t Mobile No" onkeypress="return numeric(event)"></asp:TextBox>
                            </div>
                            <div class="col-md-4">
                                <label for="textBoxMobileNumber2" class="form-label">Mobile Number (Secondary)</label>
                                <asp:TextBox ID="textBoxMobileNumber2" runat="server" class="form-control" MaxLength="25" placeholder="Enter 10-digit Mobile No" onkeypress="return numeric(event)"></asp:TextBox>
                            </div>
                            <div class="col-md-4">
                                <label for="ddlbloodgrup" class="form-label">Blood Group</label>
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
                        <div class="row mt-4">
                            <div class="col text-center">
                                <asp:Button ID="btnUpdate" CommandName="Update" runat="server" class="btn btn-primary btn-lg px-4" Text="Update" OnClick="btnUpdate_Click"></asp:Button>
                                <asp:Button ID="btnClose" runat="server" class="btn btn-secondary btn-lg px-4" Text="Cancel"></asp:Button>
                            </div>
                        </div>
                    </form>
                            </div>

                </div>
            </div>
    </asp:Panel>

    <div class="col-lg-12 grid-margin stretch-card">
    <div class="card" id="gridViewUserType2Data">
        <div class="card-body">
            <h5 class="card-title">Member Data All</h5>
            <asp:GridView ID="GridViewUserType2" runat="server" CssClass="table table-bordered" AutoGenerateColumns="true" Style="width: 100% !important;">
            </asp:GridView>
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
    <script>
        function numeric(evt) {
            var charCode = (evt.which) ? evt.which : evt.key
            if (charCode > 31 && ((charCode >= 48 && charCode <= 57) || charCode == 46))
                return true;
            else {
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

    <link href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <%-- <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>--%>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.7.1/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.7.1/js/buttons.html5.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.7.1/js/buttons.print.min.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
    <script>
        function phyReport() {

            if ($.fn.DataTable.isDataTable('[id*=GridView2]')) {
                $('[id*=GridView2]').DataTable().destroy();
            }


            $('[id*=GridView2] thead tr').clone(true).appendTo('[id*=GridView2] thead');
            $('[id*=GridView2] thead tr:eq(1) th').each(function (i) {
                var title = $(this).text().trim();
                if (title == "Actions") {
                    $(this).html('<input type="text" style="width:100%;" placeholder="Search ' + title + '"  hidden/>');

                    return;
                }
                $(this).html('<input type="text" style="width:100%;" placeholder="Search ' + title + '" />');

                $('input', this).on('keyup change', function () {
                    if (table.column(i).search() !== this.value) {
                        table
                            .column(i)
                            .search(this.value)
                            .draw();
                    }

                });
            });

            var table = $('[id*=GridView2]').DataTable({
                orderCellsTop: true,
                fixedHeader: true,
                select: true,
                "order": [[0, 'desc'], [1, 'desc'], [2, 'desc'], [3, 'desc']],
                "lengthMenu": [[10, 15, 25, 50, 100, -1], [10, 15, 25, 50, 100, "All"]],
                scrollX: true,
                bSort: true,
                dom: 'Bfrtip',
                buttons: [
                    {

                        "extend": 'excel',
                        title: "Member Data",
                        header: true,
                        filename: function () {
                            return 'Member Master Data';
                        },
                        exportOptions: {
                            columns: ':gt(1)'
                        }
                    },
                    {

                        "extend": 'pdf',
                        title: "Member Data",
                        orientation: 'landscape',
                        pageSize: 'A4',
                        header: true,
                        filename: function () {
                            return 'Sangh Master Data';
                        },
                        exportOptions: {
                            columns: ':gt(1)'
                        }

                    },
                ],

            });
        }


        function phyReport2() {

            if ($.fn.DataTable.isDataTable('[id*=GridViewUserType2]')) {
                $('[id*=GridViewUserType2]').DataTable().destroy();
            }


            $('[id*=GridViewUserType2] thead tr').clone(true).appendTo('[id*=GridViewUserType2] thead');
            $('[id*=GridViewUserType2] thead tr:eq(1) th').each(function (i) {
                var title = $(this).text().trim();
                if (title == "Actions") {
                    $(this).html('<input type="text" style="width:100%;" placeholder="Search ' + title + '"  hidden/>');

                    return;
                }
                $(this).html('<input type="text" style="width:100%;" placeholder="Search ' + title + '" />');

                $('input', this).on('keyup change', function () {
                    if (table.column(i).search() !== this.value) {
                        table
                            .column(i)
                            .search(this.value)
                            .draw();
                    }

                });
            });

            var table = $('[id*=GridViewUserType2]').DataTable({
                orderCellsTop: true,
                fixedHeader: true,
                select: true,
                "order": [[0, 'desc'], [1, 'desc'], [2, 'desc'], [3, 'desc']],
                "lengthMenu": [[10, 15, 25, 50, 100, -1], [10, 15, 25, 50, 100, "All"]],
                scrollX: true,
                bSort: true,
                dom: 'Bfrtip',
                buttons: [],
            });
        }
    </script>

    <script type="text/javascript">    
        function ShowPopup() {
            $('#mask').hide();
            $('#pnlpopup').show();
            $('#gridViewMainData').hide();
            $('#<%=pnlpopup.ClientID %>').show();
            //phyReport();
        }
        function HidePopup() {
            $('#mask').hide();
            $('#pnlpopup').hide();
            $('#<%=pnlpopup.ClientID %>').hide();

        }

        $("#btnClose").click(function (e) {
            location.reload();
        });

        $(window).on('popstate', function (event) {
            return true;
        });


    </script>


    <script type="text/javascript">  
        function handleDropDownChange() {
            var selectedValue = $('#<%= DropDownListMemberType.ClientID %> option:selected').text();
            debugger;
            var divForMemberNameOfParent = $("#<%= divForMemberNameOfParent.ClientID %>");

            if (selectedValue === "Self") {
                divForMemberNameOfParent.hide();
            } else {
                divForMemberNameOfParent.show();
            }
        }
        function confirmDelete(rowIndex, autoId) {
            if (confirm("Are you sure you want to delete this record?")) {
                $.ajax({
                    type: "POST",
                    url: "MemberMaster.aspx/DeleteRecord", // Replace with the actual server page URL that handles the delete operation
                    data: "{ autoId: '" + autoId + "' }", // Pass the AutoId as a parameter to the server-side method
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        showInfoNotification(response.d);
                        setTimeout(function () {
                            if (confirm("Do you want to reload the page now?")) {
                                location.reload();
                            }
                        }, 4500);
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        showErrorNotification("An error occurred while deleting the record.");
                    }
                });
            }
        }
        $(function () {
            phyReport();
            phyReport2();
        });

    </script>


</asp:Content>
