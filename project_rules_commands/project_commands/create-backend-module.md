---
alwaysApply: true
---
---
description: Project Command – Create Backend Module
alwaysApply: true
---

# PROJECT COMMAND: create_backend_module
## (Backend-Only Orchestrator for Controllers, Services, Repositories, Schemas, and Tests)

### Purpose
Create a **complete backend module** for a given feature, including:

- Controller  
- Service  
- Repository  
- Models / Schemas  
- Request/response DTOs  
- Routes  
- Middleware (if needed)  
- Unit + Integration Tests  
- API Contract  
- Validation Rules  
- Error Handling

This command **follows the Backend Rules (Layer 4) strictly** and integrates with User Rules + Project Rules.

---

# Behavior (Step-by-Step Backend Construction)

### 1. Refine + Clarify
Immediately call:
- `refine_prompt`
- `clarify_request`

To establish:
- backend resource name  
- actions (CRUD / custom operations)  
- API inputs & outputs  
- user roles & auth requirements  
- dependencies (DB collections, services, external APIs)

### 2. Scope Definition
Trigger:
- `scope_request`  
- `document_requirements`

Backend scope must cover:
- endpoints  
- behaviors  
- models  
- validation  
- error states  
- DB constraints  

### 3. Research Pipeline
Run:
1. Cursor Search  
2. Context7 MCP  
3. Brave MCP (if needed)  
4. Perplexity (only deeper fallback)

Research determines:
- REST conventions  
- schema patterns  
- backend patterns stored in RAG  
- best practices for validation, security, error handling  

### 4. Backend Planning Phase
Call:
- `plan_feature`

Plan must include:
- controller structure  
- service business logic  
- repository methods  
- schema definitions  
- middleware needs  
- routes  
- folder structure  
- test strategy  
- API documentation mapping  

### 5. To-Do Breakdown
Call:
- `generate_todo`

Tasks separated into:
- controller tasks  
- service tasks  
- repository tasks  
- schema tasks  
- validation tasks  
- error-handling tasks  
- test tasks  

### 6. STOP for User Approval
Ask user:

**“Do you approve this backend module plan?”**

⚠ **No code generated until approval.**

### 7. Implementation Phase
After approval, use:
- **Serena MCP** (mandatory) to generate:

Files:
- `controllers/[resource].controller.ts`
- `services/[resource].service.ts`
- `repositories/[resource].repository.ts`
- `models/[resource].model.ts`
- `schemas/[resource].schema.ts`
- `routes/[resource].routes.ts`
- `types/[resource].ts`
- `middleware/[optional].ts`
- tests (unit + integration)

Rules:
- Each file must follow backend folder structure  
- Must follow API contract  
- Must follow validation contract  
- Must follow error contract  
- Must follow security contract  

### 8. Testing Phase
Automatically route to:
- `test_cycle`

Tests must include:
- unit tests for service  
- unit tests for repository  
- controller tests  
- integration tests (API-level)  
- validation tests  
- error pathway tests  

### 9. Documentation Phase
Ask:
**“Do you want backend API documentation?”**

If yes:
- call `draft_document`  
- then refine with `refine_document` if needed  

---

# Hard Rules (Cannot Be Violated)

- Controller cannot contain business logic  
- Service cannot contain DB queries  
- Repository cannot transform data  
- All inputs must be schema-validated  
- All errors must follow error contract  
- API responses must be typed  
- Must use Zod/Yup schemas  
- Cannot skip tests  
- Cannot violate folder structure  
- No code unless explicitly approved  
- Serena MCP must be used  

---

# Output Format

When executed, this command must output:

- Refined description  
- Scope block  
- Requirements  
- Research summary  
- Detailed backend plan  
- Folder structure preview  
- To-Do list  
- **“Do you approve this backend module plan?”**

---

# Interconnection Rules

After approval:

- For controller → create controller with Serena MCP  
- For service → create service with Serena MCP  
- For repository → create repository with Serena MCP  
- For schemas → create schema files  
- For routes → generate REST route file  
- For tests → call `create_test_suite`

If at any point:
- validation missing  
- API unclear  
- schema incomplete  
→ bounce back to:
- `clarify_request`  
- or `plan_feature`

---

# MCP Tool Usage

### Serena MCP  
Mandatory for:
- code generation  
- refactoring  
- mapping controllers ↔ services ↔ repos  

### Context7  
Used for:
- Express/Nest docs  
- DB ORM docs  
- validation patterns  
- error-handling guidance  

### AgenticRag  
Store:
- backend architectural patterns  
- API → service → repository mappings  
- error patterns  
- testing patterns  

### Brave / Perplexity  
Used only after escalation.

---

# Memory Usage

**Graffiti Stores:**
- module relationships  
- schema relationships  
- error definitions  
- API endpoints & dependencies  

**VectorDB Stores:**
- implementation examples  
- testing examples  
- refactoring patterns  
- debugging summaries  

---

# Stop Conditions

Stop if:
- violates backend layer architecture  
- violates folder structure  
- missing schema  
- missing validation  
- missing error handling  
- missing tests  
- unsafe patterns detected  
- user approval not given  

---

# END OF COMMAND
