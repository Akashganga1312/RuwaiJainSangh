<%@ Page Title="Activity Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ActivityPage.aspx.cs" Inherits="JainSanghInformation.ActivityPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <style>
        .form-container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

            .form-container input, .form-container button {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }

            .form-container button {
                background-color: #4e73df;
                color: white;
                font-size: 16px;
                border: none;
                cursor: pointer;
            }

                .form-container button:hover {
                    background-color: #3751ab;
                }

        .grid-container {
            max-width: 90%;
            margin: 20px auto;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        th, td {
            text-align: left;
            padding: 12px;
        }

        th {
            background-color: #007bff;
            color: white;
            position: sticky;
            top: 0;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        @media (max-width: 768px) {
            .form-container {
                padding: 10px;
            }

                .form-container input, .form-container button {
                    font-size: 14px;
                    padding: 8px;
                }

            table, th, td {
                font-size: 14px;
            }
        }

        @media (max-width: 480px) {
            .form-container input, .form-container button {
                font-size: 12px;
                padding: 6px;
            }

            table, th, td {
                font-size: 12px;
            }
        }


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

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        th, td {
            text-align: left;
            padding: 12px;
        }

        th {
            background-color: #007bff;
            color: white;
            position: sticky;
            top: 0;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .hover-card {
            position: relative;
            overflow: hidden;
            cursor: pointer;
            transition: transform 0.3s;
            border-radius: 8px;
        }

            .hover-card:hover {
                transform: scale(1.05);
            }

            .hover-card img {
                width: 100%;
                height: auto;
                transition: transform 0.3s;
            }

            .hover-card:hover img {
                transform: scale(1.1);
            }

            .hover-card .hover-title {
                position: absolute;
                bottom: 0;
                left: 0;
                width: 100%;
                background: rgba(0, 0, 0, 0.6);
                color: white;
                text-align: center;
                padding: 10px;
                font-size: 16px;
                font-weight: bold;
                opacity: 0;
                transition: opacity 0.3s;
            }

            .hover-card:hover .hover-title {
                opacity: 1;
            }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-container">
        <div class="row">
            <div class="col-md-4">
                <asp:TextBox ID="txtBackgroundColor" runat="server" CssClass="form-control" Placeholder="Background Color (Hex)  ex.#FF0000" MaxLength="7"></asp:TextBox>
            </div>
            <div class="col-md-4">
                <asp:TextBox ID="txtTitleColor" runat="server" CssClass="form-control" Placeholder="Title Color ex.#FFFFFF"></asp:TextBox>
            </div>
            <div class="col-md-4">
                <asp:FileUpload ID="fileBackgroundImage" runat="server" CssClass="form-control" />
            </div>
        </div>
        <div class="row mt-3">
            <div class="col-md-4">
                <asp:TextBox ID="txtLinkUrl" runat="server" CssClass="form-control" Placeholder="Link URL"></asp:TextBox>
            </div>
            <div class="col-md-4">
                <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" Placeholder="Title"></asp:TextBox>
            </div>
            <div class="col-md-4">
                <asp:TextBox ID="txtIcon" runat="server" CssClass="form-control" Placeholder="Favicon Source"></asp:TextBox>
            </div>
        </div>
        <div class="d-flex justify-content-center align-items-center">
            <div class="col-md-4">
                <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary btn-block" Text="Save" OnClick="btnSave_Click" />
            </div>
        </div>
    </div>

    <div class="grid-container">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover"
            OnRowEditing="GridView1_RowEditing" OnRowDeleting="GridView1_RowDeleting"
            OnRowUpdating="GridView1_RowUpdating" OnRowCancelingEdit="GridView1_RowCancelingEdit"
            DataKeyNames="ID">
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" />
                <asp:BoundField DataField="BackgroundColor" HeaderText="Background Color" />
                <asp:BoundField DataField="TitleColor" HeaderText="Title Color" />
                <asp:TemplateField HeaderText="Background Image">
                    <EditItemTemplate>
                        <asp:FileUpload ID="fileUploadControl" runat="server" CssClass="form-control" />
                        <asp:Label ID="lblOldImageUrl" runat="server" Text='<%# Bind("BackgroundImageUrl") %>' Visible="false"></asp:Label>
                        <br />
                        <img src='<%# Eval("BackgroundImageUrl") %>' alt="Background Image" style="width: 100px; height: auto;" />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <img src='<%# ResolveUrl(Eval("BackgroundImageUrl").ToString()) %>' alt="Background Image" style="width: 100px; height: auto;" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="LinkUrl" HeaderText="Link URL" />
                <asp:BoundField DataField="Title" HeaderText="Title" />
                <asp:BoundField DataField="Icon" HeaderText="Icon" />
                <asp:CommandField ShowEditButton="True" />
                <asp:CommandField ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>
    </div>

</asp:Content>
