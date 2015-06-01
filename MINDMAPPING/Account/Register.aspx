<%@ Page Title="Rejestracja" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="MatStud.Account.Register" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc1" TagName="OpenAuthProviders" %>


<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <hgroup class="title">
        <h2>Rejestracja nowego użytkownika</h2>
        </hgroup>
        <asp:Label ID="LblKomunikat" runat="server" Text=""></asp:Label>
    <hgroup>
    </hgroup>
    <section id="loginForm">
    <asp:CreateUserWizard runat="server" DisableCreatedUser="true" ID="RegisterUser" ViewStateMode="Disabled" OnCreatedUser="RegisterUser_CreatedUser" MembershipProvider="LoginMembershipProvider" CompleteSuccessText="Konto utworzone pomyślnie" DuplicateEmailErrorMessage="E-mail podany przez Ciebie jest już używany. Podaj inny." DuplicateUserNameErrorMessage="Podana przez Ciebie nazwa użytkownika jest już zajęta. Podaj inną." InvalidPasswordErrorMessage=" Hasło musi mieć przynajmniej {0} znaków w tym {1} znak niealfanumeryczny." UnknownErrorMessage="Konto nie zostało utworzone. Spróbuj ponownie.">
        <LayoutTemplate>
            <asp:PlaceHolder runat="server" ID="wizardStepPlaceholder" />
            <asp:PlaceHolder runat="server" ID="navigationPlaceholder" />
        </LayoutTemplate>
        <WizardSteps>
            <asp:CreateUserWizardStep runat="server" ID="RegisterUserWizardStep" EnableTheming="True" Title="Zarejestruj nowe konto.">
                <ContentTemplate>
                    <p class="message-info" style="margin: 15px">
                        Hasło musi mieć przynajmniej <%: Membership.MinRequiredPasswordLength %> znaków w tym <%: Membership.MinRequiredNonAlphanumericCharacters %> znak niealfanumeryczny.
                    </p>

                    <p class="validation-summary-errors">
                        <asp:Literal runat="server" ID="ErrorMessage" />
                    </p>

                    <fieldset>
                        <legend>Formularz rejestracji</legend>
                        <ol>
                            <li>
                                <asp:Label runat="server" AssociatedControlID="UserName">Login</asp:Label>
                                <asp:TextBox runat="server" ID="UserName" MaxLength="30" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName"
                                    CssClass="field-validation-error" ErrorMessage="To pole jest wymagane" /><br />
                                <asp:RegularExpressionValidator Display="Dynamic" ID="RegularExpressionValidatorUserName"  CssClass="field-validation-error" runat="server" ControlToValidate="UserName" ValidationExpression ="^(?!(?:CON|PRN|AUX|NUL|COM[1-9]|LPT[1-9])(?:\.[^.]*)?$)[^<>:/\\|?*\s]*[^<>:/\\|?*\s]$" ErrorMessage="Login zawiera niedozwolone znaki." ToolTip="Niedozwolone znaki to / \ < > ? : * | oraz białe znaki."></asp:RegularExpressionValidator><br />
                                   <asp:RegularExpressionValidator CssClass="field-validation-error"  Display = "Dynamic" ControlToValidate = "UserName" ID="RegularExpressionValidatorMinMaxPass" ValidationExpression = "^[\s\S]{5,30}$" runat="server" ErrorMessage="Login może mieć minimalnie 5 znaków a maksymalnie 30."></asp:RegularExpressionValidator>
                            </li>
                            <li>
                                <asp:Label runat="server" AssociatedControlID="Email">Adres e-mail</asp:Label>
                                <asp:TextBox runat="server" ID="Email" />
                                <asp:RequiredFieldValidator runat="server"  Display="Dynamic" ControlToValidate="Email"
                                    CssClass="field-validation-error" ErrorMessage="To pole jest wymagane" /><br />
                                <asp:RegularExpressionValidator Display="Dynamic" ID="RegularExpressionValidatorEmail"  CssClass="field-validation-error" runat="server" ControlToValidate="Email" ValidationExpression ="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" ErrorMessage="Nie wpisałeś poprawnego adresu e-mail"></asp:RegularExpressionValidator>
                            </li>
                            <li>
                                <asp:Label runat="server" AssociatedControlID="Password">Hasło</asp:Label>
                                <asp:TextBox runat="server" ID="Password" TextMode="Password" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                                    CssClass="field-validation-error" ErrorMessage="To pole jest wymagane" />
                             
                            </li>
                            <li>
                                <asp:Label runat="server" AssociatedControlID="ConfirmPassword">Potwierdź hasło</asp:Label>
                                <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                                     CssClass="field-validation-error" Display="Dynamic" ErrorMessage="To pole jest wymagane" /><br />
                                <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                                     CssClass="field-validation-error" Display="Dynamic" ErrorMessage="Hasło nie zgadza się z potwierdzeniem" />
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
     
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Question"
                                    CssClass="field-validation-error" InitialValue="Wybierz pytanie pomocnicze" ErrorMessage="Musisz wybrać pytanie." />
                            </li>
                            <li>
                                <asp:Label runat="server" AssociatedControlID="Answer">Odpowiedz:</asp:Label>
                                <asp:TextBox runat="server" ID="Answer" ToolTip="Zapamiętaj odpowiedź, którą wprowadzisz. Będzie ona potrzebna wrazie odzyskania hasła." />
                               <asp:RequiredFieldValidator runat="server" ControlToValidate="Answer"
                                    CssClass="field-validation-error" ErrorMessage="To pole jest wymagane" />
                            </li>
                        </ol>
                        <asp:Button runat="server" CommandName="MoveNext" Width="150px" Text="Zarejestruj się" />
                    </fieldset>
                </ContentTemplate>
                <CustomNavigationTemplate />
            </asp:CreateUserWizardStep>
<asp:CompleteWizardStep runat="server">
    <ContentTemplate>
        <table>
            <tr>
                <td  colspan="2">Ukończono tworzenie konta.</td>
            </tr>
            <tr>
                <td>Twoje konto zostało pomyślnie utworzone.</td>
            </tr>
        </table>
    </ContentTemplate>
            </asp:CompleteWizardStep>
        </WizardSteps>
    </asp:CreateUserWizard>
        </section>
      <section id="socialLoginForm">
        <h2>Użyj konta w innym serwisie by się zarejestrować</h2>
          <uc1:OpenAuthProviders runat="server" ID="OpenAuthProviders" />
    </section>
</asp:Content>
