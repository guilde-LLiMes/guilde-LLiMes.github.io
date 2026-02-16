A practical way to think about this is: “What do I want the LLM to always know and respect in this repo?” That maps nicely onto must/should/nice-to-have guidelines that you can codify as shared docs + prompt snippets.

## Must-have guidelines

These are the ones I’d treat as non‑negotiable if you want stable, high‑quality LLM‑assisted coding.

- Clear project scope and domain description (what the system does, what it explicitly does not do, main user journeys, and non‑functional constraints like performance and security). [perplexity](https://www.perplexity.ai/search/482e745e-1701-4214-a0b1-cb957e4520d1)
- Tech stack and architecture decisions documented: primary language(s), frameworks, chosen architectural style (layered, hexagonal, clean), data stores, messaging patterns, and major external dependencies. [perplexity](https://www.perplexity.ai/search/6c266ea7-cfd5-401d-8b6a-06ce3e42eeff)
- Coding standards and style guide: formatting (Prettier/Black/etc.), naming conventions, error handling patterns, logging approach, and rules for side effects and I/O in domain code. This gives the LLM a strong prior for “how code should look here.” [kkovacs](https://kkovacs.eu/software-project-best-practices-checklist/)
- Testing strategy and test pyramid: which levels you expect (unit, integration, end‑to‑end), what each level is allowed to touch, and mandatory coverage thresholds or critical-path tests. [perplexity](https://www.perplexity.ai/search/8dc86872-de95-46d9-b67a-d555075bd35a)
- Directory and module structure rules: standard layout for src, domain/application/infrastructure or similar boundaries, where tests live, where API contracts live, and how new modules get added. [kkovacs](https://kkovacs.eu/software-project-best-practices-checklist/)
- API contracts and data formats: how you define and version APIs (OpenAPI/JSON Schema/Protobuf), rules for breaking vs non‑breaking changes, and how to handle backward compatibility. [github](https://github.com/ardalis/new-software-project-checklist)
- Security and compliance basics: authentication/authorization model, secrets handling, logging of sensitive data, and any domain‑specific compliance constraints that must never be violated. [datadoghq](https://www.datadoghq.com/blog/llm-guardrails-best-practices/)
- Guardrails for LLM usage: what the model is allowed to change, when it must not touch certain files (e.g., migrations, infra), how to phrase prompts, and how to run verification (tests, linters, type‑checks) after generation. [github](https://github.com/NVIDIA-NeMo/Guardrails)

Example: a “Project Ground Rules” document in the repo that you always stuff into system/context for the model, containing the above in compressed form.

## Should-have guidelines

These improve consistency and LLM reliability, but you can bring them in incrementally.

- Specification templates for new work: standard sections for context, requirements, edge cases, error scenarios, and acceptance criteria, so prompts and tickets always look similar. [manifest](https://www.manifest.ly/use-cases/software-development/software-development-plan-checklist)
- Architecture decision records (ADRs): lightweight records for major choices (e.g., “We use event sourcing for X”, “We standardize on REST, not GraphQL”), giving the LLM a history of why things are the way they are. [kkovacs](https://kkovacs.eu/software-project-best-practices-checklist/)
- Review and PR guidelines: what reviewers check (tests, architecture boundaries, performance, security), how to structure PR descriptions, and how LLM‑generated code should be annotated or explained. [ideamaker](https://ideamaker.agency/software-development-checklist/)
- Error handling and observability patterns: standard error taxonomy, how to bubble domain errors vs infrastructure failures, logging levels, and when to add metrics or tracing. [ideamaker](https://ideamaker.agency/software-development-checklist/)
- Performance and load expectations: rough SLAs and any known bottlenecks, plus guidance on when to consider caching, batching, or asynchronous processing. [kkovacs](https://kkovacs.eu/software-project-best-practices-checklist/)
- Test data and environments: conventions for fixtures, how to isolate external systems in tests (mocks, fakes, sandboxes), and which environment to use for integration and E2E runs. [codingrules](https://www.codingrules.ai/rules/code-style-and-conventions-standards-for-architecture)
- Documentation structure: where to put high‑level docs (README, /docs/architecture, /docs/decisions), how to document new modules, and expectations for code comments vs external docs. [ideamaker](https://ideamaker.agency/software-development-checklist/)

For LLM work, this is also where you keep reusable prompt snippets (e.g., “write-tests-from-spec”, “refactor-module-without-API-change”).

## Nice-to-have guidelines

These mostly help at scale or in more regulated domains.

- Quality gates and CI rules: which checks must pass (types, lint, tests, security scans), which are advisory, and how to handle flaky tests or non‑blocking warnings. [codingrules](https://www.codingrules.ai/rules/code-style-and-conventions-standards-for-architecture)
- Architecture tests/constraints as code: automated checks that enforce layering, module dependencies, and package visibility rules so the LLM can’t quietly erode your architecture over time. [codingrules](https://www.codingrules.ai/rules/core-architecture-standards-for-pytest)
- Domain language and glossary: key business terms, invariants, and ubiquitous language so the model uses consistent naming and doesn’t invent conflicting terms. [kkovacs](https://kkovacs.eu/software-project-best-practices-checklist/)
- Migration and rollout rules: how to introduce schema changes, feature flags, and backwards‑compatible deploys, including expectations for deprecations. [kkovacs](https://kkovacs.eu/software-project-best-practices-checklist/)
- Security and privacy playbook: incident response steps, data retention policies, and when to call a human or security team if something looks sensitive or risky. [datadoghq](https://www.datadoghq.com/blog/llm-guardrails-best-practices/)
- LLM evaluation and feedback loop: how you record prompt patterns that worked, test suites for LLM‑generated code, and a process to update guidelines when the model repeatedly fails on certain patterns. [developers.openai](https://developers.openai.com/cookbook/examples/how_to_use_guardrails/)

