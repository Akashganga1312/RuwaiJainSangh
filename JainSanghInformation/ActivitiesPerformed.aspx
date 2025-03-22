<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ActivitiesPerformed.aspx.cs" Inherits="JainSanghInformation.ActivitiesPerformed" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .card {
            border: 2px solid #ff4000; /* Custom border color */
            border-radius: 15px; /* Rounded corners */
            text-align: center;
            overflow: hidden;
            position: relative;
            cursor: pointer;
            transition: transform 0.3s, box-shadow 0.3s;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
        }

        .card:hover {
            transform: scale(1.05); /* Hover effect */
            box-shadow: 0px 10px 15px rgba(0, 0, 0, 0.2);
        }

        .card-content {
            position: relative;
            padding: 20px;
            height: 200px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            transition: background-color 0.3s;
            overflow: hidden;
        }

        .card-content::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: var(--background-image);
            background-size: cover;
            background-position: center;
            transition: transform 0.3s;
            z-index: 0;
        }

        .card-content:hover::before {
            transform: translateY(-100%);
        }

        .card-content i,
        .card-content h3 {
            position: relative;
            z-index: 1;
            color: var(--text-color);
        }

        .card-content:hover {
            background-color: var(--hover-bg-color);
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            <asp:Repeater ID="ActivitiesRepeater" runat="server">
                <ItemTemplate>
                    <div class="col-md-4 col-sm-6 col-12 mb-4">
                        <div class="card" onclick='window.open("<%# Eval("LinkUrl").ToString() %>", "_blank");'>
                            <div class="card-content"
                                style='--background-image: url("<%# ResolveUrl(Eval("BackgroundImageUrl").ToString()) %>"); 
                                --hover-bg-color: <%# Eval("BackgroundColor") %>; 
                                --text-color: <%# Eval("TitleColor") %>;'>
                                <i class='<%# Eval("Icon") %>'></i>
                                <h3><%# Eval("Title") %></h3>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
