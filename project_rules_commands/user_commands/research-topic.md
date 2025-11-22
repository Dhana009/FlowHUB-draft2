# research_topic

### USER COMMAND: `research_topic`

## Purpose
Perform structured, autonomous research using a phase-aware pipeline that adapts intelligently to the SDLC context. This command gathers authoritative information from Cursor Search, Context7, Brave, and Perplexity—using escalation rules that differ between planning/design vs. debugging/testing phases.

The goal is to obtain accurate, concise, non-hallucinatory answers that support the next SDLC step without generating code, planning, or documents unless explicitly requested.

## Mode Detection (Automatic)
The assistant must automatically detect the mode before research begins:

- If invoked inside debugging_session or inside test_cycle with repeated failures → Debug Mode  
- Otherwise → Normal Mode  

Mode detection must be silent and automatic. No user confirmation required.

## Normal Mode (Strict and Cost-Efficient)
Use this sequence only in planning, design, documentation, analysis, or general inquiry phases. Escalate only when needed.

1. Cursor Search  
2. Context7 MCP  
3. Brave Search MCP  
4. Perplexity MCP (final fallback only)

Never start with Perplexity in Normal Mode.  
Never escalate prematurely.  
Each stage must be evaluated for sufficiency before continuing.

## Debug Mode (Aggressive Deep Reasoning)
Used only when debugging_session or test_cycle indicates repeated failures, unclear causes, or contradictory information.

1. Cursor Search  
2. Context7 MCP  
3. Immediate Perplexity MCP when:  
   - errors repeat  
   - prior fixes fail  
   - root cause unclear  
   - Cursor/Context7 results insufficient  
4. Brave Search MCP (optional, only if Perplexity lacks concrete detail)

Perplexity must be used early in Debug Mode to minimize repeated cycles.

## Required Memory Integration
Before and after research, the assistant must use AgenticRag to:

- search_nodes for past facts, requirements, or preferences  
- search_facts for related relationships or observed patterns  

Memory may only assist interpretation, not override new user intent.  
Memory writes must never occur automatically.  
The assistant must ask: “Should I store these findings in memory?”

## Hard Rules
- Never begin with Perplexity in Normal Mode.  
- Perplexity must be used early in Debug Mode when models show struggle.  
- Never ask the user for permission for escalation within the research pipeline.  
- Always evaluate whether the current research stage is sufficient.  
- Never hallucinate when MCP-derived data is available.  
- Never generate code, diffs, plans, or documents in this command.  
- No Serena usage—Serena is for coding and refactoring, not research.  
- No file edits.  
- No document creation unless explicitly approved.

## Output Format
The assistant must output the following structure:

- Research Summary  
- Key Insights  
- Sources Used (Cursor, Context7, Brave, Perplexity)  
- Mode Used (Normal or Debug)  
- Escalation Path (the exact sequence of calls made)  
- Confidence Score  

All output must be concise, factual, and grounded in retrieved MCP data.

## SDLC Interconnection Rules
After producing research results:

- If research supports planning → transition to plan_feature  
- If research clarifies ambiguity → transition to clarify_request  
- If research supports debugging → return to debugging_session  
- If research is intended for documentation → ask user whether to generate draft_document  
- If the user asks to store results → use add_memory  

This command must never route directly to implementation, refactoring, or testing.

## Inline Example (No Break)
For example: when researching WebSockets reconnection logic during debugging_session, the assistant enters Debug Mode, performs Cursor Search, Context7 lookup, then immediately uses Perplexity to uncover edge-case reconnection failures. It summarizes key insights, lists sources, reports the Debug Mode escalation path, and returns control to debugging_session.

## Availability
This command is available in chat as `/research_topic`.
