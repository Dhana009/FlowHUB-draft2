# plan-feature

### USER COMMAND: `plan_feature`

## Purpose
Create a clear, structured, research-backed feature plan before any coding, refactoring, debugging, or documentation begins. This command determines how the feature should be approached, identifies steps, clarifies constraints, and produces a simple, SDLC-ready plan and to-do list. It prevents premature coding and ensures actions are grounded in accurate knowledge.

## Behavior (Strict, SDLC-Aligned)
The assistant must identify the user’s goal, interpret what feature or system change is required, and run the mandatory research pipeline. Research must always begin with Cursor Search, followed by Context7 MCP. Brave MCP is only used when Context7 is insufficient, and Perplexity MCP is used only for complex or unclear architectural requirements.

After research, the assistant must summarize findings concisely, describe what the feature actually is, outline the core behavior, and create a short, clean, actionable plan. This plan must stay simple unless the feature is clearly complex. The assistant must also generate a minimal to-do list that will later be used by `generate_todo` and `implement_change`.

The assistant must stop after presenting the plan and ask for explicit approval before doing anything else.

## Required Memory Integration
The assistant must use AgenticRag memory retrieval:
- search_nodes for related preferences, past architectural decisions, or recurring patterns  
- search_facts for dependencies, relationships, or constraints relevant to this feature  
Memory is used to improve relevance and consistency, not to add new scope or override new user intent. No memory writes may occur automatically.

## Rules
- No coding  
- No implementation  
- No refactoring  
- No documentation generation  
- No debugging  
- No test execution  
- No Serena usage  
- No file creation or modification  
- Research pipeline must be followed exactly as defined in the Global Rules  
- Plan must remain simple unless complexity requires deeper detail  
- Must not proceed to next SDLC step without explicit approval  
Plan_feature focuses on planning only.

## Output Format
The assistant must output the following in one continuous section:

- Research Summary  
- Feature Understanding Summary  
- Simple Plan (short, ordered steps)  
- To-Do List (non-executable tasks)  
- Approval Prompt (“Do you approve?”)  

No code blocks, no noisy formatting, no section breaks.

## SDLC Interconnection Rules
After the user approves the plan:
- Move to `generate_todo` to break tasks down further  
- After todos are approved → move to `implement_change`  
If the user modifies feature goals:
- Return to `scope_request` or `document_requirements`  
If research reveals hidden architectural constraints:
- Ask user whether to expand the plan or redirect to `explain_flow`  
If debugging context is detected rather than feature creation:
- Redirect to `debugging_session`  

Plan_feature must never directly invoke implementation, debugging, testing, or documentation.

## Inline Example (No Break)
For example: if the user asks to implement a login page, the assistant summarizes research, identifies UI and backend requirements, creates a 5–7 step plan, generates a concise to-do list, and asks for approval. No code is produced and no steps are executed until the user explicitly approves.

## Availability
This command is available in chat as `/plan-feature`.
