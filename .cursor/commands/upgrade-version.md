---
alwaysApply: true
---

---

# Output Format (Deterministic & Clean)

The command outputs:

- `upgrade_summary`
- `scope_summary`
- `existing_structure`
- `selector_map`
- `semantic_map`
- `accessibility_map`
- `behavior_map`
- `styling_map`
- `parity_gaps`
- `migration_blueprint`
- `risk_assessment`
- `next_steps`
- `approval_prompt`

---

# Interconnection Rules

This command can ONLY call the following:

### For planning:
- `scope_request`
- `document_requirements`
- `plan_feature`

### For implementation:
- `create_frontend_module`
- `create_ui_page`
- `create_test_suite`

### For validation:
- `review_project_state`

### For debugging:
- `debugging_session`

### For storage (only if user approves):
- write patterns to Graffiti  
- write examples to VectorDB  

---

# MCP Usage

### Serena MCP  
Used ONLY AFTER user approves code generation.

### Context7 MCP  
Used for:
- documentation  
- styling system references  
- API references  

### AgenticRag  
Used for:
- structural memory  
- selector memory  
- version → component mappings  
- example migrations  

### Brave/Perplexity  
Only if deep external research is required.

---

# Stop Conditions

Stop immediately if:
- asked to generate code inside this command  
- asked to write tests inside this command  
- asked to store memory without approval  
- asked to bypass parity checks  
- asked to mix styling systems  

Redirect accordingly.

---

# END OF COMMAND
