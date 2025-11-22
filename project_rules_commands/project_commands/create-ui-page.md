---
alwaysApply: true
---
---
description: Project Command – Create UI Page Across v1/v2/v3
alwaysApply: true
---

# PROJECT COMMAND: create_ui_page
## (Page-Level Orchestrator for Frontend v1, v2, v3)

### Purpose
Create a **complete UI page** for a feature across **all three frontend versions**:

- **v1 → Bootstrap version**
- **v2 → Tailwind version**
- **v3 → Custom CSS version**

This includes:
- semantic structure  
- layout  
- components  
- sub-components  
- selectors  
- accessibility  
- page-level state logic  
- backend API integration (via shared hooks/services)  
- testing (unit/integration/E2E)

This command is focused ONLY on **page-level orchestration**, not full frontend modules.

---

# Behavior (Strict, Predictable Flow)

### 1. Refine + Clarify Intent
Call:
- `refine_prompt`
- `clarify_request`

Clarify:
- page name  
- page purpose  
- page-level interactions  
- required inputs/outputs  
- required semantic structure  
- version-specific UI differences  
- accessibility considerations  
- API dependencies

---

### 2. Scope the Page
Call:
- `scope_request`
- `document_requirements`

Define:
- layout structure  
- component breakdown  
- required hooks  
- services needed  
- validation needed  
- version differences (visual only)  
- selectors (`data-testid`, `role`, semantic tags)  
- accessibility rules (labels, focus, aria links)

---

### 3. Research Pipeline
Run:
1. Cursor Search  
2. Context7 (React, Next.js, Bootstrap, Tailwind, Accessibility docs)  
3. Brave (if patterns unclear)  
4. Perplexity (only if necessary)

Research gathers:
- page layout patterns  
- form patterns  
- semantic HTML structures  
- accessible navigation rules  
- version-specific UI equivalents  
- component tree patterns stored in RAG

---

### 4. Plan the Page Structure
Call:
- `plan_feature`

Plan must include:
- final HTML semantic hierarchy (`main → section → article → ...`)  
- page-level layout  
- components required  
- sub-components  
- hooks needed  
- services to be integrated  
- page-level validation rules  
- accessibility rules  
- selector policy usage  
- version mapping:
  - v1 Bootstrap classes  
  - v2 Tailwind  
  - v3 Custom CSS  

No code yet.

---

### 5. Generate Page To-Do List
Call:
- `generate_todo`

Tasks include:
- layout skeleton  
- semantic structure  
- components to create  
- hooks to use  
- services to call  
- version-specific styling  
- selectors  
- accessibility labeling  
- unit + integration tests  
- optional E2E tests  

---

### 6. STOP — Wait for Approval
Ask:

**“Do you approve this UI page plan?”**

⚠ No code until approval.

---

### 7. Page Implementation (After Approval)
Use **Serena MCP** (mandatory) to generate:

- v1 page → Bootstrap  
- v2 page → Tailwind  
- v3 page → Custom CSS  
- shared hooks used by page  
- necessary services (if missing)  
- schemas for form validation  
- unit tests  
- integration tests  
- E2E scenarios  

Rules:
- must follow Layer 5 Frontend Rules  
- must follow selector policy  
- must follow accessibility layer  
- must generate **semantic HTML**  
- must not intermix logic across versions  
- must preserve identical functional behavior

---

### 8. Testing Phase
Automatically call:
- `test_cycle`

Validate:
- page loads  
- page renders semantics  
- components integrate correctly  
- selectors present  
- accessibility roles correct  
- API calls mocked correctly  
- cross-version consistency  
- snapshots (optional)

---

### 9. Documentation Phase
Ask:
**“Do you want a UI page specification document?”**

If yes → call `draft_document`.

---

# Hard Rules (Cannot Be Violated)

- follow page → component → sub-component hierarchy  
- follow semantic HTML  
- follow selector policy  
- follow accessibility layer  
- follow version isolation  
- components must not call APIs  
- hooks must use services  
- no inline styles  
- no skipped tests  
- no large documents without permission  
- no code generated without approval  
- must use Serena MCP only for code  
- must leverage RAG memory for patterns  

---

# Output Format

When executed, must output:

- refined prompt  
- scoped page definition  
- requirement block  
- research summary  
- page architecture plan  
- multi-version mapping  
- component tree  
- accessibility plan  
- selector plan  
- to-do list  
- approval question

---

# Interconnection Rules

After approval:
- Call Serena MCP for generating version-specific UI pages  
- Call `create_frontend_module` if deeper structure is needed  
- Call `create_test_suite` to generate test hierarchy  

If unclear:
- `clarify_request`  

If violations detected:
- stop + propose correction  

If errors during tests:
- `debugging_session`

---

# MCP Tool Usage

### Serena MCP  
Mandatory for:
- page generation  
- version-specific styling  
- refactoring

### Context7  
Used for:
- React docs  
- Next.js docs  
- Bootstrap/Tailwind docs  
- HTML semantic + accessibility docs

### AgenticRag  
Used for retrieving:
- page layout patterns  
- semantic structure examples  
- accessibility patterns  
- test patterns

Stores:
- new page patterns  
- version mappings  
- component relationships

---

# Memory Storage Rules

### Graffiti  
Store:
- page → components mapping  
- component hierarchy  
- version → page mappings  
- selector → page mappings  
- aria relationships

### VectorDB  
Store:
- semantic layout examples  
- pattern-based component usage  
- accessibility examples  
- test patterns  

---

# Stop Conditions

Stop immediately if:
- violates semantic contract  
- violates selector policy  
- violates accessibility  
- violates version isolation  
- invalid folder structure  
- missing required tests  
- missing validation  
- unclear design  

---

# END OF COMMAND
