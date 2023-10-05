<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateData.aspx.cs" Inherits="ValidationControlDemoApp.UpdateData" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style5 {
            width: 250px;
            height: 50px;
        }
        .auto-style6 {
            height: 50px;
        }
        .auto-style7 {
            width: 250px;
            height: 52px;
        }
        .auto-style8 {
            height: 52px;
        }
        .auto-style9 {
            width: 250px;
            height: 61px;
        }
        .auto-style10 {
            height: 61px;
        }
        .auto-style11 {
            width: 250px;
            height: 60px;
        }
        .auto-style12 {
            height: 60px;
        }
        .auto-style13 {
            width: 250px;
            height: 58px;
        }
        .auto-style14 {
            height: 58px;
        }
        .auto-style15 {
            width: 250px;
            height: 64px;
        }
        .auto-style16 {
            height: 64px;
        }
        .auto-style17 {
            width: 250px;
            height: 56px;
        }
        .auto-style18 {
            height: 56px;
        }
        .auto-style19 {
            width: 250px;
            height: 54px;
        }
        .auto-style20 {
            height: 54px;
        }
        .auto-style22 {
            height: 57px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>

        </div>
    <table class="auto-style1">
        <tr>
            <td class="auto-style5">CreateUid</td>
            <td class="auto-style6">
                <asp:TextBox ID="TextBox1" runat="server" Height="41px" Width="179px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style7">CreateDt</td>
            <td class="auto-style8">
                <asp:TextBox ID="TextBox2" runat="server" Height="41px" Width="179px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style9">LModifyBy</td>
            <td class="auto-style10">
                <asp:TextBox ID="TextBox3" runat="server" Height="41px" Width="179px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style11">LModifydt</td>
            <td class="auto-style12">
                <asp:TextBox ID="TextBox4" runat="server" Height="41px" Width="179px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style13">DelUid</td>
            <td class="auto-style14">
                <asp:TextBox ID="TextBox5" runat="server" Height="41px" Width="179px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style15">DelDt</td>
            <td class="auto-style16">
                <asp:TextBox ID="TextBox6" runat="server" Height="41px" Width="179px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style17">Remark</td>
            <td class="auto-style18">
                <asp:TextBox ID="TextBox7" runat="server" Height="41px" Width="179px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style19"></td>
            <td class="auto-style20"></td>
        </tr>
        <tr>
            <td class="auto-style22" colspan="2" style="text-align:center">
                <asp:Button ID="Button1" runat="server" Height="46px" Text="Button" Width="119px" OnClick="Button1_Click" />
                &nbsp;</td>
        </tr>
    </table>
    </form>
    </body>
</html>
