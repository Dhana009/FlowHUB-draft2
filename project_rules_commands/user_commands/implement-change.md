# implement-change

### USER COMMAND: `implement_change`

## Purpose
Generate safe, minimal, behavior-aligned code diffs based on an approved feature plan, approved todo items, or an explicitly confirmed user modification request. This command begins real implementation work and must follow the SDLC plan precisely, without adding, removing, or modifying behavior beyond what the user has approved.

## Behavior (Strict, SDLC-Aligned)
The assistant must read the approved plan, todo list, or direct user request and generate precise, minimal diffs that implement only the approved changes. It must rely on Serena MCP for deep code understanding, symbol mapping, cross-file connections, and safe diff generation. It must show exactly what will be changed and why, keeping changes reversible and predictable.

The assistant must never apply diffs automatically. All diffs are proposals and require explicit user approval before any file is modified. The assistant may also highlight assumptions, dependencies, or potential side effects, but must not expand scope or introduce new logic.

## Required Memory Integration
Before generating changes, the assistant must retrieve memory via AgenticRag:
- search_nodes for coding preferences, naming conventions, or architectural patterns  
- search_facts for module relationships, file interactions, or constraints  
Memory influences consistency and safety but must never override the approved plan, todo, or explicit instruction. No memory writes occur unless the user approves a memory update.

## Rules
- No applying code changes without explicit approval  
- No creating or modifying files without approval  
- No rewriting entire files unless the user explicitly requests it  
- No introducing new behavior beyond the approved plan  
- No planning, debugging, or testing inside this command  
- No invoking test_cycle automatically  
- Serena MCP may be used only for code understanding and diff preparation—not execution  
- No research tools (Cursor Search, Brave, Perplexity) during this command  
- Diffs must be minimal, reversible, and safe  

Implement_change is strictly an implementation proposal phase, not an execution or testing phase.

## Output Format
The assistant must output:
- Proposed Minimal Diff  
- Explanation: why each change is needed and how it satisfies the approved plan  
- Approval Prompt: asking the user whether to apply the changes  

The entire output must be concise, clear, and continuous with no extraneous detail.

## SDLC Interconnection Rules
If user approves:
- Move to `apply_change` inside implement_change to commit diffs safely (handled internally)  
- After applying, the assistant may suggest running `test_cycle` but never trigger it automatically  

If user rejects the diffs:
- Provide corrected diffs  
- Or transition to `review_code` if deeper inspection is needed  

If the requested change is unclear:
- Return to `clarify_request`  

If the plan appears incomplete:
- Transition to `plan_feature`  

If scope changes:
- Transition to `scope_request`  

If requirements change:
- Transition to `document_requirements`  

Implement_change must remain only within the implementation layer of the SDLC process.

## Inline Example (No Break)
For example: if the user has approved adding a new validation check, the assistant generates a minimal diff updating only the relevant lines, explains the purpose of each diff, confirms alignment with the plan, and asks for approval before applying any file modifications.

## Availability
This command is available in chat as `/implement-change`.
