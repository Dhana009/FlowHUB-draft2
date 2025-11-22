---
alwaysApply: true
---
---
description: Project Command – Create Frontend Module
alwaysApply: true
---

# PROJECT COMMAND: create_frontend_module
## (Frontend-Only Orchestrator for Pages, Components, Sub-Components, Hooks, Services, Schema, Tests)

### Purpose
Create a **complete frontend module** for a given feature, across all frontend versions (v1 Bootstrap, v2 Tailwind, v3 Custom CSS), including:

- Page  
- Components  
- Sub-components  
- Hooks  
- UI State logic  
- Selectors (data-testid, roles, semantic tags)  
- Validation schemas  
- Integration with backend services  
- Accessibility structure  
- Unit Tests  
- Integration Tests  
- E2E Test config (if needed)

This command **must follow all Frontend Rules (Layer 5)** strictly and integrate with User Rules + Project Rules.

---

# Behavior (Step-by-Step Frontend Construction)

### 1. Refine + Clarify
Immediately call:
- `refine_prompt`
- `clarify_request`

To identify:
- frontend feature name  
- pages involved  
- component tree  
- required interactions  
- validation needs  
- cross-version UI behavior  
- API dependencies (backend contracts)

### 2. Scope Definition
Call:
- `scope_request`
- `document_requirements`

Scope must include:
- page-level structure  
- component architecture  
- hooks required  
- services required  
- validation rules  
- accessibility needs  
- test coverage  
- version differences (v1/v2/v3)

### 3. Research Pipeline
Run:
1. Cursor Search  
2. Context7 for UI framework docs (React, Next.js, Bootstrap/Tailwind docs)  
3. Brave if needed  
4. Perplexity only for complex UI patterns  

Research determines:
- semantic HTML patterns  
- accessibility guidelines  
- component composition patterns  
- version-specific styling best practices  
- selector policy compliance  
- RAG-stored component patterns

### 4. Frontend Planning Phase
Call:
- `plan_feature`

Plan must include:
- Page structure  
- Component hierarchy  
- Hook structure  
- Service integration strategy  
- Selector plan (data-testid / semantic tags)  
- Accessibility plan  
- Multi-version mapping (v1/v2/v3)  
- Test strategy (unit, integration, E2E)

### 5. To-Do Breakdown
Call:
- `generate_todo`

Tasks separated into:
- Page tasks  
- Component tasks  
- Sub-component tasks  
- Hook tasks  
- Service tasks  
- Styling tasks for v1/v2/v3  
- Selector additions  
- Testing tasks (unit / integration / E2E)

### 6. STOP for Approval
Ask user:

**“Do you approve this frontend module plan?”**

⚠ **No UI code is generated until approval.**

### 7. Implementation Phase
After approval, use:
- **Serena MCP** (mandatory)

Serena generates:

Files:
- `src/v1/pages/...tsx`  
- `src/v1/components/...`  
- `src/v2/pages/...tsx`  
- `src/v2/components/...`  
- `src/v3/pages/...tsx`  
- `src/v3/components/...`  
- `src/shared/hooks/useX.ts`  
- `src/shared/services/...`  
- `src/shared/schemas/...`  
- tests in appropriate folders  

Rules:
- Must follow folder structure strictly  
- Must follow component architecture  
- Must follow semantic HTML  
- Must follow accessibility rules  
- Must follow selector policy  
- Must follow version isolation  
- Must keep UI identical across versions  

### 8. Testing Phase
Automatically trigger:
- `test_cycle`

Tests must include:
- unit tests (components + hooks)  
- integration tests (page + component + hook + service)  
- cross-version snapshots (optional)  
- accessibility tests  
- E2E tests for pages  

### 9. Documentation Phase
Ask user:

**“Do you want a UI specification document for this module?”**

If yes:
- call `draft_document`

---
  
# Hard Rules (Cannot Be Violated)

- Must follow 5-layer frontend architecture  
- Must follow version isolation  
- Must follow selector policy  
- Must use semantic HTML  
- Must enforce accessibility  
- Components cannot call APIs (must use hooks)  
- Hooks must call shared services only  
- No inline styles  
- No skipping tests  
- No code generation without approval  
- Must use Serena MCP for code generation  
- Must use Context7 for framework docs  
- Must store patterns in memory correctly  

---

# Output Format

When executed, this command must output:

- Refined description  
- Scope block  
- Requirements  
- Research summary  
- Frontend plan  
- Multi-version mapping  
- Component tree  
- Selector policy plan  
- Accessibility plan  
- To-Do list  
- “Do you approve this frontend module plan?”  

---

# Interconnection Rules

After approval:

- Create pages → Serena MCP  
- Create components → Serena MCP  
- Create sub-components → Serena MCP  
- Create hooks → Serena MCP  
- Create schemas → Serena MCP  
- Create services → Serena MCP  
- Create tests → `create_test_suite`  

If something is unclear:
- `clarify_request`  
- `document_requirements`  
- `plan_feature`  

If errors appear:
- `debugging_session`

---

# MCP Tool Usage

### Serena MCP  
Mandatory for:
- component generation  
- version-specific UI generation  
- hook/service generation  
- refactoring  

### Context7  
Used for:
- React docs  
- Next.js docs  
- Bootstrap docs  
- Tailwind docs  
- Accessibility docs  

### AgenticRag  
Reads:
- component composition patterns  
- accessibility patterns  
- selector patterns  
- testing patterns  

Stores:
- new UI patterns  
- multi-version mappings  
- important component structures  

---

# Memory Usage

### Graffiti
Store:
- component hierarchy  
- version-variant mappings  
- selector mappings  
- accessibility attributes  

### VectorDB
Store:
- component examples  
- UI patterns  
- hook patterns  
- test examples  
- debugging summaries  

---

# Stop Conditions

Stop if:
- violates architecture layers  
- violates version isolation  
- violates selector policy  
- violates accessibility  
- invalid folder structure  
- missing schemas  
- missing tests  
- unsafe UI patterns  
- user approval not provided

---

# END OF COMMAND
