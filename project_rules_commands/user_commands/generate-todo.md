# generate-todo

### USER COMMAND: `generate_todo`

## Purpose
Convert an approved feature plan or user description into a clean, actionable to-do list. This command breaks work into simple or structured tasks depending on complexity. It prepares implementation steps without performing any coding or planning expansions.

## Behavior (Strict, SDLC-Aligned)
The assistant must read the user’s description or the approved plan and determine whether the feature is small or complex. For small tasks, the assistant must generate 3–6 simple, clear to-do items. For complex tasks, the assistant must generate 6–12 structured tasks that may include brief metadata such as estimates or dependencies. All output must remain minimal, readable, and non-technical unless explicitly required.

The assistant must never rewrite the plan, never add new scope, and never modify requirements. It simply translates the plan into execution tasks. No todo may exceed what was approved in plan_feature. After generating the task list, the assistant must ask for user approval before moving forward.

## Required Memory Integration
The assistant may use AgenticRag memory retrieval only if relevant:
- search_nodes for conventions, naming, or preferred task formats  
- search_facts for dependencies or previous patterns  

Memory is optional for this command and must not override the current plan or user intent. No memory is stored unless user approves.

## Rules
- No coding  
- No file modifications  
- No planning expansion  
- No documentation creation  
- No testing or debugging actions  
- No Serena usage  
- No research pipeline invocation  
- Tasks must remain aligned strictly with the approved plan  

Generate_todo is only a translation layer from plan → task list.

## Output Format
The assistant must output:

- Simple Task List (for small tasks)  
- Structured Task List (for complex tasks with minimal metadata)  
- Approval Prompt: “Do you approve this to-do list?”  

The output must be clean, continuous, and immediately actionable.

## SDLC Interconnection Rules
If the user approves the to-do list:
- Move to `implement_change` to begin generating diffs  

If the user rejects or modifies the to-do list:
- Regenerate the todo list  
- Or transition back to `plan_feature` if scope or plan changes  

If requirements change:
- Transition to `document_requirements`  

If scope changes:
- Transition to `scope_request`  

Generate_todo must never jump directly into coding or debugging.

## Inline Example (No Break)
For example: if the user wants to implement a profile update screen, the assistant generates a small set of tasks such as creating UI layout, adding fields, integrating APIs, and testing the flow, then asks for approval.

## Availability
This command is available in chat as `/generate-todo`.
