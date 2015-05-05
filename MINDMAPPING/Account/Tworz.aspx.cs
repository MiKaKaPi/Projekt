using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace MatStud.Account
{
    public partial class Mapa : System.Web.UI.Page
    {
        public string daneodebrane = "";
        public string nazwapliku="";
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack) {
                btnFileUpload.Attributes.Add("onclick", "document.getElementById('" + FileUpload1.ClientID + "').click();"); 
             daneodebrane = (string)(Session["poledanych"]);
             nazwapliku = (string)(Session["nazwapliku"]);
         //   if (daneodebrane == null)
            //    {
             //       Response.Redirect("Projects.aspx");
            //    }
             //   else { 
                    HFnazwapliku.Value = nazwapliku;
                    HFdane.Value = daneodebrane;
                  
              //  }
            }
            Page.Title += " - " + HFnazwapliku.Value;
        }

        public void wykonajzapytanie(SqlCommand zapytanie)
        {

            string connString = ConfigurationManager.ConnectionStrings["FileTableDBConnectionString"].ConnectionString;
            SqlConnection conn = null;
            try
            {
                conn = new SqlConnection(connString);
                conn.Open();

                using (SqlCommand cmd = zapytanie)
                {
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                  
                  
                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected == 1)
                    {
                        Label1.Text += "Polecenie wykonano pomyślnie.";
                    }
                    else
                    {
                        Label1.Text += "Wystąpił błąd z zapytaniem do bazy danych.";
                    }
                }
            }
            catch (Exception ex)
            {
                Label1.Text += "Wystąpił błąd: " + ex.Message;
            }
            finally
            {
                if (conn != null)
                {
                    conn.Close();
                }
            }


        }




        protected void ZapisNaSerwer()
        {
            string danewysylane = HFdane.Value;
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = @"UPDATE MatStudFileTable
               SET file_stream = CAST(@dane AS varbinary(max)), last_write_time = SYSDATETIMEOFFSET()
             WHERE file_stream is not null AND parent_path_locator =(select path_locator from MatStudFileTable where name=@username and is_directory=1) AND name=@nazwapliku";
            cmd.Parameters.AddWithValue("@dane", danewysylane);
            cmd.Parameters.AddWithValue("@username", User.Identity.Name);
            cmd.Parameters.AddWithValue("@nazwapliku", HFnazwapliku.Value+".json");
            Label1.Text = "Zapis na serwer - ";
            wykonajzapytanie(cmd);
        }

        protected void ZapisDoPliku()
        {
            string trescpliku = HFdane.Value;
            Response.Clear();        
            Response.ContentType = "text/json";
            Response.Charset = "UTF-8";
            Response.AddHeader("Content-Disposition", "attachment; filename=TimeTable.json");
            Response.Write(trescpliku);
            Response.End();
        }

        protected void WczytajZPliku()
        {
            if (FileUpload1.HasFile)
            {
                try
                {
                    String fileExtension = System.IO.Path.GetExtension(FileUpload1.FileName).ToLower();
                    if (fileExtension == ".json")
                    {
                        string inputContent;
                        using (StreamReader inputStreamReader = new StreamReader(FileUpload1.PostedFile.InputStream,Encoding.UTF8))
                        {
                            inputContent = inputStreamReader.ReadToEnd();
                        }
                        HFdane.Value =  inputContent;
                    }
                    else
                    {
                        Label1.Text = "Rozszerzenie pliku jest niepoprawne. Dopuszczalne rozszerzenie to .json";
                        
                    }
                }
                catch(Exception ex)
                {
                    Label1.Text = "Wystąpił błąd: " + ex.Message;
                   
                }
            }
            else
            {
                Label1.Text = "Nie wybrałeś pliku.";
            }
        }


        protected void BtnZapisNaSerwer_Click(object sender, EventArgs e)
        {
            ZapisNaSerwer();
        }

        protected void BtnZapisDoPliku_Click(object sender, EventArgs e)
        {
            ZapisDoPliku();
        }

        protected void BtnWczytajZPliku_Click(object sender, EventArgs e)
        {
           WczytajZPliku();
        }
    }
}