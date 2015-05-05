<%@ Page Title="Odzyskiwanie hasła" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PasswordRecovery.aspx.cs" Inherits="MatStud.Account.PasswordRecovery" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
        <asp:PasswordRecovery MailDefinition-Subject="Odzyskaj hasło do serwisu" MembershipProvider="LoginMembershipProvider"  ID="PwdRecovery" runat="server" MailDefinition-CC="administrator@mindmap.com" EnableViewState="True" MailDefinition-BodyFileName="~/App_Data/recoverypasswordemail.txt" AnswerLabelText="Odpowiedź:" GeneralFailureText="Próba odzyskania hasła nie powiodła się. Proszę spróbować ponownie." QuestionFailureText="Odpowiedź nie zgadza się z tą podaną przez Ciebie przy rejestracji. Spróbuj ponownie." QuestionInstructionText="Odpowiedz na pytanie by odzyskać hasło." QuestionLabelText="Pytanie:" SubmitButtonText="Potwierdź" SuccessText="Hasło zostało pomyślnie wysłane na twój e-mail." UserNameFailureText="Nie można rozpoznać podanej nazwy użytkownika. Spróbuj ponownie." UserNameInstructionText="Wprowadź swoją nazwę użytkownika." UserNameLabelText="Nazwa użytkownika:" UserNameTitleText="Formularz odzyskiwania hasła" AnswerRequiredErrorMessage="Odpowiedź jest wymagana" UserNameRequiredErrorMessage="Nazwa użytkownika jest wymagana." QuestionTitleText="Potwierdzenie tożsamości">
         

        </asp:PasswordRecovery>

</asp:Content>
