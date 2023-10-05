<%@ Page Language="C#" UnobtrusiveValidationMode="None" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ValidationControlDemoApp.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        var urlParams = new URLSearchParams(window.location.search);
        var message = urlParams.get("message");

        if (message === "deleted") {
            alert("Record deleted successfully!");
        }
    </script>

    <title></title>
   
    <style type="text/css">
        .auto-style1 {
            width: 1216px;
        }
        .auto-style2 {
            width: 1549px;

        }

        .Watermark WatermarkText{
            opacity:0.5;
        }


        #TextBox1_TextBoxWatermarkExtender{
            color:antiquewhite;
        }


        /*btn*/
        .custom-button {
          
            background-color: #66FF66;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 2s
        }

        .custom-button:hover {
            background-color: #4CFF4C;
            color: white;
        }

        </style>
</head>
<body>
    <form id="form1" runat="server">

        <asp:HiddenField ID="hfSlno" runat="server" />
        <asp:HiddenField ID="hfUkey" runat="server" />

        <div class="auto-style2">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" />

            <table class="auto-style1">
                <tr>
                    <td colspan="2" style="text-align:center"><h1>User Registration</h1></td>
                </tr>
            </table>
            First Name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox ID="txtFirstName" runat="server" onkeydown="return /[a-z]/i.test(event.key)"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator" runat="server" ControlToValidate="txtFirstName" ForeColor="Red" ErrorMessage="Please provide FirstName" SetFocusOnError="True" ToolTip="Please provide FirstName" Display="Dynamic" Visible="False">Required</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Valid characters: Alphabets" ForeColor="Red" ControlToValidate="txtFirstName" ValidationExpression="[a-zA-Z ]*$"></asp:RegularExpressionValidator>
            <ajaxToolkit:TextBoxWatermarkExtender ID="TextBox1_TextBoxWatermarkExtender" runat="server" BehaviorID="TextBox1_TextBoxWatermarkExtender" TargetControlID="txtFirstName" WatermarkText="Enter Your First Name" >
                </ajaxToolkit:TextBoxWatermarkExtender>
            <br />
            <br />
            LastName:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox ID="txtLastName" runat="server" onkeydown="return /[a-z]/i.test(event.key)"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtLastName" ForeColor="Red" ErrorMessage="Please provide LastName" SetFocusOnError="True">Required</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Valid characters: Alphabets" ForeColor="Red" ControlToValidate="txtLastName" ValidationExpression="[a-zA-Z ]*$"></asp:RegularExpressionValidator>
            <ajaxToolkit:TextBoxWatermarkExtender ID="txtLastName_TextBoxWatermarkExtender1" runat="server" BehaviorID="txtLastName_TextBoxWatermarkExtender" TargetControlID="txtLastName" WatermarkText="Enter Your Last Name">
            </ajaxToolkit:TextBoxWatermarkExtender>
            <br />
            <br />
            
            MobileNo:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox ID="txtMobileNo" runat="server" MaxLength="10" TextMode="Phone" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtMobileNo" ErrorMessage="Please provide MobileNo" ForeColor="Red" SetFocusOnError="True" ToolTip="Please provide MobileNo">Required</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" ID="regexMobileNo" ControlToValidate="txtMobileNo" ValidationExpression="^\d{10}$" ForeColor="Red" ErrorMessage="Phone number must be exactly 10 digits"/>
            <%--<asp:CustomValidator ID="CustomValidator2" runat="server"  ControlToValidate="txtMobileNo" ForeColor="Red" ErrorMessage="Mobile No already exists." OnServerValidate="CustomValidator_EmailExists_ServerValidate" Display="Dynamic"></asp:CustomValidator>--%>

            <ajaxToolkit:TextBoxWatermarkExtender ID="txtMobileNo_TextBoxWatermarkExtender1" runat="server" BehaviorID="txtMobileNo_TextBoxWatermarkExtender1" TargetControlID="txtMobileNo" WatermarkText="Enter Your MobileNo" WatermarkCssClass="Watermark">
            </ajaxToolkit:TextBoxWatermarkExtender>
            <br />
            <br />
           <%-- MobileNo: <asp:TextBox ID="txtMobileNo" runat="server" MaxLength="10" TextMode="phone"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtMobileNo"
                          ErrorMessage="Please provide MobileNo" SetFocusOnError="True" ToolTip="Please provide MobileNo">Required</asp:RequiredFieldValidator>
                      <asp:RegularExpressionValidator runat="server" ID="regexMobileNo" ControlToValidate="txtMobileNo"
                          ValidationExpression="^[0-9]+$" ErrorMessage="Please enter a valid mobile number"/>
            <br />
            <br />--%>
            Email ID:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox ID="txtEmail" runat="server" ></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail" ForeColor="Red" ErrorMessage="Please enter valid Email Id" ValidationExpression="^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$"></asp:RegularExpressionValidator>
            <%--<asp:CustomValidator ID="CustomValidator1" runat="server"  ControlToValidate="txtEmail" ErrorMessage="Email already exists." ForeColor="Red" OnServerValidate="CustomValidator_EmailExists_ServerValidate" Display="Dynamic"></asp:CustomValidator>--%>
            <ajaxToolkit:TextBoxWatermarkExtender ID="txtEmail_TextBoxWatermarkExtender1" runat="server" BehaviorID="txtEmail_TextBoxWatermarkExtender" TargetControlID="txtEmail" WatermarkText="Enter Your Email">
            </ajaxToolkit:TextBoxWatermarkExtender>
            <br />
            <br />
            Password:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox ID="txtpwd" runat="server" ></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtpwd" ForeColor="Red" ErrorMessage="Please create a Password" SetFocusOnError="True">Required</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" ID="regexPwd" ControlToValidate="txtpwd" ValidationExpression="^.{8,20}$" ForeColor="Red" ErrorMessage="Password must be between 8 and 20 characters" Display="Dynamic" />
                   
            <ajaxToolkit:PasswordStrength ID="PasswordStrength1" runat="server" MinimumLowerCaseCharacters="2" MinimumNumericCharacters="2" MinimumSymbolCharacters="1" MinimumUpperCaseCharacters="1" PreferredPasswordLength="8" TargetControlID="txtpwd" HelpStatusLabelID="lblpwd" PrefixText="Password Strength: " RequiresUpperAndLowerCaseCharacters="True" StrengthIndicatorType="Text" BarBorderCssClass="" />
            <asp:Label ID="lblpwd" runat="server" Text="Label"></asp:Label>

            <br />
            <br />
            Comfirm Password:&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtcmpwd" runat="server"></asp:TextBox>
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtpwd" ControlToValidate="txtcmpwd" ForeColor="Red" Display="Dynamic" ErrorMessage="Please enter the match password" SetFocusOnError="True">*</asp:CompareValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtcmpwd" Display="Dynamic" ForeColor="Red" ErrorMessage="Please provide comfirm passowrd" SetFocusOnError="True">Required</asp:RequiredFieldValidator>          
            <br />
            <br />
             Address:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Height="67px" Width="164px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtAddress" ForeColor="Red" ErrorMessage="Please provide Address" SetFocusOnError="True" ToolTip="Please provide Address">Required</asp:RequiredFieldValidator>
            <ajaxToolkit:TextBoxWatermarkExtender ID="txtAddress_TextBoxWatermarkExtender1" runat="server" BehaviorID="txtAddress_TextBoxWatermarkExtender" TargetControlID="txtAddress" WatermarkText="Enter Your Address">
            </ajaxToolkit:TextBoxWatermarkExtender>
            <br />
            <br />

            Gender:  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<asp:RadioButton ID="rdbMale" runat="server" GroupName="Gender" Text="Male" />
            &nbsp;<asp:RadioButton ID="rdbFemale" runat="server" GroupName="Gender" Text="Female" />
            &nbsp;<br />
            <br />
             PinCode:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox ID="txtPinCode" runat="server" MaxLength="6" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtPinCode" ForeColor="Red" ErrorMessage="Please provide PinCode" SetFocusOnError="True" ToolTip="Please provide PinCode">Required</asp:RequiredFieldValidator>
            <ajaxToolkit:TextBoxWatermarkExtender ID="txtPinCode_TextBoxWatermarkExtender1" runat="server" BehaviorID="txtPinCode_TextBoxWatermarkExtender" TargetControlID="txtPinCode" WatermarkText="Enter Your PinCode">
            </ajaxToolkit:TextBoxWatermarkExtender>
            <br />
            <br />
            
           
            
            
            Country:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:DropDownList ID="ddlCountry" runat="server">
                <asp:ListItem Value="-1">(Select One)</asp:ListItem>
                <asp:ListItem Value="India">India</asp:ListItem>
                <asp:ListItem Value="USA">USA</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlCountry" ForeColor="Red" ErrorMessage="Please Select Country" InitialValue="-1" SetFocusOnError="True">Required</asp:RequiredFieldValidator>
            <br />
            <br />


            <div>
                Status:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:CheckBox ID="CheckBox1" runat="server" />
                <asp:Label ID="Label1" runat="server" Visible="False"></asp:Label>
            </div>


            <br />
            <br />
           <div> 
               <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" BackColor="#66FF66" BorderColor="#66FF66"  CssClass="custom-button"/>

           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <asp:Button ID="btnSave" runat="server" Text="Save Changes" OnClick="btnSave_Click" Visible="false"  BackColor="#66FF66" BorderColor="#66FF66"  CssClass="custom-button" />
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <asp:Label ID="lblMsg" runat="server" Visible="False"></asp:Label>

           </div>
            &nbsp;&nbsp;
            <br />
            <br />
            <br />
            
        </div>


        

       


        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        

    </form>
</body>
</html>

