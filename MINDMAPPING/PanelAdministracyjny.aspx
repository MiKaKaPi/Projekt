<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PanelAdministracyjny.aspx.cs" Inherits="MatStud.PanelAdministracyjny" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT * FROM [DoPaneluView] WHERE ([IsApproved] = @IsApproved)">
        <SelectParameters>
            <asp:Parameter DefaultValue="False" Name="IsApproved" Type="Boolean" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="Users_GV" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" OnRowCommand="Users_GV_RowCommand" DataKeyNames="UserId">
        <Columns>
            <asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName" />
            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
            <asp:BoundField DataField="IsApproved" HeaderText="IsApproved" SortExpression="IsApproved" />
            <asp:ButtonField CommandName="zatwierdz" Text="Zatwierdź" />
        </Columns>
    </asp:GridView>
</asp:Content>
