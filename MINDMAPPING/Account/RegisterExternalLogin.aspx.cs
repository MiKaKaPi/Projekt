using System;
using System.Web;
using System.Web.Security;
using DotNetOpenAuth.AspNet;
using Microsoft.AspNet.Membership.OpenAuth;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace MatStud.Account
{
    public partial class RegisterExternalLogin : System.Web.UI.Page
    {
        protected string ProviderName
        {
            get { return (string)ViewState["ProviderName"] ?? String.Empty; }
            private set { ViewState["ProviderName"] = value; }
        }

        protected string ProviderDisplayName
        {
            get { return (string)ViewState["ProviderDisplayName"] ?? String.Empty; }
            private set { ViewState["ProviderDisplayName"] = value; }
        }

        protected string ProviderUserId
        {
            get { return (string)ViewState["ProviderUserId"] ?? String.Empty; }
            private set { ViewState["ProviderUserId"] = value; }
        }

        protected string ProviderUserName
        {
            get { return (string)ViewState["ProviderUserName"] ?? String.Empty; }
            private set { ViewState["ProviderUserName"] = value; }
        }

        protected void Page_Load()
        {
            userName.MaxLength = 30;
            if (!IsPostBack)
            {
                ProcessProviderResult();
            }
        }

        protected void logIn_Click(object sender, EventArgs e)
        {
            CreateAndLoginUser();
        }

        protected void cancel_Click(object sender, EventArgs e)
        {
            RedirectToReturnUrl();
        }

        private void ProcessProviderResult()
        {
            ProviderName = OpenAuth.GetProviderNameFromCurrentRequest();
            
            if (String.IsNullOrEmpty(ProviderName))
            {
                Response.Redirect(FormsAuthentication.LoginUrl);
            }

            // Buduje zwrotny url dla OpenAuth
            var redirectUrl = "~/Account/RegisterExternalLogin";
            var returnUrl = Request.QueryString["ReturnUrl"];
            if (!String.IsNullOrEmpty(returnUrl))
            {
                redirectUrl += "?ReturnUrl=" + HttpUtility.UrlEncode(returnUrl);
            }

            var authResult = OpenAuth.VerifyAuthentication(redirectUrl);
            ProviderDisplayName = OpenAuth.GetProviderDisplayName(ProviderName);
            if (!authResult.IsSuccessful)
            {
                Title = "Wystąpił błąd z zewnętrznym loginem.";
                userNameForm.Visible = false;

                providerMessage.Text = String.Format("Wystąpił błąd z {0} ,", ProviderDisplayName);

                return;
            }

            // Użytkownik się zalogował u zewnetrznego dostawcy
            // Sprawdzanie czy uzytkownik jest lokalny
            if (OpenAuth.Login(authResult.Provider, authResult.ProviderUserId, createPersistentCookie: false))
            {
                RedirectToReturnUrl();
            }

            // Zapisujemy dane o dostawcy w ViewState
            ProviderName = authResult.Provider;
            ProviderUserId = authResult.ProviderUserId;
            ProviderUserName = authResult.UserName;
            

            Form.Action = ResolveUrl(redirectUrl);

            if (User.Identity.IsAuthenticated)
            {
                // Użytkownik jest uwierzetelniony, dodaje zewnetrzny login i przekierowuje do zwrotnego url
                OpenAuth.AddAccountToExistingUser(ProviderName, ProviderUserId, ProviderUserName, User.Identity.Name);
                RedirectToReturnUrl();
            }
            else
            {
                // Użytkownik jest nowy, pobieranie UserName do Membership
                userName.Text = authResult.UserName;
            }
        }

        private void CreateAndLoginUser()
        {
            if (!IsValid)
            {
                return;
            }
            else { 
            
            var createResult = OpenAuth.CreateUser(ProviderName, ProviderUserId, ProviderUserName, userName.Text);
            if (!createResult.IsSuccessful)
            {

                userNameMessage.Text = createResult.ErrorMessage;

            }
            else
            {
                // Uzytkownik utworzony i powiązany poprawnie
                if (OpenAuth.Login(ProviderName, ProviderUserId, createPersistentCookie: false))
                {
                    var nazwafolderu = userName.Text;
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
                            RedirectToReturnUrl();
                        }
                    }
                   
                }
            }
            }
        }

        private void RedirectToReturnUrl()
        {
            var returnUrl = Request.QueryString["ReturnUrl"];
            if (!String.IsNullOrEmpty(returnUrl) && OpenAuth.IsLocalUrl(returnUrl))
            {
                Response.Redirect(returnUrl);
            }
            else
            {
                Response.Redirect("~/Account/Pliki");
            }
        }
    }
}