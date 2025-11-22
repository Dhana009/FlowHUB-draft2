# document-requirements

### USER COMMAND: `document_requirements`

## Purpose
Transform the confirmed user request and confirmed scope into a clean, structured set of requirements before planning begins. This is the pre-planning, pre-PRD layer that ensures feature clarity and prevents incorrect or overly broad plans during plan_feature. Requirements must remain short, precise, and strictly aligned with the confirmed scope.

## Behavior (Strict, SDLC-Aligned)
The assistant must take the refined and clarified request along with the finalized scope and convert them into four requirement categories:
- Functional Requirements  
- Non-Functional Requirements  
- Edge Cases  
- Assumptions  

If any requirement is unclear or ambiguous, the assistant must ask exactly one clarification question. After receiving a response, the assistant must finalize the requirements and present them for approval. These requirements become the direct input to plan_feature and must not include extra content or unapproved scope.

The assistant must keep all requirements concise, exact, and free from unnecessary verbosity. Requirements must not be expanded into documents or design specifications.

## Required Memory Integration
The assistant must retrieve memory using AgenticRag:
- search_nodes for user preferences regarding requirement format  
- search_facts for related context or dependencies  

Memory can guide formatting consistency but must not add requirements or hidden assumptions. Memory writes may only occur with explicit user approval.

## Rules
- No documents or long-form writing  
- No planning or architecture decisions  
- No coding, debugging, or testing  
- No MCP research unless needed for clarifying definitions  
- No Serena usage  
- Requirements must stay short and exact  
- No expanding scope beyond what was confirmed  

Document_requirements is strictly a requirements-layer command.

## Output Format
The assistant must output:
- Functional Requirements  
- Non-Functional Requirements  
- Edge Cases  
- Assumptions  
- Approval Prompt: “Approve these requirements?”  

The output must remain continuous, clean, and minimal.

## SDLC Interconnection Rules
If the user approves the requirements:
- Move to `plan_feature` for feature planning  

If the user says the requirements are unclear:
- Transition to `clarify_request`  

If scope changes:
- Transition to `scope_request`  

If the user wants to turn requirements into a document:
- Transition to `draft_document`  

If the user wants to refine requirement phrasing:
- Transition to `refine_document`  

Document_requirements must never directly begin planning, coding, testing, or debugging.

## Inline Example (No Break)
For example: for a login feature, the assistant lists functional requirements such as validating credentials and calling the login API; non-functional requirements such as response time expectations; edge cases like empty fields or server errors; and assumptions such as API availability. Then it asks the user whether to approve these requirements.

## Availability
This command is available in chat as `/document-requirements`.
