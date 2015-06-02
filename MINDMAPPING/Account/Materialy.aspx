<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Materialy.aspx.cs" Inherits="PlanZajec.Materialy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
        <asp:HiddenField ID="HF_subjectID"  runat="server" />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:mywindowshosting %>" SelectCommand="SELECT [Nazwa], [Id] FROM [Przedmioty]"></asp:SqlDataSource>
        <asp:FileUpload ID="FileUpload1" runat="server" />
        <asp:DropDownList ID="DropDownList1" runat="server"  DataSourceID="SqlDataSource1" DataTextField="Nazwa" DataValueField="Id" Height="2em" >
        </asp:DropDownList>
    <asp:Button ID="Btn_Wyslij" runat="server"  OnClick="Btn_Wyslij_Click"  Text="Wyślij" CssClass="withoutPadding"/>
        <br/>
        Opis:
    <br/>
        <asp:TextBox ID="Opis_TB" runat="server" Height="122px" TextMode="MultiLine"></asp:TextBox>
        <div><asp:GridView ID="GridPrzedmioty"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6" HorizontalAlign="Left" runat="server"  RowStyle-HorizontalAlign="Center" AutoGenerateColumns="false" OnRowCommand="GridPrzedmioty_OnRowCommand">
        <Columns>
            <asp:BoundField  DataField="Nazwa"  HeaderText ="Nazwa przedmiotu"/>
            <asp:ButtonField   ButtonType="Button"  Text="Wyświetl" />
       
        </Columns>
        </asp:GridView>

    </div >
    <div>
    <asp:GridView ID="GridMaterialy"  RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6"  RowStyle-HorizontalAlign="Center" HorizontalAlign="Left" OnRowDataBound="GridMaterialy_OnRowDataBound" OnRowCommand="GridMaterialy_RowCommand" CssClass="DDGridView" runat="server" Width="400px" AutoGenerateColumns="False" AllowSorting="True" >
        <Columns>
            <asp:BoundField DataField="Nazwa" HeaderText="Nazwa" />
            <asp:BoundField DataField="Opis" HeaderText="Opis"/>
            <asp:BoundField DataField="Wlasciciel" HeaderText="Właściciel"/>
            <asp:ButtonField  ButtonType="Button" Text="Ściągnij" CommandName="sciagnij"  />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="BtnDelete" CssClass="buttonfield" runat="server" Text="Usuń" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName="usun"/>
                </ItemTemplate>
             </asp:TemplateField>
        </Columns>
    </asp:GridView></div>
</asp:Content>
