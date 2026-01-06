---
name: forensic-coder
description: Comprehensive forensic analysis skill for enterprise codebases across Azure, Dynamics 365, C#, SAP, Mulesoft, Power Platform, and more. Covers security, performance, architecture, and compliance in multi-language, multi-system environments. Use this for deep-dive audits and refactoring insights.
---

# Forensic Coder Skill

## Overview

The Forensic Coder is an advanced, enterprise-grade skill for conducting thorough forensic analysis of complex codebases spanning multiple technologies, languages, and systems. It provides high-level architectural overviews followed by granular deep dives, leveraging Grok-first reasoning and MCP integrations for unbiased, actionable insights. Designed for Acornsoft's ecosystem, it excels in Azure-native, Dynamics 365, and integration-heavy environments.

## Purpose

- Perform comprehensive codebase audits across enterprise stacks (Azure, Dynamics 365, SAP, Mulesoft, Power Platform)
- Identify security vulnerabilities, authentication/authorization flaws, and compliance gaps
- Evaluate performance bottlenecks, scalability issues, and architectural anti-patterns
- Assess code quality, error handling, and maintainability in polyglot environments
- Deliver prioritized recommendations for refactoring, optimization, and modernization

## Scope

- **Technologies**: 
  - **Microsoft Ecosystem (Emphasis)**: Azure (Functions, Logic Apps, AI, Storage, VMs, AKS, App Service, Synapse, Purview), Dynamics 365 (Sales, Customer Service, plug-ins, workflows), Power Platform (PCF controls, Power Automate, Power Apps, Power BI), Microsoft 365 (Teams, SharePoint, OneDrive, Exchange), Windows Server, SQL Server, .NET ecosystem.
  - **SaaS Services**: Office 365 (Word, Excel, Outlook), Teams collaboration, SharePoint sites, OneDrive storage, Exchange email, Intune device management, Azure AD identity, Defender security suite.
  - **AI Services**: Azure OpenAI (GPT models), Azure Cognitive Services (Vision, Language, Speech), Azure Machine Learning, Azure Bot Services, Copilot integrations, Microsoft Graph AI, LUIS, QnA Maker.
  - **Other Clouds**: AWS (Lambda, S3, EC2, SageMaker), GCP (Cloud Functions, BigQuery, Compute Engine, Vertex AI), IBM Cloud, Oracle Cloud, Alibaba Cloud.
- **Languages**: C# (.NET), JavaScript/TypeScript (Node.js, client-side), Python (serverless, ML), Java (enterprise), Go (cloud-native), M-Query (Dataverse), Snowflake (SQL variants), SQL (T-SQL, PL/SQL), PowerShell (automation), Bash (scripts), and others (e.g., R for analytics, F# for functional programming).
- **Systems**: Cloud-native (Azure/AWS/GCP), on-premise (SAP, Windows Server), hybrid (Mulesoft, Azure Arc), low-code (Power Platform), database (Snowflake, SQL Server, Cosmos DB), containerized (Docker/Kubernetes), AI-driven (ML models, chatbots, Copilot integrations).
- **Analysis Depth**: From repo-level metrics to line-by-line code reviews, including AI model evaluations, SaaS integration audits, and Microsoft ecosystem compliance.
- **Integration**: MCP servers for static analysis, Git APIs, Azure DevOps/AWS CodeCommit/GCP Cloud Source Repositories, Microsoft Graph API for SaaS insights, Azure AI APIs for model analysis, and custom Grok prompts.
- **Output**: Structured Markdown reports with executive summary, detailed findings, risk matrix, and implementation roadmaps.

## Coding Best Practices Framework

The forensic-coder evaluates code against comprehensive best practices across languages and paradigms:

- **General Principles**: SOLID (Single Responsibility, Open-Closed, Liskov Substitution, Interface Segregation, Dependency Inversion), DRY (Don't Repeat Yourself), KISS (Keep It Simple, Stupid).
- **Error Handling**: Use try-catch-finally, log with correlation IDs, avoid swallowing exceptions.
- **Security**: Input validation, parameterized queries, least privilege, OWASP top 10 compliance.
- **Performance**: Optimize algorithms (O(n) analysis), minimize I/O, use caching, profile bottlenecks.
- **Concurrency**: Thread safety, async/await patterns, avoid deadlocks.
- **Testing**: Unit tests (80%+ coverage), integration tests, TDD/BDD approaches.
- **Documentation**: Inline comments, API docs (Swagger/OpenAPI), READMEs.
- **Version Control**: Git best practices, branching strategies, commit hygiene.
- **Cloud-Specific**:
  - **Azure**: Use Managed Identity, Azure Monitor, Well-Architected Framework.
  - **AWS**: IAM least privilege, CloudWatch monitoring, serverless best practices (Lambda cold starts).
  - **GCP**: Identity-Aware Proxy, Cloud Logging, BigQuery optimization.
- **Language-Specific**:
  - **C#**: Async patterns, LINQ efficiency, nullable reference types.
  - **JavaScript/TypeScript**: ESLint rules, module bundling, type safety.
  - **Python**: PEP 8, virtual environments, efficient libraries (Pandas for data).
  - **Java**: JVM tuning, Spring Boot best practices.
  - **Go**: Goroutines for concurrency, error handling idioms.
  - **SQL**: Indexing, query optimization, normalization.

## Supported Analysis Dimensions

1. **Security & Compliance**
   - Vulnerability scanning (OWASP, Azure security best practices)
   - Auth/AuthZ flows (Azure AD, OAuth, plug-in permissions)
   - Data protection (encryption, PII handling in Dataverse/SAP)
   - Compliance (GDPR, SOX for enterprise systems)

2. **Performance & Scalability**
   - Bottleneck identification (Azure Functions cold starts, Mulesoft message queues)
   - Resource optimization (Azure costs, Snowflake query tuning)
   - Scalability patterns (microservices in C#, event-driven in Power Automate)

3. **Architecture & Design**
   - Pattern evaluation (CQRS in Dynamics plug-ins, event sourcing in Mulesoft)
   - Coupling/cohesion analysis (PCF control dependencies, SAP integrations)
   - Modernization opportunities (Azure migration from on-premise)

4. **Code Quality & Maintainability**
   - Error handling (try-catch in C#, async patterns)
   - Testing coverage (unit tests for plug-ins, integration tests for flows)
   - Documentation and standards (code comments, ADR alignment)

5. **Integration & Interoperability**
   - API consistency (REST/GraphQL in Azure, SOAP in SAP)
   - Data flow analysis (Mulesoft transformations, Power Automate connectors)
   - Cross-system dependencies (Dynamics to SAP via Mulesoft)

## Persona-Based Perspectives

To ensure comprehensive, multi-disciplinary analysis, the forensic-coder evaluates codebases through the lenses of key personas, addressing their specific concerns, best practices, issues, and interests. Each persona brings domain expertise, ensuring no blind spots in enterprise codebases.

- **Azure Developer**: Best practices: Azure SDK guidelines, async patterns, dependency injection. Concerns: Cold starts, throttling, cost optimization. Issues: Improper error handling, resource leaks. Interests: Performance tuning, scalability.
- **Azure Architect**: Best practices: Well-Architected Framework (security, reliability, performance, cost, operations). Concerns: Compliance with Azure policies, multi-region deployments. Issues: Over-provisioning, security gaps. Interests: Cloud migration strategies, hybrid architectures.
- **Solution Architect**: Best practices: TOGAF, solution design principles. Concerns: End-to-end integration, non-functional requirements. Issues: Misaligned business/tech needs, scalability bottlenecks. Interests: Solution roadmaps, technology evaluations.
- **Enterprise Architect**: Best practices: EA frameworks (e.g., Zachman), governance models. Concerns: Long-term strategy, portfolio alignment. Issues: Technical debt, vendor lock-in. Interests: Digital transformation, enterprise standards.
- **Functional Consultant**: Best practices: Business process modeling, user story creation. Concerns: User experience, process efficiency. Issues: Misconfigured workflows, data inconsistencies. Interests: Business requirements validation, training materials.
- **System Tester**: Best practices: ISTQB standards, test automation frameworks. Concerns: Test coverage, defect tracking. Issues: Manual testing reliance, flaky tests. Interests: CI/CD integration, quality metrics.
- **Dynamics Functional Consultant**: Best practices: Microsoft Dynamics best practices, data modeling. Concerns: Plug-in performance, UI responsiveness. Issues: Blocking operations, data integrity. Interests: Customization optimization, user adoption.
- **Mulesoft Developer**: Best practices: MuleSoft best practices, API-led connectivity. Concerns: Message processing efficiency, error handling. Issues: Flow complexity, debugging challenges. Interests: Integration patterns, monitoring.
- **SAP Developer**: Best practices: SAP development guidelines, ABAP programming standards. Concerns: Performance in ERP contexts, data consistency. Issues: Custom code maintenance, upgrade impacts. Interests: SAP modernization, Fiori UI.
- **Integration Specialist**: Best practices: SOA principles, API design (REST, SOAP). Concerns: Data transformation accuracy, security in transit. Issues: Version mismatches, latency. Interests: Middleware optimization, event-driven architectures.
- **Web Developer**: Best practices: Web standards (HTML5, CSS3), accessibility (WCAG). Concerns: Cross-browser compatibility, responsive design. Issues: Security vulnerabilities (XSS), performance (bundle size). Interests: Front-end frameworks, PWAs.
- **Mobile Developer**: Best practices: Platform guidelines (iOS Human Interface, Material Design). Concerns: Battery usage, offline capabilities. Issues: App store rejections, device fragmentation. Interests: Native vs. cross-platform, app performance.
- **Dataverse Developer**: Best practices: Microsoft Dataverse best practices, data modeling. Concerns: Query optimization, security roles. Issues: Entity relationships, data migration. Interests: Power Platform integration, low-code extensions.
- **Power BI Developer**: Best practices: Data modeling best practices, DAX optimization. Concerns: Report performance, data refresh. Issues: Complex measures, security filters. Interests: Visualization best practices, real-time dashboards.
- **DevOps Engineer**: Best practices: Infrastructure as Code (IaC), CI/CD pipelines. Concerns: Deployment reliability, monitoring. Issues: Configuration drift, downtime. Interests: Automation, containerization.
- **Security Specialist**: Best practices: OWASP, NIST frameworks. Concerns: Vulnerability management, compliance. Issues: Unpatched dependencies, weak auth. Interests: Threat modeling, penetration testing.
- **Database Administrator**: Best practices: Normalization, indexing strategies. Concerns: Query performance, data integrity. Issues: Deadlocks, backup failures. Interests: Database tuning, migration strategies.
- **UI/UX Designer**: Best practices: Design systems, usability testing. Concerns: User accessibility, intuitive interfaces. Issues: Poor information architecture, inconsistent branding. Interests: User research, prototyping.
- **QA Engineer**: Best practices: Test planning, defect management. Concerns: Quality assurance processes, regression testing. Issues: Incomplete test cases, environment issues. Interests: Test automation, quality metrics.
- **Project Manager**: Best practices: Agile/Scrum methodologies, risk management. Concerns: Timeline adherence, resource allocation. Issues: Scope creep, communication gaps. Interests: Stakeholder management, delivery tracking.
- **Business Analyst**: Best practices: Requirements gathering, use case modeling. Concerns: Business value alignment, requirement traceability. Issues: Ambiguous requirements, change management. Interests: Process improvement, ROI analysis.

Each persona's insights are synthesized into unified recommendations, ensuring holistic codebase understanding.

## Phases

1. **High-Level Analysis**: Structural overview, dependency mapping, and key metrics (e.g., tech stack breakdown, repo health scores)
2. **Knowledge Sources Audit**: Identify technical debt accumulators, design docs, presentations, ADRs, videos/podcasts, and SME mappings via Git history and documentation scans
3. **SME and Ownership Mapping**: Determine code developers, last modifiers, documenters, and subject experts for each component using Git blame/history
4. **Targeted Deep Dives**: Focused on user-specified concerns or automated priority detection
5. **Synthesis & Recommendations**: Risk-prioritized insights with implementation guidance
6. **Validation**: Cross-reference with ADRs, compliance frameworks, and best practices

## Inputs

- Repository URLs/paths (GitHub, Azure DevOps, local)
- Analysis scope (full ecosystem, targeted components, specific technologies)
- Priority concerns (e.g., "security in Dynamics plug-ins", "performance in Power Automate flows")
- Tech stack details (languages, systems, versions)
- Compliance requirements (e.g., Azure security benchmarks, industry standards)

## Outputs

- **Comprehensive Report**: Markdown with executive summary, detailed findings, risk matrix, AI recommendations, and implementation roadmaps.
- **AS-IS Assessment**: Current state analysis with strengths, weaknesses, and compliance scores.
- **TO-BE Recommendations**: Future-state suggestions including modernization paths, technology upgrades, architectural improvements, and client requirement alignments. Includes prioritized roadmaps, cost-benefit analyses, and migration strategies.
- **Visual Aids**: Mermaid diagrams for current architecture, proposed future state, data flows, and dependency graphs. UML sequence diagrams for key workflows spanning the solution, C4 diagrams for system context/containers/components, deployment diagrams for infrastructure and cloud topologies.
- **Prioritized Backlog**: User story format for refactoring tasks, with TO-BE enhancements.
- **Compliance Scorecard**: Against Azure, Dynamics, and enterprise standards, with TO-BE compliance targets.

## TO-BE Analysis Framework

Beyond AS-IS evaluation, the forensic-coder provides forward-looking insights to guide evolution:

- **Modernization Paths**: Recommendations for cloud migration (e.g., on-premise SAP to Azure), microservices adoption, or AI integration based on client hints.
- **Technology Upgrades**: Suggest adopting newer Microsoft services (e.g., Azure OpenAI for legacy chatbots) or best practices (e.g., serverless for monoliths).
- **Architectural Improvements**: Propose patterns like event-driven architectures or CQRS for scalability, aligned with future requirements.
- **Client Alignment**: Incorporate incoming requirements (e.g., "add AI features") into TO-BE roadmaps, with feasibility assessments.
- **Risk Mitigation**: Identify future risks (e.g., vendor lock-in) and mitigation strategies.
- **Cost-Benefit Analysis**: Quantify TO-BE benefits (e.g., performance gains, cost savings) with implementation timelines.
- **Roadmap Generation**: Create phased plans for TO-BE state, including dependencies and success metrics.
- **Obsolescence and Deprecation Analysis**: Flag out-of-date technologies (e.g., .NET Framework vs. .NET Core), deprecated coding practices (e.g., synchronous patterns), unsupported features (e.g., legacy APIs), and end-of-life components with upgrade priorities and migration guides.


## Knowledge Sources and SME Identification

To enrich analysis, the forensic-coder catalogs available knowledge resources and maps subject matter experts:

- **Technical Debt Accumulators**: Files/directories with high churn, complexity, or outdated patterns (e.g., legacy code without tests).
- **Design Documents**: Architecture diagrams, flowcharts, and specs in docs/ or .github/ folders.
- **Presentations and ADRs**: Slides, videos, podcasts in docs/ or linked repos; ADR documents in docs/Analysis/adr-xxx.md.
- **Multimedia Resources**: Videos/podcasts of running code or demos for contextual understanding.
- **SME Mapping**:
  - Code Developers: Via Git history/blame (who wrote initial code).
  - Last Modifiers: Recent commit authors for maintenance insights.
  - Documenters: Contributors to READMEs, comments, or docs.
  - Subject Experts: Identified by domain (e.g., Azure SME from commit patterns, Dynamics SME from plug-in expertise).
- **Git History Integration**: Analyze commit logs for ownership, change frequency, and knowledge transfer points.

This ensures analysis is informed by historical context and expert availability.

## Follow-Up Questions Framework

To ensure thorough understanding, the forensic-coder generates categorized lists of follow-up questions for developers and business analysts:

- **Immediate Questions** (Can be handled right away via quick checks or existing docs):
  - Technical: "What are the specific error logs in production that aren't captured in code?"
  - Business: "What business rules drive these data transformations?"
  - Architecture: "Why was this cloud service chosen over alternatives?"
- **Follow-Up Questions** (Require sessions with key stakeholders for deeper discussion):
  - Performance: "Can you walk me through peak load scenarios and monitoring?" (Session with DevOps/SRE).
  - Security: "What compliance certifications are required and how are they maintained?" (Session with Security Team).
  - Maintenance: "Who handles incident response and what is the escalation process?" (Session with Operations).
  - Future: "How do client requirements influence feature prioritization?" (Session with Product/Business).

These questions bridge analysis gaps, prioritized by impact (High/Medium/Low), urgency (immediate vs. scheduled), and stakeholder involvement.

## Tools Integration

- **MCP Servers**: ESLint/SonarQube for static analysis, Azure DevOps for CI/CD insights, GitHub for PR reviews
- **Azure-Specific**: Azure Monitor logs, Application Insights for runtime analysis
- **Dynamics/SAP**: Dataverse APIs, SAP HANA queries via MCP
- **Custom Prompts**: Grok-optimized for unbiased, first-principles reasoning
- **Reporting**: Pandoc integration for branded PDF/DOCX outputs

## Usage Patterns

- **Enterprise Audit**: "@Luna analyze this Azure Dynamics integration for security and performance"
- **Refactoring Guidance**: "@Luna review these C# plug-ins for design patterns and error handling"
- **Compliance Check**: "@Luna audit Power Platform flows against Azure best practices"
- **Modernization Planning**: "@Luna evaluate SAP to Azure migration opportunities"

## Dependencies

- MCP server access for analysis tools
- Git credentials for repo access
- Azure/Dynamics/SAP API keys (as needed)
- Grok API for advanced reasoning
- Optional: Pandoc for enhanced reporting

## Best Practices

- Start with high-level overviews to scope deep dives
- Prioritize based on business impact (e.g., security > performance)
- Integrate findings with ADR process for architectural decisions
- Use iterative analysis: scan → identify → recommend → validate

This skill is unbounded in its adaptability—tailored for Acornsoft's polyglot, enterprise environments while maintaining Grok-first integrity.
