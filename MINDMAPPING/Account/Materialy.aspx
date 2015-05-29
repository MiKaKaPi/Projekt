<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Materialy.aspx.cs" Inherits="PlanZajec.Materialy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
        <asp:HiddenField ID="HF_subjectID"  runat="server" />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:mywindowshosting %>" SelectCommand="SELECT [Nazwa], [Id] FROM [Przedmioty]"></asp:SqlDataSource>
        <asp:FileUpload ID="FileUpload1" runat="server" />
        <asp:DropDownList ID="DropDownList1" runat="server"  DataSourceID="SqlDataSource1" DataTextField="Nazwa" DataValueField="Id">
        </asp:DropDownList>
    <asp:Button ID="Btn_Wyslij" runat="server" OnClick="Btn_Wyslij_Click" Text="Wyślij" />
        <br/>
        Opis:
        <asp:TextBox ID="Opis_TB" runat="server" Height="122px" TextMode="MultiLine"></asp:TextBox>
        <div><asp:GridView ID="GridPrzedmioty"  HorizontalAlign="Left" runat="server"  AutoGenerateColumns="false" OnRowCommand="GridPrzedmioty_OnRowCommand">
        <Columns>
            <asp:BoundField  DataField="Nazwa"  HeaderText ="Nazwa przedmiotu"/>
            <asp:ButtonField ControlStyle-Height="50px"  ButtonType="Button"  Text="Wyświetl" ControlStyle-CssClass="buttonfield" />
       
        </Columns>
        </asp:GridView>

    </div>
    
    <asp:GridView ID="GridMaterialy" RowStyle-HorizontalAlign="Center" HorizontalAlign="center" OnRowDataBound="GridMaterialy_OnRowDataBound" OnRowCommand="GridMaterialy_RowCommand" CssClass="grid" runat="server" Width="400px" AutoGenerateColumns="False">
        <Columns>
            <%--<asp:BoundField DataField="id" HeaderText="" /> --%>
            <asp:BoundField DataField="Nazwa" HeaderText="Nazwa"/>
            <asp:BoundField DataField="Rozszerzenie" HeaderText="Rozszerzenie"/>
            <asp:BoundField DataField="Opis" HeaderText="Opis"/>
            <asp:BoundField DataField="Wlasciciel" HeaderText="Właściciel"/>
            <asp:ButtonField  ButtonType="Button" Text="Ściągnij" CommandName="sciagnij" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="BtnDelete" runat="server" Text="Usuń" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName="usun"/>
                </ItemTemplate>
             </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
