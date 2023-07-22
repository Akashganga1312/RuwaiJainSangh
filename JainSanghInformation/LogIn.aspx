<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LogIn.aspx.cs" Inherits="JainSanghInformation.LogIn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <title>JSI-LogIn</title>
    <link rel="stylesheet" href="assets/vendors/mdi/css/materialdesignicons.min.css"/>
    <link rel="stylesheet" href="assets/vendors/css/vendor.bundle.base.css"/>
    <link rel="stylesheet" href="assets/css/style.css" />
    
</head>
<body>
    <div class="container-scroller">
        <div class="container-fluid page-body-wrapper full-page-wrapper" >
            <div class="content-wrapper d-flex align-items-center auth" >
                <div class="row flex-grow">
                    <div class="col-lg-4 mx-auto">
                        <div class="auth-form-light text-left p-5">
                            <h1 class="menu-title text-center">Log In</h1>
                           <%-- <h6 class="font-weight-light">LogIn to continue..</h6>--%>
                            <form class="pt-3" runat="server">

                                <div class="form-group">
                                    <asp:TextBox ID="username" runat="server" class="form-control form-control-lg" placeholder="Username" Style="color: dimgray;"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <asp:TextBox ID="password" type="password" runat="server" class="form-control form-control-lg" placeholder="Password" Style="color: dimgray;"></asp:TextBox>
                                </div>
                                <div class="mt-3">
                                    <asp:Button ID="Button1" runat="server" Text="LOG IN" class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn" OnClick="Login" />
                                    <%--<a  href="../../index.html">SIGN IN</a>--%>
                                </div>
                                <div class="my-2 d-flex justify-content-between align-items-center">
                                    <a href="ForgotPassword.aspx" class="auth-link text-black">Forgot password?</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="assets/vendors/js/vendor.bundle.base.js"></script>
    <script src="assets/js/off-canvas.js"></script>
    <script src="assets/js/hoverable-collapse.js"></script>
    <script src="assets/js/misc.js"></script>
</body>
</html>
