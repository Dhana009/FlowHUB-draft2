# refine-prompt

### USER COMMAND: `refine_prompt`

## Purpose
Rewrite and analyze the user’s raw request to extract true intent, hidden layers, missing details, complexity level, and the correct next SDLC command. This command always runs before clarification, scoping, planning, coding, debugging, or testing. It ensures the assistant never misinterprets the user.

## Behavior (Strict, SDLC-Aligned)
The assistant must read the user’s raw message exactly as written, rewrite it clearly, remove ambiguity, and extract the core intent. It must identify whether the request represents a feature, bug, improvement, documentation, debugging need, testing requirement, or coding action. It must detect hidden layers, implicit expectations, unstated dependencies, and any subproblems implied by the request. The assistant must determine complexity as small, medium, complex (requires planning), or very complex (requires research plus planning). The assistant must detect missing details such as required files, logs, parameters, or system context.

## Required Memory Integration
The assistant must retrieve relevant context using AgenticRag:
- search_nodes for past preferences, constraints, or recurring patterns  
- search_facts for relationships influencing interpretation  
Memory must only assist disambiguation and must never override new instructions. No memory is stored unless user explicitly asks.

## Routing Behavior
Based on the refined interpretation, the assistant must determine the next SDLC command:
- If intent is unclear → route to `clarify_request`  
- If it is a new feature → route to `scope_request`  
- If it is a bug or error → route to `debugging_session`  
- If it is documentation → route to `draft_document` or `refine_document`  
- If it is a coding action → route to `review_code` or `implement_change`  
- If it is a testing action → route to `define_test_expectations` → `test_cycle`  
The assistant must not begin any SDLC action inside refine_prompt. It only routes.

## Rules
- No planning  
- No coding  
- No debugging  
- No testing  
- No document writing  
- No Serena usage  
- No MCP research unless ambiguity requires external facts  
- Only rewrite, analyze, detect, and route  
This is a meaning-extraction layer, not an execution layer.

## Output Format (Continuous, Clean)
Refined Prompt: a rewritten, clearer version of the user’s request  
Detected Intent: feature, bug, code change, document, test, improvement, or similar  
Complexity: small, medium, complex, or very complex  
Hidden Tasks: any implicitly required sub-tasks  
Missing Information: any unknown pieces that block progress  
Suggested Next Command: the SDLC command that should run next  

The output must be one continuous section with no breaks or isolated blocks.

## Interconnection Rules (Strict)
After refine_prompt:
- If intent unclear → go to `clarify_request`  
- If feature → go to `scope_request`  
- If documentation request → go to `draft_document`  
- If bug/error → go to `debugging_session`  
- If code change → go to `review_code` or `implement_change`  
- If testing-related → go to `define_test_expectations` then `test_cycle`  
Refine_prompt must never skip directly to planning or implementation.

## Correction Handling
If the user says the interpretation is wrong, refine_prompt must run again on the corrected explanation, producing a new refined interpretation and updated routing.

## Inline Example (No Break)
For example: if a user says “the signup flow is crashing sometimes,” refine_prompt rewrites it as a bug in the signup module, identifies missing details such as logs and triggering conditions, marks complexity as medium, and routes to debugging_session without executing anything.

## Availability
This command is available in chat as `/refine-prompt`.
