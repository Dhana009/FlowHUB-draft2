# explain-flow

### USER COMMAND: `explain_flow`

## Purpose
Provide a clear, human-friendly explanation of how a feature, module, API, or piece of code works. This command is used to build understanding before planning, debugging, or coding begins. The explanation must remain simple, sequential, and technically accurate without generating new logic or modifying any scope.

## Behavior (Strict, SDLC-Aligned)
The assistant must read the provided code, module, or feature description—or infer the target flow from the active context—and produce a clean explanation. The explanation must describe inputs, outputs, transitions, decisions, dependencies, and any internal interactions. The assistant must highlight complexity only for understanding, not to introduce architectural or planning decisions.

The assistant must keep the explanation clear, linear, and step-by-step. It may also point out where the flow interacts with other modules, external services, or data layers. It may identify potential bottlenecks or points of failure but cannot propose fixes unless the user asks.

## Required Memory Integration
Before giving the explanation, the assistant must use AgenticRag memory retrieval to:
- search_nodes for relevant architecture notes or definitions  
- search_facts for module relationships or prior flow descriptions  
Memory is used to improve accuracy and continuity but must not override the user’s meaning. No memory writes occur unless explicitly approved.

## Rules
- No code generation  
- No code modification  
- No planning  
- No debugging  
- No research pipeline unless user requests deeper understanding  
- No Serena usage  
- No shifting scope or introducing new requirements  
Explain_flow is purely informational and must not trigger any SDLC action on its own.

## Output Format
The assistant must output:
- Step-by-step flow explanation  
- Key components involved  
- Inputs and outputs (if relevant)  
- External dependencies or calls  
- Potential risks, edge cases, or complexity points  
- Optional note about next relevant command (e.g., simulate_flow, debugging_session)  

The output must be continuous, readable, and structured without code blocks unless required for clarity.

## SDLC Interconnection Rules
If the user wants deeper understanding:
- Transition to `simulate_flow` for step-by-step logical execution  

If the explanation reveals conceptual or design gaps:
- Transition to `plan_feature`  

If the explanation exposes suspicious or incorrect logic:
- Transition to `debugging_session`  

If the user says the explanation feels unclear:
- Transition to `clarify_request`  

Explain_flow must never enter coding, planning, or debugging on its own.

## Inline Example (No Break)
For example: if the user asks about the login flow, the assistant explains how inputs move through validation, authentication calls, response handling, error states, and UI transitions. The assistant highlights failure points or branching logic clearly without modifying or proposing changes.

## Availability
This command is available in chat as `/explain-flow`.
