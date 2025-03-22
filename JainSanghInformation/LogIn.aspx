<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LogIn.aspx.cs" Inherits="JainSanghInformation.LogIn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Login</title>
    <link rel="stylesheet" href="assets/vendors/mdi/css/materialdesignicons.min.css" />
    <link rel="stylesheet" href="assets/vendors/css/vendor.bundle.base.css" />
    <link rel="stylesheet" href="assets/css/style.css" />
    <link rel="icon" type="image/icon" href="favicon.png" />
    <link href="https://fonts.googleapis.com/css2?family=Rasa:wght@600&family=Poppins:wght@400;600;700&display=swap" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <style>
        body {
            background: linear-gradient(135deg, #667eea, #764ba2);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 10px;
            font-family: 'Poppins', sans-serif;
            animation: fadeIn 2s ease-in-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }

            to {
                opacity: 1;
            }
        }

        .card {
            background: rgba(255, 255, 255, 0.3);
            backdrop-filter: blur(15px);
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            padding: 20px;
            width: 100%;
            max-width: 600px;
            margin: auto;
            animation: slideIn 1s ease-out;
        }

        @keyframes slideIn {
            from {
                transform: translateY(100px);
                opacity: 0;
            }

            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        h1, h4 {
            color: #000000;
            font-weight: 700;
            text-align: center;
            text-shadow: 2px 4px 10px rgba(0, 0, 0, 0.5);
            padding: 10px 0;
        }

        h1 {
            font-size: 24px;
        }

        h4 {
            font-size: 20px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #ff8c00, #ff2e63);
            border: none;
            color: #fff;
            font-size: 15px;
            font-weight: 600;
            padding: 12px;
            transition: background 0.3s ease, transform 0.3s ease;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

            .btn-primary:hover {
                background: linear-gradient(135deg, #ff2e63, #ff8c00);
                transform: translateY(-5px);
            }

        .form-control {
            background: rgba(255, 255, 255, 0.6);
            border: none;
            color: #333;
            font-size: 15px;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }

            .form-control::placeholder {
                color: #555;
                font-size: 14px;
            }

            .form-control:focus {
                box-shadow: 0 0 15px rgba(255, 255, 255, 0.7);
                outline: none;
            }

        .form-group label {
            color: #fff;
            font-weight: 400;
            margin-bottom: 10px;
        }

        @media (max-width: 768px) {
            .card {
                padding: 20px;
                max-width: 768px;
            }

            h1 {
                font-size: 22px;
            }

            h4 {
                font-size: 14px;
            }

            body {
                display: block;
            }
        }

        .content-wrapper {
            background: none;
        }

        .toast-title {
            font-size: 18px; 
            font-weight: bold;
            font-family: 'Poppins', sans-serif;
        }

        .toast-message {
            font-size: 14px; 
            font-family: 'Poppins', sans-serif; 
        }

        .toast {
            border-radius: 4px; 
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3); 
        }


        .p-5 {
            padding: 0rem !important;
        }

        .logo-img {
            max-width: 100px;
            height: auto;
            margin-bottom: 10px;
        }

        @media (max-width: 480px) {
            .card {
                padding: 15px;
                max-width: 90%;
            }

            h1, h4 {
                font-size: 18px;
            }
        }

        .social-icons .icon {
            display: inline-block;
            margin: 0 10px;
            font-size: 36px;
            color: #fff;
            background: linear-gradient(135deg, #6e8efb, #a777e3);
            width: 60px;
            height: 60px;
            border-radius: 50%;
            line-height: 60px;
            text-align: center;
            transition: all 0.3s ease-in-out;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

            .social-icons .icon:hover {
                transform: translateY(-5px) scale(1.1);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.5);
            }

            .social-icons .icon.facebook {
                background: linear-gradient(135deg, #4267B2, #32456A);
            }

            .social-icons .icon.twitter {
                background: linear-gradient(135deg, #1DA1F2, #1A91DA);
            }

            .social-icons .icon.instagram {
                background: linear-gradient(135deg, #E1306C, #C13584);
            }

            .social-icons .icon.linkedin {
                background: linear-gradient(135deg, #0077B5, #005582);
            }

            .social-icons .icon i {
                color: #fff;
                transition: color 0.3s ease-in-out;
            }

            .social-icons .icon:hover i {
                color: #ffd700;
            }
    </style>
</head>
<body>
    <div class="container-scroller">
        <div class="container-fluid page-body-wrapper full-page-wrapper">
            <div class="content-wrapper d-flex align-items-center auth">
                <div class="row flex-grow">
                    <div class="col-lg-10 col-md-10 col-sm-12 mx-auto">
                        <div class="card">
                            <div class="auth-form-light text-center p-5">
                                <center>
                                    <img src="<%= logoUrl %>" class="logo-img" alt="Logo" />
                                </center>
                                <h1 id="welcomeLabel" runat="server"></h1>
                                <h4 id="titleLabel" runat="server"></h4>
                                <h4 id="eventLabel" runat="server" hidden="hidden"></h4>

                                <form class="pt-3" runat="server">
                                    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <div class="form-group" style="margin-bottom: 20px;">
                                                <label for="loginType" style="color: #000; font-weight: bold;">Login Type</label>
                                                <asp:DropDownList ID="loginType" runat="server"
                                                    class="form-control form-control-lg"
                                                    OnChange="handleLoginTypeChange(this)"
                                                    Style="border: 2px solid #000; color: #000; background-color: #f8f9fa; padding: 5px; font-size: 14px; width: 97%;">
                                                    <asp:ListItem Value="" Text="Select Login Type"></asp:ListItem>
                                                    <asp:ListItem Value="admin" Text="Admin Login"></asp:ListItem>
                                                    <asp:ListItem Value="member" Text="Member Login"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>

                                            <div id="loginForm" style="display: none; border: 2px solid #000; color: #000; background-color: #f8f9fa; padding: 10px; font-size: 16px; margin: 10px;">
                                                <div class="form-group">
                                                    <label for="usernamemain" style="color: #000; padding: 2px; font-size: 16px;">Username or Mobile Number</label>
                                                    <asp:TextBox ID="usernamemain" runat="server" class="form-control" placeholder="Enter Username or MobileNumber"></asp:TextBox>
                                                </div>
                                                <div class="form-group">
                                                    <label for="passwordmain" style="color: #000; padding: 2px; font-size: 16px;">Password</label>
                                                    <asp:TextBox ID="passwordmain" type="password" runat="server" class="form-control" placeholder="Enter Password"></asp:TextBox>
                                                </div>
                                                <div class="mt-3">
                                                    <asp:Button ID="Button1" runat="server" Text="LOG IN" class="btn btn-primary btn-block" OnClick="Login" />
                                                </div>
                                            </div>

                                            <div id="memberLoginOptions" style="display: none; border: 2px solid #000; color: #000; background-color: #f8f9fa; padding: 10px; font-size: 16px; margin: 10px;">
                                                <ul class="nav nav-tabs justify-content-center" id="memberLoginTab" role="tablist">
                                                    <li class="nav-item">
                                                        <a class="nav-link active" id="mobile-tab" data-toggle="tab" href="#mobileTabContent" role="tab" aria-controls="mobileTabContent" aria-selected="true">Mobile OTP</a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link" id="email-tab" data-toggle="tab" href="#emailTabContent" role="tab" aria-controls="emailTabContent" aria-selected="false">Email OTP</a>
                                                    </li>
                                                </ul>
                                                <div class="tab-content" id="memberLoginTabContent">
                                                    <div class="tab-pane fade show active" id="mobileTabContent" role="tabpanel" aria-labelledby="mobile-tab">
                                                        <div class="form-group mt-3">
                                                            <label for="mobilemain" style="color: #000; padding: 2px; font-size: 16px;">Mobile Number</label>
                                                            <asp:TextBox ID="mobilemain" runat="server" class="form-control" placeholder="Enter Mobile Number"></asp:TextBox>
                                                        </div>
                                                        <div class="mt-3">
                                                            <asp:Button ID="Button2" runat="server" Text="Generate OTP" class="btn btn-primary btn-block" OnClick="GenerateOTP" />
                                                        </div>
                                                    </div>
                                                    <div class="tab-pane fade" id="emailTabContent" role="tabpanel" aria-labelledby="email-tab">
                                                        <div class="form-group mt-3">
                                                            <label for="emailmain" style="color: #000; padding: 2px; font-size: 16px;">Email Address</label>
                                                            <asp:TextBox ID="emailmain" runat="server" class="form-control" placeholder="Enter Email Address"></asp:TextBox>
                                                        </div>
                                                        <div class="mt-3">
                                                            <asp:Button ID="Button3" runat="server" Text="Generate OTP" class="btn btn-primary btn-block" OnClick="GenerateEmailOTP" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </form>
                                <div class="social-icons mt-4 text-center">
                                    <a href="https://www.instagram.com/ruwaignatitrust?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==" class="icon facebook" target="_blank"><i class="mdi mdi-facebook"></i></a>
                                    <a href="https://www.instagram.com/ruwaignatitrust?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==" class="icon instagram" target="_blank"><i class="mdi mdi-instagram"></i></a>
                                    <%--<a href="https://linkedin.com/in/your-profile" class="icon linkedin" target="_blank"><i class="mdi mdi-linkedin"></i></a>--%>
                                    <a href="https://www.youtube.com/channel/your-channel-id" class="icon youtube" target="_blank">
                                        <i class="mdi mdi-youtube"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function handleLoginTypeChange(selectElement) {
            var loginType = selectElement.value;
            var adminLoginForm = document.getElementById("loginForm");
            var memberLoginOptions = document.getElementById("memberLoginOptions");
            if (loginType === "member") {
                adminLoginForm.style.display = "none";
                memberLoginOptions.style.display = "block";
            } else if (loginType === "admin") {
                memberLoginOptions.style.display = "none";
                adminLoginForm.style.display = "block";
            } else {
                adminLoginForm.style.display = "none";
                memberLoginOptions.style.display = "none";
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
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            var loginTypeSelect = document.getElementById("loginType");
            if (loginTypeSelect) {
                handleLoginTypeChange(loginTypeSelect); // Reinitialize dynamic form visibility
            }
        });
        $(document).ready(function () {
            var loginTypeSelect = $("#loginType")[0];
            if (loginTypeSelect) {
                handleLoginTypeChange(loginTypeSelect);
            }
        });
    </script>
</body>
</html>
