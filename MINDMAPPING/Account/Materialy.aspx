<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Materialy.aspx.cs" Inherits="PlanZajec.Materialy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div><asp:GridView ID="GridPrzedmioty"  HorizontalAlign="Left" runat="server"  AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="Nazwa"  HeaderText ="Nazwa przedmiotu"/>
            <asp:ButtonField ButtonType="Button"  Text="Wyświetl" ControlStyle-CssClass="contact" />
        </Columns>
        </asp:GridView></div>
    
    <asp:GridView ID="GridMaterialy" runat="server" Width="400px"></asp:GridView>
</asp:Content>
