<%@ Page Title="ડેશબોર્ડ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="JainSanghInformation._Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Rasa:wght@600&display=swap" rel="stylesheet" />
    <style>
        @import url("https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600");

        :root {
            --bar-scale-y: 0;
            --sparkle-color: rgb(253 244 215 / 40%);
        }

        @keyframes pop-word {
            to {
                transform: rotateX(0);
            }
        }

        @keyframes show {
            to {
                opacity: 1;
            }
        }

        @keyframes bar-scale {
            to {
                transform: scaleY(1);
            }
        }

        @keyframes sparkle {
            0% {
                transform: scale(0);
            }

            60% {
                transform: scale(1) translate(4px, 1px) rotate(8deg);
            }

            100% {
                transform: scale(0) translate(4px, 1px) rotate(8deg);
            }
        }

        @keyframes shimmer {
            to {
                text-shadow: 0 0 8px red;
            }
        }

        card {
            display: grid;
            height: 100vh;
            place-items: center;
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f0f0f0;
            padding: 20px;
        }

        h1 {
            color: white;
            font-family: "Playfair Display", Vidaloka, serif;
            font-size: 8rem;
            line-height: 0.85;
            perspective: 500px;
        }

        .word {
            display: block;
            animation: show 0.01s forwards, pop-word 1.5s forwards;
            animation-timing-function: cubic-bezier(0.14, 1.23, 0.33, 1.16);
            opacity: 0;
            transform: rotateX(120deg);
            transform-origin: 50% 100%;
        }

            .word:nth-of-type(2) {
                padding: 0 2rem;
                animation-delay: 1.5s;
                color: gold;
            }

        .superscript {
            position: relative;
            animation-delay: 3.6s;
            animation-duration: 0.25s;
            animation-name: shimmer;
            vertical-align: text-top;
        }

            /* bars */
            .superscript::before {
                --bar-width: 25%;
                position: absolute;
                top: 37%;
                left: 47%;
                width: 14%;
                height: 48%;
                animation: bar-scale 0.25s linear 3s 1 forwards;
                background: linear-gradient( to right, white var(--bar-width), transparent var(--bar-width) calc(100% - var(--bar-width)), white calc(100% - var(--bar-width)) );
                content: "";
                transform: scaleY(var(--bar-scale-y));
            }

            /* sparkle */
            .superscript::after {
                --size: 10rem;
                position: absolute;
                top: -5%;
                left: -85%;
                width: var(--size);
                height: var(--size);
                animation: sparkle 0.4s linear 3.5s 1 forwards;
                background: radial-gradient( circle at center, rgb(252 249 241 / 94%) 0% 7%, transparent 7% 100% ), conic-gradient( transparent 0deg 18deg, var(--sparkle-color) 18deg, transparent 20deg 40deg, var(--sparkle-color) 40deg, transparent 43deg 87deg, var(--sparkle-color) 87deg, transparent 95deg 175deg, var(--sparkle-color) 175deg, transparent 178deg 220deg, var(--sparkle-color) 220deg, transparent 222deg 270deg, var(--sparkle-color) 270deg, transparent 275deg 300deg, var(--sparkle-color) 300deg, transparent 303deg 360deg );
                border-radius: 50%;
                clip-path: polygon( 50% 0, 59.13% 26.64%, 85.13% -2.35%, 100% 50%, 50% 100%, 0 50%, 31.39% 34.86% );
                content: "";
                filter: blur(1px);
                transform: scale(0);
            }

        .shaded-text {
            font-size: 32px;
            color: #fff;
        }

        .shaded-text-v2 {
            font-size: 20px;
            color: #fff;
            font-family: "Baloo Bhai 2", sans-serif !important;
        }

        .event-info {
            font-size: 32px;
            color: #ffffff;
            background-color: #e1e3d8;
            padding: 20px 40px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        }

        .table-info {
            font-size: 18px;
            background-color: #e1e3d8;
            padding: 10px 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.4);
        }



        @media screen and (max-width: 600px) {
            h1 {
                font-size: 5rem;
            }

            /* sparkle */
            .superscript::after {
                --size: 6rem;
            }
        }

        .shaded-text {
            color: #fff !important;
            font-size: 30px;
            font-family: "Baloo Bhai 2", sans-serif !important;
        }

        .shaded-text-v2 {
            font-size: 20px;
            color: #fff;
            font-family: "Baloo Bhai 2", sans-serif !important;
        }

        .dataTables_wrapper .dataTables_scroll div.dataTables_scrollBody > table > tbody > tr > td {
            font-size: 15px !important;
        }


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

        hr {
            border-top: 1px solid #ffffff78 !important;
        }

        .card-header {
            background-color: #9a9a9a30 !important;
        }

        .content-wrapper {
            background: transparent !important;
        }

        .page-title {
            color: white;
        }

        .bg-red {
            background-color: #CC3300;
            color: #fff !important;
        }

        .bg-blue {
            background-color: #063c97;
            color: #fff !important;
        }

        .bg-green {
            background-color: #097969;
            color: #fff !important;
        }

        .bg-yellow {
            background-color: #FFD700;
            color: #000 !important;
        }

        .bg-purple {
            background-color: #800080;
            color: #fff !important;
        }

        .text-white {
            color: #fff !important;
        }

        .text-dark {
            color: #000 !important;
        }

        .fa {
            margin-right: 8px;
        }

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
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
    <asp:Label ID="lblTitle" CssClass="page-title" runat="server"></asp:Label>
</div>

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

    <div class="card">
        <div class="card-body">
            <div class="row">
                <div class="col-md-12 grid-margin transparent">
                    <div class="row">
                        <div class="col-md-4 mb-4 stretch-card transparent">
                            <div class="card card-tale">
                                <div class="card-body" style="box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15) !important; background: #CC3300; color: #fff !important;">
                                    <h5 class="card-title  d-flex justify-content-around">
                                        <span class="shaded-text">કુલ સંઘ </span>
                                        <asp:Label runat="server" ID="totalsangh" class="shaded-text count">0</asp:Label>
                                    </h5>
                                    <h4 class="card-title"></h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 mb-4 stretch-card transparent">
                            <div class="card card-dark-blue">
                                <div class="card-body" style="box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15) !important; background: #974706; color: #fff !important;">
                                    <h5 class="card-title  d-flex justify-content-around">
                                        <span class="shaded-text">કુલ પરિવાર </span>
                                        <asp:Label runat="server" ID="totalmember" class="shaded-text count">0</asp:Label>
                                    </h5>
                                    <h4 class="card-title"></h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 mb-4 stretch-card transparent">
                            <div class="card card-dark-blue">
                                <div class="card-body" style="box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15) !important; background: #063c97; color: #fff !important;">
                                    <h5 class="card-title  d-flex justify-content-around">
                                        <span class="shaded-text">કુલ સભ્યો </span>
                                        <asp:Label runat="server" ID="totalsabhyo" class="shaded-text count">0</asp:Label>
                                    </h5>
                                    <h4 class="card-title"></h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <br />

    <asp:Repeater ID="rptSections" runat="server">
        <ItemTemplate>
            <div class="card mb-5">
                <!-- Main Title -->
                <div class="card-header text-center shaded-text" style="color:black;">
                    <h3  style="color:black;"><%# Eval("MainTitle") %></h3>
                </div>



                <!-- Cards Section -->
                <div class="card-body">
                    <div class="row">
                        <asp:Repeater ID="rptCards" runat="server" DataSource='<%# Eval("Cards") %>'>
                            <ItemTemplate>
                                <div class="col-md-4 mb-4 stretch-card transparent">
                                    <div class="card" style="background-color: <%# Eval("BackgroundColor") %>; color: <%# Eval("TextColor") %>;">
                                        <div class="card-body" style="box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);">
                                            <h2 class="card-title text-center shaded-text">
                                                <%# Eval("CardTitle") %>
                                            </h2>
                                            <hr />
                                            <h6 class="card-title d-flex justify-content-around">
                                                <span class="shaded-text-v2"><%# Eval("SubTitle1") %></span>
                                                <span class="shaded-text-v2 count"><%# Eval("Number1") %></span>
                                            </h6>
                                            <h6 class="card-title d-flex justify-content-around">
                                                <span class="shaded-text-v2"><%# Eval("SubTitle2") %></span>
                                                <span class="shaded-text-v2 count"><%# Eval("Number2") %></span>
                                            </h6>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
    <br />
    <link href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.7.1/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.7.1/js/buttons.html5.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.7.1/js/buttons.print.min.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
    <script>
        $(function () {
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
                bLengthChange: true,
                orderCellsTop: true,
                fixedHeader: true,
                select: true,
                order: [[0, 'desc'], [1, 'desc']],
                lengthMenu: [[10, 15, 25, 50, 100, -1], [10, 15, 25, 50, 100, "All"]],
                bPaginate: true,
                scrollX: true,
                dom: 'Bfrtip',
                buttons: [
                    {

                        "extend": 'excel',
                        text: 'Excel',
                        title: '',
                        header: true,
                        filename: function () {
                            return 'Summary';
                        },

                    },
                    {
                        "extend": 'pdf',
                        text: 'PDF',
                        title: '',
                        pageSize: 'A4',
                        header: true,
                        filename: function () {
                        },
                    },
                ],
            });
        }
    </script>
    <script>
        $('.count').each(function () {
            $(this).prop('Counter', 0).animate({
                Counter: $(this).text()
            }, {
                duration: 3000,
                easing: 'swing',
                step: function (now) {
                    $(this).text(Math.ceil(now));
                }
            });
        });
    </script>

</asp:Content>
