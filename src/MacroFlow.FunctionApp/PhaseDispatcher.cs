#region Collapsed: Copyright (c) Acornsoft. All rights reserved.
// Portions Copyright (c) Acornsoft. All Rights Reserved.
#endregion

#region Using Directives

/* ========== MICROSOFT .NET framework file(s) ========= */
using System;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

/* ========== MICROSOFT extensions file(s) ========= */
using Microsoft.Extensions.Configuration;

/* ========== ACORNSOFT file(s) ========= */
using Acornsoft.Luna.MacroFlow.Foundry;

#endregion

namespace Acornsoft.Luna.MacroFlow.Foundry
{
    /// <summary>
    /// Simple dispatcher for MacroFlow phases with Grok API integration.
    /// </summary>
    public sealed class PhaseDispatcher
    {
        private readonly HttpClient _httpClient;
        private readonly string _apiKey;
        private readonly PromptLoader _promptLoader;
        private const string GrokApiUri = "https://api.x.ai/v1/chat/completions";

        #region Public Members
        // ===== INSTANCE CONSTRUCTORS ======
        /// <summary>
        /// Initializes a new instance of the <see cref="PhaseDispatcher"/> class.
        /// </summary>
        public PhaseDispatcher(IHttpClientFactory httpClientFactory, IConfiguration configuration, PromptLoader promptLoader)
        {
            ArgumentNullException.ThrowIfNull(httpClientFactory);
            ArgumentNullException.ThrowIfNull(configuration);
            ArgumentNullException.ThrowIfNull(promptLoader);

            _httpClient = httpClientFactory.CreateClient();
            _apiKey = configuration["GrokApiKey"]!;
            if (string.IsNullOrEmpty(_apiKey))
            {
                throw new InvalidOperationException("GrokApiKey is not configured.");
            }
            _promptLoader = promptLoader;
        }

        // ===== INSTANCE METHODS ==========
        /// <summary>
        /// Executes the specified MacroFlow phase asynchronously using Grok API.
        /// </summary>
        /// <param name="phase">The phase to execute.</param>
        /// <param name="context">The context for the phase.</param>
        public async Task<string> ExecutePhaseAsync(string phase, string context)
        {
            ArgumentException.ThrowIfNullOrEmpty(phase);
            ArgumentException.ThrowIfNullOrEmpty(context);

            var promptTemplate = _promptLoader.LoadPrompt(phase);
            if (promptTemplate == null)
            {
                throw new InvalidOperationException($"Prompt template for phase '{phase}' not found.");
            }

            // For testing without API key
            if (_apiKey == "secret-is-stored-in-local-secrets-json")
            {
                return $"Mock response for phase {phase}: System: {promptTemplate.System}\nUser: {promptTemplate.UserTemplate?.Replace("{context}", context, StringComparison.Ordinal)}";
            }

            string systemMessage = promptTemplate.System ?? "You are a helpful assistant.";
            string userMessage = promptTemplate.UserTemplate?.Replace("{context}", context, StringComparison.Ordinal) ?? $"Execute phase {phase} for {context}.";

            var requestContent = new
            {
                model = "grok-4-1-fast-reasoning",
                messages = new[] {
                    new { role = "system", content = systemMessage },
                    new { role = "user", content = userMessage }
                },
                temperature = 0.3 // Low for code tasks
            };

            var jsonContent = JsonSerializer.Serialize(requestContent);
            using var httpContent = new StringContent(jsonContent, Encoding.UTF8, "application/json");

            httpContent.Headers.ContentType = MediaTypeHeaderValue.Parse("application/json; charset=utf-8");

            _httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", _apiKey);
            var uri = new Uri(GrokApiUri);
            var response = await _httpClient.PostAsync(uri, httpContent).ConfigureAwait(false);

            if (!response.IsSuccessStatusCode)
            {
                throw new HttpRequestException($"Grok API error: {response.StatusCode}");
            }

            var responseContent = await response.Content.ReadAsStringAsync().ConfigureAwait(false);
            var grokResponse = JsonDocument.Parse(responseContent);
            string? result = grokResponse.RootElement.GetProperty("choices")[0].GetProperty("message").GetProperty("content").GetString();
            return result ?? throw new InvalidOperationException("No content in Grok response.");
        }

        #endregion
    }
}