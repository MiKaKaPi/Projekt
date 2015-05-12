<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Materialy.aspx.cs" Inherits="PlanZajec.Materialy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <asp:GridView ID="GridPrzedmioty" runat="server" Width="205px"></asp:GridView> <asp:GridView ID="GridMaterialy" runat="server" Width="205px"></asp:GridView>
</asp:Content>
