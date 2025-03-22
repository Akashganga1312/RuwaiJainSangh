<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubMenuMaster.aspx.cs" Inherits="JainSanghInformation.SubMenuMaster" %>

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
    </div>
    <div class="col-12" id="maindiv" runat="server">
        <div class="card">
            <div class="card-body">
                <div class="col-md-8">
                    <div class="row" style="justify-content: space-between;">
                        <a href="CreateNewSubmenu.aspx" class="btn">Create New</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-12 grid-margin stretch-card">
        <div class="card" id="gridViewMainData">
            <div style="width: 100%; height: auto;">
                <div class="card">
                    <div class="card-body">
                        <div style="width: 100%;">
                            <asp:GridView ID="GridView2" runat="server" DataKeyNames="Id" class="table table-bordered" OnRowCommand="GridViewData_RowCommand" Style="width: 100% !important;" OnRowDataBound="GridView2_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="Actions">
                                        <ItemTemplate>
                                            <asp:LinkButton Text="Edit" runat="server" CssClass="Edit font-weight-bold btn btn-xs btn-primary" CommandName="ShowPopup" CommandArgument="<%# Container.DataItemIndex %>" />
                                            |
                                           <asp:LinkButton Text="Delete" runat="server" CssClass="Delete font-weight-bold btn btn-xs btn-danger" OnClientClick='<%# "confirmDelete(\"" + Container.DataItemIndex + "\", \"" + Eval("Id") + "\"); return false;" %>' />
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

    <asp:Panel ID="pnlpopup" runat="server" class="panelDesign" Style="margin-top: -50px;">
        <div class="container">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title text-center">Update Menu Details</h4>
                    <asp:Label ID="lblid" runat="server" Style="display: none"></asp:Label>
                    <form>
                        <div class="row g-3">
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


                        </div>
                        <div class="form-group text-center">
                            <asp:Button ID="btnUpdate" runat="server" class="btn btn-primary" Text="Update" OnClick="btnUpdate_Click"></asp:Button>
                            <asp:Button ID="btnClose" runat="server" class="btn btn-secondary" Text="Cancel"></asp:Button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </asp:Panel>

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
                        title: "Sub Menu Data",
                        header: true,
                        filename: function () {
                            return 'Sub Menu Data';
                        },
                        exportOptions: {
                            columns: ':gt(2)'
                        }
                    },
                    {
                        "extend": 'pdf',
                        title: "Sub Menu Data",
                        orientation: 'landscape',
                        pageSize: 'A4',
                        customize: function (doc) {
                            doc.content[1].table.widths =
                                Array(doc.content[1].table.body[0].length + 1).join('*').split('');
                        },
                        header: true,
                        filename: function () {
                            return 'Sub Menu Data';
                        },
                        exportOptions: {
                            columns: ':gt(2)'
                        }

                    },
                ],

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
        function confirmDelete(rowIndex, autoId) {
            if (confirm("Are you sure you want to delete this record?")) {
                $.ajax({
                    type: "POST",
                    url: "SubMenuMaster.aspx/DeleteRecord", // Replace with the actual server page URL that handles the delete operation
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
        });
    </script>
    <br />
</asp:Content>
