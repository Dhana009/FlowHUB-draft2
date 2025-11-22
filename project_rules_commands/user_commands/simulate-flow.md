# simulate-flow

### USER COMMAND: `simulate_flow`

## Purpose
Simulate the behavior of a feature, function, module, or system flow without executing real code. This is a controlled, logical dry-run that predicts behavior, identifies gaps, and validates flow correctness inside the SDLC before any implementation or debugging happens.

## Behavior (Strict, SDLC-Aligned)
The assistant must simulate behavior step-by-step based entirely on the described context. It must define the initial state, list inputs and conditions, walk through the system flow logically, identify expected transitions, surface unexpected branches, and detect logical gaps or inconsistencies. Output must remain clean, structured, and non-verbose.

## Required Memory Integration
Before simulating, the assistant must check memory using AgenticRag:
- search_nodes for past requirements, flows, or constraints  
- search_facts for relationships that shape behavior  
Memory is used only to enrich simulation accuracy and must not override new user intent.

## Rules
- No real execution  
- No running code  
- No modifying files  
- No code generation unless user explicitly asks  
- No implementing changes  
- No Serena invocation  
- No research unless the user requests it  
Simulation stays purely conceptual and deterministic.

## Output Format
- Initial State  
- Inputs and Conditions  
- Step-by-Step Flow Simulation  
- Expected Outputs or State Transitions  
- Logical Risks, Gaps, or Failure Points  
- Recommended Next Command Based on the Outcome

## Interconnection Rules
If simulation reveals:
- a flaw or failure → automatically transition to `debugging_session`  
- missing requirements → transition to `document_requirements`  
- architecture or structural gaps → transition to `plan_feature`  
- unclear expected behavior → transition to `define_test_expectations`  
- user intent to implement the simulated flow → transition to `generate_todo` → `implement_change`  
Simulation must not directly trigger coding or testing; it only routes to the proper next command.

## Inline Example (No Break)
Here is an inline example that stays within this document: if the user asks to simulate a checkout process, the assistant defines the user state, cart contents, inventory availability, payment conditions, and walks step-by-step through each transition. If a missing validation or contradictory branch appears, simulation points it out and recommends debugging_session or plan_feature without performing any execution.

## Availability
This command is available in chat as `/simulate-flow`.
