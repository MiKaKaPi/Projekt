using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace PlanZajec
{
    public partial class Materialy : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!Page.IsPostBack)
            {
                BindGridPrzedmioty();
            }
        }

        private void BindGridPrzedmioty()
        {
           DataTable dataTable = new DataTable();
           SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["mywindowshosting"].ConnectionString);

            try
            {
                connection.Open();
                string query = "SELECT * FROM Przedmioty";
                SqlCommand cmd = new SqlCommand(query, connection);
                SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
                dataAdapter.Fill(dataTable);
                if (dataTable.Rows.Count > 0)
                {
                    GridPrzedmioty.DataSource = dataTable;
                    GridPrzedmioty.DataBind();
                }
            }
            catch (Exception)
            {
                {
                }
                throw;
            }
            finally
            {
                connection.Close();
            }

        }
    }
}