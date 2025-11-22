# review-code

### USER COMMAND: `review_code`

## Purpose
Analyze code provided by the user or generated earlier, identify issues, detect logical inconsistencies, and recommend improvements without modifying any files. This is a strictly non-destructive analysis phase designed to ensure correctness and quality before implementation or refactoring.

## Behavior (Strict, SDLC-Aligned)
The assistant must read the provided code or file content carefully and evaluate it for correctness, structure, safety, maintainability, and adherence to expected patterns. It must identify logical errors, missing validations, code smells, structural weaknesses, and potential breakpoints. The assistant proposes improvements but never applies them. Serena MCP may be used for deeper contextual cross-referencing of symbols, patterns, or file relationships when necessary.

## Required Memory Integration
Before reviewing, the assistant must retrieve memory using AgenticRag:
- search_nodes for past constraints, conventions, or decisions that affect this code  
- search_facts for relationships such as modules, flows, or warnings  
Memory is used only to enhance review accuracy and must not override new instructions.

## Rules
- No file edits.  
- No automatic code rewriting.  
- No implementing fixes.  
- No refactoring.  
- No triggering Serena for code generation or execution — only for cross-referencing and analysis.  
- No document generation.  
- No research unless the user explicitly requests external validation.  
- No storing memory unless the user approves.  

Review_code must remain strictly analytical.

## Output Format
- Summary of Findings  
- Issues Detected  
- Suggested Improvements  
- Optional Proposed Diff (non-applied, conceptual only)  
- “Would you like to proceed to implement_change or refactor_code?”  

All sections must be short, precise, and directly tied to the given code.

## SDLC Interconnection Rules
If the user approves the suggested fix:
- Move to `implement_change` for targeted diffs.  
If the user wants structural cleanup:
- Move to `refactor_code`.  
If the provided code context is incomplete:
- Move to `refine_prompt` or `clarify_request`.  
If the identified issues suggest deeper architecture concerns:
- Move to `plan_feature`.  
If the code relates to incorrect behavior:
- Move to `debugging_session`.  

Review_code must never skip directly to implementation on its own.

## Inline Example (No Break)
Here is an inline example: the assistant analyzes a login handler and identifies missing null checks and improper error propagation. It suggests adding validation, improving early returns, and fixing the branching logic. It then asks the user whether to proceed with implement_change or perform a broader refactor_code pass.

## Availability
This command is available in chat as `/review-code`.
