#region Collapsed: Copyright (c) Acornsoft. All rights reserved.
// Portions Copyright (c) Acornsoft. All Rights Reserved.
#endregion

#region Using Directives

/* ========== MICROSOFT .NET framework file(s) ========= */
using System;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;

/* ========== .NET framework file(s) =================== */
using Microsoft.Extensions.Configuration;

/* ========== 3RD PARTY .NET framework file(s) ========= */
using Moq;
using Moq.Protected;

using Xunit;

#endregion

namespace Acornsoft.Luna.MacroFlow.Foundry.Tests // Match your namespace
{
    /// <summary>
    /// Represents unit tests for PhaseDispatcher in the MCP.
    /// </summary>
    public sealed class PhaseDispatcherTests : IDisposable
    {
        private readonly IConfiguration _configuration;
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly PromptLoader _promptLoader;
        private readonly PhaseDispatcher _dispatcher;

        public PhaseDispatcherTests()
        {
            var inMemorySettings = new Dictionary<string, string>
            {
                ["GrokApiKey"] = "test-api-key-for-testing"
            };

            _configuration = new ConfigurationBuilder()
                .AddInMemoryCollection(inMemorySettings!)
                .Build();

            _httpClientFactory = new TestHttpClientFactory();
            _promptLoader = new PromptLoader();
            _dispatcher = new PhaseDispatcher(_httpClientFactory, _configuration, _promptLoader);
        }

        public void Dispose()
        {
            // Cleanup if needed
        }

        #region Public Members
        // ===== INSTANCE METHODS ==========
        /// <summary>
        /// Tests ExecutePhaseAsync with a safe prompt to ensure no Grok refusal.
        /// </summary>
        [Fact]
        public async Task ExecutePhaseAsyncSafePromptReturnsNoRefusal()
        {
            // Arrange: Mock IConfiguration
            var mockConfig = new Mock<IConfiguration>();
            mockConfig.Setup(c => c["GrokApiKey"]).Returns("mock-test-key");

            // Mock HttpMessageHandler for fake response
            var mockHandler = new Mock<HttpMessageHandler>(MockBehavior.Loose);
            mockHandler.Protected()
                .Setup<Task<HttpResponseMessage>>("SendAsync", ItExpr.IsAny<HttpRequestMessage>(), ItExpr.IsAny<CancellationToken>())
                .ReturnsAsync(() =>
                {
                    var response = new HttpResponseMessage
                    {
                        StatusCode = HttpStatusCode.OK,
                        Content = new StringContent(JsonSerializer.Serialize(new
                        {
                            choices = new[]
                            {
                                new { message = new { content = "Loaded manifesto for Luna MCP POC." } } // Fake non-refusal response
                            }
                        }), Encoding.UTF8, "application/json")
                    };
                    return response;
                });

            using var mockHttpClient = new HttpClient(mockHandler.Object);
            var mockFactory = new Mock<IHttpClientFactory>();
            mockFactory.Setup(f => f.CreateClient(It.IsAny<string>())).Returns(mockHttpClient);

            var promptLoader = new PromptLoader();

            // Instantiate your actual PhaseDispatcher
            var dispatcher = new PhaseDispatcher(mockFactory.Object, mockConfig.Object, promptLoader);

            // Act
            string result = await dispatcher.ExecutePhaseAsync("Constitution", "Luna MCP POC");

            // Assert: No refusal in content
            Assert.DoesNotContain("can't engage", result, StringComparison.OrdinalIgnoreCase);
            Assert.DoesNotContain("sorry", result, StringComparison.OrdinalIgnoreCase);
            Assert.Contains("manifesto", result, StringComparison.Ordinal); // Example expected content check
        }

        /// <summary>
        /// Integration test for Constitution phase with real API.
        /// </summary>
        [Fact]
        public async Task ExecutePhaseAsyncConstitutionSimpleTest()
        {
            // Act
            string result = await _dispatcher.ExecutePhaseAsync("Constitution", "Simple test - Basic functionality");

            // Assert
            Assert.NotNull(result);
            Assert.NotEmpty(result);
            Console.WriteLine($"Constitution result length: {result.Length}");
            Console.WriteLine($"Preview: {result.Substring(0, Math.Min(200, result.Length))}...");
        }

        /// <summary>
        /// Integration test for Clarify phase with real API.
        /// </summary>
        [Fact]
        public async Task ExecutePhaseAsyncClarifyMediumTest()
        {
            // Act
            string result = await _dispatcher.ExecutePhaseAsync("Clarify", "Medium test - Dynamics 365 Functional Consultant role analysis");

            // Assert
            Assert.NotNull(result);
            Assert.NotEmpty(result);
            Console.WriteLine($"Clarify result length: {result.Length}");
            Console.WriteLine($"Preview: {result.Substring(0, Math.Min(200, result.Length))}...");
        }

        /// <summary>
        /// Integration test for Specify phase with real API.
        /// </summary>
        [Fact]
        public async Task ExecutePhaseAsyncSpecifyCompleteTest()
        {
            // Act
            string result = await _dispatcher.ExecutePhaseAsync("Specify", "Complete test - Full requirements specification for D365 consultant agent");

            // Assert
            Assert.NotNull(result);
            Assert.NotEmpty(result);
            Console.WriteLine($"Specify result length: {result.Length}");
            Console.WriteLine($"Preview: {result.Substring(0, Math.Min(200, result.Length))}...");
        }

        /// <summary>
        /// Integration test for Plan phase with real API.
        /// </summary>
        [Fact]
        public async Task ExecutePhaseAsyncPlanCompleteTest()
        {
            // Act
            string result = await _dispatcher.ExecutePhaseAsync("Plan", "Complete test - Comprehensive implementation plan");

            // Assert
            Assert.NotNull(result);
            Assert.NotEmpty(result);
            Console.WriteLine($"Plan result length: {result.Length}");
            Console.WriteLine($"Preview: {result.Substring(0, Math.Min(200, result.Length))}...");
        }

        /// <summary>
        /// Integration test for Tasks phase with real API.
        /// </summary>
        [Fact]
        public async Task ExecutePhaseAsyncTasksCompleteTest()
        {
            // Act
            string result = await _dispatcher.ExecutePhaseAsync("Tasks", "Complete test - Detailed task breakdown");

            // Assert
            Assert.NotNull(result);
            Assert.NotEmpty(result);
            Console.WriteLine($"Tasks result length: {result.Length}");
            Console.WriteLine($"Preview: {result.Substring(0, Math.Min(200, result.Length))}...");
        }

        /// <summary>
        /// Integration test for Implement phase with real API.
        /// </summary>
        [Fact]
        public async Task ExecutePhaseAsyncImplementCompleteTest()
        {
            // Act
            string result = await _dispatcher.ExecutePhaseAsync("Implement", "Complete test - Full implementation details");

            // Assert
            Assert.NotNull(result);
            Assert.NotEmpty(result);
            Console.WriteLine($"Implement result length: {result.Length}");
            Console.WriteLine($"Preview: {result.Substring(0, Math.Min(200, result.Length))}...");
        }

        /// <summary>
        /// Tests ExecutePhaseAsync with API failure response.
        /// </summary>
        [Fact]
        public async Task ExecutePhaseAsyncApiFailureThrowsException()
        {
            // Arrange: Mock IConfiguration
            var mockConfig = new Mock<IConfiguration>();
            mockConfig.Setup(c => c["GrokApiKey"]).Returns("mock-test-key");

            // Mock HttpMessageHandler for failure response
            var mockHandler = new Mock<HttpMessageHandler>(MockBehavior.Loose);
            mockHandler.Protected()
                .Setup<Task<HttpResponseMessage>>("SendAsync", ItExpr.IsAny<HttpRequestMessage>(), ItExpr.IsAny<CancellationToken>())
                .ReturnsAsync(() =>
                {
                    var response = new HttpResponseMessage
                    {
                        StatusCode = HttpStatusCode.InternalServerError,
                        Content = new StringContent("Internal Server Error")
                    };
                    return response;
                });

            using var mockHttpClient = new HttpClient(mockHandler.Object);
            var mockFactory = new Mock<IHttpClientFactory>();
            mockFactory.Setup(f => f.CreateClient(It.IsAny<string>())).Returns(mockHttpClient);

            var promptLoader = new PromptLoader();

            // Instantiate your actual PhaseDispatcher
            var dispatcher = new PhaseDispatcher(mockFactory.Object, mockConfig.Object, promptLoader);

            // Act & Assert
            await Assert.ThrowsAsync<HttpRequestException>(() => dispatcher.ExecutePhaseAsync("Constitution", "Test"));
        }

        /// <summary>
        /// Tests ExecutePhaseAsync with invalid JSON response.
        /// </summary>
        [Fact]
        public async Task ExecutePhaseAsyncInvalidJsonResponseThrowsException()
        {
            // Arrange: Mock IConfiguration
            var mockConfig = new Mock<IConfiguration>();
            mockConfig.Setup(c => c["GrokApiKey"]).Returns("mock-test-key");

            // Mock HttpMessageHandler for invalid JSON response
            var mockHandler = new Mock<HttpMessageHandler>(MockBehavior.Loose);
            mockHandler.Protected()
                .Setup<Task<HttpResponseMessage>>("SendAsync", ItExpr.IsAny<HttpRequestMessage>(), ItExpr.IsAny<CancellationToken>())
                .ReturnsAsync(() =>
                {
                    var response = new HttpResponseMessage
                    {
                        StatusCode = HttpStatusCode.OK,
                        Content = new StringContent("Invalid JSON response")
                    };
                    return response;
                });

            using var mockHttpClient = new HttpClient(mockHandler.Object);
            var mockFactory = new Mock<IHttpClientFactory>();
            mockFactory.Setup(f => f.CreateClient(It.IsAny<string>())).Returns(mockHttpClient);

            var promptLoader = new PromptLoader();

            // Instantiate your actual PhaseDispatcher
            var dispatcher = new PhaseDispatcher(mockFactory.Object, mockConfig.Object, promptLoader);

            // Act & Assert
            await Assert.ThrowsAnyAsync<Exception>(() => dispatcher.ExecutePhaseAsync("Constitution", "Test"));
        }

        /// <summary>
        /// Tests ExecutePhaseAsync with invalid phase name.
        /// </summary>
        [Fact]
        public async Task ExecutePhaseAsyncInvalidPhaseThrowsInvalidOperationException()
        {
            // Arrange: Mock IConfiguration
            var mockConfig = new Mock<IConfiguration>();
            mockConfig.Setup(c => c["GrokApiKey"]).Returns("mock-test-key");

            var mockFactory = new Mock<IHttpClientFactory>();
            var promptLoader = new PromptLoader();

            // Instantiate your actual PhaseDispatcher
            var dispatcher = new PhaseDispatcher(mockFactory.Object, mockConfig.Object, promptLoader);

            // Act & Assert
            await Assert.ThrowsAsync<InvalidOperationException>(() => dispatcher.ExecutePhaseAsync("InvalidPhase", "Test"));
        }

        [Fact]
        public void PromptLoaderLoadsAllPhasePrompts()
        {
            // Arrange
            var promptLoader = new PromptLoader();

            // Test each phase individually
            var constitutionPrompt = promptLoader.LoadPrompt("Constitution");
            Assert.NotNull(constitutionPrompt);

            var clarifyPrompt = promptLoader.LoadPrompt("Clarify");
            Assert.NotNull(clarifyPrompt);

            var specifyPrompt = promptLoader.LoadPrompt("Specify");
            Assert.NotNull(specifyPrompt);

            var planPrompt = promptLoader.LoadPrompt("Plan");
            Assert.NotNull(planPrompt);

            var tasksPrompt = promptLoader.LoadPrompt("Tasks");
            Assert.NotNull(tasksPrompt);

            var implementPrompt = promptLoader.LoadPrompt("Implement");
            Assert.NotNull(implementPrompt);
        }

        /// <summary>
        /// Tests PromptLoader returns null for invalid phase.
        /// </summary>
        [Fact]
        public void PromptLoaderInvalidPhaseReturnsNull()
        {
            // Arrange
            var promptLoader = new PromptLoader();

            // Act
            var prompt = promptLoader.LoadPrompt("InvalidPhase");

            // Assert
            Assert.Null(prompt);
        }

        #endregion

        #region Protected and Internal Members
        // ===== PROTECTED PROPERTIES =======
        // ===== PROTECTED METHODS ==========
        // ===== INTERNAL PROPERTIES ========
        // ===== INTERNAL METHODS ===========

        #endregion

        #region Private Members
        // ===== PRIVATE PROPERTIES ========
        // ===== PRIVATE METHODS ===========

        #endregion
    }

    internal sealed class TestHttpClientFactory : IHttpClientFactory
    {
        public HttpClient CreateClient(string name)
        {
            // Create a mock HttpMessageHandler
            var mockHandler = new Mock<HttpMessageHandler>();
            mockHandler.Protected()
                .Setup<Task<HttpResponseMessage>>("SendAsync", ItExpr.IsAny<HttpRequestMessage>(), ItExpr.IsAny<CancellationToken>())
                .ReturnsAsync(() =>
                {
                    var response = new HttpResponseMessage
                    {
                        StatusCode = HttpStatusCode.OK,
                        Content = new StringContent(JsonSerializer.Serialize(new
                        {
                            choices = new[]
                            {
                                new { message = new { content = "Mock response for testing phase execution." } }
                            }
                        }), Encoding.UTF8, "application/json")
                    };
                    return response;
                });

            return new HttpClient(mockHandler.Object);
        }
    }
}
