using System;
using System.Collections.Generic;
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
    }
}