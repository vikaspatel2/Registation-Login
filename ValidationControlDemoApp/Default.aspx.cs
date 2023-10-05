using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace ValidationControlDemoApp
{
    public partial class Default : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["slno"] != null)
                {
                    //hfSlno.Value = Session["UserSlno"].ToString();

                    //if (Session["UserUKey"] != null)
                    //{
                    //    Guid uniqueKey = (Guid)Session["UserUKey"];
                    //    string UniqueKey = uniqueKey.ToString();
                    //}
                    //else
                    //{
                    //    Response.Write("Session  UserUKey is null or not set.");
                    //}


                    hfSlno.Value = Request.QueryString["slno"];
                    hfUkey.Value = Request.QueryString["UniqueKey"];

                    txtFirstName.Text = Request.QueryString["FirstName"];
                    txtLastName.Text = Request.QueryString["LastName"];
                    txtMobileNo.Text = Request.QueryString["MobileNo"];
                    txtEmail.Text = Request.QueryString["EmailId"];
                    txtpwd.Text = Request.QueryString["Password"];
                    txtcmpwd.Text = Request.QueryString["ComfirmPassword"];
                    txtAddress.Text = Request.QueryString["Address"];
                    string gender = Request.QueryString["Gender"];
                    if (gender == "Male")
                    {
                        rdbMale.Checked = true;
                    }
                    else if (gender == "Female")
                    {
                        rdbFemale.Checked = true;
                    }
                    txtPinCode.Text = Request.QueryString["PinCode"];
                    string country = Request.QueryString["Country"];
                    ddlCountry.SelectedValue = country;
                    string status = Request.QueryString["status"];
                    CheckBox1.Checked = (status == "Active");


                    btnSave.Visible = true;
                    btnSubmit.Visible = false;
                }




                //if (Session["FirstName"] != null && Session["EmailId"] != null)
                //{
                //    string firstName = Session["FirstName"].ToString();
                //    string emailId = Session["EmailId"].ToString();

                //    txtFirstName.Text = firstName;
                //    txtEmail.Text = emailId;
                //}



            }
        }




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






        protected void btnSave_Click(object sender, EventArgs e)
        {

            // int slnoToUpdate = GetSelectedSlnoFromDatabase();

            string slnoToUpdate = hfSlno.Value;
            //string slnoToUpdate = Session["UserSlno"].ToString();
            //if (Session["UserUKey"] != null)
            //{
                //Guid uniqueKey = (Guid)Session["UserUKey"];
                //string UkeyToUpdate = uniqueKey.ToString();
            //}
           

            string UkeyToUpdate = hfUkey.Value;

            string updatedFirstName = txtFirstName.Text;
            string updatedLastName = txtLastName.Text;
            long updatedMobileNo = long.Parse(txtMobileNo.Text);
            string updatedEmailId = txtEmail.Text;

            Console.WriteLine($"Email: {updatedEmailId}, Mobile: {updatedMobileNo}");

            string updatedPassword = txtpwd.Text;
            string updatedComfirmPassword = txtcmpwd.Text;
            string updatedAddress = txtAddress.Text;
            string updatedGender = string.Empty;

            if (rdbMale.Checked)
            {
                updatedGender = "Male";
            }
            else if (rdbFemale.Checked)
            {
                updatedGender = "Female";
            }

            long updatedPincode = long.Parse(txtPinCode.Text);
            string updatedCountry = ddlCountry.SelectedValue;
            string updatedStatus = CheckBox1.Checked ? "Active" : "Inactive";

            //int createUid = 0;int lmodifyby = 0;
            DateTime lmodifydt = DateTime.Now;

            int slno = Convert.ToInt32(Session["UserSlno"]);

            //int slno = GetSlno(); 

            //Session["UserSlno"] = slno;

            //int slno = Convert.ToInt32(Session["UserSlno"]);

            //int createUid = GetCreateUidFromDatabase(updatedEmailId);

            //string uniqueKey = Guid.NewGuid().ToString();
            //Session["slno"] = createUid;
            //Session["UniqueKey"] = uniqueKey;

            try
            {
                //string connectionString = @"Data Source=.\SQL2022;Initial Catalog=Work;Integrated Security=True";
                using (SqlConnection con = new SqlConnection(connectionString))
                {


                
                        try
                        {
                            con.Open();
                            // string query = "sp_UpdateUserRegisterDatatbl2";
                            string query = "sp_UpdateUserDatatbl2";

                            SqlCommand cmd = new SqlCommand(query, con);
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@slno", slnoToUpdate);
                            cmd.Parameters.AddWithValue("@UniqueKey", UkeyToUpdate);
                            cmd.Parameters.AddWithValue("@FirstName", updatedFirstName);
                            cmd.Parameters.AddWithValue("@LastName", updatedLastName);
                            cmd.Parameters.AddWithValue("@MobileNo", updatedMobileNo);
                            cmd.Parameters.AddWithValue("@EmailId", updatedEmailId);
                            cmd.Parameters.AddWithValue("@Password", updatedPassword);
                            cmd.Parameters.AddWithValue("@ComfirmPassword", updatedComfirmPassword);
                            cmd.Parameters.AddWithValue("@Address", updatedAddress);
                            cmd.Parameters.AddWithValue("@Gender", updatedGender);
                            cmd.Parameters.AddWithValue("@Pincode", updatedPincode);
                            cmd.Parameters.AddWithValue("@Country", updatedCountry);
                            cmd.Parameters.AddWithValue("@status", updatedStatus);

                            cmd.Parameters.AddWithValue("@lmodifyby", slno);

                            int rowsAffected = cmd.ExecuteNonQuery();
                            //int rowsAffected = Convert.ToInt32(cmd.ExecuteScalar());
                            Console.WriteLine("Rows affected: " + rowsAffected);

                            if (rowsAffected > 0)
                            {

                                string userName = GetUserName(updatedEmailId);
                                (int slno2, Guid UniqueKey) = GetSlnoAndUniqueKey(updatedEmailId);


                                Session["FirstName"] = updatedFirstName;
                                Session["LastName"] = updatedLastName;
                                Session["UserEmail"] = updatedEmailId;
                                Session["UserName"] = userName;
                                //Session["UserSlno"] = slno2;
                                Session["UserUKey"] = UniqueKey;
                                Response.Redirect("UserWelcome.aspx");
                            }
                    
                            else
                            {
                                lblMsg.Text = "No data updated.";
                            }
                        }

                        catch (SqlException ex)
                        {
                            if (ex.Number == 2627)
                            {
                                if (ex.Message.Contains("EmailId"))
                                {
                                    ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('Duplicate EmailId.');", true);
                                }
                                else if (ex.Message.Contains("MobileNo"))
                                {
                                    ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('Duplicate MobileNo.');", true);
                                }
                                else
                                {
                                    ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('Duplicate EmailId ');", true);
                                }
                            }
                            else
                            {
                                lblMsg.Text = "An error occurred: " + ex.Message;
                            }
                        }

                }


            }

            catch (Exception ex)
            {
                Console.WriteLine("An error occurred: " + ex.Message);
                throw;
            }

        }







        private int GetCreateUidFromDatabase(string emailId)
        {
            int createUid = -1;

            //string connectionString = @"Data Source=.\SQL2022;Initial Catalog=Work;Integrated Security=True";
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT slno FROM Registrationtbl2 WHERE EmailId = @EmailId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@EmailId", emailId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    createUid = reader.GetInt32(0);
                }

                reader.Close();
            }

            return createUid;
        }






        private (int slno, Guid UniqueKey) GetSlnoAndUniqueKey(string email)
        {
            int slno = 0;
            Guid uniqueKey = Guid.Empty;

            //string connectionString = @"Data Source=.\SQL2022;Initial Catalog=Work;Integrated Security=True";
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT slno, UniqueKey FROM Registrationtbl2 WHERE EmailId = @EmailId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@EmailId", email);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    slno = reader.GetInt32(0);
                    uniqueKey = reader.GetGuid(1);
                }

                con.Close();
            }

            return (slno, uniqueKey);
        }



        private string GetUserName(string email)
        {
            //string connectionString = @"Data Source=.\SQL2022;Initial Catalog=Work;Integrated Security=True";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string query = "SELECT FirstName + ' ' + LastName AS UserName FROM Registration WHERE EmailId = @EmailId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@EmailId", email);

                SqlDataReader dr = cmd.ExecuteReader();
                string userName = "";

                if (dr.Read())
                {
                    userName = dr["UserName"].ToString();
                }

                dr.Close();
                return userName;
            }
        }







        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            
            if (CheckBox1.Checked)
            {
                Label1.Text = "Active";
                Label1.ForeColor = Color.Green;
            }
            else
            {
                Label1.Text = "Inactive";
                Label1.ForeColor = Color.Red;
            }
            Label1.Visible = true;


            //string connectionString = @"Data Source=.\SQL2022;Initial Catalog=Work;Integrated Security=True";
            string FName = txtFirstName.Text;
            string LName = txtLastName.Text;
            string Mobileno = txtMobileNo.Text;
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
            string Pincode = txtPinCode.Text;
            string Country = ddlCountry.SelectedValue;

            string Status = CheckBox1.Checked ? "Active" : "Inactive";



            int slno2 = GetSlno();

            Session["UserSlno"] = slno2;


            try
            {

                int createUid = GetCreateUidFromDatabase(EmailId);

                string uniqueKey = Guid.NewGuid().ToString();
                Session["slno"] = createUid;
                Session["UniqueKey"] = uniqueKey;

                HttpCookie createUidCookie = new HttpCookie("CreateUidCookie");
                createUidCookie.Value = createUid.ToString();
                createUidCookie.Expires = DateTime.Now.AddMinutes(30);
                Response.Cookies.Add(createUidCookie);


                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "sp_Registrationtbl2";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("FirstName", FName);
                    cmd.Parameters.AddWithValue("LastName", LName);
                    cmd.Parameters.AddWithValue("MobileNo", Mobileno);
                    cmd.Parameters.AddWithValue("Emailid", EmailId);
                    cmd.Parameters.AddWithValue("Password", Pwd);
                    cmd.Parameters.AddWithValue("ComfirmPassword", CmfPwd);
                    cmd.Parameters.AddWithValue("Address", Address);
                    cmd.Parameters.AddWithValue("Gender", Gender);
                    cmd.Parameters.AddWithValue("Pincode", Pincode);
                    cmd.Parameters.AddWithValue("Country", Country);
                    cmd.Parameters.AddWithValue("status", Status);

                    if (Session["UserSlno"] != null && (int)Session["UserSlno"] != 0)
                    {
                        //int slno2 = (int)Session["UserSlno"];
                        cmd.Parameters.AddWithValue("@createUid", slno2);


                    }
                    else
                    {
                        HttpCookie existingCookie = Request.Cookies["CreateUidCookie"];
                        if (existingCookie != null)
                        {
                            int storedCreateUid;
                            if (int.TryParse(existingCookie.Value, out storedCreateUid))
                            {
                                cmd.Parameters.AddWithValue("createUid", storedCreateUid);
                                //createUid = storedCreateUid;
                            }
                        }
                    }
                    



                    con.Open();
                    int rowsAffected = Convert.ToInt32(cmd.ExecuteScalar());
                    con.Close();
                    if (rowsAffected == 1)
                    {
                        string userName = GetUserName(EmailId);
                        (int slno, Guid UniqueKey) = GetSlnoAndUniqueKey(EmailId);


                        Session["FirstName"] = FName;
                        Session["LastName"] = LName;
                        Session["UserEmail"] = EmailId;
                        Session["UserName"] = userName;
                        Session["UserSlno"] = slno;
                        Session["UserUKey"] = UniqueKey;

                        string script = "Swal.fire({ title: 'Success!', text: 'Thank You', icon: 'success' }).then(() => { window.location = 'UserWelcome.aspx'; });";
                        ClientScript.RegisterStartupScript(this.GetType(), "BookingSuccessAlert", script, true);
                    }
                    else if (rowsAffected ==2)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('MobileNo is already Exists');", true);
                    }
                    else if (rowsAffected == 3)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('EmailId is already Exists');", true);
                    }
                    else
                    {
                        lblMsg.Text = "Please enter all details";
                    }



                }


            }

            catch (Exception ex)
            {
                lblMsg.Text = "An error occurred: " + ex.Message;
            }
        }




        


    }
}