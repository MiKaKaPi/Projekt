using System;
using System.Collections.Generic;
using System.Linq;

using System.Web.UI.WebControls;

using Microsoft.AspNet.Membership.OpenAuth;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web.Security;

namespace MatStud.Account
{
    public partial class Manage : System.Web.UI.Page
    {
        protected string SuccessMessage
        {
            get;
            private set;
        }

        protected bool CanRemoveExternalLogins
        {
            get;
            private set;
        }

        protected void Page_Load()
        {
            if (!IsPostBack)
            {
                // Sprawdzamy co wyrenderowac
                var hasLocalPassword = OpenAuth.HasLocalPassword(User.Identity.Name);
                setPassword.Visible = !hasLocalPassword;
                changePassword.Visible = hasLocalPassword;

                CanRemoveExternalLogins = hasLocalPassword;

                // wiadomosc
                var message = Request.QueryString["m"];
                if (message != null)
                {

                    Form.Action = ResolveUrl("~/Account/Manage");

                    SuccessMessage =
                        message == "ChangePwdSuccess" ? "Hasło zostało zmienione poprawnie."
                        : message == "SetPwdSuccess" ? "Hasło zostało ustawione poprawnie."
                        : message == "RemoveLoginSuccess" ? "Zewnętrzny login został usunięty poprawnie."
                        : String.Empty;
                    successMessage.Visible = !String.IsNullOrEmpty(SuccessMessage);
                }
            }


            // Zawiązanie danych - lista zewnetrznych loginow
            var accounts = OpenAuth.GetAccountsForUser(User.Identity.Name);
            
            CanRemoveExternalLogins = CanRemoveExternalLogins || accounts.Count() > 1;
            externalLoginsList.DataSource = accounts;
            externalLoginsList.DataBind();

        }
        
        protected void setPassword_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                var czydalej = true;
                MembershipUserCollection uc = Membership.GetAllUsers();
                foreach (MembershipUser u in uc)
                {
                    if(u.Email == Email.Text)
                    {
                        LblKomunikat.ForeColor = System.Drawing.Color.Red;
                        LblKomunikat.Font.Bold = true;
                        LblKomunikat.Text = "E-mail podany przez Ciebie jest już używany. Podaj inny.";
                        czydalej = false;
                    }
                }

                if (czydalej) { 


                string connString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection conn = null;
            try
            {
                conn = new SqlConnection(connString);
                conn.Open();

                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "update Memberships set Email=@email,IsApproved=1 where userid =(select userID from Users where Username = @username)";
                    cmd.Parameters.AddWithValue("@email", Email.Text);
                    cmd.Parameters.AddWithValue("@username", User.Identity.Name);
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

                    var result = OpenAuth.AddLocalPassword(User.Identity.Name, password.Text);
                    

                    if (result.IsSuccessful)
                    {
                        MembershipUser u = Membership.GetUser(User.Identity.Name);
                        Boolean result2 = u.ChangePasswordQuestionAndAnswer(password.Text,
                                                          Question.SelectedValue.ToString(),
                                                          Answer.Text);
                        if (result2) { 
                        Response.Redirect("~/Account/Manage?m=SetPwdSuccess");
                        }
                        else
                        {
                            newPasswordMessage.Text = "Nie udało się zapisać sekretnego pytania i odpowiedzi";
                        }
                    }
                    else
                    {

                        newPasswordMessage.Text = result.ErrorMessage;

                    }
                }
            }

                }
            }
        }


        protected void externalLoginsList_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {
            var providerName = (string)e.Keys["ProviderName"];
            var providerUserId = (string)e.Keys["ProviderUserId"];
            var m = OpenAuth.DeleteAccount(User.Identity.Name, providerName, providerUserId)
                ? "?m=RemoveLoginSuccess"
                : String.Empty;
            Response.Redirect("~/Account/Manage" + m);
        }

        // typ generyczny gdzie parametr jest klasa (potrzebne do OAuth) Item<OpenAuthAccountData>() w .aspx
        protected T Item<T>() where T : class
        {
            return GetDataItem() as T ?? default(T);
        }


        protected static string ConvertToDisplayDateTime(DateTime? utcDateTime)
        {
            return utcDateTime.HasValue ? utcDateTime.Value.ToLocalTime().ToString("G") : "[nigdy]";
        }
    }
}