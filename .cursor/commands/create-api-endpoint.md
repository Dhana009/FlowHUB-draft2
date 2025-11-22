# create-api-endpoint

Write your command content here.
---
alwaysApply: true
---
---
description: Project Command – Create Backend API Endpoint
alwaysApply: true
---

# PROJECT COMMAND: create_api_endpoint
## (Backend Endpoint Orchestrator – Controllers, Services, Repositories, Schemas, Tests)

### Purpose
Create a complete backend API endpoint – *safely, predictably, and strictly within backend architecture rules*.  

This includes:
- request validation schema  
- response schema  
- controller  
- service logic  
- repository access  
- database model usage  
- error handling  
- authentication/authorization  
- integration tests  
- unit tests  
- API contract documentation  

This command is used ANY time a new backend endpoint is needed.

---

# Behavior (Strict, Deterministic Flow)

### 1. Refine and Clarify Intent
Call:
- `refine_prompt`
- `clarify_request`

Clarify:
- endpoint purpose  
- HTTP method  
- URL path  
- input schema  
- output schema  
- authentication  
- authorization  
- business logic  
- DB entities involved  
- error cases  
- relation with other endpoints  

---

### 2. Scope the Endpoint
Call:
- `scope_request`
- `document_requirements`

Define:
- in-scope behavior  
- out-of-scope edge cases  
- DB entities affected  
- validation flow  
- service requirements  
- repository usage  
- error format requirements  

---

### 3. Research Pipeline
Run:
1. Cursor Search  
2. Context7 (Express/NestJS docs, validation libs, schema patterns)  
3. Brave (only when needed)  
4. Perplexity (rare, fallback for tricky cases)

Research for:
- endpoint patterns  
- schema patterns  
- error handling best practices  
- authentication/authorization patterns  
- repository design patterns  
- response formatting  

---

### 4. Plan API Endpoint
Call:
- `plan_feature`

Plan includes:
- request → controller → service → repository → DB mapping  
- validation schema structure  
- response schema structure  
- domain logic sequence  
- error conditions  
- status codes  
- unit test design  
- integration test design  

No code yet.

---

### 5. Generate To-Do List
Call:
- `generate_todo`

Tasks include:
- create request schema  
- create response schema  
- create controller  
- create service method  
- create repository method  
- update model/schema (if needed)  
- create controller tests  
- create service tests  
- create repository tests  
- create integration tests  
- update API contract document (optional)  

---

### 6. STOP — Wait For Approval
Ask:

**“Do you approve the API endpoint plan?”**

⚠ Absolutely no code until approval.

---

# Implementation Phase (After Approval)

### 7. Code Generation via Serena MCP
Mandatory use of Serena to generate:

- request schema (Zod/Yup)  
- response schema  
- controller file  
- controller test  
- service file  
- service test  
- repository file  
- repository test  
- route registration  
- integration tests  
- DB schema updates  
- error types  

Rules:
- Controller must NEVER contain business logic  
- Service must NEVER perform direct DB operations  
- Repository must NEVER change business logic  
- All schemas must be typed  
- All tests must be deterministic  
- Error handling must follow standardized error contract  
- Code must follow Backend Layer Contract exactly  

---

### 8. Automatic Testing Phase
Call:
- `test_cycle`

Validate:
- endpoint responds with correct HTTP status  
- request validation works  
- service logic correct  
- repository works  
- all success/error paths  
- database integration  
- authentication/authorization  
- edge cases  
- contract tests  

---

### 9. Documentation Phase
Ask:

**“Do you want an API contract document generated for this endpoint?”**

If yes → call `draft_document`.

---

# Hard Rules (Cannot Be Violated)

- Every endpoint MUST use controller → service → repository  
- No direct DB operations in controllers/services  
- Must use request + response + error schemas  
- Must validate every input  
- Must return typed responses  
- Must follow REST conventions  
- Must implement authentication/authorization if required  
- Must generate unit + integration tests  
- Must follow folder structure contract  
- Must follow error handling contract  
- Must use Serena MCP for code  
- Must use Context7 for framework docs  
- Must use AgenticRag to retrieve prior patterns  
- No code without approval  
- No documents without permission  

---

# Output Format

- refined prompt  
- confirmed scope  
- requirements block  
- research summary  
- full API architecture plan  
- schema mapping  
- error handling plan  
- test plan  
- to-do list  
- approval prompt  

---

# Interconnection Rules

After approval:
- Call Serena MCP to generate backend files  
- Call `create_backend_module` if multiple endpoints needed  
- Call `create_test_suite` if advanced tests needed  
- Call `migrate_schema` if DB schema changes required  

If unclear:
- Re-run `clarify_request`

If violations occur:
- Stop + report issues

If tests fail:
- Enter `debugging_session`

---

# MCP Tool Usage

### Serena MCP (Mandatory)
- controller/service/repo generation  
- refactoring  
- type mapping  
- schema validation  

### Context7
- Express/NestJS docs  
- validation docs  
- error handling best practices  

### AgenticRag
Retrieve patterns for:
- API contracts  
- error handling  
- validation patterns  
- test structures  

Store:
- endpoint pattern  
- service/repository mapping  
- schema pattern  

---

# Memory Storage Rules

### Graffiti  
Store:
- endpoint → service → repository mapping  
- schema → model mapping  
- error code definitions  
- route metadata  

### VectorDB  
Store:
- request/response examples  
- test patterns  
- error patterns  
- debugging sessions  

---

# Stop Conditions

Stop generation immediately if:
- endpoint violates architecture  
- schema missing  
- validation missing  
- error handling incomplete  
- wrong file structure  
- no test coverage defined  
- unclear logic  
- DB update required but not planned  

---

# END OF COMMAND

This command will be available in chat with /create-api-endpoint
