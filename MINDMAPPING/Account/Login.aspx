<%@ Page Title="Logowanie" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MatStud.Account.Login" %>
<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <hgroup class="title">
        <h1><%: Title %>.</h1>
    </hgroup>
    <section id="loginForm">
        <h2>Użyj lokalnego konta by się zalogować</h2>
        <asp:Login runat="server" ViewStateMode="Disabled" RenderOuterTable="false" DestinationPageUrl="~/Account/Pliki" FailureText="Nie udało ci się zalogować. Spróbuj ponownie.">
            <LayoutTemplate>
                <p class="validation-summary-errors">
                    <asp:Literal runat="server" ID="FailureText" />
                </p>
                <fieldset>
                    <legend>Formularz logowania</legend>
                    <ol>
                        <li>
                            <asp:Label runat="server" AssociatedControlID="UserName">Login</asp:Label>
                            <asp:TextBox runat="server" ID="UserName" /><br />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName" CssClass="field-validation-error" ErrorMessage="Pole login jest wymagane" />
                        </li>
                        <li>
                            <asp:Label runat="server" AssociatedControlID="Password">Hasło</asp:Label>
                            <asp:TextBox runat="server" ID="Password" TextMode="Password" /><br />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="field-validation-error" ErrorMessage="Hasło jest wymagane" />
                        </li>
                        <li>
                            <asp:CheckBox runat="server" ID="RememberMe" />
                            <asp:Label runat="server" AssociatedControlID="RememberMe" CssClass="checkbox">Pamiętaj mnie</asp:Label>
                        </li>
                    </ol>
                    <asp:Button runat="server" CommandName="Login" Text="Zaloguj się" ForeColor="White" />
                </fieldset>
            </LayoutTemplate>
        </asp:Login>
        <p>
            Nie masz konta? <asp:HyperLink runat="server" ID="RegisterHyperLink" ViewStateMode="Disabled">Zarejestruj się</asp:HyperLink><br />
           Zapomiałeś hasła? <asp:HyperLink runat="server" ID="PasswordRecoveryHyperLink" ViewStateMode="Disabled">Odzyskaj je</asp:HyperLink>
        </p>
    </section>
   <section id="socialLoginForm">
        <h2>Użyj konta w innym serwisie by się zalogować</h2>
        <uc:OpenAuthProviders runat="server" ID="OpenAuthLogin" />
    </section>
</asp:Content>
