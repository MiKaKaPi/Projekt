using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace MatStud.Account
{
    public partial class Pliki : System.Web.UI.Page
    {

        protected string dane = null;
        protected string trescpoczatkowa = "";
  
        protected string nazwapliku = "";
        protected Regex reg = new Regex(@"^(?!(?:CON|PRN|AUX|NUL|COM[1-9]|LPT[1-9])(?:\.[^.]*)?$)[^<>:/\\|?*]*[^<>:/\\|?*]$");
        protected void Page_Load(object sender, EventArgs e)
        {
           

        }
    }
}