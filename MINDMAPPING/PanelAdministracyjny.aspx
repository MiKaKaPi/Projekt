<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PanelAdministracyjny.aspx.cs" Inherits="MatStud.PanelAdministracyjny" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:mywindowshosting %>" SelectCommand="SELECT [Id], [Nazwa] FROM [Przedmioty]"></asp:SqlDataSource>
    <asp:Label ID="lbltextAddSubject" runat="server" Text="Dodaj przedmiot: "></asp:Label><asp:TextBox ID="TB_AddSubject" runat="server"></asp:TextBox> <asp:DropDownList ID="DropDownListRoki" runat="server"></asp:DropDownList>
    <asp:Button ID="Btn_AddSubject" runat="server" Text="Dodaj" OnClick="Btn_AddSubject_Click" />
    <br />
    <asp:Label ID="lbltxtDelete" runat="server" Text="Usuwanie przedmiotów:    "></asp:Label>
    <asp:DropDownList ID="DropDownListDelete" runat="server" DataSourceID="SqlDataSource2" DataTextField="Nazwa" DataValueField="Id">
    </asp:DropDownList>
    <asp:Button ID="Btn_DeleteSubject" runat="server" OnClick="Btn_DeleteSubject_Click" Text="Usuń" />
    <br />
    <asp:Label ID="lbltextZatwierdz" runat="server" Text="Zatwierdzanie studentów: "></asp:Label>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT * FROM [DoPaneluView] WHERE ([IsApproved] = @IsApproved)">
        <SelectParameters>
            <asp:Parameter DefaultValue="False" Name="IsApproved" Type="Boolean" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="Users_GV" EmptyDataText="Brak studentów do zatwierdzenia" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" OnRowCommand="Users_GV_RowCommand" DataKeyNames="UserId">
        <Columns>
            <asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName" />
            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
            <asp:BoundField DataField="IsApproved" HeaderText="IsApproved" SortExpression="IsApproved" />
            <asp:ButtonField CommandName="zatwierdz" Text="Zatwierdź" />
        </Columns>
    </asp:GridView>

</asp:Content>
