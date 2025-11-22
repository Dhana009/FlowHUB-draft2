# draft-document

### USER COMMAND: `draft_document`

## Purpose
Generate a clean, minimal draft of a requested document (PRD, Design Document, Test Strategy, API Document, Release Notes, or any other formal artifact). This draft provides a structured starting point using the user’s clarified request, scope, and requirements. Drafts remain intentionally short and lightweight unless the user explicitly approves a more detailed version.

## Behavior (Strict, SDLC-Aligned)
The assistant must first identify what document type the user wants based on context from refine_prompt, clarify_request, scope_request, and document_requirements. Before writing anything, the assistant must always ask:  
“Should I create a document for this?”

If the user says YES, the assistant must then ask:
- Preferred style (full, medium, short)  
- Target size (maximum number of lines)  

Only after receiving these answers may the assistant generate a draft.

The draft must be clean, minimal, and structured with sections such as Title, Overview, Problem Statement, Requirements Summary, Constraints, and Proposed Approach. It must not expand scope and must not introduce new requirements or architecture. The assistant must wait for user approval before generating a full document or writing to any file.

## Required Memory Integration
The assistant must use AgenticRag memory retrieval only to:
- search_nodes for prior document style preferences  
- search_facts for related components or terminology  

Memory is used to maintain consistency but must not override new instructions, expand scope, or guess missing requirements. No memory may be stored unless explicitly approved.

## Rules
- Do not generate final or long documents unless explicitly approved  
- Do not create or modify files  
- Do not perform planning, coding, debugging, or testing inside this command  
- No Serena or research pipeline usage here  
- Keep drafts minimal unless the user explicitly asks for detailed output  
- Follow user size and style constraints strictly  
Draft_document is strictly for producing initial drafts, not completing or approving them.

## Output Format
The assistant must output:
- A short, clean, Markdown-formatted draft document  
- A final prompt asking the user to approve the draft or request refinement  

The output must be continuous, readable, and professional.

## SDLC Interconnection Rules
If the user approves the document:
- PRD → transition to `plan_feature`  
- Design Document → transition to `plan_feature`  
- Test Strategy → transition to `define_test_expectations`  

If the user requests refinement:
- Transition to `refine_document`  

If the user changes scope:
- Transition to `scope_request`  

If requirements evolve:
- Transition to `document_requirements`  

Draft_document must never route directly to implementation, debugging, or testing.

## Inline Example (No Break)
For example: if the user asks for a PRD draft, the assistant first asks for permission, then asks for style and size, then produces a short PRD outline (Title, Overview, Problem, Requirements Summary, Constraints, Proposed Approach), and finally asks for approval.

## Availability
This command is available in chat as `/draft-document`.
