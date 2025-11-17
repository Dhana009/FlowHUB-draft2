# MCP Server for FlowHub

## What is the MCP Server?

The MCP (Model Context Protocol) server is an AI assistant knowledge layer that provides fast, targeted access to FlowHub documentation, policies, and automation tools. It reduces token usage by 90% through semantic search and structured retrieval.

## Why We Need It

**Problem**: Without MCP, the AI must manually read multiple files (20K-50K tokens) for each question, re-reading the same docs across sessions.

**Solution**: MCP + Vector DB indexes docs once, returns only relevant chunks (500-2K tokens) with exact citations.

**Benefits**:
- 90% token reduction per session
- Faster responses (no manual file reading)
- Better accuracy (semantic search vs keyword)
- Cross-session efficiency (indexed once, used forever)
- Structured, targeted retrieval

---

## Architecture Decisions

### Core Components

1. **MCP Server**: Local Python server (port 3000)
2. **Vector Database**: Hybrid Qdrant (cloud + local)
3. **AI Brain**: Cursor/cloud AI (no LLM embedded in MCP)
4. **Search**: Semantic search with sentence-transformers embeddings

### Hybrid Storage Strategy

**Cloud Qdrant (1GB free)**:
- Core stable docs (SDLC, policies, flows, infrastructure)
- Size: ~50-800MB
- Purpose: Fast, always-available knowledge base
- Protected from changes

**Local Qdrant (unlimited)**:
- Mirror of all cloud docs
- Active work (decisions, logs, progress, generated code)
- Purpose: Free experimentation, full write access

**Search Order**: Cloud first → Local fallback

**Sync**: Cloud docs auto-replicate to local (one-way mirror)

---

## MCP Tools (20 Total)

### Category 1: Ask & Understand (3 tools)

**Purpose**: Get clarifications, search knowledge, understand concepts before implementing

1. **ask(question, context)**
   - Ask clarifications, comparisons, explanations
   - Use before implementing to avoid mistakes
   - Example: "Should I use aria-label or aria-labelledby for this button?"

2. **search(query)**
   - Semantic search across all FlowHub docs
   - Returns relevant chunks with file:line citations
   - Example: "selector policy" → returns exact rules from SELECTOR_POLICY.md

3. **explain(topic)**
   - Explain flows, policies, architecture, infrastructure
   - Provides context and rationale
   - Example: "explain phase-1 flows" → details about auth + tasks CRUD

---

### Category 2: SDLC Documentation (2 tools)

**Purpose**: Generate SDLC documents for flows

4. **generate_sdlc_docs(flow_id, stage)**
   - Generate BRD/PRD/FRD/System Design documents
   - Follows FlowHub SDLC structure
   - Example: `generate_sdlc_docs("flow-4", "BRD")` → Business Requirements Doc

5. **generate_plan(flow_id)**
   - Step-by-step implementation plan
   - Includes backend, frontend, tests, validation steps
   - Example: `generate_plan("flow-4")` → Complete implementation roadmap

---

### Category 3: Code Scaffolding (3 tools)

**Purpose**: Generate code structure following FlowHub architecture

6. **scaffold_backend(flow_id)**
   - Complete backend code (controller, service, model, routes)
   - Follows architecture rules (thin controllers, business logic in services)
   - Example: `scaffold_backend("flow-4")` → All backend files for Task CRUD

7. **scaffold_frontend(flow_id, version)**
   - Complete frontend code (page, components, hooks, services)
   - Supports v1, v2, v3 UI variants
   - Example: `scaffold_frontend("flow-4", "v1")` → Bootstrap UI for tasks

8. **scaffold_infrastructure(type, profile)**
   - Generate .env, docker-compose, CI/CD config files
   - Supports local/cloud profiles
   - Example: `scaffold_infrastructure("env", "local")` → Local .env file

---

### Category 4: Test Generation (4 tools)

**Purpose**: Generate test code following FlowHub testing policies

9. **scaffold_unit_tests(flow_id, target)**
   - Unit tests (auto-detects frontend/backend)
   - Isolated tests with mocks
   - Example: `scaffold_unit_tests("flow-4", "backend")` → Service unit tests

10. **scaffold_integration_tests(flow_id)**
    - Integration tests (components + services working together)
    - Tests interactions between layers
    - Example: `scaffold_integration_tests("flow-4")` → Frontend integration tests

11. **scaffold_api_tests(flow_id)**
    - API tests (Python + pytest + requests)
    - Black-box HTTP testing
    - Example: `scaffold_api_tests("flow-4")` → Complete API test suite

12. **scaffold_e2e_tests(flow_id, versions)**
    - E2E tests (Playwright, semantic selectors only)
    - Tests across v1/v2/v3 UI variants
    - Example: `scaffold_e2e_tests("flow-4", ["v1", "v2"])` → E2E tests for both versions

---

### Category 5: Validation (3 tools)

**Purpose**: Check code against FlowHub policies and standards

13. **validate_code(files, rules)**
    - Check architecture, selectors, anti-patterns, reuse rules
    - Validates against all development policies
    - Example: `validate_code(["controller.ts"], ["architecture", "anti-patterns"])`

14. **validate_accessibility(target)**
    - Check ARIA, semantic HTML, a11y compliance
    - Ensures WCAG 2.1 AA compliance
    - Example: `validate_accessibility("components/TaskCard.tsx")`

15. **validate_performance(target)**
    - Check LCP/INP/CLS thresholds
    - Validates Core Web Vitals requirements
    - Example: `validate_performance("pages/tasks.tsx")` → Performance report

---

### Category 6: Project Tracking (3 tools)

**Purpose**: Track progress and log decisions

16. **track(flow_id, status)**
    - Update progress.json with flow status
    - Tracks completion, in-progress, blocked states
    - Example: `track("flow-4", "completed")` → Updates progress tracking

17. **next_task()**
    - What to do next (smart recommendations)
    - Considers phase, dependencies, priorities
    - Example: `next_task()` → "Start flow-5 (Kanban) - phase-3"

18. **log_decision(summary, details)**
    - Auto-log to Discussion/decisions/ (Markdown ADR format)
    - Records all important decisions
    - Example: `log_decision("Use Qdrant hybrid", "Cloud for stable, local for work")`

---

### Category 7: Smart Helpers (2 tools)

**Purpose**: Generate test data and fix issues

19. **generate_fixtures(flow_id, test_type)**
    - Test data/mocks (adapts to test type)
    - Generates appropriate fixtures for unit/integration/API/E2E
    - Example: `generate_fixtures("flow-4", "api")` → API test fixtures

20. **fix_issues(errors)**
    - Suggest fixes for lint/validation errors
    - Provides code snippets and explanations
    - Example: `fix_issues("ESLint errors in TaskService.ts")` → Fix suggestions

---

## What Goes in Vector DB

### Cloud Collection (stable core)
- `software-development-life-cycle/` (BRD, PRD, FRD, System Design)
- `proposal-plan/development/` (selector-policy, architecture-rules, standards, anti-patterns, reuse-rules, monitoring, workflow, structure)
- `proposal-plan/testing/` (test-types, accessibility, performance, ci-requirements, selector-policy)
- `proposal-plan/phases/` (phase-1 to phase-4)
- `infrastructure/` (INFRASTRUCTURE.md, REDIS-USAGE.md)
- `complete-flows/FLOWS-SIMPLE.md`

### Local Collection (cloud mirror + active)
- All cloud docs (mirrored automatically)
- `Discussion/` (decision logs, meeting notes)
- Generated code and test skeletons
- Progress tracking (progress.json)
- Current work artifacts

---

## Key Decisions Summary

### Architecture
- Custom local MCP (FlowHub-specific, not Pieces)
- Python language
- Cursor/cloud AI as brain (no LLM in MCP server)
- Qdrant hybrid (cloud 1GB + local unlimited)
- Semantic search with sentence-transformers

### Storage
- Cloud: Core stable knowledge (protected, fast)
- Local: Mirror + work area (unlimited, writable)
- Search: Cloud first, local fallback
- Sync: Cloud → Local (auto-mirror)

### Operations
- Auto-log all tool calls to `Discussion/decisions/`
- Config: `mcp-config.json` in repo root
- Test generation: Skeleton only (you fill logic)
- Validation: Block/warn on violations
- Progress tracking: `progress.json` with timestamps

### Advanced Features
- Infrastructure templates with TODO comments
- Strict 1:1 flow-to-test mapping
- ARIA/accessibility validation
- SDLC gates: warn but don't block
- Versioned code snippet library
- Pieces integration: read from Pieces, write to local
- Error recovery with code snippets

---

## Configuration

### mcp-config.json (repo root)

```json
{
  "cloud_qdrant": {
    "url": "https://your-cluster.qdrant.io",
    "api_key": "env:QDRANT_API_KEY",
    "collection": "flowhub-core"
  },
  "local_qdrant": {
    "path": "./qdrant_data",
    "collection": "flowhub-local"
  },
  "cloud_docs": [
    "software-development-life-cycle/**/*.md",
    "proposal-plan/**/*.md",
    "infrastructure/*.md",
    "complete-flows/*.md"
  ],
  "decision_log_path": "Discussion/decisions/"
}
```

### Environment Variables

```bash
QDRANT_CLOUD_URL=https://your-cluster.qdrant.io
QDRANT_API_KEY=your-api-key
```

---

## Project Structure

```
LinkedIn/
├── mcp-server/
│   ├── main.py              # MCP server entry
│   ├── tools/               # 20 tools organized by category
│   │   ├── ask.py
│   │   ├── search.py
│   │   ├── explain.py
│   │   ├── generate_sdlc_docs.py
│   │   ├── generate_plan.py
│   │   ├── scaffold_backend.py
│   │   ├── scaffold_frontend.py
│   │   ├── scaffold_infrastructure.py
│   │   ├── scaffold_unit_tests.py
│   │   ├── scaffold_integration_tests.py
│   │   ├── scaffold_api_tests.py
│   │   ├── scaffold_e2e_tests.py
│   │   ├── validate_code.py
│   │   ├── validate_accessibility.py
│   │   ├── validate_performance.py
│   │   ├── track.py
│   │   ├── next_task.py
│   │   ├── log_decision.py
│   │   ├── generate_fixtures.py
│   │   └── fix_issues.py
│   ├── vector_store.py      # Hybrid Qdrant layer
│   ├── indexer.py           # Document indexing
│   └── requirements.txt
├── mcp-config.json          # Server config
└── qdrant_data/             # Local storage
```

---

## Token Savings Example

**Question: "What's the selector policy?"**

**Without MCP (current)**:
- Read SELECTOR_POLICY.md: ~2,500 tokens
- Read testing/selector-policy.md: ~1,800 tokens
- Read architecture-rules.md: ~3,000 tokens
- Total: ~7,300 tokens

**With MCP (future)**:
- Call search("selector policy"): ~600 tokens
- Total: ~600 tokens

**Savings: 92% reduction**

**Full Session**:
- Without MCP: 100-200K tokens
- With MCP: 10-20K tokens
- **~90% session reduction**

---

## Implementation Phases

### Phase 1: Core Setup
- MCP server structure
- Hybrid Qdrant connection
- Document indexing
- Basic search tool

### Phase 2: Essential Tools
- Ask, search, explain
- Generate SDLC docs
- Scaffold backend/frontend

### Phase 3: Testing Tools
- All test scaffolding tools
- Validation tools
- Fixtures generation

### Phase 4: Advanced Features
- Project tracking
- Auto-logging
- Error recovery
- Progress tracking

---

## Success Criteria

- Cloud search returns core docs instantly (<1s)
- Local search provides broader context
- Auto-sync keeps local mirror updated
- Tools generate valid, policy-compliant outputs
- Decision logging works automatically
- 90% token reduction achieved in practice

---

## Verification

- Date: 2025-11-17
- Documented by: Assistant
- All key decisions captured from discussion
- Architecture aligns with FlowHub constraints and goals
- Tools designed for complete SDLC workflow
- Configuration matches infrastructure setup

