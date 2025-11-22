---
alwaysApply: true
---
---
description: Project Command – Create Fullstack Feature
alwaysApply: true
---

# PROJECT COMMAND: create_fullstack_feature
## (Top-Level Orchestrator for Complete Feature Development)

### Purpose
Create an entire full-stack feature across:
- Backend  
- Database schema  
- API layer  
- Frontend (v1 Bootstrap, v2 Tailwind, v3 Custom CSS)  
- Shared contracts  
- Testing (unit, integration, E2E)  
- Documentation (PRD, Design Doc, API Spec)

This command coordinates *all* project rules, user rules, and user commands.

---

# Behavior (High-Level Orchestration)

### 1. Refine + Clarify
Immediately call:
- `refine_prompt`
- `clarify_request`

To extract:
- feature name  
- feature boundaries  
- inputs/outputs  
- acceptance criteria  
- role-based behavior  
- dependencies  

### 2. Scope Definition
Automatically trigger:
- `scope_request`
- `document_requirements`

Scope is validated across:
- Backend  
- Frontend  
- Database  
- API  
- Testing  

### 3. Research Pipeline
Run the mandatory research sequence:

1. Cursor Search  
2. Context7 MCP  
3. Brave (if needed)  
4. Perplexity (only if needed)

Output is summarized into:
- feature references  
- architecture hints  
- best practices  
- security requirements  

### 4. Planning Phase
Call:
- `plan_feature`

Plan must include:
- backend architecture  
- database schema  
- API endpoints  
- frontend pages/components  
- selectors & accessibility patterns  
- testing strategy  
- folder structures  
- performance & security notes  

### 5. To-Do Breakdown
Call:
- `generate_todo`

Tasks are broken into:
- backend tasks  
- frontend v1/v2/v3 tasks  
- test tasks  
- infra tasks  

### 6. Validation Step
Stop and ask user:
**“Approve this fullstack plan?”**

No code is generated until approval.

### 7. Implementation Phase
After approval, orchestrates:
- `create_backend_module`
- `create_frontend_module`
- `create_ui_page`
- `create_api_endpoint`
- `create_test_suite`
- `migrate_schema` (if needed)

Each sub-task must obey:
- Project Rules  
- User Rules  
- Tool Rules  
- Storage Rules  

### 8. Testing Phase
Automatically triggers:
- `test_cycle`

Full flow:
- backend tests  
- frontend tests  
- E2E  
- accessibility tests  
- selector stability tests  
- performance tests  

### 9. Documentation Phase
Ask:
**“Should I generate documentation?”**

If yes → call:
- `draft_document`  
- `refine_document`  

---

# Hard Rules (Cannot Be Violated)

- Cannot generate backend without API contracts.
- Cannot generate frontend UI without semantic + accessibility validation.
- Cannot skip any version (v1, v2, v3).
- Cannot generate code without user approval.
- Cannot skip tests.
- Must use Serena MCP for code creation.
- Must use Context7 for documentation queries.
- Must store knowledge correctly in AgenticRag.

---

# Output Format

When this command is executed, the output must be:

- Refined feature description  
- Scope (in/out/dependencies)  
- Requirements  
- Research summary  
- Architecture plan  
- Backend plan  
- Frontend v1/v2/v3 plan  
- DB plan  
- API plan  
- Testing plan  
- To-Do list  
- **“Do you approve this fullstack feature plan?”**

---

# Interconnection Rules

After approval:

- Backend → `create_backend_module`
- Frontend → `create_frontend_module`
- UI → `create_ui_page`
- API → `create_api_endpoint`
- DB → `migrate_schema`
- Tests → `create_test_suite`
- Documentation → `draft_document`

If user rejects → go back to:
- `refine_prompt`  
- or `plan_feature`

---

# MCP Tool Usage

### Serena MCP
Mandatory for:
- code generation  
- refactoring  
- mapping dependencies  

### Context7
Mandatory for:
- React / Next.js / Express / DB docs  
- semantic/accessibility references  

### Brave/Perplexity  
Used only when research pipeline escalates properly.

### AgenticRag
Must store:
- feature → API → component → test mappings  
- regression patterns  
- architecture references  

---

# Stop Conditions

Stop immediately if:
- Layer architecture is violated  
- Folder structure is incorrect  
- Selector policy not followed  
- Accessibility violated  
- Schema inconsistent  
- API contract missing  
- No aesthetic/semantic parity across v1/v2/v3  
- Code is attempted without user approval  

If violation occurs → propose correction.

---

# END OF COMMAND
