<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VerifyOTP.aspx.cs" Inherits="JainSanghInformation.VerifyOTP" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Verify OTP</title>
    <link rel="stylesheet" href="assets/vendors/mdi/css/materialdesignicons.min.css" />
    <link rel="stylesheet" href="assets/vendors/css/vendor.bundle.base.css" />
    <link rel="stylesheet" href="assets/css/style.css" />
    <link rel="icon" type="image/icon" href="favicon.png" />
    <link href="https://fonts.googleapis.com/css2?family=Rasa:wght@600&family=Poppins:wght@400;600;700&display=swap" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
            border-radius: 4px; /* Rounded corners */
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3); /* Add a subtle shadow */
        }

        .p-5 {
            padding: 0rem !important;
        }

        .logo-img {
            max-width: 100px; /* Adjust size as needed */
            height: auto;
            margin-bottom: 10px; /* Adds spacing below the logo */
        }

        @media (max-width: 480px) {
            .card {
                padding: 15px;
                max-width: 90%; /* Prevents overflow */
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
                                <form id="form1" class="pt-3" runat="server" style="border: 2px solid #000; color: #000; background-color: #f8f9fa; padding: 10px; font-size: 16px; margin: 10px;">
                                    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <div class="form-group">
                                                <label for="otpInput" style="color: #000; font-size: 16px;">Enter the OTP sent to your mobile number</label>
                                                <asp:TextBox ID="otpInput" runat="server" placeholder="Enter OTP" class="form-control"></asp:TextBox>
                                            </div>
                                            <div class="mt-3">
                                                <asp:Button ID="VerifyButton" runat="server" Text="Verify OTP" class="btn btn-primary btn-block" OnClick="VerifyOTPCode" />
                                            </div>
                                            <div class="my-2 d-flex justify-content-between align-items-center">
                                                <a href="/LogIn.aspx" class="auth-link text-black">Go Back</a>
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
        });
        $(document).ready(function () {
        });
    </script>

</body>
</html>
