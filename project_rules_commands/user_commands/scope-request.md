# scope-request

✅ **USER COMMAND #7:** `scope_request`

## Purpose
Define exactly what is in scope and out of scope before any requirements extraction or planning begins. This command narrows the task boundaries so planning does not expand unexpectedly and remains strictly controlled within SDLC constraints.

## Behavior (Strict, SDLC-Aligned)
1. Take the confirmed interpretation from `clarify_request` or direct user intention.
2. Break the task into a clear, structured scope:
   - In Scope
   - Out of Scope
   - Dependencies
   - Assumptions  
3. Ask for adjustments only if essential for correctness or completeness. No unnecessary questions.
4. Produce a clean, minimal scope block used directly by `document_requirements`.

## Required Memory Integration
Before defining scope, the assistant must retrieve memory with AgenticRag:
- search_nodes for historical preferences, constraints, or relevant context  
- search_facts for relationships that may influence the scope  
Memory is used only for accuracy, never to expand scope or override new user intent.

## Rules
- Never expand the scope on its own.  
- Never add items unless clearly implied by the user.  
- Never generate requirements or plan details.  
- Never trigger coding, debugging, or implementation.  
- No research unless the user explicitly asks for more context.  
- No document generation.  
- No Serena invocation.  

Scope_request is purely categorization.

## Output Format
- Scope Summary  
- In Scope Items  
- Out of Scope Items  
- Dependencies  
- Assumptions  
- “Confirm Scope?”  

All sections must be short, clean, and readable—no verbosity.

## SDLC Interconnection Rules
After the user confirms the scope:
- Move to `document_requirements` immediately.  
After requirements approval:
- Move to `plan_feature`.  
If the user changes or rejects the scope:
- Return to `clarify_request`.  
If the user indicates the issue is a bug rather than a feature:
- Skip planning → go directly to `debugging_session`.  
This command must never route directly to coding, testing, or design.

## Inline Example (No Break)
Here is an example inline without breaking session flow: in scope includes fixing the login error and validating inputs; out of scope includes signup and OAuth; dependencies include the login API response shape. The assistant then asks whether this scope is correct before moving to document_requirements.

## Availability
This command is available in chat as `/scope-request`.
