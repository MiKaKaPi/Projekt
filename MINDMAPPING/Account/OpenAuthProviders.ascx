<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OpenAuthProviders.ascx.cs" Inherits="MatStud.Account.OpenAuthProviders" %>
<%@ Import Namespace="Microsoft.AspNet.Membership.OpenAuth" %>
<fieldset class="open-auth-providers">
    <legend>Zaloguj się używając konta zewnętrznego</legend>
    
    <asp:ListView runat="server" ID="providersList" ViewStateMode="Disabled">
        <ItemTemplate>
            <button  type="submit" name="provider" value="<%# HttpUtility.HtmlAttributeEncode(Item<ProviderDetails>().ProviderName) %>"
                title="Zaloguj się używając konta: <%# HttpUtility.HtmlAttributeEncode(Item<ProviderDetails>().ProviderDisplayName) %>.">
                <%# HttpUtility.HtmlEncode(Item<ProviderDetails>().ProviderDisplayName) %>
            </button><br />    
        </ItemTemplate>
    
        
    </asp:ListView>
</fieldset>