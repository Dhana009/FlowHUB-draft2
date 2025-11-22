# refine-document

### USER COMMAND: `refine_document`

## Purpose
Refine, improve, and polish an existing document (user-provided or previously drafted) by enhancing clarity, structure, and readability without altering meaning, scope, or intent. This command ensures documents become cleaner, clearer, and easier to understand while staying faithful to the original content.

## Behavior (Strict, SDLC-Aligned)
The assistant must read the provided draft or document and reorganize sections logically, improve clarity, simplify or tighten language, and enhance formatting without changing meaning. The assistant must preserve the author’s intent, boundaries, and assumptions. If any structural expansion may be helpful, the assistant must ask the user before adding anything. It must ask for permissions before writing any document output.

Before generating or refining content, the assistant must explicitly ask:
“Should I create or refine the document for this?”

If the user approves, the assistant must immediately ask:
- Preferred detail level (full, medium, short)  
- Target maximum size (number of lines)  
The assistant must abide by these constraints with no exceptions.

## Required Memory Integration
Before refining, the assistant must check memory using AgenticRag:
- search_nodes for preferences about document style  
- search_facts for relevant formatting or context details  
Memory is used only to shape formatting preferences, not to alter meaning or add content. No memory writes may occur unless the user approves.

## Rules
- No adding new content unless the user requests expansion  
- No planning, coding, debugging, or testing  
- No generating new documents unless explicitly allowed  
- No altering scope or requirements  
- No file creation or committing without approval  
- No Serena usage—refine_document is purely editorial  
- No research unless user asks for factual improvements  

Refine_document must remain purely transformational, not generative.

## Output Format
The assistant outputs a refined version of the document in clean, well-structured Markdown, following:
- Improved sectioning  
- Better clarity  
- Cleaner formatting  
- Fully preserved meaning  
- Adherence to user-selected style and size  

At the end, the assistant must ask whether the user wants to:
- Approve the refinement  
- Refine again  
- Expand or shorten the document  

## SDLC Interconnection Rules
If the user approves the refined document:
- If it is a PRD, Architecture Doc, or Design Doc → transition to `plan_feature`  
- If it is a Test Strategy or Test Document → transition to `define_test_expectations`  
If requirements change during refinement:
- Transition to `document_requirements`  
If scope changes or broadens:
- Transition to `scope_request`  
Refine_document must never directly trigger implementation, refactoring, debugging, or test execution.

## Inline Example (No Break)
For example: if the user gives a rough test strategy draft, the assistant refines the language, restructures headings, clarifies test categories, preserves all meaning, applies the chosen style level, keeps within the size limit, and then asks whether to approve or further refine the document.

## Availability
This command is available in chat as `/refine-document`.
