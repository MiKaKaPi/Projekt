<%@ Page Title="Zarządzanie kontem" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="MatStud.Account.Manage" %>
<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>
<%@ Import Namespace="Microsoft.AspNet.Membership.OpenAuth" %>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <hgroup class="title">
        <h1><%: Title %>.</h1>
    </hgroup>
    <link href="../Content/tablestyle.css" rel="stylesheet" />
    <section id="passwordForm">
        <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
            <p class="message-success"><%: SuccessMessage %></p>
        </asp:PlaceHolder>

        <p>Jesteś zalogowany jako,  <strong><%: User.Identity.Name %></strong>.</p>

        <asp:PlaceHolder runat="server" ID="setPassword" Visible="false">
            <p>
             Nie posiadasz lokalnego konta na naszym serwisie. Utwórz je, by nie musieć korzystać z konta zewnętrznego.
            </p>
            <asp:Label ID="LblKomunikat" runat="server" Text=""></asp:Label>
            <fieldset>
                <legend>Ustawienie hasła</legend>
                <ol>
                    <li>
                        <asp:Label runat="server" AssociatedControlID="password">Hasło</asp:Label>
                        <asp:TextBox runat="server" ID="password" TextMode="Password" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="password"
                            CssClass="field-validation-error" ErrorMessage="To pole jest wymagane."
                            Display="Dynamic" ValidationGroup="SetPassword" /> <br />       
                        <asp:Label runat="server" ID="newPasswordMessage" CssClass="field-validation-error"
                            AssociatedControlID="password" />
                        
                    </li>
                    <li>
                        <asp:Label runat="server" AssociatedControlID="confirmPassword">Potwierdź hasło</asp:Label>
                        <asp:TextBox runat="server" ID="confirmPassword" TextMode="Password" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="confirmPassword"
                            CssClass="field-validation-error" Display="Dynamic" ErrorMessage="Potwierdzenie nie może być puste."
                            ValidationGroup="SetPassword" />
                        <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="confirmPassword"
                            CssClass="field-validation-error" Display="Dynamic" ErrorMessage="Hasło nie zgadza się z potwierdzeniem."
                            ValidationGroup="SetPassword" />
                    </li>
                     <li>
                                <asp:Label runat="server" AssociatedControlID="Email">Adres e-mail</asp:Label>
                                <asp:TextBox runat="server" ID="Email" ToolTip="Adres ten potrzebny jest do odzyskania/zmiany hasła w przyszłości." />
                                <asp:RequiredFieldValidator runat="server" Display="Dynamic" ControlToValidate="Email"
                                    CssClass="field-validation-error" ValidationGroup="SetPassword" ErrorMessage="To pole jest wymagane" />
                                <asp:RegularExpressionValidator Display="Dynamic" ValidationGroup="SetPassword" ID="RegularExpressionValidatorEmail" runat="server" ControlToValidate="Email" ValidationExpression ="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" ErrorMessage="Nie wpisałeś poprawnego adresu e-mail"></asp:RegularExpressionValidator>
                            </li>
                    <li>
                                <asp:Label runat="server" AssociatedControlID="Question">Pytanie pomocnicze:</asp:Label>
                                <asp:DropDownList ID="Question" runat="server" ToolTip="Pytanie pomocnicze służy do odzyskiwania hasła. Wybierz odpowiednie dla siebie.">
                                    <asp:ListItem Selected="True">Wybierz pytanie pomocnicze</asp:ListItem>
                                    <asp:ListItem>Jaka jest twoja ulubiona potrawa?</asp:ListItem>
                                    <asp:ListItem>Jaki jest twój ulubiony kolor?</asp:ListItem>
                                    <asp:ListItem>Jak miała na imię twoja pierwsza miłość?</asp:ListItem>
                                    <asp:ListItem>Nazwisko twojej ulubionej nauczycielki/nauczyciela.</asp:ListItem>
                                    <asp:ListItem>Nazwa ulubionego zespołu.</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" ValidationGroup="SetPassword" ControlToValidate="Question"
                                    CssClass="field-validation-error" InitialValue="Wybierz pytanie pomocnicze" ErrorMessage="To pole jest wymagane" />
                            </li>
                            <li>
                                <asp:Label runat="server" AssociatedControlID="Answer">Odpowiedz:</asp:Label>
                                <asp:TextBox runat="server" ID="Answer" ToolTip="Zapamiętaj odpowiedź, którą wprowadzisz. Będzie ona potrzebna wrazie odzyskania hasła." />
                               <asp:RequiredFieldValidator runat="server" ValidationGroup="SetPassword" ControlToValidate="Answer"
                                    CssClass="field-validation-error" ErrorMessage="To pole jest wymagane" />
                            </li>
                </ol>
                <asp:Button runat="server" Text="Ustaw hasło" CausesValidation="true" ValidationGroup="SetPassword" OnClick="setPassword_Click" />
            </fieldset>
        </asp:PlaceHolder>

        <asp:PlaceHolder runat="server" ID="changePassword" Visible="false">
            <h3>Zmiana hasła</h3>
            <asp:ChangePassword runat="server" CancelDestinationPageUrl="~/" ViewStateMode="Disabled" RenderOuterTable="false" SuccessPageUrl="Manage?m=ChangePwdSuccess" MailDefinition-BodyFileName="~/App_Data/changepasswordemail.txt" MailDefinition-Subject="Zmiana hasła w serwisie mindmapp" MailDefinition-From="admin@mindmapp.com" ChangePasswordButtonText="Zmiana hasła" ChangePasswordFailureText=" Hasło musi mieć przynajmniej {0} znaków w tym {1} znak niealfanumeryczny." ChangePasswordTitleText="Zmień hasło" ConfirmNewPasswordLabelText="Potwierdź nowe hasło: " SuccessText="Twoje hasło zostało zmienione." SuccessTitleText="Zmiana hasła udana.">
                <ChangePasswordTemplate>
                    <p class="validation-summary-errors">
                        <asp:Literal runat="server" ID="FailureText" />
                    </p>
                    <fieldset class="changePassword">
                        <legend>Zmień hasło</legend>
                        <ol>
                            <li>
                                <asp:Label runat="server" ID="CurrentPasswordLabel" AssociatedControlID="CurrentPassword">Stare hasło</asp:Label>
                                <asp:TextBox runat="server" ID="CurrentPassword" CssClass="passwordEntry" TextMode="Password" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="CurrentPassword"
                                    CssClass="field-validation-error" ErrorMessage="To pole jest wymagane."
                                    ValidationGroup="ChangePassword" />
                            </li>
                            <li>
                                <asp:Label runat="server" ID="NewPasswordLabel" AssociatedControlID="NewPassword">Nowe hasło</asp:Label>
                                <asp:TextBox runat="server" ID="NewPassword" CssClass="passwordEntry" TextMode="Password" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="NewPassword"
                                    CssClass="field-validation-error" ErrorMessage="To pole jest wymagane."
                                    ValidationGroup="ChangePassword" />
                            </li>
                            <li>
                                <asp:Label runat="server" ID="ConfirmNewPasswordLabel" AssociatedControlID="ConfirmNewPassword">Potwierdź nowe hasło</asp:Label>
                                <asp:TextBox runat="server" ID="ConfirmNewPassword" CssClass="passwordEntry" TextMode="Password" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmNewPassword"
                                    CssClass="field-validation-error" Display="Dynamic" ErrorMessage="To pole jest wymagane."
                                    ValidationGroup="ChangePassword" />
                                <asp:CompareValidator runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword"
                                    CssClass="field-validation-error" Display="Dynamic" ErrorMessage="Nowe hasło nie zgadza się z potwierdzeniem."
                                    ValidationGroup="ChangePassword" />
                            </li>
                        </ol>
                        <asp:Button runat="server" CommandName="ChangePassword" Text="Zmień hasło" ValidationGroup="ChangePassword" />
                    </fieldset>
                </ChangePasswordTemplate>
            </asp:ChangePassword>
        </asp:PlaceHolder>
    </section>

    <section id="externalLoginsForm">
        
        <asp:ListView  runat="server" ID="externalLoginsList" ViewStateMode="Disabled"
            DataKeyNames="ProviderName,ProviderUserId" OnItemDeleting="externalLoginsList_ItemDeleting">
        
            <LayoutTemplate>
                <h3>Zarejestrowane konta zewnętrzne.</h3>
                <table class="GV_projekty" style="width:70%;" >
                    <thead><tr><th>Serwis</th><th>Nazwa użytkownika</th><th>  Ostatnio używane</th><th>&nbsp;</th></tr></thead>
                    <tbody>
                        <tr runat="server" id="itemPlaceholder"></tr>
                    </tbody>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    
                    <td style="text-align:center;"><%# HttpUtility.HtmlEncode(Item<OpenAuthAccountData>().ProviderDisplayName) %></td>
                    <td style="text-align:center;"><%# HttpUtility.HtmlEncode(Item<OpenAuthAccountData>().ProviderUserName) %></td>
                    <td style="text-align:center;"><%# HttpUtility.HtmlEncode(ConvertToDisplayDateTime(Item<OpenAuthAccountData>().LastUsedUtc)) %></td>
                    <td style="text-align:center;">
                        <asp:Button runat="server" Text="Usuń" CommandName="Delete" CausesValidation="false" 
                            ToolTip='<%# "Usuń konto " + Item<OpenAuthAccountData>().ProviderDisplayName + " z naszego serwisu." %>'
                            Visible="<%# CanRemoveExternalLogins %>" />
                    </td>
                    
                </tr>
            </ItemTemplate>
        </asp:ListView>

        <h3>Dodaj zewnętrzny login</h3>
        <uc:OpenAuthProviders runat="server" ReturnUrl="~/Account/Manage" />
    </section>
</asp:Content>
