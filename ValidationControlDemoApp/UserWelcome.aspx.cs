using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ValidationControlDemoApp
{
    public partial class UserWelcome : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserEmail"] != null)
                {
                    string userEmail = Session["UserEmail"].ToString();
                    //LoadUserBookedRoomDetails(userEmail);
                    BindGridView();

                    lblName.Text = Session["UserName"].ToString();
                }
                else
                {
                    Response.Write("User email not available.");
                }





                if (ViewState["DeletedRows"] == null)
                {
                    ViewState["DeletedRows"] = new List<int>();
                }



                ClientScriptManager cs = Page.ClientScript;
                cs.RegisterForEventValidation("gvRecentUser", "DeleteRow|1");


            }
        }



        


        protected void LoadUserBookedRoomDetails(string userEmail)
        {
           // string connectionString = @"Data Source=.\SQL2022;Initial Catalog=Work;Integrated Security=True";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "select * from Registrationtbl2 Where EmailId = @EmailId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@EmailId", userEmail);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                gvRecentUser.DataSource = reader;
                gvRecentUser.DataBind();

                reader.Close();


            }

        }




        private (string password, string confirmPwd) GetPasswordAndConfirmPassword(int slno)
        {
           // string connectionString = @"Data Source=.\SQL2022;Initial Catalog=Work;Integrated Security=True";
            string password = "";
            string confirmPwd = "";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT Password, ComfirmPassword FROM Registrationtbl2 WHERE slno = @slno";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@slno", slno);
                    con.Open();

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        password = reader["Password"].ToString();
                        confirmPwd = reader["ComfirmPassword"].ToString();
                    }
                }
            }

            return (password, confirmPwd);
        }





        protected void gvRecentUser_RowEditing(object sender, GridViewEditEventArgs e)
        {
            //gvRecentUser.EditIndex = e.NewEditIndex;
            ////FillData();
            //LoadUserBookedRoomDetails(Session["UserEmail"].ToString());
            try
            {

                GridViewRow selectedRow = gvRecentUser.Rows[e.NewEditIndex];

                HiddenField hfSlno = (HiddenField)selectedRow.FindControl("hfSlno");
                HiddenField hfUkey = (HiddenField)selectedRow.FindControl("hfUkey");
                string slno = hfSlno.Value;
                //string slno = Session["UserSlno"].ToString();
                //  Guid uniqueKey = (Guid)Session["UserUKey"];
                //  string UniqueKey = uniqueKey.ToString();
                string UniqueKey = hfUkey.Value;

                string firstName = ((Label)selectedRow.FindControl("Label1")).Text;
                string lastName = ((Label)selectedRow.FindControl("Label2")).Text;
                string mobileNo = ((Label)selectedRow.FindControl("Label3")).Text;
                string emailId = ((Label)selectedRow.FindControl("Label4")).Text;
                //string password = ((Label)selectedRow.FindControl("Label5")).Text;
                //string confirmPwd = ((Label)selectedRow.FindControl("Label6")).Text;
                (string password, string confirmPwd) = GetPasswordAndConfirmPassword(Convert.ToInt32(hfSlno.Value));
                string address = ((Label)selectedRow.FindControl("Label7")).Text;
                string gender = ((Label)selectedRow.FindControl("Label8")).Text;
                string pinCode = ((Label)selectedRow.FindControl("Label9")).Text;
                string country = ((Label)selectedRow.FindControl("Label10")).Text;
                string status = ((Label)selectedRow.FindControl("Label11")).Text;

                string redirectUrl = $"default.aspx?slno={slno}&UniqueKey={UniqueKey}&FirstName={firstName}&LastName={lastName}&MobileNo={mobileNo}&EmailId={emailId}&Password={password}&ComfirmPassword={confirmPwd}&Address={address}&Gender={gender}&PinCode={pinCode}&Country={country}&status={status}";

                Response.Redirect(redirectUrl);

            }
            catch (NullReferenceException ex)
            {
                Response.Write("An error occurred: " + ex.Message);
            }


        }


        protected void gvRecentUser_RowCancelingEdit1(object sender, GridViewCancelEditEventArgs e)
        {
            gvRecentUser.EditIndex = -1;
        }


        protected void gvRecentUser_RowUpdating1(object sender, GridViewUpdateEventArgs e)
        {
            // Get the edited row
            GridViewRow row = gvRecentUser.Rows[e.RowIndex];

            // Find the controls in the row
            //TextBox txtId = (TextBox)row.FindControl("txtId");
            TextBox txtFirstName = (TextBox)row.FindControl("txtFirstName");
            TextBox txtLastName = (TextBox)row.FindControl("txtLastName");
            TextBox txtMobileNo = (TextBox)row.FindControl("txtMobileNo");
            TextBox txtEmail = (TextBox)row.FindControl("txtEmailId");
            TextBox txtpwd = (TextBox)row.FindControl("txtPassword");
            TextBox txtcmpwd = (TextBox)row.FindControl("txtComfirmPassword");
            TextBox txtAddress = (TextBox)row.FindControl("txtAddress");
            TextBox txtPinCode = (TextBox)row.FindControl("txtPinCode");
            RadioButton rdbMale = (RadioButton)row.FindControl("rdbMale");
            RadioButton rdbFemale = (RadioButton)row.FindControl("rdbFemale");
            DropDownList ddlCountry = (DropDownList)row.FindControl("ddlCountry");

            int slno = Convert.ToInt32(gvRecentUser.DataKeys[e.RowIndex].Values["slno"]);
            string FName = txtFirstName.Text;
            string LName = txtLastName.Text;
            long Mobileno = Convert.ToInt64(txtMobileNo.Text);
            string EmailId = txtEmail.Text;
            string Pwd = txtpwd.Text;
            string CmfPwd = txtcmpwd.Text;
            string Address = txtAddress.Text;
            string Gender = string.Empty;

            if (rdbMale.Checked)
            {
                Gender = "Male";
            }
            else if (rdbFemale.Checked)
            {
                Gender = "Female";
            }

            long Pincode = Convert.ToInt64(txtPinCode.Text);
            string Country = ddlCountry.SelectedValue;

           // string connectionString = @"Data Source=.\SQL2022;Initial Catalog=Work;Integrated Security=True";
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                try
                {
                    con.Open();
                    string query = "sp_UpdateUserRegisterDatatbl2";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@slno", slno);
                    cmd.Parameters.AddWithValue("@FirstName", FName);
                    cmd.Parameters.AddWithValue("@LastName", LName);
                    cmd.Parameters.AddWithValue("@MobileNo", Mobileno);
                    cmd.Parameters.AddWithValue("@EmailId", EmailId);
                    cmd.Parameters.AddWithValue("@Password", Pwd);
                    cmd.Parameters.AddWithValue("@ComfirmPassword", CmfPwd);
                    cmd.Parameters.AddWithValue("@Address", Address);
                    cmd.Parameters.AddWithValue("@Gender", Gender);
                    cmd.Parameters.AddWithValue("@Pincode", Pincode);
                    cmd.Parameters.AddWithValue("@Country", Country);
                    
                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        gvRecentUser.EditIndex = -1;
                        LoadUserBookedRoomDetails(Session["UserEmail"].ToString());

                        string script = "Swal.fire({ title: 'Success!', text: 'Thank You', icon: 'success' }).then(() => { window.location = 'Welcome.aspx'; });";
                        ClientScript.RegisterStartupScript(this.GetType(), "BookingSuccessAlert", script, true);
                    }
                    else
                    {
                        lblMsg.Text = "No data updated.";
                    }
                }
                catch (Exception ex)
                {
                    lblMsg.Text = "An error occurred: " + ex.Message;
                }
            }
        }






        protected void gvRecentUser_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[7].Text = "*******";
                e.Row.Cells[8].Text = "*******";

            }


        }


        //protected void gvRecentUser_RowDeleting1(object sender, GridViewDeleteEventArgs e)
        //{
        //    int slno = Convert.ToInt32(gvRecentUser.DataKeys[e.RowIndex].Value);

        //    if (Session["DeleteConfirmed"] != null && (bool)Session["DeleteConfirmed"])
        //    {
        //        string remark = Session["DeleteRemark"].ToString();

        //        using (SqlConnection con = new SqlConnection(@"Data Source=.\SQL2022;Initial Catalog=Work;Integrated Security=True"))
        //        {
        //            using (SqlCommand cmd = new SqlCommand("sp_DeleteUserRecord", con))
        //            {
        //                cmd.CommandType = CommandType.StoredProcedure;
        //                cmd.Parameters.AddWithValue("@slno", slno);
        //                cmd.Parameters.AddWithValue("@remark", remark);

        //                con.Open();
        //                cmd.ExecuteNonQuery();
        //            }
        //        }

        //        Session["DeleteConfirmed"] = false;
        //        Session.Remove("DeleteRemark");

        //        BindGridView();
        //    }
        //    else
        //    {
        //        lblMsg.Text = "Delete operation was canceled.";
        //    }
        //}


        //protected void gvRecentUser_RowDeleting1(object sender, GridViewDeleteEventArgs e)
        //{
        //    int slno = Convert.ToInt32(gvRecentUser.DataKeys[e.RowIndex].Value);
        //    string remark = "old id need to be deleted from registration!!";
        //    string connectionString = @"Data Source=.\SQL2022;Initial Catalog=Work;Integrated Security=True";

        //    using (SqlConnection con = new SqlConnection(connectionString))
        //    {
        //        con.Open();

        //        using (SqlCommand cmd = new SqlCommand("sp_DeleteUserRegisterRecord", con))
        //        {
        //            cmd.CommandType = CommandType.StoredProcedure;
        //            cmd.Parameters.AddWithValue("@slno", slno);
        //            cmd.Parameters.AddWithValue("@delUid", slno); // This depends on your specific requirements
        //            cmd.Parameters.AddWithValue("@remark", remark);

        //            cmd.ExecuteNonQuery();
        //        }
        //    }

        //    Response.Redirect("Default.aspx?message=deleted");

        //    gvRecentUser.DeleteRow(e.RowIndex);
        //}


        //protected void gvRecentUser_RowDeleting1(object sender, GridViewDeleteEventArgs e)
        //{
        //    int slno = Convert.ToInt32(gvRecentUser.DataKeys[e.RowIndex].Value);

        //    string remark = hdnRemark.Value;

        //    string connectionString = @"Data Source=.\SQL2022;Initial Catalog=Work;Integrated Security=True";

        //    using (SqlConnection con = new SqlConnection(connectionString))
        //    {
        //        con.Open();

        //        using (SqlCommand cmd = new SqlCommand("sp_DeleteUserRegisterRecord", con))
        //        {
        //            cmd.CommandType = CommandType.StoredProcedure;
        //            cmd.Parameters.AddWithValue("@slno", slno);
        //            cmd.Parameters.AddWithValue("@delUid", slno);
        //            cmd.Parameters.AddWithValue("@remark", remark);

        //            cmd.ExecuteNonQuery();
        //        }
        //    }

        //    Response.Redirect("Default.aspx?message=deleted");

        //    gvRecentUser.DeleteRow(e.RowIndex);
        //}

        protected void gvRecentUser_RowDeleting1(object sender, GridViewDeleteEventArgs e)
        {

        }





        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            string slno = hdnCurrentSLNo.Value;
            string remark = txtRemark.Text;

            if (string.IsNullOrWhiteSpace(remark))
            {
                return;
            }

            if (sender is LinkButton)
            {
                LinkButton lnkDelete = (LinkButton)sender;

                GridViewRow row = (GridViewRow)lnkDelete.NamingContainer;

                if (row != null)
                {
                    string dataField = DataBinder.Eval(row.DataItem, "ColumnName").ToString();

                }
            }

            string commandName = "Delete";
            string commandArgument = slno;
            gvRecentUser_RowCommand(gvRecentUser, new GridViewCommandEventArgs(gvRecentUser, new CommandEventArgs(commandName, commandArgument)));
        }



        protected void btnCancelDelete_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showAlert", "alert('Are you sure you want to cancel or delete?');", true);
        }





        //private (int slno, Guid UniqueKey) GetSlnoAndUniqueKey(int deleteslno)
        //{
        //    int slno = 0;
        //    Guid uniqueKey = Guid.Empty;

        //    string connectionString = @"Data Source=.\SQL2022;Initial Catalog=Work;Integrated Security=True";
        //    using (SqlConnection con = new SqlConnection(connectionString))
        //    {
        //        string query = "SELECT slno, UniqueKey FROM Registrationtbl2 WHERE slno = @slno";
        //        SqlCommand cmd = new SqlCommand(query, con);
        //        cmd.Parameters.AddWithValue("@slno", slno);

        //        con.Open();
        //        SqlDataReader reader = cmd.ExecuteReader();

        //        if (reader.Read())
        //        {
        //            slno = reader.GetInt32(0);
        //            uniqueKey = reader.GetGuid(1);
        //        }

        //        con.Close();
        //    }

        //    return (slno, uniqueKey);
        //}






        public int GetSlno()
        {
            if (Session["UserSlno"] != null)
            {
                return (int)Session["UserSlno"];
            }
            else
            {
                return 0;
            }
        }


        protected void gvRecentUser_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                int slno = Convert.ToInt32(e.CommandArgument);

                string remark = txtRemark.Text;

                int Delteteslno = GetSlno();

                Session["UserSlno"] = Delteteslno;

                // int userSlno = GetSlno();


                //string connectionString = @"Data Source=.\SQL2022;Initial Catalog=Work;Integrated Security=True";

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Open();

                        using (SqlCommand cmd = new SqlCommand("sp_DeleteUserRegisterRecord", connection))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;

                            cmd.Parameters.AddWithValue("@slno", slno);
                            cmd.Parameters.AddWithValue("@delUid", Delteteslno);
                           //cmd.Parameters.AddWithValue("@UserSlno", userSlno);
                            cmd.Parameters.AddWithValue("@remark", remark);

                            int rowsAffected = cmd.ExecuteNonQuery();

                            if (rowsAffected > 0)
                            {

                                //(int slno2, Guid UniqueKey) = GetSlnoAndUniqueKey(deleteslno);



                                //Session["UserSlno"] = slno2;
                                //Session["UserUKey"] = UniqueKey;
                                ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('Delete Successful!');", true);
                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('Data present delete not permitted!');", true);
                            }
                        }

                         BindGridView();
                    }
                
            }
        }








        private void BindGridView()
        {
            //string connectionString = @"Data Source=.\SQL2022;Initial Catalog=Work;Integrated Security=True";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                //string query = "select * from Registrationtbl2 where delUid is null order by slno desc";
                string query = "sp_AllUsers";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.CommandType = CommandType.StoredProcedure;

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                gvRecentUser.DataSource = reader;
                gvRecentUser.DataBind();

                reader.Close();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }







        //protected void gvRecentUser_RowCommand(object sender, GridViewCommandEventArgs e)
        //{
        //    if (e.CommandName == "Delete")
        //    {
        //        int rowIndex = Convert.ToInt32(e.CommandArgument); 
        //        int slno = Convert.ToInt32(gvRecentUser.DataKeys[rowIndex].Value); 

        //        List<int> deletedRows = (List<int>)ViewState["DeletedRows"];

        //        deletedRows.Add(slno);

        //        gvRecentUser.DeleteRow(rowIndex);

        //        BindGridView();
        //    }
        //}




       




    }
}