<%@ Page Language="C#" ResponseEncoding="UTF-8" AutoEventWireup="true" CodeBehind="Tworz.aspx.cs" Inherits="MatStud.Account.Mapa" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Plan zajęć</title>
    <link href='http://fonts.googleapis.com/css?family=Tinos:400,700,400italic,700italic' rel='stylesheet' type='text/css' />
    <script type="text/javascript" src="../Scripts/jquery.js"></script>
    <script type="text/javascript" src="../Scripts/jquery.cookie.js"></script>
		<script type="text/javascript" src="../Scripts/redips-drag-min.js"></script>
		<script type="text/javascript" src="../Scripts/MatStudlogic.js"></script>
    <link href="../Content/planstyle.css" rel="stylesheet" type="text/css" />
</head>

<body>
  
    <form id="form1" runat="server">
        <asp:HiddenField ID="HFnazwapliku" runat="server" />
        <asp:HiddenField ID="HFdane" runat="server"   />
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel runat="server" UpdateMode="Conditional">
            <Triggers>
               <asp:AsyncPostBackTrigger ControlID="BtnZapisNaSerwer"  EventName="click" />
                 <asp:PostBackTrigger ControlID="BtnZapisDoPliku"  />
                <asp:PostBackTrigger  ControlID="BtnWczytajZPliku" />
            </Triggers>
            <ContentTemplate>
               
      
  <ul id="menu-bar">
      <div id="leftbar">
 <li><a href="#">Zapisz</a>
  <ul>
   <li><asp:Button runat="server" ID="BtnZapisNaSerwer" CssClass="btncss" OnClick="BtnZapisNaSerwer_Click" Text="Zapisz na serwer" /></li>
   <li><asp:Button OnClick="BtnZapisDoPliku_Click"  CssClass="btncss" ID="BtnZapisDoPliku" runat="server" Text="Zapisz do pliku" /></li>
  </ul>
 </li>
 <li><a href="#">Wczytaj</a>
  <ul>
   <li>   <asp:FileUpload ID="FileUpload1" runat="server" style="display:none" />
        <input id="btnFileUpload" class="btncss" type="button" value="Wybierz plik" runat="server"  /></li>
   <li><asp:Button CssClass="btncss" ID="BtnWczytajZPliku" runat="server" Text="Wczytaj z pliku" onclick="BtnWczytajZPliku_Click" /></li>
  </ul>
 </li>
 <li> <asp:Label ID="Label1" runat="server" CssClass="Labelkomunikat" Text="" ToolTip="W tym oknie wyświetlane są komunikaty."></asp:Label></li>
          </div>
      <div id="rightbar"> 
          <li><asp:ImageButton CssClass="btnpowrot" runat="server" ToolTip="Powrót do projektów" AlternateText="Powrót" ImageUrl="~/Images/gnome_shutdown.png" PostBackUrl="~/Account/Pliki.aspx"/></li>
      </div>
</ul>

                      </ContentTemplate>
        </asp:UpdatePanel>
        
<div id="main_container">
			<!-- tables inside this DIV could have draggable content -->
			<div id="drag">
	
				<!-- left container (table with subjects) -->
				<div id="left">
					<table id="tablesubjects">
						<colgroup>
							<col style="width:190px;"/>
						</colgroup>
						<tbody>
							<tr><td class="dark"><div id="ar" class="redips-drag redips-clone ar">Plastyka</div><input id="b_ar" class="ar" type="button" value="" onclick="report('ar')" title="Show only Arts"/></td></tr>
							<tr><td class="dark"><div id="bi" class="redips-drag redips-clone bi">Biologia</div><input id="b_bi" class="bi" type="button" value="" onclick="report('bi')" title="Show only Biology"/></td></tr>
							<tr><td class="dark"><div id="ch" class="redips-drag redips-clone ch">Chemia</div><input id="b_ch" class="ch" type="button" value="" onclick="report('ch')" title="Show only Chemistry"/></td></tr>
							<tr><td class="dark"><div id="en" class="redips-drag redips-clone en">Angielski</div><input id="b_en" class="en" type="button" value="" onclick="report('en')" title="Show only English"/></td></tr>
							<tr><td class="dark"><div id="et" class="redips-drag redips-clone et">Religia</div><input id="b_et" class="et" type="button" value="" onclick="report('et')" title="Show only Ethics"/></td></tr>
							<tr><td class="dark"><div id="hi" class="redips-drag redips-clone hi">Historia</div><input id="b_hi" class="hi" type="button" value="" onclick="report('hi')" title="Show only History"/></td></tr>
							<tr><td class="dark"><div id="it" class="redips-drag redips-clone it">Informatyka</div><input id="b_it" class="it" type="button" value="" onclick="report('it')" title="Show only IT"/></td></tr>
							<tr><td class="dark"><div id="ma" class="redips-drag redips-clone ma">Matematyka</div><input id="b_ma" class="ma" type="button" value="" onclick="report('ma')" title="Show only Mathematics"/></td></tr>
							<tr><td class="dark"><div id="ph" class="redips-drag redips-clone ph">Fizyka</div><input id="b_ph" class="ph" type="button" value="" onclick="report('ph')" title="Show only Physics"/></td></tr>
							<tr><td class="redips-trash" title="Trash">Trash</td></tr>
						</tbody>
					</table>
				</div><!-- left container -->
				
				<!-- right container -->
				<div id="right">
					<table id="timetable">
						<colgroup>
							<col style="width:50px;"/>
							<col style="width:100px;"/>
							<col style="width:100px;"/>
							<col style="width:100px;"/>
							<col style="width:100px;"/>
							<col style="width:100px;"/>
						</colgroup>
						<tbody>
							<tr>
				                <td class="mark dark"></td>
								<td class="mark dark">Poniedziałek</td>
								<td class="mark dark">Wtorek</td>
								<td class="mark dark">Środa</td>
								<td class="mark dark">Czwartek</td>
								<td class="mark dark">Piątek</td>

							</tr>
							<tr>
								<td class="mark dark">8:00-9:00</td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td class="mark dark">9:00-10:00</td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td class="mark dark">10:00-11:00</td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td class="mark dark">11:00-12:00</td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td class="mark dark">12:00-13:00</td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td class="mark dark">13:00-14:00</td>
                                <td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td class="mark dark">14:00-15:00</td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td class="mark dark">15:00-16:00</td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td class="mark dark">16:00-17:00</td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
                            	<tr>
								<td class="mark dark">17:00-18:00</td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
                            	<tr>
								<td class="mark dark">18:00-19:00</td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
                            	<tr>
								<td class="mark dark">19:00-20:00</td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</tbody>
					</table>
				</div><!-- right container -->
			</div><!-- drag container -->
		</div><!-- main container -->
    </form>
</body>
</html>
