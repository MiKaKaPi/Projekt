<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Materialy.aspx.cs" Inherits="PlanZajec.Materialy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
        <asp:HiddenField ID="HF_subjectID"  runat="server" />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:mywindowshosting %>" SelectCommand="SELECT [Nazwa], [Id] FROM [Przedmioty]"></asp:SqlDataSource>
        <asp:FileUpload ID="FileUpload1" runat="server" />
        <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" DataSourceID="SqlDataSource1" DataTextField="Nazwa" DataValueField="Id">
        </asp:DropDownList>
    <asp:Button ID="Btn_Wyslij" runat="server" OnClick="Btn_Wyslij_Click" Text="Wyślij" />
        <textarea id="TextArea1" cols="20" name="S1" rows="2"></textarea><div><asp:GridView ID="GridPrzedmioty"  HorizontalAlign="Left" runat="server"  AutoGenerateColumns="false" OnRowCommand="GridPrzedmioty_OnRowCommand">
        <Columns>
            <asp:BoundField DataField="Nazwa"  HeaderText ="Nazwa przedmiotu"/>
            <asp:ButtonField ButtonType="Button"  Text="Wyświetl" ControlStyle-CssClass="contact" />
        </Columns>
        </asp:GridView>

    </div>
    
    <asp:GridView ID="GridMaterialy" OnRowCommand="GridMaterialy_RowCommand" runat="server" Width="400px" AutoGenerateColumns="False">
        <Columns>
            <%--<asp:BoundField DataField="id" HeaderText="" />--%>
            <asp:BoundField DataField="Nazwa" HeaderText="Nazwa"/>
            <asp:BoundField DataField="Rozszerzenie" HeaderText="Rozszerzenie"/>
            <asp:BoundField DataField="Opis" HeaderText="Opis"/>
            <asp:BoundField DataField="Wlasciciel" HeaderText="Właściciel"/>
            <asp:ButtonField ButtonType="Button" Text="Ściągnij" CommandName="sciagnij" />
        </Columns>
    </asp:GridView>
</asp:Content>
