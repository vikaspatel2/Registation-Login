using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ValidationControlDemoApp
{
    public partial class Welcome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {


                if (Session["FirstName"] != null)
                {
                    string userFirstName = Session["FirstName"].ToString();
                    lblName.Text = "Welcome, " + userFirstName + "!";
                }
                else
                {
                    lblName.Text = "Welcome!";
                }


                Gridviewdata();


            }

        }



       


        protected void Gridviewdata()
        {
            string connectionString = @"Data Source=.\SQL2022;Initial Catalog=Work;Integrated Security=True";
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "select * from Registrationtbl2 order by slno desc";

                SqlCommand cmd = new SqlCommand(query, con);

                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                Gridview1.DataSource = dr;
                Gridview1.DataBind();
                //Gridview1.Visible = true;


                dr.Close();
                con.Close();
            }
        }


        protected void LoadRegister(string userEmail)
        {
            string connectionString = @"Data Source=.\SQL2022;Initial Catalog=Work;Integrated Security=True";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Registrationtbl2" +
                    "" +
                    "" +
                    "" +
                    " WHERE EmailId = @EmailId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@EmailId", userEmail);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    Gridview1.DataSource = dr;
                    Gridview1.DataBind();
                }

                dr.Close();


            }
        }
        protected void Gridview1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            Gridview1.EditIndex = e.NewEditIndex;
            //FillData();
            BindGridView();


        }

      


        //private void BindGridView()
        //{
        //    string connectionString = @"Data Source=.\SQL2022;Initial Catalog=Work;Integrated Security=True";

        //    using (SqlConnection con = new SqlConnection(connectionString))
        //    {
        //        string query = "select * from Registrationtbl2";
        //        SqlCommand cmd = new SqlCommand(query, con);

        //        con.Open();
        //        SqlDataReader reader = cmd.ExecuteReader();

        //        Gridview1.DataSource = reader;
        //        Gridview1.DataBind();

        //        reader.Close();  
        //    }
        //}




        protected void gvRecentUser_RowEditing(object sender, GridViewEditEventArgs e)
        {
            //gvRecentUser.EditIndex = e.NewEditIndex;
            ////FillData();
            //LoadUserBookedRoomDetails(Session["UserEmail"].ToString());


            GridViewRow selectedRow = Gridview1.Rows[e.NewEditIndex];

            HiddenField hfSlno = (HiddenField)selectedRow.FindControl("hfSlno");
            HiddenField hfUkey = (HiddenField)selectedRow.FindControl("hfUkey");
            string slno = hfSlno.Value;
            string UniqueKey = hfUkey.Value;

            string firstName = ((Label)selectedRow.FindControl("Label1")).Text;
            string lastName = ((Label)selectedRow.FindControl("Label2")).Text;
            string mobileNo = ((Label)selectedRow.FindControl("Label3")).Text;
            string emailId = ((Label)selectedRow.FindControl("Label4")).Text;
            string password = ((Label)selectedRow.FindControl("Label5")).Text;
            string confirmPwd = ((Label)selectedRow.FindControl("Label6")).Text;
            string address = ((Label)selectedRow.FindControl("Label7")).Text;
            string gender = ((Label)selectedRow.FindControl("Label8")).Text;
            string pinCode = ((Label)selectedRow.FindControl("Label9")).Text;
            string country = ((Label)selectedRow.FindControl("Label10")).Text;
            string status = ((Label)selectedRow.FindControl("Label11")).Text;

            string redirectUrl = $"default.aspx?slno={slno}&UniqueKey={UniqueKey}&FirstName={firstName}&LastName={lastName}&MobileNo={mobileNo}&EmailId={emailId}&Password={password}&ComfirmPassword={confirmPwd}&Address={address}&Gender={gender}&PinCode={pinCode}&Country={country}&status{status}";

            Response.Redirect(redirectUrl);


        }


        protected void gvRecentUser_RowCancelingEdit1(object sender, GridViewCancelEditEventArgs e)
        {
            Gridview1.EditIndex = -1;
        }




        protected void gvRecentUser_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[7].Text = "******";
                e.Row.Cells[8].Text = "******";
            }
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
            gvRecentUser_RowCommand(Gridview1, new GridViewCommandEventArgs(Gridview1, new CommandEventArgs(commandName, commandArgument)));
        }




        protected void gvRecentUser_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                int slno = Convert.ToInt32(e.CommandArgument);

                string remark = txtRemark.Text;
                // Get the remark and userChoice from the GridView's EditIndex row
                //GridViewRow row = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                //string remark = ((TextBox)row.FindControl("txtRemark")).Text;
                //string userChoice = ((HiddenField)row.FindControl("hdnUserChoice")).Value;

                //if (userChoice == "Ok")
                //{
                string connectionString = @"Data Source=.\SQL2022;Initial Catalog=Work;Integrated Security=True";

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    using (SqlCommand cmd = new SqlCommand("sp_DeleteUserRegisterRecord", connection))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@slno", slno);
                        cmd.Parameters.AddWithValue("@delUid", slno);
                        cmd.Parameters.AddWithValue("@remark", remark);

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
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
            string connectionString = @"Data Source=.\SQL2022;Initial Catalog=Work;Integrated Security=True";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "select * from Registrationtbl2 where delUid is null";
                SqlCommand cmd = new SqlCommand(query, con);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                Gridview1.DataSource = reader;
                Gridview1.DataBind();

                reader.Close();
            }
        }






        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoginPage.aspx");
        }
    }
}