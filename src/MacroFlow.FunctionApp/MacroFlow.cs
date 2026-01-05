#region Collapsed: Copyright (c) Acornsoft. All rights reserved.
// Portions Copyright (c) Acornsoft. All Rights Reserved.
#endregion

#region Using Directives

/* ========== MICROSOFT .NET framework file(s) ========= */
using System;
using System.IO;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

/* ========== .NET framework file(s) =================== */
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

/* ========== 3RD PARTY .NET framework file(s) ========= */

#endregion

namespace Acornsoft.Luna.MacroFlow.Foundry
{
    /// <summary>
    /// Represents the Luna MacroFlow MCP orchestrator Function.
    /// </summary>
    internal sealed class MacroFlowOrchestrator
    {
        private readonly ILogger _logger;
        private readonly PhaseDispatcher _dispatcher;
        private static readonly Action<ILogger, Exception?> _macroFlowTriggered = LoggerMessage.Define(LogLevel.Information, new EventId(1, "MacroFlowTriggered"), "MacroFlow MCP triggered.");

        #region Public Members
        // ===== NESTED TYPES ===============
        // ===== CONSTANTS/STATIC FIELDS ====
        // ===== STATIC PROPERTIES ==========
        // ===== STATIC METHODS =============
        // ===== INSTANCE CONSTRUCTORS ======
        /// <summary>
        /// Initializes a new instance of the <see cref="MacroFlowOrchestrator"/> class.
        /// </summary>
        public MacroFlowOrchestrator(ILoggerFactory loggerFactory, PhaseDispatcher dispatcher)
        {
            _logger = loggerFactory.CreateLogger<MacroFlowOrchestrator>();
            _dispatcher = dispatcher;
        }

        // ===== DISPOSE PATTERN ============
        // ===== OPERATORS ==================
        // ===== INSTANCE PROPERTIES ========
        // ===== EVENTS ====================
        // ===== INDEXERS ==================
        // ===== INSTANCE METHODS ==========
        /// <summary>
        /// HTTP-triggered entry point for MacroFlow orchestration.
        /// </summary>
        [Function("MacroFlow")]
        public async Task<IActionResult> Run([HttpTrigger(AuthorizationLevel.Function, "post")] HttpRequestData req)
        {
            ArgumentNullException.ThrowIfNull(req);
            _macroFlowTriggered(_logger, null);

            using var reader = new StreamReader(req.Body);
            string requestBody = await reader.ReadToEndAsync().ConfigureAwait(false);
            if (string.IsNullOrWhiteSpace(requestBody))
            {
                return new BadRequestObjectResult("Request body is required and must contain valid JSON.");
            }

            JsonDocument data;
            try
            {
                data = JsonDocument.Parse(requestBody);
            }
            catch (System.Text.Json.JsonException)
            {
                return new BadRequestObjectResult("Request body must contain valid JSON.");
            }
            
            string? useCase = data.RootElement.GetProperty("useCase").GetString();
            string? context = data.RootElement.GetProperty("context").GetString();
            if (string.IsNullOrEmpty(useCase) || string.IsNullOrEmpty(context))
            {
                return new BadRequestObjectResult("Request body must contain 'useCase' and 'context' properties.");
            }

            // Run full MacroFlow ritual
            var results = new Dictionary<string, string>();
            string phaseContext = $"{useCase} - {context}";

            // Run Constitution, Clarify, and D365Consult in parallel as they are independent
            var initialPhases = new[] { "Constitution", "Clarify", "D365Consult" };
            var initialTasks = initialPhases.Select(async phase => 
                (phase, await _dispatcher.ExecutePhaseAsync(phase, phaseContext).ConfigureAwait(false))).ToArray();
            
            var initialResults = await Task.WhenAll(initialTasks).ConfigureAwait(false);
            
            foreach (var (phase, result) in initialResults)
            {
                results[phase] = result;
            }

            // Run remaining phases sequentially as they depend on previous results
            var sequentialPhases = new[] { "Specify", "Plan", "Tasks", "Implement", "AgentCreation" };
            foreach (var phase in sequentialPhases)
            {
                string result = await _dispatcher.ExecutePhaseAsync(phase, phaseContext).ConfigureAwait(false);
                results[phase] = result;
            }

            return new OkObjectResult(results);
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
