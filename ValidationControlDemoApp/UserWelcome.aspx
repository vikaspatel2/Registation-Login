<%@ Page Language="C#" EnableViewState="true" AutoEventWireup="true" CodeBehind="UserWelcome.aspx.cs" Inherits="ValidationControlDemoApp.UserWelcome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
  


     <style>
    .edit-button {
        background-color: #007bff;
        color: #fff;
        border: none;
        padding: 5px 10px;
        border-radius: 4px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 14px;
        margin: 2px 2px;
        cursor: pointer;
    }

    .delete-button {
        background-color: #dc3545;
        color: #fff;
        border: none;
        padding: 5px 10px;
        border-radius: 4px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 14px;
        margin: 2px 2px;
        cursor: pointer;
    }


    #remarkPrompt {
    display: none;
    text-align: center;
    padding: 20px;
    background-color: #f0f0f0;
    border: 1px solid #ccc;
    border-radius: 5px;
    width: 300px;
    margin: 0 auto;
    }

    #remarkPrompt label {
        display: block;
        font-weight: bold;
        margin-bottom: 10px;
    }

    #txtRemark {
        width: 100%;
        padding: 5px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 3px;
    }

    #btnConfirmDelete,
    #btnCancelDelete {
        background-color: #007bff;
        color: #fff;
        border: none;
        padding: 10px 20px;
        border-radius: 3px;
        cursor: pointer;
    }

    #btnConfirmDelete:hover,
    #btnCancelDelete:hover {
        background-color: #0056b3;
    }



    .custom-button {
        background-color: #4CAF50; 
        color: white; 
        padding: 10px 20px;
        border: none; 
        cursor: pointer; 
        border-radius: 5px; 
        text-align: center; 
        text-decoration: none;
        display: inline-block; 
        font-size: 16px;
    }

    .custom-button:hover {
        background-color: #45a049;
    }


</style>


       


   

 <script type="text/javascript">
     function showRemarkPrompt(slno) {
         console.log('showRemarkPrompt called');
         document.getElementById('<%= hdnCurrentSLNo.ClientID %>').value = slno;
         document.getElementById('remarkPrompt').style.display = 'block';
         return false;
     }

 </script>







   




    <title></title>
</head>
<body>
     <form id="form1" runat="server">





         <asp:HiddenField ID="hdnUserChoice" runat="server" />
         <asp:HiddenField ID="hdnCurrentSLNo" runat="server" />




       <%--  <asp:HiddenField ID="hidPassword" runat="server" />
        <asp:HiddenField ID="hidConfirmPassword" runat="server" />--%>


         <asp:ScriptManager ID="ScriptManager1" runat="server" />
            <%--<Triggers>
                <asp:PostBackTrigger ControlID="btnCancelDelete" />
            </Triggers>--%>
     <%--   </asp:ScriptManager>--%>

            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="RemarkGrp" DisplayMode="BulletList" />
                 <div id="remarkPrompt" style="display:none;">
                    <label for="txtRemark">Enter Remark:</label>
                    <asp:TextBox ID="txtRemark" runat="server" ClientIDMode="Static" CssClass="form-control" ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator" runat="server" ControlToValidate="txtRemark" ForeColor="Red" ErrorMessage="Please provide Remark" ValidationGroup="RemarkGrp" SetFocusOnError="True" ToolTip="Please provide FirstName" Display="Dynamic" Visible="False">Required</asp:RequiredFieldValidator>
                    <asp:Button ID="btnConfirmDelete" runat="server" ClientIDMode="Static" Text="Confirm Delete" OnClick="btnConfirmDelete_Click" ValidationGroup="RemarkGrp" style="margin-top: 10px;" />

                
                     <asp:Button ID="btnCancelDelete" runat="server" ClientIDMode="Static" Text="Cancel" OnClick="btnCancelDelete_Click" UseSubmitBehavior="false" CausesValidation="false" style="margin-top: 10px;" />
                </div>

            </ContentTemplate>
                <Triggers>
        <asp:PostBackTrigger ControlID="btnConfirmDelete" />
    </Triggers>
        </asp:UpdatePanel>



        <div>
                    <h2>Welcome &nbsp <asp:Label ID="lblName" runat="server" Text=""></asp:Label></h2>

            <asp:GridView ID="gvRecentUser" runat="server" DataKeyNames="slno" KeyFieldName="SLNo" AutoGenerateColumns="False" OnRowEditing="gvRecentUser_RowEditing" OnRowCancelingEdit="gvRecentUser_RowCancelingEdit1" OnRowUpdating="gvRecentUser_RowUpdating1"  OnRowCommand="gvRecentUser_RowCommand" OnRowDeleting="gvRecentUser_RowDeleting1" Width="100%" CssClass="modern-grid"  OnRowDataBound="gvRecentUser_RowDataBound">
    <Columns>
        <asp:CommandField ShowEditButton="True"  ControlStyle-CssClass="edit-button"/>



        <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
                <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CssClass="delete-button" CommandArgument='<%# Eval("SLNo") %>'
                    OnClientClick='<%# "return showRemarkPrompt(\"" + Eval("SLNo") + "\");" %>'>Delete</asp:LinkButton>

            </ItemTemplate>
        </asp:TemplateField>



       <%-- <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
                <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("SLNo") + ";" + Eval("Remark") %>'
    OnClientClick='<%# "return showRemarkPrompt(" + Eval("SLNo") + ", \"" + Eval("Remark") + "\");" %>'>Delete</asp:LinkButton>


            </ItemTemplate>
        </asp:TemplateField>--%>

   

        <%--<asp:TemplateField>
            <ItemTemplate>
                <asp:LinkButton ID="lnkDelete" runat="server" CommandArgument='<%# Eval("SLNo") %>'
                    OnClientClick="return showRemarkPrompt(); return confirmDelete();" OnCommand="CmdDelete_Command">Delete</asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>--%>





        <%--<asp:TemplateField >
            <ItemTemplate>
                <asp:LinkButton ID="lnkData" EnableViewState="false" runat="server"
                    CommandArgument= '<%# Eval("SLNo") + ", " + Eval("UniqueKey") %>'></asp:LinkButton>
            </ItemTemplate>

        </asp:TemplateField>
        --%>

 


     <%--    <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkDelete" runat="server" CommandArgument='<%# Eval("SLNo") %>' OnClientClick="javascript:return confirm('Do you really want to delete?');'yes,no'" Text="Delete" OnCommand="CmdDelete_Command" >Delete</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
--%>


        <asp:TemplateField>
            <ItemTemplate>
                <asp:HiddenField ID="hfSlno" runat="server" Value='<%# Eval("slno") %>' />
                <asp:HiddenField ID="hfUkey" runat="server" Value='<%# Eval("UniqueKey") %>' />
            </ItemTemplate>
        </asp:TemplateField>
      

        


        <asp:TemplateField HeaderText="First Name">
            <EditItemTemplate>
                <asp:TextBox ID="txtFirstName" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("FirstName") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Last Name">
            <EditItemTemplate>
                <asp:TextBox ID="txtLastName" runat="server" Text='<%# Bind("LastName") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# Bind("LastName") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="MobileNo">
            <EditItemTemplate>
                <asp:TextBox ID="txtMobileNo" runat="server" Text='<%# Bind("MobileNo") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label3" runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="EmailId">
            <EditItemTemplate>
                <asp:TextBox ID="txtEmailId" runat="server" Text='<%# Bind("EmailId") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label4" runat="server" Text='<%# Bind("EmailId") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Password">
            <EditItemTemplate>
                <asp:TextBox ID="txtPassword" runat="server" Text='<%# Bind("Password") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label5" runat="server" Text='<%# Bind("Password") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="ComfirmPassword">
            <EditItemTemplate>
                <asp:TextBox ID="txtComfirmPassword" runat="server" Text='<%# Bind("ComfirmPassword") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label6" runat="server" Text='<%# Bind("ComfirmPassword") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Address">
            <EditItemTemplate>
                <asp:TextBox ID="txtAddress" runat="server" Text='<%# Bind("Address") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label7" runat="server" Text='<%# Bind("Address") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Gender">
            <EditItemTemplate>
                <asp:RadioButton ID="rdbMale" runat="server" Text="Male" GroupName="GenderGroup" value="Male" />
                <asp:RadioButton ID="rdbFemale" runat="server" Text="Female" GroupName="GenderGroup" value="Female" />
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label8" runat="server" Text='<%# Bind("Gender") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="PinCode">
            <EditItemTemplate>
                <asp:TextBox ID="txtPinCode" runat="server" Text='<%# Bind("PinCode") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label9" runat="server" Text='<%# Bind("PinCode") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Country">
            <EditItemTemplate>
                <asp:DropDownList ID="ddlCountry" runat="server" SelectedValue='<%# Bind("Country") %>'>
                    <asp:ListItem Text="India" Value="India" />
                    <asp:ListItem Text="USA" Value="USA" />
                </asp:DropDownList>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label10" runat="server" Text='<%# Bind("Country") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Status">
            <EditItemTemplate>
               <%-- <asp:CheckBox ID="CheckBox1" runat="server"  Text='<%# Bind("Status") %>' />  --%>          
            <asp:CheckBox ID="CheckBox1" runat="server" Text="Active" value="Active"  />               
            <asp:CheckBox ID="CheckBox2" runat="server" Text="InActive" value="InActive"  />               

            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label11" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>


         <asp:TemplateField HeaderText="lmodifybyName">
            <EditItemTemplate>
                <asp:TextBox ID="txtlmodifybyName" runat="server" Text='<%# Bind("lmodifybyName") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label12" runat="server" Text='<%# Bind("lmodifybyName") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>


         <asp:TemplateField HeaderText="lmodifydt">
            <EditItemTemplate>
                <asp:TextBox ID="txtlmodifydt" runat="server" Text='<%# Bind("lmodifydt") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label14" runat="server" Text='<%# Bind("lmodifydt") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>




        <asp:TemplateField HeaderText="createbyName">
            <EditItemTemplate>
                <asp:TextBox ID="txtcreatebyName" runat="server" Text='<%# Bind("createbyName") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label13" runat="server" Text='<%# Bind("createbyName") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="createdt">
            <EditItemTemplate>
                <asp:TextBox ID="txtcreatedt" runat="server" Text='<%# Bind("createdt") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label15" runat="server" Text='<%# Bind("createdt") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>

    </Columns>
</asp:GridView>


            <br />

            <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>

    </div>





<%--          <div id="deleteModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h2>Delete Confirmation</h2>
        <p>Enter a remark for deletion:</p>
        <asp:TextBox ID="txtRemark" runat="server"></asp:TextBox>
        <asp:Button ID="btnConfirmDelete" runat="server" Text="Yes" OnClientClick="return confirmDelete();" />
        <asp:Button ID="btnCancelDelete" runat="server" Text="No" OnClientClick="closeModal()"></asp:Button>
    </div>
</div>



    <asp:HiddenField ID="hdnRemark" runat="server" />--%>




         <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>


         
        <asp:Button ID="Button1" runat="server" Text="Register" OnClick="Button1_Click" CssClass="custom-button" />
    


    </form>






</body>


   
</html>
