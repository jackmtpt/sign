﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;

namespace SignService.Services
{
    public interface IUser
    {
        string ObjectId { get; }
        string TenantId { get; }
        string TimestampUrl { get; }
        string KeyVaultUrl { get; }
        string CertificateName { get; }
        string IncomingAccessToken { get; }
    }

    class HttpContextUser : IUser
    {
        readonly ClaimsPrincipal currentUser;
        public HttpContextUser(IHttpContextAccessor contextAccessor)
        {
            currentUser = contextAccessor.HttpContext.User;
        }

        public string ObjectId => currentUser.FindFirst("oid").Value;

        public string TenantId => currentUser.FindFirst("tid").Value;

        public string TimestampUrl => currentUser.FindFirst("timestampUrl")?.Value;

        public string KeyVaultUrl => currentUser.FindFirst("keyVaultUrl")?.Value;

        public string CertificateName => currentUser.FindFirst("keyVaultCertificateName")?.Value;

        public string IncomingAccessToken => currentUser.FindFirst("access_token")?.Value;
    }
}
