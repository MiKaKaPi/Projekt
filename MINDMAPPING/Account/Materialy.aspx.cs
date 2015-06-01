using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;
using System.Data.SqlTypes;

namespace PlanZajec
{
    public partial class Materialy : System.Web.UI.Page
    {
        
        private DataTable _dataTablePrzedmioty;
        private DataTable _dataTablePliki;
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
            
            _dataTablePliki = new DataTable();
            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["mywindowshosting"].ConnectionString);

            try
            {
                connection.Open();
                string query = "SELECT id, Nazwa, Opis, Wlasciciel FROM Pliki where IdPrzedmiotu = @id";
                SqlCommand cmd = new SqlCommand(query, connection);
                SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = query;
                SqlParameter parameter = new SqlParameter("@id", subjectId);
                cmd.Parameters.Add(parameter);
                dataAdapter.Fill(_dataTablePliki);
                if (_dataTablePliki.Rows.Count > 0)
                {
                    GridMaterialy.DataSource = _dataTablePliki;
                    
                    GridMaterialy.DataBind();
                    Session["dataTable"] = _dataTablePliki;
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
            HF_subjectID.Value = subjectId.ToString();
            BindGridMaterialyById(subjectId);

        }

        protected void GridMaterialy_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "sciagnij")
            {
               // const int columnNumberOfFileId = 0;
                const int columnNumberOfFileName = 0;
                DataTable dt = (DataTable) Session["dataTable"];
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                string streamID = dt.Rows[rowIndex].ItemArray[0].ToString();
                string nazwapliku = GridMaterialy.Rows[rowIndex].Cells[columnNumberOfFileName].Text;
                
                SqlConnection objSqlCon = new SqlConnection();
                objSqlCon.ConnectionString = ConfigurationManager.ConnectionStrings["mywindowshosting"].ConnectionString;
                objSqlCon.Open();
                SqlTransaction objSqlTran = objSqlCon.BeginTransaction();
                SqlCommand objSqlCmd = new SqlCommand("SELECT file_stream FROM Pliki where id=@stream_id", objSqlCon, objSqlTran);
                objSqlCmd.Parameters.AddWithValue("stream_id", streamID);

                byte[] context = { };
                string fileType = string.Empty;

                using (SqlDataReader sdr = objSqlCmd.ExecuteReader())
                {
                    
                    while (sdr.Read())
                        context = (byte[])sdr[0];
                }

                objSqlTran.Commit();
                Response.Clear();
                Response.AddHeader("Content-disposition", "attachment; filename=" + nazwapliku);
                //Response.ContentType = "image/jpeg";  
                Response.BinaryWrite(context);
            }
            if (e.CommandName == "usun")
            {
                DataTable dt = (DataTable)Session["dataTable"];
                int rowIndex = Int32.Parse(e.CommandArgument.ToString());
                string streamID = dt.Rows[rowIndex].ItemArray[0].ToString();

                SqlConnection objSqlCon = new SqlConnection();
                objSqlCon.ConnectionString = ConfigurationManager.ConnectionStrings["mywindowshosting"].ConnectionString;
                objSqlCon.Open();
                SqlTransaction objSqlTran = objSqlCon.BeginTransaction();
                SqlCommand objSqlCmd = new SqlCommand("DELETE FROM Pliki WHERE id=@stream_id", objSqlCon, objSqlTran);
                objSqlCmd.Parameters.AddWithValue("stream_id", streamID);
                objSqlCmd.ExecuteNonQuery();
                objSqlTran.Commit();
                BindGridMaterialyById(Convert.ToInt32(dt.Rows[rowIndex].ItemArray[5].ToString()));

            }

        }
        

        protected void Btn_Wyslij_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                byte[] context = FileUpload1.FileBytes;
                string saveFileName = FileUpload1.FileName;
                String fileExtension = System.IO.Path.GetExtension(FileUpload1.FileName).ToLower();
                string owner = User.Identity.Name;
                SqlConnection objSqlCon = new SqlConnection();
                int idprzedmiotu = Convert.ToInt32(DropDownList1.SelectedValue);
                String opis = Opis_TB.Text;
                Guid guid = Guid.NewGuid();
                objSqlCon.ConnectionString = ConfigurationManager.ConnectionStrings["mywindowshosting"].ConnectionString;
                objSqlCon.Open();
                SqlTransaction objSqlTran = objSqlCon.BeginTransaction();
                SqlCommand objSqlCmd = new SqlCommand("INSERT INTO Pliki(id,file_stream, Nazwa, Opis,Rozszerzenie, IdPrzedmiotu, Wlasciciel) VALUES (@guid,@dane, @nazwa,@opis,@rozszerzenie,@idprzedmiotu,@owner) ", objSqlCon, objSqlTran);
                objSqlCmd.Parameters.AddWithValue("guid", guid);
                objSqlCmd.Parameters.AddWithValue("dane", context);
                objSqlCmd.Parameters.AddWithValue("nazwa", saveFileName);
                objSqlCmd.Parameters.AddWithValue("opis", opis);
                objSqlCmd.Parameters.AddWithValue("rozszerzenie", fileExtension);
                objSqlCmd.Parameters.AddWithValue("idprzedmiotu", idprzedmiotu);
                objSqlCmd.Parameters.AddWithValue("owner", owner);
                objSqlCmd.ExecuteNonQuery();

                objSqlTran.Commit();
                Opis_TB.Text = "";
            }
        }

        protected void GridMaterialy_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            const int columnNumberOfOwner = 2;

            if (e.Row.RowType != DataControlRowType.DataRow) return;
            string userNameInRow = e.Row.Cells[columnNumberOfOwner].Text;
            if (!userNameInRow.Equals(User.Identity.Name))
            {
                Button btnDelete = (Button) e.Row.FindControl("btnDelete");
                btnDelete.Visible = false;
            }
        }

    
    }
}