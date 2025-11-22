# clarify-request

✅ **USER COMMAND #6:** `clarify_request`

## Purpose
Ensure the assistant fully understands the user’s intent before any SDLC workflow begins. This command resolves ambiguity, extracts meaning, identifies the correct SDLC entry point, and prevents wrong assumptions.

## Why This Matters
Most AI errors happen because the model misinterprets the request. This command is the gatekeeper that guarantees the next step is correct.

## ✔ Behavior (Strict, SDLC-Aligned)
1. Interpret the user request exactly as written.  
2. Rewrite it cleanly in structured form: what the user wants, expected outcome, relevant context, assumptions to validate.  
3. Run AgenticRag memory retrieval only for understanding (search_nodes + search_facts).  
4. Detect complexity: small, medium, complex, or very complex (requires research).  
5. Detect missing details such as files, logs, parameters, or context.  
6. Ask a maximum of 1–2 clarifying questions.  
7. Produce a final “Confirmed Interpretation” that becomes the input to the next User Command.

## ✔ Alignment With User Rules
- No planning  
- No coding  
- No research unless ambiguity requires external facts  
- No testing  
- No debugging  
- No requirements extraction  
- No document writing  
- No Serena invocation  
- No memory writes unless user explicitly approves  

Only clarify → confirm → route.

## ✔ Output Format
- Rewritten Interpretation  
- Complexity Level  
- Missing Details  
- Clarifying Question(s)  
- Next Recommended Command  
- “Confirm to proceed”

## ⭐ SDLC Routing Logic
After confirmation, route to the correct workflow:

- Feature request → `scope_request`  
- New feature idea → `scope_request`  
- Incomplete description → `scope_request` → `document_requirements`  
- Architecture / design → `plan_feature`  
- Bug or error → `debugging_session`  
- Testing discussion → `define_test_expectations` → `test_cycle`  
- Code change → `generate_todo` → `implement_change`  
- Documentation → `draft_document` or `refine_document`  
- Research → `research_topic`  
- Architecture explanation → `explain_flow`  
- Simulation request → `simulate_flow`  
- Casual discussion → `open_discussion`

The assistant must not skip refine_prompt → clarify_request before choosing the next SDLC command.

## 🧪 Example (Inline, No Block Break)
Here is an example that stays inside the same markdown flow without breaking the document:

Here is my interpretation of your request: you want to fix the login error and ensure the submit flow works correctly.  
Complexity Level: Medium (requires debugging_session → test_cycle).  
Missing information: the exact error message and which file contains the login logic.  
Please confirm whether this interpretation is correct so I can route to the correct next command.

## Availability
This command is available in chat as `/clarify-request`.
