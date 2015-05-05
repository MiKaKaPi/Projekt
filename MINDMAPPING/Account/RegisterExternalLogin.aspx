<%@ Page Language="C#" Title="Rejestracja loginu zewnętrznego" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegisterExternalLogin.aspx.cs" Inherits="MatStud.Account.RegisterExternalLogin" %>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <hgroup class="title">
        <h1>Rejestracja konta <%: ProviderDisplayName %> jako </h1>
        <h2><%: ProviderUserName %>.</h2>
    </hgroup>

    
    <asp:Label runat="server" ID="providerMessage" CssClass="field-validation-error" />
    

    <asp:PlaceHolder runat="server" ID="userNameForm">
        <fieldset>
            <legend>Association Form</legend>
            <p>
                Autoryzacja konta przez <strong><%: ProviderDisplayName %></strong> jako
                <strong><%: ProviderUserName %></strong> prawie dobiegła końca.<br />
                 Wystarczy, że podasz nazwę użytkownika jakiej chcesz używać w naszym serwisie.
            </p>
            <asp:Label ID="LblKomunikat" runat="server" Text=""></asp:Label>
            <ol>
                    <li class="email">
                        <asp:Label runat="server" AssociatedControlID="userName">Nazwa użytkownika</asp:Label>
                        <asp:TextBox runat="server" ID="userName"/>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="userName"
                            Display="Dynamic" ErrorMessage="To pole jest wymagane" ValidationGroup="NewUser" /><br />
                          <asp:RegularExpressionValidator Display="Dynamic" ValidationGroup="NewUser" ID="RegularExpressionValidatorUserName"  CssClass="field-validation-error" runat="server" ControlToValidate="userName" ValidationExpression ="^(?!(?:CON|PRN|AUX|NUL|COM[1-9]|LPT[1-9])(?:\.[^.]*)?$)[^<>:/\\|?*\s]*[^<>:/\\|?*\s]$" ErrorMessage="Login zawiera niedozwolone znaki." ToolTip="Niedozwolone znaki to / \ < > ? : * | oraz białe znaki."></asp:RegularExpressionValidator><br />
                         <asp:RegularExpressionValidator CssClass="field-validation-error"  Display = "Dynamic"  ValidationGroup="NewUser" ControlToValidate = "userName" ID="RegularExpressionValidatorMinMaxPass" ValidationExpression = "^[\s\S]{5,30}$" runat="server" ErrorMessage="Login może mieć minimalnie 5 znaków a maksymalnie 30."></asp:RegularExpressionValidator>
                        <asp:Label runat="server" ID="userNameMessage" CssClass="field-validation-error" />
                    
                    </li>
                  
            </ol>
            <asp:Button runat="server" Text="Zaloguj się" ValidationGroup="NewUser" CausesValidation="true" OnClick="logIn_Click" />
            <asp:Button runat="server" Text="Anuluj" CausesValidation="false" OnClick="cancel_Click" />
        </fieldset>
    </asp:PlaceHolder>
</asp:Content>
