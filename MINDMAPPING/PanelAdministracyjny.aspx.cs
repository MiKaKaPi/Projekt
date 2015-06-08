using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MatStud
{
    public partial class PanelAdministracyjny : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Users_GV_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName == "zatwierdz")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                
                MembershipUser user = Membership.GetUser(Users_GV.Rows[rowIndex].Cells[0].Text);
                user.IsApproved = true;
                Membership.UpdateUser(user);
                Response.Redirect(Request.RawUrl); 
            }

        }

        protected void Btn_AddSubject_Click(object sender, EventArgs e)
        {
            string nazwaprzedmiotu = string.Empty;
            if(TB_AddSubject.Text != ""){
            nazwaprzedmiotu = TB_AddSubject.Text;
            SqlConnection objSqlCon = new SqlConnection();
            objSqlCon.ConnectionString = ConfigurationManager.ConnectionStrings["mywindowshosting"].ConnectionString;
            objSqlCon.Open();
            SqlTransaction objSqlTran = objSqlCon.BeginTransaction();
            SqlCommand objSqlCmd = new SqlCommand("INSERT INTO Przedmioty(Nazwa) values(@nazwaPliku)", objSqlCon, objSqlTran);
            objSqlCmd.Parameters.AddWithValue("nazwaPliku", nazwaprzedmiotu);
            objSqlCmd.ExecuteNonQuery();
            objSqlTran.Commit();
            Response.Redirect(Request.RawUrl); 
            }
        }

        protected void Btn_DeleteSubject_Click(object sender, EventArgs e)
        {
            string idPrzedmiotu = DropDownListDelete.SelectedValue;
            SqlConnection objSqlCon = new SqlConnection();
            objSqlCon.ConnectionString = ConfigurationManager.ConnectionStrings["mywindowshosting"].ConnectionString;
            objSqlCon.Open();
            SqlTransaction objSqlTran = objSqlCon.BeginTransaction();
            SqlCommand objSqlCmd = new SqlCommand("DELETE FROM Przedmioty WHERE Id=@nazwaPliku", objSqlCon, objSqlTran);
            objSqlCmd.Parameters.AddWithValue("nazwaPliku", idPrzedmiotu);
            objSqlCmd.ExecuteNonQuery();
            objSqlTran.Commit();
            Response.Redirect(Request.RawUrl); 
        }
    }
}