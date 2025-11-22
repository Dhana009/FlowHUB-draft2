---
alwaysApply: true
---
---
description: Project Command – Review Overall Project State (Architecture, Rules, Tests, MCP Usage)
alwaysApply: true
---

# PROJECT COMMAND: review_project_state
## (High-Level Audit Orchestrator for Codebase, Rules, Tests, Memory, and Tool Usage)

### Purpose
Perform a **non-destructive, read-only audit** of the entire project state:

- Architecture alignment (backend, frontend, testing)
- Folder and file structure correctness
- Rule compliance (project rules, user rules)
- Test coverage + test health overview
- MCP usage sanity (Serena, AgenticRag, Context7, Brave, Perplexity)
- Memory usage correctness (Graffiti vs VectorDB)
- Version parity (v1 Bootstrap, v2 Tailwind, v3 Custom CSS)
- Selector + accessibility health
- CI/monitoring configuration sanity

This command **never writes code, never edits files, never changes memory.**  
It only reads, analyzes, and summarizes.

---

# Behavior (Read-Only, Layered Audit)

## 1. Determine Audit Scope
Call:
- `refine_prompt`
- `clarify_request`

Clarify whether the user wants to:
- audit the entire project  
- audit only backend  
- audit only frontend  
- audit only tests  
- audit only a specific feature/module  
- audit only a version (v1/v2/v3)  

---

## 2. Define Audit Boundaries
Call:
- `scope_request`

Define:
- in-scope directories  
- in-scope modules/features  
- in-scope versions  
- test coverage expectations  
- rule sets to check (backend/frontend/testing/perf/a11y)  

No code or file modifications allowed.

---

## 3. Gather Local Context
Use:
- **Cursor Search** to locate:
  - code files (backend & frontend)
  - tests
  - docs (PRD, design docs, specs)
  - CI config
  - MCP config
  - project rule files (& .cursor/rules)

Summarize:
- architecture structure  
- folder layout  
- presence/absence of expected files  
- visible anti-patterns (high-level)  

---

## 4. Query Memory Systems
Use **AgenticRag** (via existing rules) to retrieve:

From Graffiti:
- architecture relationships  
- entity → schema → API maps  
- UI component hierarchies  
- test → feature mappings  
- selector policies  

From VectorDB:
- prior debugging summaries  
- test suite patterns  
- stored best-practice examples  
- known project issues  

This step is **read-only**.

---

## 5. Check MCP Usage Patterns
Analyze:
- whether Serena is being used where required  
- whether Context7 is being used instead of hallucinating docs  
- whether Brave/Perplexity usage stays within escalation rules  
- whether manual code writing is bypassing MCP tools  
- whether missing MCP tools cause early aborts as required  

Summarize any misuse or gaps.

---

## 6. Rule Compliance Audit
Cross-check the codebase + patterns against:

- Backend Rules (Layer 4)
- Frontend Rules (Layer 5)
- Testing Rules (Layer 6, when defined)
- Selector Policy (Layer 7)
- Accessibility Rules (Layer 8)
- CI/CD Rules (Layer 9)
- Performance Rules (Layer 10)
- Anti-Pattern Rules (Layer 11)
- Monitoring Rules (Layer 12)
- Architecture Rules (Layer 14)
- MCP Server Rules (Layer 15)

Identify:
- violations  
- partial compliance  
- missing pieces  
- risky deviations  

---

## 7. Version Parity Check (v1/v2/v3 Frontend)
Compare:
- page availability across versions  
- component presence across versions  
- selector parity  
- accessibility parity  
- behavior parity (based on docs/tests)  

Highlight:
- missing pages  
- missing components  
- misaligned behavior  
- inconsistent selectors/accessibility  

---

## 8. Testing Health Overview
Without running tests directly (unless user asks):

- inspect test files  
- inspect coverage reports (if present)  
- inspect CI config for test steps  
- check if critical paths are covered  
- identify missing test suites (backend, frontend, E2E, a11y, performance)  

---

## 9. Optional Deep Check (If User Approves)
Ask:

**“Do you want a deeper, more expensive audit using external research/tools?”**

If YES:
- Context7 for external best practices  
- Brave/Perplexity for comparison patterns  

All still read-only: no changes.

---

# Hard Rules (Cannot Be Violated)

- Must NOT edit any file.  
- Must NOT generate code.  
- Must NOT write to memory (Graffiti/VectorDB) by default.  
- Must NOT generate migrations, APIs, or components.  
- Must NOT auto-run tests unless user explicitly agrees.  
- Must operate in READ-ONLY inspection mode.  
- Must respect all project rules when interpreting issues.  
- Must not hallucinate – must rely on actual code, rules, and memory.  

---

# Output Format

This command must output a **compact but structured report**, including:

- `scope_summary`  
- `architecture_status`  
- `backend_compliance`  
- `frontend_compliance`  
- `testing_status`  
- `mcp_usage_status`  
- `memory_usage_status`  
- `version_parity_status (v1/v2/v3)`  
- `selector_and_a11y_status`  
- `ci_cd_status`  
- `performance_and_monitoring_status`  
- `top_5_risks`  
- `top_5 recommended_next_actions`  

Plus a final question:

**“Which action should I orchestrate next? (e.g., create_test_suite, create_backend_module, create_frontend_module, migrate_schema, upgrade_version)”**

---

# Interconnection Rules

This command may **suggest** but NOT auto-run:

- `create_test_suite` if tests are missing  
- `create_backend_module` if APIs are incomplete  
- `create_frontend_module` or `create_ui_page` if UI is missing/misaligned  
- `migrate_schema` if schema mismatches are found  
- `upgrade_version` if v1/v2/v3 are out of sync  
- `debugging_session` if there are recurring failures recorded in memory  

Execution only happens if the user explicitly selects a next command.

---

# MCP Tool Usage

### Cursor Search
- primary source for code + docs inspection  

### AgenticRag
- read-only retrieval of:
  - rules  
  - patterns  
  - historical issues  

### Context7
- read-only retrieval of:
  - official framework docs  
  - best practices  

### Brave / Perplexity
- only if deep external comparison is requested  

No Serena usage here: **no code written or refactored.**

---

# Memory Rules

By default: **READ-ONLY.**

Only if user explicitly asks:
- “Store this as a long-term rule”  
or  
- “Remember this pattern”

Then:
- Graffiti: store architectural/structural insights  
- VectorDB: store example patterns and issue summaries  

Otherwise, no writes.

---

# Stop Conditions

Stop immediately if:
- asked to generate code  
- asked to refactor code  
- asked to write migrations  
- asked to modify tests  
- asked to “just fix it” inside this command  

In those cases, redirect to:
- `create_backend_module`  
- `create_frontend_module`  
- `create_api_endpoint`  
- `create_test_suite`  
- `migrate_schema`  
- `debugging_session`  

---

# END OF COMMAND
