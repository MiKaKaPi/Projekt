<%@ Page Title="Strona główna" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MatStud._Default" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <section class="featured">
        <div class="content-wrapper">
            <hgroup class="title">
                <h1>Witaj</h1>
            </hgroup>
        </div>
    </section>
</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <h3>Projekt powstał na potrzeby przedmiotu Zarządzanie Projektami Informatycznymi.<br /><br />

        Autor: Team MiKaKaPi<br />
        Politechnika Częstochowska.<br />
        Wydział Inżynierii Mechanicznej i Informatyki.<br />
        Instytut Inteligentnych Systemów Informatycznych. <br />
    </h3>
    </asp:Content>
