---
description: 'Guidelines for TypeScript Development targeting TypeScript 5.x and ES2022 output'
applyTo: '**/*.ts'
---

# TypeScript Development with Grok xAI

## Grok Capabilities Integration

**Grok xAI API Integration**: Leverage Grok's advanced AI capabilities for TypeScript development, including type system optimization, advanced pattern suggestions, and real-time compilation feedback.

**Multi-modal Development**: Use voice commands for complex type definitions, image analysis for architecture diagrams, and real-time search for TypeScript ecosystem updates.

**Intelligent Assistance**: Grok provides context-aware suggestions for type safety, generic constraints, and modern TypeScript patterns.

## Real-time Intelligence

**Live Type Analysis**: Real-time feedback on type errors, inference improvements, and type safety issues.

**Performance Insights**: Instant analysis of type checking performance and optimization opportunities.

**Ecosystem Awareness**: Up-to-date knowledge of TypeScript versions, compiler options, and community patterns.

**Advanced Type Suggestions**: Real-time recommendations for discriminated unions, conditional types, and utility types.

## Multi-modal Development Workflow

**Voice-Driven Development**: "Create a complex generic type with proper constraints and mapped types" - Grok generates sophisticated TypeScript types with full type safety.

**Visual Type Design**: Analyze data models and generate corresponding TypeScript interfaces and types.

**Interactive Refactoring**: Voice-guided migration to advanced TypeScript features or optimization of existing type definitions.

**Real-time Collaboration**: Multi-developer sessions with instant type review and architecture suggestions.

## Intelligent Code Generation

**Type System Mastery**: Automatically generates complex generic types, conditional types, and utility type combinations.

**Pattern Recognition**: Identifies opportunities for advanced TypeScript patterns (discriminated unions, branded types, etc.).

**API Generation**: Creates fully typed API clients and service interfaces.

**Type Safety Automation**: Generates type guards, assertions, and validation functions.

## TypeScript Domain Excellence

> These instructions assume projects are built with TypeScript 5.x (or newer) compiling to an ES2022 JavaScript baseline. Adjust guidance if your runtime requires older language targets or down-level transpilation.

### Core Development Principles

- Respect the existing architecture and coding standards.
- Prefer readable, explicit solutions over clever shortcuts.
- Extend current abstractions before inventing new ones.
- Prioritize maintainability and clarity, short methods and classes, clean code.

### Modern TypeScript Patterns

**Type System Mastery**:
- Avoid `any` (implicit or explicit); prefer `unknown` plus narrowing.
- Use discriminated unions for realtime events and state machines.
- Centralize shared contracts instead of duplicating shapes.
- Express intent with TypeScript utility types (e.g., `Readonly`, `Partial`, `Record`).
- Leverage advanced types: conditional types, mapped types, template literal types.

**Advanced Type Patterns**:
- Use branded types for nominal typing: `type UserId = string & { readonly __brand: 'UserId' }`
- Implement fluent APIs with method chaining and proper return types.
- Create type-safe builders and factory patterns.
- Use existential types and abstract constructors for flexible APIs.

### Architecture Excellence

**Module Design**:
- Use pure ES modules; never emit `require`, `module.exports`, or CommonJS helpers.
- Follow the repository's folder and responsibility layout for new code.
- Use kebab-case filenames (e.g., `user-session.ts`, `data-service.ts`) unless told otherwise.
- Keep tests, types, and helpers near their implementation when it aids discovery.

**Dependency Management**:
- Follow the repository's dependency injection or composition pattern; keep modules single-purpose.
- Observe existing initialization and disposal sequences when wiring into lifecycles.
- Keep transport, domain, and presentation layers decoupled with clear interfaces.
- Supply lifecycle hooks (e.g., `initialize`, `dispose`) and targeted tests when adding services.

### Type-Safe Async Programming

**Async/Await Patterns**:
- Use `async/await`; wrap awaits in try/catch with structured errors.
- Guard edge cases early to avoid deep nesting.
- Send errors through the project's logging/telemetry utilities.
- Surface user-facing errors via the repository's notification pattern.
- Debounce configuration-driven updates and dispose resources deterministically.

**Advanced Async Types**:
- Use `Promise<T>` for single async operations.
- Implement proper error types with union types for different failure modes.
- Create type-safe promise utilities and combinators.
- Use generator functions for complex async workflows.

### External Integrations

**Type-Safe APIs**:
- Instantiate clients outside hot paths and inject them for testability.
- Never hardcode secrets; load them from secure sources.
- Apply retries, backoff, and cancellation to network or IO calls.
- Normalize external responses and map errors to domain shapes.

**Integration Patterns**:
- Create strongly-typed API clients with automatic type generation.
- Implement proper error boundaries and recovery patterns.
- Use type guards for runtime validation of external data.
- Implement circuit breakers and resilience patterns.

## Security Considerations

**Type-Safe Security**:
- Validate and sanitize external input with schema validators or type guards.
- Avoid dynamic code execution and untrusted template rendering.
- Encode untrusted content before rendering HTML; use framework escaping or trusted types.
- Use parameterized queries or prepared statements to block injection.

**Advanced Security Patterns**:
- Implement zero-trust architecture with type-level guarantees.
- Use branded types to prevent type confusion attacks.
- Create type-safe cryptographic operations.
- Implement secure coding patterns with compile-time verification.

## Testing and Quality Assurance

**Type-Driven Testing**:
- Add or update unit tests with the project's framework and naming style.
- Expand integration or end-to-end suites when behavior crosses modules or platform APIs.
- Run targeted test scripts for quick feedback before submitting.
- Avoid brittle timing assertions; prefer fake timers or injected clocks.

**Advanced Testing Patterns**:
- Use property-based testing with type constraints.
- Implement type-safe test utilities and fixtures.
- Create comprehensive type coverage metrics.
- Use mutation testing for type safety validation.

## Performance and Reliability

**Type-Level Performance**:
- Lazy-load heavy dependencies and dispose them when done.
- Defer expensive work until users need it.
- Batch or debounce high-frequency events to reduce thrash.
- Track resource lifetimes to prevent leaks.

**Compile-Time Optimization**:
- Use const assertions for literal types.
- Leverage readonly modifiers for immutability.
- Implement proper generic constraints for performance.
- Use type narrowing for efficient runtime checks.

## Documentation and Developer Experience

**Type Documentation**:
- Add JSDoc to public APIs; include `@remarks` or `@example` when helpful.
- Write comments that capture intent, and remove stale notes during refactors.
- Update architecture or design docs when introducing significant patterns.
- Document complex type relationships and constraints.

**Developer Tools Integration**:
- Configure strict TypeScript compiler options.
- Use project references for monorepo setups.
- Implement proper declaration file generation.
- Set up automated type checking in CI/CD pipelines.

## Configuration and Tooling

**TypeScript Configuration**:
- Reach configuration through shared helpers and validate with schemas or dedicated validators.
- Handle secrets via the project's secure storage; guard `undefined` and error states.
- Document new configuration keys and update related tests.
- Use advanced compiler options for maximum type safety.

**Build and Development Tools**:
- Use `tsc` for type checking and compilation.
- Integrate with bundlers (Webpack, Vite, esbuild) for optimal output.
- Configure linting tools (ESLint with TypeScript rules).
- Set up proper source maps and debugging support.

## Quality Checklist

Before deploying TypeScript applications, ensure:

### Core Requirements
- [ ] **Type Safety**: Strict TypeScript configuration with no `any` types
- [ ] **Architecture**: Proper module organization and dependency injection
- [ ] **Error Handling**: Comprehensive error types and async error management
- [ ] **Documentation**: Complete JSDoc and type documentation
- [ ] **Testing**: Type-driven testing with comprehensive coverage

### Advanced TypeScript Features
- [ ] **Modern Types**: Utilizes advanced TypeScript 5.x features appropriately
