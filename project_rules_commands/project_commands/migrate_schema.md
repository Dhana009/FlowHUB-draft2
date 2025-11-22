---
alwaysApply: true
---
---
description: Project Command – Migrate Database Schema Safely
alwaysApply: true
---

# PROJECT COMMAND: migrate_schema
## (Safe Orchestrator for Database Schema Changes and Migrations)

### Purpose
Safely design, plan, and implement **database schema changes** for this project, including:

- new tables/collections  
- new fields  
- field type changes  
- constraints/index changes  
- relationships  
- soft-deletes  
- performance-oriented schema changes  

This command **does not** directly write DB code by itself.  
It orchestrates the correct sequence of user commands + tools to guarantee safety.

---

# Behavior (Step-by-Step, Non-Destructive Flow)

### 1. Refine + Clarify Schema Intent
Call:
- `refine_prompt`
- `clarify_request`

Clarify:
- which entity/entities are affected  
- what is changing (add, remove, modify)  
- why change is needed  
- backward compatibility requirements  
- performance vs functional motivation  
- any versioning constraints  
- data migration needs (existing data)  

---

### 2. Scope the Migration
Call:
- `scope_request`
- `document_requirements`

Define clearly:
- in-scope schema changes  
- out-of-scope changes  
- affected APIs  
- affected services/repositories  
- affected tests  
- allowed downtime (if any)  
- rollout strategy (big bang vs phased)  

---

### 3. Research Pipeline (Schema-Focused)
Run:
1. Cursor Search  
2. Context7 (ORM/DB library docs, schema evolution guides)  
3. Brave (if patterns unclear)  
4. Perplexity (only for complex evolution strategies)

Research must consider:
- backward compatibility  
- migration frameworks used (Prisma, TypeORM, Mongoose, etc.)  
- indexing strategies  
- partitioning/sharding (if any)  
- best practices for migrating live data  

---

### 4. Migration Planning Phase
Call:
- `plan_feature`

Plan must include:
- current schema → target schema diff  
- new/updated models  
- fields added/removed/changed  
- index changes  
- constraints changes  
- relations changes  
- data migration steps (transformations, backfills)  
- validation changes  
- impact on APIs/services/repositories  
- required test changes  
- rollback plan  

No code yet.

---

### 5. Migration To-Do List
Call:
- `generate_todo`

Tasks must explicitly include:
- update model(s)  
- update schema(s)  
- create migration file(s)  
- add/update indexes  
- write data migration logic (if needed)  
- add/update tests  
- update API contracts if necessary  
- run tests in isolated environment  
- add monitoring for rollout  

---

### 6. STOP — Wait for Explicit Approval
Ask the user:

**“Do you approve this schema migration plan?”**

⚠ No migration code or DB changes are generated before approval.

---

# Implementation Phase (After Approval)

### 7. Generate Migration Code via Serena MCP
Use **Serena MCP** (mandatory) to:

- update model files  
- update schema definitions  
- create migration files  
- add index definitions  
- update repository code if needed  
- add validation updates  
- update or create tests  

Rules:
- no direct inline queries bypassing repository layer  
- repository/DB logic must follow backend rules  
- migrations must be reversible  
- migration naming must follow project conventions  
- no destructive data changes without explicit marking  

---

### 8. Testing the Migration
Call:
- `test_cycle`

Tests must verify:
- migrations apply cleanly in test DB  
- rollback path functions correctly  
- model/DB interactions still work  
- API behavior still correct  
- performance not degraded (or improved, if expected)  

If tests fail → route to:
- `debugging_session`

---

### 9. Rollout and Monitoring Plan
This command must orchestrate a **logical rollout plan** (even if only conceptual in dev):

- pre-migration backups  
- migration on staging  
- migration on production (conceptually)  
- post-migration verification queries  
- monitoring of DB metrics (latency, errors, timeouts)  

If user asks, generate a short migration runbook via `draft_document`.

---

# Hard Rules (Cannot Be Violated)

- Must never apply breaking schema changes without planning.  
- Must never drop data/columns silently.  
- Must never change primary keys without explicit callout.  
- Must never run destructive operations without rollback.  
- Must follow backend folder structure for models/schemas/migrations.  
- Must keep DB access behind repository layer.  
- Must keep API contracts in sync with schema.  
- Must always use Serena MCP for code & migrations.  
- Must always run `test_cycle` after generating migrations.  
- Must not proceed without explicit user `APPROVED:` style confirmation.  

---

# Output Format

This command’s visible output must include:

- refined schema change description  
- in-scope/out-of-scope changes  
- current schema summary (from memory & code)  
- target schema summary  
- migration strategy (one-shot / phased / backward compatible)  
- risk analysis (high/medium/low)  
- explicit list of impacted modules (APIs/services/repos/tests)  
- to-do list for migration  
- explicit approval question  

---

# Interconnection Rules

After approval:

- Call Serena MCP to:
  - update models/schemas  
  - generate migration files  
  - update repositories  

- Call `create_backend_module`  
  if schema introduces a new entity with APIs.

- Call `create_test_suite`  
  to ensure all affected areas are tested.

- Call `review_project_state` (optional)  
  to ensure consistency after big migrations.

If something is unclear at any step:
- go back to `clarify_request` or `plan_feature`.

If tests fail:
- `debugging_session`.

---

# MCP Tool Usage

### Serena MCP (Mandatory)
- model/schema updates  
- migration file generation  
- repository alignment  

### Context7
- ORM/DB docs  
- migration API usage  
- DB best practices  

### AgenticRag
Retrieve:
- previous migrations  
- schema evolution patterns  
- performance issues tied to schema  
- debugging patterns from past DB incidents  

Store:
- schema evolution graph  
- entity → migration history  
- known migration pitfalls  

---

# Memory Storage Rules

### Graffiti  
Store:
- entity → fields mapping  
- entity → indexes mapping  
- entity → relationships  
- entity → migration history  
- versioned schema rules  

### VectorDB  
Store:
- migration examples  
- common schema change patterns  
- migration runbooks  
- debugging + rollback experience  

---

# Stop Conditions

Stop immediately if:
- migration would break existing APIs without versioning  
- migration would cause data loss without backup plan  
- migration plan lacks rollback  
- tests are not defined  
- performance impact is not assessed  
- folder/architecture rules violated  
- user has not explicitly approved  

---

# END OF COMMAND
