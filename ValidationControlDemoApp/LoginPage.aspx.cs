using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ValidationControlDemoApp
{
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }




        //private int GetSlno(string email)
        //{
        //    int slno = 0;
        //    string UniqueKey = "";

        //    string connectionString = @"Data Source=.\SQL2022;Initial Catalog=Work;Integrated Security=True";
        //    using (SqlConnection con = new SqlConnection(connectionString))
        //    {
        //        string query = "SELECT slno, UniqueKey FROM Registrationtbl2 WHERE EmailId = @EmailId";
        //        SqlCommand cmd = new SqlCommand(query, con);
        //        cmd.Parameters.AddWithValue("@EmailId", email);

        //        con.Open();
        //        var result = cmd.ExecuteScalar();
        //        con.Close();

        //        if (result != null && int.TryParse(result.ToString(), out slno))
        //        {
        //            return slno;
        //        }
        //    }

        //    return (slno);
        //}



        private (int slno, Guid UniqueKey) GetSlnoAndUniqueKey(string email)
        {
            int slno = 0;
            Guid uniqueKey = Guid.Empty;

            string connectionString = @"Data Source=.\SQL2022;Initial Catalog=Work;Integrated Security=True";
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








        protected void saved_Click(object sender, EventArgs e)
        {
            string EmailId = txtEmail.Text;
            string Pwd = txtPwd.Text;

            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            //string connectionString = @"Data Source=.\SQL2022;Initial Catalog=Work;Integrated Security=True";
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "sp_UserLogintbl2";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EmailId", EmailId);
                cmd.Parameters.AddWithValue("@Password", Pwd);
                con.Open();
                object result = cmd.ExecuteScalar();
                con.Close();

                if (result != null)
                {
                    string userName = GetUserName(EmailId);

                    (int slno, Guid UniqueKey) = GetSlnoAndUniqueKey(EmailId);


                    Session["UserEmail"] = EmailId;
                    Session["UserName"] = userName;

                    Session["UserSlno"] = slno;
                    Session["UserUKey"] = UniqueKey;

                    Response.Redirect("UserWelcome.aspx");

                }
                else
                {
                    lblError.Text = "Invalid username or password.";
                    lblError.Visible = true;
                }


            }
        }


        private string GetUserName(string email)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

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





        protected void Register_Click(object sender, EventArgs e)
        {

            Response.Redirect("Default.aspx");

        }

    }
}