#region Collapsed: Copyright (c) Acornsoft. All rights reserved.
// Portions Copyright (c) Acornsoft. All Rights Reserved.
#endregion

#region Using Directives

/* ========== MICROSOFT .NET framework file(s) ========= */


/* ========== .NET framework file(s) =================== */
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Builder;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Configuration.AzureAppConfiguration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

/* ========== 3RD PARTY .NET framework file(s) ========= */
using Azure.Extensions.AspNetCore.Configuration.Secrets;
using Azure.Identity;


#endregion

namespace Acornsoft.Luna.MacroFlow.Foundry
{
    /// <summary>
    /// Represents the entry point for the Luna MacroFlow MCP Function App.
    /// </summary>
    internal static class Program
    {
        #region Public Members
        // ===== NESTED TYPES ===============
        // ===== CONSTANTS/STATIC FIELDS ====
        // ===== STATIC PROPERTIES ==========
        // ===== STATIC METHODS =============
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        /// <param name="args">Command-line arguments.</param>
        private static void Main(string[] args)
        {
            var builder = FunctionsApplication.CreateBuilder(args);

            builder.Configuration.AddUserSecrets(typeof(Program).Assembly);

            // Configure Azure Key Vault if URI is provided
            string? keyVaultUri = builder.Configuration["AzureKeyVault:Uri"];
            if (!string.IsNullOrEmpty(keyVaultUri))
            {
                builder.Configuration.AddAzureKeyVault(new Uri(keyVaultUri), new DefaultAzureCredential());
            }

            // Configure Azure App Configuration if endpoint is provided
            string? appConfigEndpoint = builder.Configuration["AzureAppConfiguration:Endpoint"];
            if (!string.IsNullOrEmpty(appConfigEndpoint))
            {
                builder.Configuration.AddAzureAppConfiguration(options =>
                {
                    options.Connect(new Uri(appConfigEndpoint), new DefaultAzureCredential());
                });
            }

            builder.ConfigureFunctionsWebApplication();

            builder.Services
                   .AddSingleton<IConfiguration>(builder.Configuration)
                   .AddApplicationInsightsTelemetryWorkerService()
                   .ConfigureFunctionsApplicationInsights()
                   .AddHttpClient()
                   .AddSingleton<PromptLoader>()
                   .AddTransient<PhaseDispatcher>();

            builder.Build().Run();
        }

        #endregion

        #region Protected and Internal Members
        // ===== PROTECTED PROPERTIES =======
        // ===== PROTECTED METHODS =========
        // ===== INTERNAL PROPERTIES ========
        // ===== INTERNAL METHODS ==========

        #endregion

        #region Private Members
        // ===== PRIVATE PROPERTIES ========
        // ===== PRIVATE METHODS ===========

        #endregion
    }
}
