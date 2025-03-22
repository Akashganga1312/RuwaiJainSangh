<%@ Page Title="કોર કમિટી" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SanghCommittee.aspx.cs" Inherits="JainSanghInformation.SanghCommittee" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css" />
    <style>
        .no-content {
            text-align: center;
            padding: 20px;
            color: #666;
            font-size: 1.2rem;
            font-style: italic;
        }
        .single-image {
            text-align: center;
            padding: 20px;
        }
        .single-image img {
            max-width: 100%;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        .carousel-item img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="page-header">
         <asp:Label ID="lblTitle" CssClass="page-title" runat="server"></asp:Label>
     </div>

    <!-- No Images Section -->
    <div id="divNoImages" runat="server" class="no-content" visible="false">
        No images found.
    </div>

    <!-- Single Image Section -->
    <div id="divSingleImage" runat="server" class="single-image" visible="false">
        <asp:Image ID="imgSingle" runat="server" />
    </div>

    <!-- Carousel Section -->
    <div id="divCarousel" runat="server" visible="false">
        <div id="carouselImages" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
                <asp:Repeater ID="rptCarousel" runat="server">
                    <ItemTemplate>
                        <div class="carousel-item <%# Container.ItemIndex == 0 ? "active" : "" %>">
                            <img src='<%# Eval("ImageURL") %>' class="d-block w-100" alt="Image" />
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <a class="carousel-control-prev" href="#carouselImages" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselImages" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
    </div>

</asp:Content>
