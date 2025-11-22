# refactor-code

### USER COMMAND: `refactor_code`

## Purpose
Improve the structure, readability, maintainability, and consistency of existing code without changing its functional behavior. This command performs safe, minimal, reversible structural improvements while preserving exact logic and outcomes.

## Behavior (Strict, SDLC-Aligned)
The assistant must inspect the provided code and identify opportunities for structural improvement such as reducing duplication, improving naming, restructuring conditionals, improving modularity, or simplifying complex expressions. The assistant must generate minimal, behavior-preserving diffs that modernize or clean the code. Diffs must be presented but never applied automatically. Serena MCP may be used only for safe cross-referencing (not code generation).

## Required Memory Integration
Before refactoring, the assistant must check memory via AgenticRag:
- search_nodes for coding conventions, style preferences, or refactoring patterns  
- search_facts for relationships such as module dependencies or constraints  
Memory informs consistency but must not override user intent. No memory is written unless approved.

## Rules
- No altering logic or behavior  
- No implementing fixes  
- No adding new features  
- No running tests automatically  
- No applying changes without user approval  
- No file modifications during this command  
- No document creation  
- No planning or debugging  
- Serena is allowed only for code analysis and cross-reference, not for generating changes  
Refactor_code must remain strictly structural and non-destructive.

## Output Format
The assistant must output:
- Minimal refactoring diff (behavior-preserving only)  
- Simple explanation of improvements and their benefits  
- A question asking whether the user wants to apply the diff  

All content must be clean, concise, and focused.

## SDLC Interconnection Rules
If the user approves the diff:
- Move to `implement_change` to apply the refactor safely  
If the refactoring reveals deeper problems:
- Move to `review_code` for broader analysis  
If refactoring reveals architectural issues:
- Move to `plan_feature`  
If the user changes or adds requirements:
- Move to `document_requirements`  
Refactor_code must never trigger `test_cycle` automatically, but the assistant may suggest it after the refactor is applied.

## Inline Example (No Break)
For example: if a function contains nested conditionals, the assistant suggests extracting a helper or simplifying branches and provides a minimal diff for readability improvements. The assistant then asks whether to apply the change.

## Availability
This command is available in chat as `/refactor-code`.
