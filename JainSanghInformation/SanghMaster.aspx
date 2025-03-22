<%@ Page Title="સંઘ માહિતી" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SanghMaster.aspx.cs" Inherits="JainSanghInformation.SanghMaster" %>
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
            position: absolute;
            top: 20%;
            left: 10%;
            right: 10%;
            background: white;
            border-radius: 8px;
            padding: 20px;
            display:none;
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
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <h3 class="page-title">સંઘ માહિતી</h3>
    </div>
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                <div class="col-md-8">
                    <div class="row" style="justify-content: space-between;">
                        <a href="CreateNewSangh.aspx" class="btn">Create New</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <br />
    <div id="gridViewForWorkInProgress" class="col-lg-12 stretch-card">
        <div class="card">
            <div class="card-body">
                <asp:GridView 
                    ID="GridView2" 
                    runat="server" 
                    DataKeyNames="AutoId" 
                    CssClass="table dataTable table-bordered table-hover" 
                    OnRowCommand="GridViewData_RowCommand" 
                    Width="100%" 
                    AutoGenerateColumns="true">
                    <Columns>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton 
                                    Text="Edit" 
                                    runat="server" 
                                    CssClass="btn btn-sm btn-primary" 
                                    CommandName="ShowPopup" 
                                    CommandArgument="<%# Container.DataItemIndex %>" />
                                |
                                <asp:LinkButton 
                                    Text="Delete" 
                                    runat="server" 
                                    CssClass="btn btn-sm btn-danger" 
                                    OnClientClick='<%# "confirmDelete(\"" + Container.DataItemIndex + "\", \"" + Eval("AutoId") + "\"); return false;" %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <div id="mask" class="mask"></div>

    <asp:Panel ID="pnlpopup" runat="server" class="panelDesign">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <p class="card-title">Update Sangh Details</p>
                    <asp:Label ID="id" runat="server" Style="display: none"></asp:Label>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="lblid" class="form-label">Id</label>
                                <asp:Label ID="lblid" runat="server" class="form-control" readonly></asp:Label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="txtsname" class="form-label">Sangh Name <span style="color:red;">*</span></label>
                                <asp:TextBox ID="txtsname" runat="server" class="form-control" placeholder="Enter Sangh Name"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="txtlocn" class="form-label">Location <span style="color:red;">*</span></label>
                                <asp:TextBox ID="txtlocn" runat="server" class="form-control" placeholder="Enter Location"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="txtpname" class="form-label">President Name</label>
                                <asp:TextBox ID="txtpname" runat="server" class="form-control" placeholder="Enter President Name"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="txtpmob" class="form-label">President MobileNo.</label>
                                <asp:TextBox ID="txtpmob" runat="server" class="form-control" MaxLength="10" placeholder="Enter Mobile Number"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="form-group text-center">
                        <asp:Button ID="btnUpdate" runat="server" class="btn btn-primary" Text="Update" OnClick="btnUpdate_Click"></asp:Button>
                        <asp:Button ID="btnClose" runat="server" class="btn btn-secondary" Text="Cancel"></asp:Button>
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>


    <link href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.7.1/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.7.1/js/buttons.html5.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.7.1/js/buttons.print.min.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">


    <script type="text/javascript">    
        function ShowPopup() {
            $('#mask').hide();
            $('#pnlpopup').show();
            $('#<%=pnlpopup.ClientID %>').show();
        }
        function HidePopup() {
            $('#mask').hide();
            $('#pnlpopup').hide();
            $('#<%=pnlpopup.ClientID %>').hide();
        }


        $("#btnClose").click(function (e) {
            HidePopup();
            e.preventDefault();
        });

        $(window).on('popstate', function (event) {
            return true;
        });

    </script>


    <script type="text/javascript">  
        $(function () {
            phyReport();
        });

    </script>

   <script type="text/javascript">
       function confirmDelete(rowIndex, autoId) {
           if (confirm("Are you sure you want to delete this record?")) {
               $.ajax({
                   type: "POST",
                   url: "SanghMaster.aspx/DeleteRecord", // Replace with the actual server page URL that handles the delete operation
                   data: "{ autoId: '" + autoId + "' }", // Pass the AutoId as a parameter to the server-side method
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   success: function (response) {
                       showSuccessNotification(response.d);

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
       function numeric(evt) {
           var charCode = (evt.which) ? evt.which : eventkeyCode
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

    <script>
        function phyReport() {
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
                        title: "Sangh Data",
                        header: true,
                        filename: function () {
                            return 'Sangh Master Data';
                        },
                        exportOptions: {
                            columns: ':gt(1)'
                        }
                    },
                    {
                        "extend": 'pdf',
                        title: "Sangh Data",
                        orientation: 'landscape',
                        pageSize: 'A4',
                        customize: function (doc) {
                            doc.content[1].table.widths =
                                Array(doc.content[1].table.body[0].length + 1).join('*').split('');
                        },
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

        
    </script>
   
</asp:Content>
