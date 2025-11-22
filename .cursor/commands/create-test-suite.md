# create-test-suite

Write your command content here.
---
alwaysApply: true
---
---
description: Project Command – Create Full Test Suite (Frontend, Backend, E2E)
alwaysApply: true
---

# PROJECT COMMAND: create_test_suite
## (Unified Orchestrator for Unit, Integration, API, E2E, Accessibility & Performance Tests)

### Purpose
Create a **complete, multi-layered test suite** for any feature, endpoint, component, flow, or module.

This command does *not* write tests directly.  
It orchestrates the **correct sequence** of analysis, planning, and generation using user commands + Serena MCP.

---

# High-Level Goal
Ensure that **every part of the system** has the required tests:

### Backend Tests  
- unit tests (controller/service/repository)  
- integration tests (API + DB)  

### Frontend Tests  
- component tests  
- hook tests  
- integration tests  
- snapshot tests (only when allowed)  

### End-to-End Tests  
- full UI flows  
- API → UI → DB validation  
- semantic selectors and accessibility checks  

### Global Tests  
- accessibility tests  
- performance tests  
- contract tests  
- regression tests  

---

# Behavior (Full Orchestration Pipeline)

## 1. Understand What Needs Testing
Automatically trigger:
- `refine_prompt`
- `clarify_request`

Extract:
- feature/module/API/component name  
- inputs, outputs, side effects  
- affected layers (frontend/back-end/both)  
- required test types  
- repeatability requirements  
- performance/a11y needs  
- versions affected (v1, v2, v3 Frontend)  

---

## 2. Scope the Testing Work
Call:
- `scope_request`
- `document_requirements`

Define:
- in-scope test types  
- out-of-scope test types  
- required test data  
- test environments  
- CI integration needs  
- affected API routes  
- affected UI flows  
- required mocks/stubs  

---

## 3. Analyze Testing Needs
Use:
- **Cursor Search** (existing tests, patterns, folder structure)  
- **Context7** (framework testing documentation: Jest, React Testing Library, Playwright, Supertest, Vitest, etc.)  
- **Brave MCP** (real-world patterns)  
- **Perplexity MCP** (only if testing patterns unclear)  

Derive:
- exact test structure  
- required mocks  
- expected assertions  
- failure scenarios  
- a11y rules (contrast, roles, keyboard)  
- performance budget  

---

## 4. Create Test Plan (before writing tests)
Call:
- `plan_feature`

Plan includes:
- required test suite types  
- file paths (strict)  
- test data strategy  
- mocks strategy  
- semantic selectors needed  
- environment setup  
- cleanup strategy  
- coverage expectations  

---

## 5. Generate Test To-Do List
Call:
- `generate_todo`

Tasks include:
- write backend unit tests  
- write repository tests  
- write component tests  
- write hook tests  
- write integration tests  
- write accessibility tests  
- write E2E tests (Playwright)  
- update CI config for tests  
- update mocks/stubs  
- update test environment setup  

---

## 6. STOP — Require Explicit Approval
Ask:

**“Do you approve generating the full test suite?”**

Nothing moves unless user explicitly approves.

---

# Implementation Phase (After Approval)

## 7. Generate Tests Using Serena MCP
Serena must be used to generate:
- Jest / Vitest / RTL component tests  
- Hook tests  
- Integration tests (backend)  
- Supertest API tests  
- Playwright E2E tests  
- Accessibility test scripts  
- Contract tests  
- Performance scripts (Lighthouse / Playwright-Web-Vitals)  

Rules:
- Must use correct folder structure (strict)  
- Must use correct selectors (testid → role → semantic tag)  
- Must follow backend test structure  
- Must follow frontend test structure  
- Must not violate project rules (semantic, accessibility, architecture)  
- Must not generate unnecessary snapshots  
- Must include failure case tests  

---

## 8. Validate the Entire Test Suite
Call:
- `test_cycle`

Validate:
- coverage  
- correctness  
- stability  
- deterministic behavior  
- selector reliability  
- accessibility  
- performance  

Failures → automatically enter `debugging_session`.

---

## 9. Regression Memory Storage (Optional)
If user approves, store:
- test patterns  
- selectors used  
- test structure  
- failure patterns  
- stable test IDs  

Into AgenticRag memory:
- Graffiti: test → component/API mapping  
- VectorDB: reusable test patterns  

---

# Hard Rules (Cannot Be Violated)

- Must not generate tests before planning.  
- Must not write tests without explicit approval.  
- Must use Serena MCP for all code.  
- Must follow folder structures strictly.  
- Must follow selector policy.  
- Must follow accessibility policy.  
- Must follow backend testing conventions.  
- Must run `test_cycle` after generating tests.  
- Must stop if user has not explicitly approved.  

---

# Output Format

This command must output:

- refined understanding  
- test scope summary  
- test plan summary  
- detailed test types list  
- folder paths  
- selectors needed  
- impacted modules  
- migration impact (if any)  
- to-do list  
- explicit approval question  

---

# Interconnection Rules

### Calls the following before approval:
- `refine_prompt`
- `clarify_request`
- `scope_request`
- `document_requirements`
- `plan_feature`
- `generate_todo`

### After Approval:
- Serena MCP → generate test code  
- `test_cycle` → validate  
- `debugging_session` → if tests fail  
- `review_project_state` → optional system audit  
- AgenticRag memory updates → optional  

---

# MCP Tool Rules

### Serena MCP (Mandatory)
- generate tests  
- update mocks  
- update setup files  

### Context7
- testing docs  
- library APIs  
- framework guidelines  

### Brave
- real-world test patterns  

### Perplexity
- used only for complex flows  

### AgenticRag
Store:
- stable selectors  
- test-suite structure  
- version-specific issues  

---

# Stop Conditions

Stop immediately if:
- test violates architecture  
- folder structure incorrect  
- selectors invalid  
- missing accessibility rules  
- test non-deterministic  
- violates frontend/backend project rules  
- user has not approved  

---

# END OF COMMAND

This command will be available in chat with /create-test-suite
