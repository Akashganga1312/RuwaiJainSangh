<%@ Page Title="સ્નેહમિલન આમંત્રણ પત્રિકા" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SnehMilanInvitation.aspx.cs" Inherits="JainSanghInformation.SnehMilanInvitation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <h3 class="page-title">સ્નેહમિલન આમંત્રણ પત્રિકા</h3>
    </div>

    <div class="col-lg-12 grid-margin stretch-card">
        <div style="width: 100%;">
            <div class="card">
                <div class="card-body" style="padding: 3.5rem 1.7rem;">
                    <iframe src="assets/images/Invitation/Saneh%20Milan__2024.pdf" style="width: 100%; max-height: 100vh; min-height: 76vh;overflow:auto;" id="myIframe" runat="server" onscroll="true" title="SnehMilan Invitation"></iframe>
                </div>
            </div>
            <br />
            <br />
            <br />
            <div class="card" >
                <div class="card-body d-flex justify-content-center">
                    <a href="assets/images/Invitation/Saneh Milan__2024.pdf" download="SnehMilan Invitation 2024" class="btn  btn-primary font-weight-medium auth-form-btn" runat="server" >Download SnehMilan Invitation</a>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

