using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.Membership.OpenAuth;

namespace MatStud
{
    internal static class AuthConfig
    {
        public static void RegisterOpenAuth()
        {

            OpenAuth.AuthenticationClients.AddFacebook(
                appId: "604834612973063",
                appSecret: "569376bc31c841e95b6f14c04afb2ff3");

            OpenAuth.AuthenticationClients.AddGoogle();       
        }
    }
}