using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Membership.OpenAuth;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace MatStud.Account
{
    public partial class Register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RegisterUser.ContinueDestinationPageUrl = Request.QueryString["ReturnUrl"];
        }

        protected void RegisterUser_CreatedUser(object sender, EventArgs e)
        {
            string nazwafolderu = RegisterUser.UserName.ToString();
            string connString = ConfigurationManager.ConnectionStrings["FileTableDB"].ConnectionString;
            SqlConnection conn = null;
            try
            {
                conn = new SqlConnection(connString);
                conn.Open();

                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = " INSERT INTO MatStudFileTable(name, is_directory) values(@nazwafolderu,1)";
                    cmd.Parameters.AddWithValue("@nazwafolderu", nazwafolderu);
                    int rowsAffected = cmd.ExecuteNonQuery();
                   
                }
            }
            catch (Exception ex)
            {
                LblKomunikat.Text = ex.Message;
            }
            finally
            {
                if (conn != null)
                {
                    conn.Close();
                    FormsAuthentication.SetAuthCookie(RegisterUser.UserName, createPersistentCookie: false);

                    string continueUrl = RegisterUser.ContinueDestinationPageUrl;
                    if (!OpenAuth.IsLocalUrl(continueUrl))
                    {
                        continueUrl = "~/Account/Pliki.aspx";
                    }
                    Response.Redirect(continueUrl);
                }
            }


           
        }
    }
}