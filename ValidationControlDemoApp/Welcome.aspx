<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Welcome.aspx.cs" Inherits="ValidationControlDemoApp.Welcome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

    
  


     

       


   

 <script type="text/javascript">
     function showRemarkPrompt(slno) {
         console.log('showRemarkPrompt called');
         document.getElementById('<%= hdnCurrentSLNo.ClientID %>').value = slno;
         document.getElementById('remarkPrompt').style.display = 'block';
         return false;
     }

 </script>


    <style>
        .modern-grid {
            border-collapse: collapse;
            width: 100%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }

        .modern-grid th {
            background-color: #007BFF;
            color: white;
            font-weight: bold;
            padding: 12px 15px;
            text-align: left;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }

        .modern-grid td {
            padding: 12px 15px;
            border-bottom: 1px solid #ddd;
        }

        .alt-row {
            background-color: #f2f2f2;
        }

        .modern-grid tr:hover {
            background-color: #D1DDF1;
            cursor: pointer;
            transition: background-color 0.3s ease-in-out;
        }

        .grid-footer {
            text-align: center;
            margin-top: 10px;
            padding: 10px;
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


        <asp:HiddenField ID="hdnUserChoice" runat="server" />
         <asp:HiddenField ID="hdnCurrentSLNo" runat="server" />



         <div id="remarkPrompt" style="display:none;">
            <label for="txtRemark">Enter Remark:</label>
            <asp:TextBox ID="txtRemark" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>
            <asp:Button ID="btnConfirmDelete" runat="server" ClientIDMode="Static" Text="Confirm Delete" OnClick="btnConfirmDelete_Click" style="margin-top: 10px;" />
        </div>




        <div>
            <h2><asp:Label ID="lblName" runat="server" Text=""></asp:Label></h2>

             <asp:GridView ID="Gridview1" style="width:100%" runat="server" DataKeyNames="slno" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None"  CssClass="modern-grid"   OnRowEditing="gvRecentUser_RowEditing" OnRowCancelingEdit="gvRecentUser_RowCancelingEdit1"   OnRowCommand="gvRecentUser_RowCommand">
            <AlternatingRowStyle BackColor="White" />
            <Columns>


              
                <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
                <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("SLNo") %>'
                    OnClientClick='<%# "return showRemarkPrompt(\"" + Eval("SLNo") + "\");" %>'>Delete</asp:LinkButton>

            </ItemTemplate>
        </asp:TemplateField>



               <asp:CommandField ShowEditButton="True" />

                <asp:TemplateField>
            <ItemTemplate>
                <asp:HiddenField ID="hfSlno" runat="server" Value='<%# Eval("slno") %>' />
<%--                <asp:HiddenField ID="hfUkey" runat="server" Value='<%# Eval("UniqueKey") %>' />--%>
            </ItemTemplate>
        </asp:TemplateField>




                <asp:TemplateField HeaderText="FirstName">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtFirstName" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("FirstName") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle BackColor="#66CCFF" CssClass="col-firstname" Font-Bold="True" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="LastName">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtLastName" runat="server" Text='<%# Bind("LastName") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("LastName") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle BackColor="#66CCFF" CssClass="col-lastname" Font-Bold="True" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="MobileNo">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtMobileNo" runat="server" Text='<%# Bind("MobileNo") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle BackColor="#66CCFF" CssClass="col-date" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="EmailId">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEmailId" runat="server" Text='<%# Bind("EmailId") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("EmailId") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle BackColor="#66CCFF" CssClass="col-date" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Password">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtPassword" runat="server" Text='<%# Bind("Password") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("Password") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle BackColor="#66CCFF" CssClass="col-date" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ComfirmPassword">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtComfirmPassword" runat="server" Text='<%# Bind("ComfirmPassword") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("ComfirmPassword") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle BackColor="#66CCFF" CssClass="col-room" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Address">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtAddress" runat="server" Text='<%# Bind("Address") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("Address") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle BackColor="#66CCFF" CssClass="col-roomtype" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Gender">
                <EditItemTemplate>
                    <asp:RadioButton ID="rdbMale" runat="server" Text="Male" GroupName="GenderGroup" value="Male" />
                    <asp:RadioButton ID="rdbFemale" runat="server" Text="Female" GroupName="GenderGroup" value="Female" />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label8" runat="server" Text='<%# Bind("Gender") %>'></asp:Label>
                </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle BackColor="#66CCFF" CssClass="col-roomtype" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="PinCode">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtPinCode" runat="server" Text='<%# Bind("PinCode") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label9" runat="server" Text='<%# Bind("PinCode") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle BackColor="#66CCFF" CssClass="col-roomtype" HorizontalAlign="Center" />
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
                            <asp:CheckBox ID="CheckBox1" runat="server"  Text='<%# Bind("Status") %>' />            

                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label11" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                        </ItemTemplate>
                     </asp:TemplateField>



                <%--<asp:TemplateField
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle BackColor="#66CCFF" CssClass="col-roomtype" HorizontalAlign="Center" />
                </asp:TemplateField>--%>
               <%-- <asp:BoundField DataField="Status" HeaderText="Status" >
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle CssClass="col-roomtype" HorizontalAlign="Center" BackColor="#66CCFF"></ItemStyle>
                </asp:BoundField>--%>
                
               
                
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>


        </div>

        <asp:Button ID="Button1" runat="server" Text="Register" OnClick="Button1_Click" CssClass="custom-button" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="lblMsg" runat="server" Text="Label"></asp:Label>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button2" runat="server" Text="Login" OnClick="Button2_Click" CssClass="custom-button"/>
    </form>
</body>
</html>
