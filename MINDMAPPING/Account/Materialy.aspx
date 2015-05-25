<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Materialy.aspx.cs" Inherits="PlanZajec.Materialy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
        <asp:HiddenField ID="HF_subjectID"  runat="server" />
        <asp:FileUpload ID="FileUpload1" runat="server" />
    <asp:Button ID="Btn_Wyslij" runat="server" OnClick="Btn_Wyslij_Click" Text="Wyślij" />
    <div><asp:GridView ID="GridPrzedmioty"  HorizontalAlign="Left" runat="server"  AutoGenerateColumns="false" OnRowCommand="GridPrzedmioty_OnRowCommand">
        <Columns>
            <asp:BoundField DataField="Nazwa"  HeaderText ="Nazwa przedmiotu"/>
            <asp:ButtonField ButtonType="Button"  Text="Wyświetl" ControlStyle-CssClass="contact" />
        </Columns>
        </asp:GridView>

    </div>
    
    <asp:GridView ID="GridMaterialy" OnRowCommand="GridMaterialy_RowCommand" runat="server" Width="400px" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="id" HeaderText="" />
            <asp:BoundField DataField="Nazwa" HeaderText="Nazwa"/>
            <asp:BoundField DataField="Rozszerzenie" HeaderText="Rozszerzenie"/>
            <asp:BoundField DataField="Opis" HeaderText="Opis"/>
            <asp:ButtonField ButtonType="Button" Text="Ściągnij" CommandName="sciagnij" />
        </Columns>
    </asp:GridView>
</asp:Content>
