<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="ValidationControlDemoApp.LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="CSS/StyleSheet1.css" rel="stylesheet" />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>

    <form id="form1" runat="server">

             <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>


        <div class="container-fluid">
            <p class="subtitle text-center">Sign In</p>

            <div class="contendor row" style="padding-left: 200px;">
                <div class="col-md-6 col-md-offset-3"> 
                    <div class="content-form">            

                        <div class="form-group">
                            <label for="txtEmail" class="col-sm-2 control-label">Email</label>
                            <div class="col-sm-10">
                                <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" placeholder="Email" Required="true" TextMode="Email"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="txtPwd" class="col-sm-2 control-label">Password</label>
                            <div class="col-sm-10">
                                <asp:TextBox runat="server" ID="txtPwd" CssClass="form-control" placeholder="Password" Required="true" TextMode="Password"></asp:TextBox>
                            </div>
                        </div>

                        <asp:Button ID="saved" CssClass="btn btn-warning btn-lg btn-block" runat="server" Text="Sign In" OnClick="saved_Click"  />
                    &nbsp;
                        <asp:Label ID="lblError" runat="server" Visible="False"></asp:Label>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                        <div>

                            <br />
                            <br />

                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>

                                Didn`t Have an Account. Click on Register
                                <br />
                                <asp:Button ID="btnregister" CssClass="btn btn-warning btn-lg btn-block" runat="server" Text="Register" OnClick="Register_Click" CausesValidation="false" UseSubmitBehavior="false" ValidationGroup="registerValidate"  />

                                    </ContentTemplate>
                                </asp:UpdatePanel>
                         </div>

                    </div>
                </div>
            </div>
        </div>

    

        
    </form>
</body>
</html>
