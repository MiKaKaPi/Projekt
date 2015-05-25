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
        
        private DataTable _dataTablePrzedmioty;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            
            
                BindGridPrzedmioty();
            
        }

        private void BindGridPrzedmioty()
        {
           
           _dataTablePrzedmioty = new DataTable();
           SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["mywindowshosting"].ConnectionString);

            try
            {
                connection.Open();
                string query = "SELECT * FROM Przedmioty";
                SqlCommand cmd = new SqlCommand(query, connection);
                SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
                dataAdapter.Fill(_dataTablePrzedmioty);
                if (_dataTablePrzedmioty.Rows.Count > 0)
                {
                    GridPrzedmioty.DataSource = _dataTablePrzedmioty;
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

        private void BindGridMaterialyById(int subjectId)
        {
            
            DataTable dataTable = new DataTable();
            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["mywindowshosting"].ConnectionString);

            try
            {
                connection.Open();
                string query = "SELECT * FROM Pliki where IdPrzedmiotu = @id";
                SqlCommand cmd = new SqlCommand(query, connection);
                SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = query;
                SqlParameter parameter = new SqlParameter("@id", subjectId);
                cmd.Parameters.Add(parameter);
                dataAdapter.Fill(dataTable);
                if (dataTable.Rows.Count > 0)
                {
                    GridMaterialy.DataSource = dataTable;
                    GridMaterialy.DataBind();
                }
                else
                {
                    GridMaterialy.DataSource = null;
                    GridMaterialy.DataBind();
                
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

        protected void GridPrzedmioty_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            int numberOfClickedRow = Int32.Parse(e.CommandArgument.ToString());
            const int iterFromTable = 0;
            int subjectId = Int32.Parse(_dataTablePrzedmioty.Rows[numberOfClickedRow].ItemArray[iterFromTable].ToString());
            BindGridMaterialyById(subjectId);

        }
    }
}