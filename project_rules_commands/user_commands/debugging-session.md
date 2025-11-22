# debugging-session

### USER COMMAND: `debugging_session`

## Purpose
Perform a layered, context-aware debugging investigation to identify the root cause of a failure, summarize the findings, generate alternative hypotheses, and propose minimal, safe mitigations. The output must be concise, evidence-backed, and must not include code, diffs, or large logs unless the user explicitly requests them. Debugging_session focuses solely on reasoning and diagnosis, not implementation.

## Behavior (Strict, SDLC-Aligned)
The assistant must confirm debugging intent and request missing artifacts such as error messages, stack traces, logs, test names, or CI job IDs. Once the required information is present, the assistant must begin a structured debugging flow.

The assistant must run the lookup pipeline in order:
1. Cursor Search for recent diffs, PRs, or related issues  
2. AgenticRag memory lookup for prior patterns  
3. Context7 MCP for configuration, APIs, framework behaviors, or known pitfalls  
4. Brave MCP only when additional context is needed  
5. Perplexity MCP only when synthesis is required and the user approves  
If any required MCP tool is unavailable, the assistant must report the missing tool and stop.

Serena MCP may be used for source-level mapping or stack frame resolution. Serena output must always be summarized; raw frames or raw data must not be shown unless explicitly requested.

The assistant must identify one primary root cause and up to two alternative hypotheses. For each, it must present a title, type, evidence summary, confidence level, minimal mitigation, recommended tests, and relevant preventive best practices. No code or diffs should be shown unless the user asks for them.

Debugging_session must not modify any files, tests, or code. It may provide pseudo-diffs only when a fix preview is explicitly requested.

## Required Memory Integration
The assistant must use AgenticRag to:
- search_nodes for prior similar failures, regression patterns, or relevant preferences  
- search_facts for relationships between modules, configs, or previous issues  

Memory hits must be included in the summary. Memory writes must never happen automatically. If the user approves saving a regression pattern, the assistant may write a compact data entry summarizing signature, root cause, fix summary, and tests passed.

## Rules
- No code output unless requested  
- No file changes  
- No implementation  
- No test execution inside debugging_session  
- No automatic research escalation beyond the defined lookup pipeline  
- No raw Serena frames unless user explicitly asks  
- No planning or architecture generation  
Debugging_session must remain diagnostic-only.

## Output Format
The assistant must output the following sections:

local_context_summary — 1–2 lines highlighting the relevant impact  
primary_root_cause — with fields:  
- title  
- type  
- why (1–2 line evidence summary)  
- confidence (high / medium / low)  
- minimal_mitigation  
- tests_to_run  
- preventive_best_practices  
alternative_hypotheses — up to two, same structure  
memory_hits — IDs or summaries retrieved from AgenticRag  
context7_citations — any Context7 references  
recommended_action_options — A/B/C/D list for next steps  
approval_prompt — explicit next-action request  

The output must always remain concise and continuous.

## SDLC Interconnection Rules
If the user selects an action option:
- If the user chooses to run tests → transition to `test_cycle`  
- If the user asks to preview the fix → provide pseudo-diff (non-applied)  
- If the user wants to apply the fix → transition to `implement_change`  
- If the user requests further investigation → escalate research_topic  
- If the user asks to store the pattern → write to AgenticRag  

If debugging reveals unclear intent:
- Transition back to `clarify_request`  

If debugging reveals missing requirements or scope gaps:
- Transition to `document_requirements` or `scope_request`  

Debugging_session must never automatically apply fixes, modify code, or trigger test runs without explicit user approval.

## Inline Example (No Break)
For example: if a component crashes on initial render, the assistant summarizes that recent diffs touched user-loading logic, identifies an undefined access as the primary cause, proposes a minimal guard-based mitigation, lists the relevant test to validate, includes memory hits of similar past failures, and offers action options without showing any code unless explicitly requested.

## Availability
This command is available in chat as `/debugging-session`.
