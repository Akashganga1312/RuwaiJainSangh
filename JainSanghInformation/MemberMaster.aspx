<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MemberMaster.aspx.cs" Inherits="JainSanghInformation.MemberMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .dataTables_wrapper .dataTables_paginate .paginate_button.current, .dataTables_wrapper .dataTables_paginate .paginate_button.current:hover {
            color: #333 !important;
            border: 1px solid #4e73df;
            background-color: #4e73df;
        }

        input, .form-control:focus, input:focus, select:focus, textarea:focus, button:focus {
            border: 1px solid #808080;
        }

        .btn, .btn-group.open .dropdown-toggle, .btn:active, .btn:focus, .btn:hover, .btn:visited,
        button, button:active,
        button:hover, button:visited {
            background-color: #4e73df;
            color: white;
            border: 1px solid #4e73df;
        }

        table.dataTable tbody td {
            padding: 15px 10px !important;
        }



        .Background {
            background-color: Black;
            opacity: 0.94;
        }



        .lbl {
            font-size: 16px;
            font-weight: bold;
        }

        .lbltitl {
            font-size: 24px;
            font-weight: bold;
            text-align: center;
        }


        .form-control {
            display: block;
            width: 100%;
            height: 2.875rem;
            padding: 0.94rem 1.375rem;
            font-size: 0.8125rem;
            font-weight: 400;
            line-height: 1;
            color: #495057;
            background-color: #ffffff;
            background-clip: padding-box;
            border: 1px solid #ced4da;
            border-radius: 2px;
            transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
            transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out, -webkit-box-shadow 0.15s ease-in-out;
        }

        .btn {
            display: inline-block;
            font-weight: 400;
            color: #343a40;
            text-align: center;
            vertical-align: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
            background: #4e73df;
            border: 1px solid transparent;
            padding: 0.875rem 2.5rem;
            font-size: 0.875rem;
            line-height: 1;
            border-radius: 0.1875rem;
            transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out, -webkit-box-shadow 0.15s ease-in-out;
        }

        input [type="button"] {
            background: #4e73df;
        }

        .btn-outline-success {
            color: #1bcfb4;
            border-color: #1bcfb4;
        }

        .btn-outline-dark {
            color: #3e4b5b;
            border-color: #3e4b5b;
        }

        .card-title {
            color: #343a40;
            margin-bottom: 0.75rem;
            text-transform: capitalize;
            font-weight: bold;
            font-size: 1.650rem;
        }

        .mask {
            position: fixed;
            left: 0px;
            top: 0px;
            z-index: 10000;
            opacity: 0.90;
            background-color: black;
            display: none;
            width: 100%;
            height: 100%;
        }

        .panelDesign {
            z-index: 14000;
            position: absolute;
            top: 20%;
            right: 3%;
            left: 5%;
            display: none;
            width: auto;
            overflow: auto;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <h3 class="page-title">Member Master</h3>
    </div>
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                <div class="col-md-8" style="background: #fff;">
                    <div class="row" style="justify-content: space-between; display: flex;">
                        <a style="border-left: 5px solid #4e73df; padding-left: 15px;" href="CreateNewMember.aspx">Create New</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <br />
    <div class="col-lg-12 grid-margin stretch-card">
        <div class="card">
            <div style="width: 100%; height: auto;">
                <div class="card">
                    <div class="card-body">
                        <div style="width: 100%;">
                            <asp:GridView ID="GridView2" runat="server" DataKeyNames="Id" class="table table-bordered" OnRowCommand="GridViewData_RowCommand" Style="width: 100% !important;">
                                <Columns>
                                    <asp:TemplateField HeaderText="Actions">
                                        <ItemTemplate>
                                            <%--<asp:LinkButton Text="Edit" runat="server" CssClass="Edit" CommandName="ShowPopup" CommandArgument="<%# Container.DataItemIndex %>" />
                                    <asp:LinkButton Text="Delete" runat="server" CssClass="Delete" />--%>
                                            <asp:LinkButton Text="Edit" runat="server" CssClass="Edit" CommandName="ShowPopup" CommandArgument="<%# Container.DataItemIndex %>" />
                                            |
                                            <asp:LinkButton Text="Delete" runat="server" CssClass="Delete" />
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

    <asp:Panel ID="pnlpopup" runat="server" class="panelDesign" orizontalAlign="Center">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <p class="card-description">Update Member Details</p>
                    <asp:Label ID="id" runat="server" Style="display: none"></asp:Label>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label">Sangh Name</label>
                                <div class="col-sm-7">
                                    <asp:Label ID="textBoxSanghName" runat="server" class="form-control" readonly="true"></asp:Label>
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
                                <label class="col-sm-3 col-form-label">Member Name</label>
                                <div class="col-sm-7">
                                    <asp:TextBox type="text" ID="txtmembername" runat="server" class="form-control" placeholder="Enter Member Name" autocomplete="off"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label">Member Type</label>
                                <div class="col-sm-7">
                                    <asp:TextBox type="text" ID="txtmtype" runat="server" class="form-control" placeholder="Enter Member Name" autocomplete="off"></asp:TextBox>
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
                                    <asp:TextBox type="text" ID="txtoccupation" runat="server" class="form-control" placeholder="Enter Member Name" autocomplete="off"></asp:TextBox>
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
                                        <asp:ListItem Text="--Please Select--"></asp:ListItem>
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


                    </div>
                    <div class="form-group col-md-12">
                        <div class="col-md-offset-2 col-md-12" align="center">
                            <asp:Button ID="btnUpdate" CommandName="Update" runat="server" class="btn btn-lg btn-primary col-sm-2 font font-weight-medium auth-form-btn" Text="Update" AutoPostBack="False" OnClick="btnUpdate_Click"></asp:Button>
                            <asp:Button ID="btnClose" runat="server" class="btnClose btn btn-lg btn-primary col-sm-2 font font-weight-medium auth-form-btn" Text="Cancel" AutoPostBack="False" OnClick="btnClose_Click"></asp:Button>
                        </div>
                    </div>
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


    <script type="text/javascript">    
        function ShowPopup() {
            $('#mask').show();
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

        //$("#btnClose").live('click', function () {
        //    HidePopup();
        //});
    </script>


    <script type="text/javascript">  
        $(function () {
            //$("[id*=GridView2]").DataTable(
            //    {
            //        bLengthChange: true,
            //        lengthMenu: [[10, -1], [10, "All"]],
            //        bFilter: true,
            //        bSort: true,
            //        bPaginate: true,
            //        scroll: true,
            //        scrollX: true,
            //        scrollY: true,
            //        dom: 'Bfrtip',
            //        //buttons: [
            //        //    'excel', 'pdf'
            //        //]
            //        buttons: [
            //            'excel'
            //        ],

            //    });
            phyReport();
        });


    </script>

    <script>
        function phyReport() {
            // Setup - add a text input to each footer cell
            $('[id*=GridView2] thead tr').clone(true).appendTo('[id*=GridView2] thead');
            $('[id*=GridView2] thead tr:eq(1) th').each(function (i) {
                var title = $(this).text().trim();
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
                scrollX: true
            });
        }
    </script>


</asp:Content>
