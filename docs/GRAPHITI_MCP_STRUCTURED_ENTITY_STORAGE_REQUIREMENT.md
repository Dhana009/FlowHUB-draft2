# Graphiti MCP: Universal Structured Entity Storage Enhancement

**Date:** 2025-11-23  
**Status:** Feature Enhancement Request  
**Priority:** High - Enables structured knowledge graph creation across all use cases  
**Type:** Universal Enhancement (Not Project-Specific)  

---

## EXECUTIVE SUMMARY

Graphiti MCP server currently supports episode-based storage (`add_memory`) with automatic entity extraction from text, but lacks **direct APIs for creating structured entities and relationships** with explicit entity IDs, entity types, and relationship types. This limits its ability to store structured knowledge graphs for any domain (documents, code relationships, requirements, business rules, etc.).

**Current State:** Graphiti MCP `add_memory` tool creates episodes and automatically extracts entities from text, but:
- Cannot create typed entities with explicit `entity_id` and `entity_type`
- Cannot create explicit relationships with specific relationship types
- Entity extraction is automatic but not controllable

**Required State:** Ability to programmatically create structured entities and relationships for any use case, enabling:
- Document management systems
- Code relationship tracking
- Requirements traceability
- Business rule hierarchies
- Process workflows
- And any other structured knowledge graph use case

---

## 1. PROBLEM STATEMENT

### 1.1 Current Limitation

**What Graphiti MCP Currently Supports:**

1. **Episode Storage (`add_memory`):**
   - Stores text or JSON episodes
   - Automatically extracts entities from narrative text
   - Creates generic "Entity" nodes with labels
   - Automatically extracts relationships from text

2. **Automatic Entity Extraction:**
   - Uses LLM to extract entities from unstructured text
   - Creates nodes with labels based on extraction
   - No control over entity IDs or explicit entity types

**What's Missing:**

1. **Direct Entity Creation:**
   - Cannot create entities with explicit `entity_id` (business key)
   - Cannot specify explicit `entity_type` (e.g., "Document", "CodeModule", "Requirement")
   - Cannot set entity properties in a controlled way

2. **Direct Relationship Creation:**
   - Cannot create relationships between specific entities by ID
   - Cannot specify explicit relationship types (e.g., "DEPENDS_ON", "IMPLEMENTS", "REFERENCES")
   - Relationships are inferred from text, not explicitly defined

3. **Query Capabilities:**
   - `get_entities_by_type` returns empty for typed entities (works only for auto-extracted entities)
   - `get_entity_by_id` doesn't work with custom entity IDs
   - Cannot query relationships by type

### 1.2 Why This Matters (Universal Use Cases)

**Use Case 1: Document Management System**
- Need to store documents as typed entities: `Document`, `Section`, `Chapter`
- Need relationships: `Document` → `CONTAINS` → `Section` → `REFERENCES` → `Document`
- Cannot do this with automatic extraction alone

**Use Case 2: Code Relationship Tracking**
- Need to store code modules: `Module`, `Function`, `Class`, `Interface`
- Need relationships: `Module` → `DEPENDS_ON` → `Module`, `Class` → `IMPLEMENTS` → `Interface`
- Need explicit IDs: `module:auth`, `class:UserController`, `interface:IAuthentication`

**Use Case 3: Requirements Traceability**
- Need to store requirements: `FunctionalRequirement`, `NonFunctionalRequirement`, `Test`
- Need relationships: `FunctionalRequirement` → `SATISFIES` → `Test`, `Requirement` → `DEPENDS_ON` → `Requirement`
- Need traceability: Which tests satisfy which requirements?

**Use Case 4: Business Rule Management**
- Need to store rules: `BusinessRule`, `Policy`, `Constraint`, `Exception`
- Need relationships: `BusinessRule` → `APPLIES_TO` → `Process`, `Policy` → `OVERRIDES` → `BusinessRule`
- Need hierarchies: Rule layers, policy trees

**Use Case 5: Process Workflow Tracking**
- Need to store processes: `Process`, `Step`, `Decision`, `Action`
- Need relationships: `Process` → `CONTAINS` → `Step` → `FOLLOWS` → `Step`
- Need workflow queries: What's the sequence of steps?

**All these use cases require:**
- Explicit entity IDs (business keys, not UUIDs)
- Explicit entity types (domain-specific types)
- Explicit relationship types (domain-specific relationships)
- Query capabilities (by type, by ID, by relationship)

---

## 2. RESEARCH FINDINGS

### 2.1 Graphiti Python Library Capabilities

**From Context7 Documentation:**

Graphiti Python library (`graphiti_core`) **DOES support** direct entity/relationship creation via `add_triplet`:

```python
# Create source entity
source_node = EntityNode(
    name="Alice Johnson",
    labels=["Person"],
    summary="Senior software engineer",
    group_id="employees"
)

# Create target entity
target_node = EntityNode(
    name="Project Phoenix",
    labels=["Project"],
    summary="AI infrastructure project",
    group_id="employees"
)

# Create relationship
edge = EntityEdge(
    source_node_uuid=source_node.uuid,
    target_node_uuid=target_node.uuid,
    name="LEADS",
    fact="Alice Johnson leads Project Phoenix",
    group_id="employees"
)

# Add triplet
await graphiti.add_triplet(
    source_node=source_node,
    edge=edge,
    target_node=target_node
)
```

**Key Finding:** The Python library supports structured entity creation, but this capability is **not exposed via MCP server**.

### 2.2 Graphiti MCP Server Current Capabilities

**From Context7 Documentation:**

Graphiti MCP server supports:

1. **`add_memory` (Episode Storage):**
   - `source="text"` - Stores text episodes, auto-extracts entities
   - `source="json"` - Stores JSON episodes, auto-extracts entities
   - Both create episodes, not direct entities

2. **Query Tools:**
   - `search_nodes` - Semantic search for nodes
   - `search_facts` - Semantic search for relationships
   - `get_entities_by_type` - Gets entities by type (only works for auto-extracted)
   - `get_entity_by_id` - Gets entity by ID (only works for auto-extracted)

**Key Finding:** MCP server doesn't expose `add_triplet` or direct entity/relationship creation APIs.

### 2.3 JSON Format Issue

**What We Tested:**
```python
add_memory(
    name="Test",
    episode_body='{"entities": [...], "relationships": [...]}',
    source="json"
)
```

**Error Received:**
```
Error: Input should be a valid string [type=string_type, input_value={'entities': [...], input_type=dict]
```

**Research Finding:**
- JSON format requires proper escaping as string
- Even when properly escaped, it still extracts entities automatically
- No control over entity IDs or explicit entity types via JSON

**Conclusion:** JSON format exists but doesn't provide the structured control needed for explicit entity/relationship creation.

---

## 3. RECOMMENDED SOLUTION

### 3.1 Option 1: Expose Direct Entity/Relationship APIs (RECOMMENDED)

**Add MCP Tools to Mirror Python Library Capabilities:**

#### A. `add_entity` Tool

**Tool Name:** `mcp_graphiti-memory_add_entity`

**Purpose:** Create structured entities with explicit IDs and types for any domain.

**Parameters:**
```json
{
    "entity_id": string,          // Required: Business key (e.g., "doc:user-guide", "module:auth")
    "entity_type": string,        // Required: Type name (e.g., "Document", "Module", "Requirement")
    "name": string,               // Required: Display name
    "labels": array<string>,      // Optional: Neo4j labels (e.g., ["Document", "Entity"])
    "properties": object,         // Optional: Additional properties (file_path, version, etc.)
    "summary": string,            // Optional: Description/summary
    "group_id": string           // Optional: Group ID (default: "main")
}
```

**Returns:**
```json
{
    "message": "Entity created successfully",
    "entity_uuid": string,        // Graphiti's internal UUID
    "entity_id": string,          // The provided entity_id
    "entity_type": string,        // The provided entity_type
    "database_name": string,
    "provider": string
}
```

**Example Usage:**
```python
# Document management
add_entity(
    entity_id="doc:user-guide",
    entity_type="Document",
    name="User Guide",
    labels=["Document", "Entity"],
    properties={
        "file_path": "docs/user-guide.md",
        "version": "1.0",
        "category": "documentation"
    }
)

# Code module tracking
add_entity(
    entity_id="module:authentication",
    entity_type="CodeModule",
    name="Authentication Module",
    labels=["CodeModule", "Entity"],
    properties={
        "file_path": "src/modules/auth",
        "language": "typescript",
        "package": "@app/auth"
    }
)

# Requirements management
add_entity(
    entity_id="req:user-login",
    entity_type="FunctionalRequirement",
    name="User Login Requirement",
    labels=["Requirement", "FunctionalRequirement", "Entity"],
    properties={
        "requirement_id": "FR-001",
        "priority": "high",
        "status": "approved"
    }
)
```

#### B. `add_relationship` Tool

**Tool Name:** `mcp_graphiti-memory_add_relationship`

**Purpose:** Create structured relationships between entities for any domain.

**Parameters:**
```json
{
    "source_entity_id": string,   // Required: Source entity ID
    "target_entity_id": string,   // Required: Target entity ID
    "relationship_type": string,  // Required: Type (e.g., "DEPENDS_ON", "CONTAINS", "REFERENCES")
    "fact": string,               // Optional: Human-readable fact description
    "properties": object,         // Optional: Relationship properties
    "group_id": string            // Optional: Group ID (default: "main")
}
```

**Returns:**
```json
{
    "message": "Relationship created successfully",
    "relationship_uuid": string,  // Graphiti's internal UUID
    "source_entity_id": string,
    "target_entity_id": string,
    "relationship_type": string,
    "database_name": string,
    "provider": string
}
```

**Example Usage:**
```python
# Document hierarchy
add_relationship(
    source_entity_id="doc:user-guide",
    target_entity_id="doc:user-guide-chapter-1",
    relationship_type="CONTAINS",
    fact="User Guide contains Chapter 1"
)

# Code dependencies
add_relationship(
    source_entity_id="module:authentication",
    target_entity_id="module:user-management",
    relationship_type="DEPENDS_ON",
    fact="Authentication module depends on User Management module",
    properties={
        "dependency_type": "direct",
        "version": "1.0"
    }
)

# Requirements traceability
add_relationship(
    source_entity_id="test:login-test",
    target_entity_id="req:user-login",
    relationship_type="SATISFIES",
    fact="Login test satisfies user login requirement"
)

# Process workflow
add_relationship(
    source_entity_id="step:validate-credentials",
    target_entity_id="step:generate-session",
    relationship_type="FOLLOWS",
    fact="Generate session step follows validate credentials step"
)
```

#### C. Enhanced Query Tools

**Update existing tools to work with typed entities:**

1. **`get_entities_by_type`** - Should return entities created via `add_entity`
2. **`get_entity_by_id`** - Should query by `entity_id` property, not just UUID
3. **`get_entity_relationships`** - Should filter by `relationship_type`

**Example:**
```python
# Get all documents
get_entities_by_type(entity_type="Document")

# Get specific document by business ID
get_entity_by_id(entity_id="doc:user-guide")

# Get all DEPENDS_ON relationships for a module
get_entity_relationships(
    entity_id="module:authentication",
    relationship_types=["DEPENDS_ON"]
)
```

### 3.2 Option 2: Fix JSON Format for Structured Entity Creation (ALTERNATIVE)

**If direct APIs are not feasible, enhance JSON format:**

**Current Issue:**
- JSON string validation error
- No control over entity IDs/types

**Recommended Enhancement:**
Allow JSON format to specify structured entities explicitly:

```json
{
    "entities": [
        {
            "entity_id": "doc:user-guide",
            "entity_type": "Document",
            "name": "User Guide",
            "labels": ["Document", "Entity"],
            "properties": {
                "file_path": "docs/user-guide.md",
                "version": "1.0"
            }
        }
    ],
    "relationships": [
        {
            "source_entity_id": "doc:user-guide",
            "target_entity_id": "doc:user-guide-chapter-1",
            "relationship_type": "CONTAINS",
            "fact": "User Guide contains Chapter 1"
        }
    ]
}
```

**Required Changes:**
1. Fix JSON string parsing (accept properly escaped JSON)
2. When entities are specified in JSON, create them directly (don't auto-extract)
3. When relationships are specified, create them directly (don't auto-extract)
4. Store `entity_id` as a property for querying

### 3.3 Option 3: Hybrid Approach (BEST OF BOTH)

**Combine both approaches:**

1. **Keep `add_memory`** for episodes (backward compatibility, automatic extraction)
2. **Add `add_entity` and `add_relationship`** for direct structured creation (recommended)
3. **Enhance JSON format** as fallback option for batch imports

**This provides:**
- Direct control (best for structured data)
- Batch import capability (useful for migrations)
- Backward compatibility (existing workflows continue to work)

---

## 4. IMPLEMENTATION DETAILS

### 4.1 Entity Schema in Neo4j

**Node Structure:**
```cypher
(:Document:Entity {
    entity_id: "doc:user-guide",
    name: "User Guide",
    file_path: "docs/user-guide.md",
    version: "1.0",
    category: "documentation",
    created_at: "2025-11-23T10:00:00Z"
})
```

**Relationship Structure:**
```cypher
(doc:user-guide)-[:CONTAINS {
    fact: "User Guide contains Chapter 1",
    created_at: "2025-11-23T10:00:00Z"
}]->(doc:user-guide-chapter-1)
```

### 4.2 Entity ID and Type Naming Conventions

**Entity ID Format:** `{domain_prefix}:{unique_identifier}`

**Examples:**
- Documents: `doc:user-guide`, `doc:api-reference`
- Code Modules: `module:authentication`, `module:user-management`
- Requirements: `req:user-login`, `req:user-registration`
- Business Rules: `rule:authentication-policy`, `rule:data-privacy`
- Process Steps: `step:validate-credentials`, `step:generate-session`

**Entity Type Examples:**
- Document Types: `Document`, `Section`, `Chapter`, `Appendix`
- Code Types: `CodeModule`, `Function`, `Class`, `Interface`, `Package`
- Requirement Types: `FunctionalRequirement`, `NonFunctionalRequirement`, `BusinessRequirement`
- Rule Types: `BusinessRule`, `Policy`, `Constraint`, `Exception`
- Process Types: `Process`, `Workflow`, `Step`, `Decision`, `Action`

**Relationship Type Examples:**
- Document: `CONTAINS`, `REFERENCES`, `RELATED_TO`, `SUPERSEDES`
- Code: `DEPENDS_ON`, `IMPLEMENTS`, `EXTENDS`, `CALLS`, `IMPORTS`
- Requirements: `SATISFIES`, `CONFLICTS_WITH`, `DEPENDS_ON`, `REQUIRES`
- Rules: `APPLIES_TO`, `OVERRIDES`, `EXTENDS`, `CONFLICTS_WITH`
- Process: `FOLLOWS`, `CONTAINS`, `BRANCHES_TO`, `MERGES_WITH`

### 4.3 Implementation Steps

**Step 1: Database Schema**
- Create indexes on `entity_id` property for fast lookups
- Create indexes on `entity_type` property for type-based queries
- Create indexes on relationship types for relationship queries
- Ensure Neo4j supports custom labels and properties

**Step 2: MCP Server Updates**
- Add `add_entity` endpoint (mirrors Python `add_triplet` source node creation)
- Add `add_relationship` endpoint (mirrors Python `add_triplet` edge creation)
- Update `get_entities_by_type` to query by `entity_type` property
- Update `get_entity_by_id` to query by `entity_id` property
- Update `get_entity_relationships` to filter by `relationship_type`

**Step 3: Validation Logic**
- Validate `entity_id` format (recommend but don't enforce)
- Validate `entity_type` is not empty
- Validate `relationship_type` is not empty
- Check for duplicate `entity_id` (prevent duplicates)
- Validate source/target entities exist before creating relationship

**Step 4: Error Handling**
- Return clear error if `entity_id` already exists
- Return clear error if source/target entity doesn't exist
- Return clear error if required parameters are missing

---

## 5. BENEFITS (UNIVERSAL)

### 5.1 Immediate Benefits

1. **Structured Knowledge Graph Creation:**
   - Can store any structured data as typed entities
   - Can create explicit relationships between entities
   - Can query by entity type and relationship type

2. **Domain Flexibility:**
   - Works for documents, code, requirements, rules, processes, etc.
   - No domain-specific limitations
   - Can adapt to any structured data use case

3. **Query Capabilities:**
   - "What documents exist?" → Returns all Document entities
   - "What modules does authentication depend on?" → Returns dependencies
   - "What tests satisfy requirement FR-001?" → Returns traceability
   - "What's the process workflow sequence?" → Returns step sequence

### 5.2 Long-Term Benefits

1. **Scalability:**
   - Can handle thousands of entities and relationships
   - Can add new entity/relationship types without schema changes
   - Can build complex knowledge graphs for any domain

2. **Maintainability:**
   - Clear separation: structured data in Graphiti, narrative in VectorDB
   - Easy to query and update relationships
   - Easy to track dependencies and impacts

3. **Extensibility:**
   - Can add new entity types for any domain
   - Can add new relationship types dynamically
   - Can build complex queries for analysis

4. **Integration:**
   - Works with existing Graphiti features (episodes, search)
   - Compatible with Neo4j ecosystem
   - Can be used with any MCP-compatible client

---

## 6. USE CASE EXAMPLES

### 6.1 Document Management System

**Entities:**
- `Document`, `Section`, `Chapter`, `Appendix`, `Author`, `Topic`

**Relationships:**
- `Document` → `CONTAINS` → `Section`
- `Document` → `WRITTEN_BY` → `Author`
- `Section` → `REFERENCES` → `Document`
- `Document` → `RELATED_TO` → `Topic`

**Queries:**
- "What sections does the user guide contain?"
- "What documents did Alice write?"
- "What documents reference the API guide?"

### 6.2 Code Relationship Tracking

**Entities:**
- `CodeModule`, `Function`, `Class`, `Interface`, `Package`, `Test`

**Relationships:**
- `CodeModule` → `DEPENDS_ON` → `CodeModule`
- `Class` → `IMPLEMENTS` → `Interface`
- `Function` → `CALLS` → `Function`
- `Test` → `TESTS` → `Class`

**Queries:**
- "What modules does authentication depend on?"
- "What classes implement IAuthentication?"
- "What functions are called by authenticateUser?"

### 6.3 Requirements Traceability

**Entities:**
- `FunctionalRequirement`, `NonFunctionalRequirement`, `Test`, `Design`, `Implementation`

**Relationships:**
- `Test` → `SATISFIES` → `FunctionalRequirement`
- `Implementation` → `IMPLEMENTS` → `FunctionalRequirement`
- `FunctionalRequirement` → `DEPENDS_ON` → `FunctionalRequirement`

**Queries:**
- "What tests satisfy requirement FR-001?"
- "What requirements does implementation IMPL-001 implement?"
- "What requirements does FR-002 depend on?"

### 6.4 Business Rule Management

**Entities:**
- `BusinessRule`, `Policy`, `Constraint`, `Exception`, `Process`

**Relationships:**
- `BusinessRule` → `APPLIES_TO` → `Process`
- `Policy` → `OVERRIDES` → `BusinessRule`
- `BusinessRule` → `DEPENDS_ON` → `BusinessRule`
- `Exception` → `MODIFIES` → `BusinessRule`

**Queries:**
- "What rules apply to the authentication process?"
- "What policies override the data privacy rule?"
- "What exceptions modify the authentication policy?"

### 6.5 Process Workflow Tracking

**Entities:**
- `Process`, `Workflow`, `Step`, `Decision`, `Action`

**Relationships:**
- `Process` → `CONTAINS` → `Step`
- `Step` → `FOLLOWS` → `Step`
- `Decision` → `BRANCHES_TO` → `Step`
- `Action` → `TRIGGERS` → `Action`

**Queries:**
- "What's the sequence of steps in the login process?"
- "What steps follow validate credentials?"
- "What actions does generate session trigger?"

---

## 7. TESTING REQUIREMENTS

### 7.1 Unit Tests

1. **Entity Creation:**
   - Create entity with valid `entity_id`, `entity_type`, `name`
   - Verify entity is stored in Neo4j with correct labels and properties
   - Verify `get_entity_by_id` returns created entity
   - Verify `get_entities_by_type` returns created entity

2. **Relationship Creation:**
   - Create relationship with valid source, target, type
   - Verify relationship is stored in Neo4j with correct type and properties
   - Verify `get_entity_relationships` returns created relationship

3. **Error Handling:**
   - Attempt to create duplicate `entity_id` → Should return error
   - Attempt to create relationship with non-existent entity → Should return error
   - Attempt to use empty `entity_type` → Should return error
   - Attempt to use empty `relationship_type` → Should return error

### 7.2 Integration Tests

1. **Domain-Specific Tests:**
   - Create document management entities and relationships
   - Create code relationship entities and relationships
   - Create requirements traceability entities and relationships
   - Verify all entities and relationships are queryable

2. **Query Tests:**
   - Query entities by type → Should return all entities of that type
   - Query entity by ID → Should return specific entity
   - Query relationships by type → Should return all relationships of that type
   - Query entity relationships → Should return all relationships for entity

### 7.3 Performance Tests

1. **Bulk Operations:**
   - Create 100 entities → Should complete in < 10 seconds
   - Create 500 relationships → Should complete in < 30 seconds
   - Query entities by type → Should return results in < 1 second
   - Query relationships → Should return results in < 1 second

---

## 8. MIGRATION PATH

### 8.1 For Existing Data

**Current State:**
- Episodes stored in Graphiti (text/JSON)
- Auto-extracted entities (generic "Entity" nodes)
- Auto-extracted relationships (generic types)

**Migration Options:**

1. **Keep Existing Data:**
   - Existing episodes remain (backward compatibility)
   - New structured entities can coexist
   - Can link new entities to existing episodes if needed

2. **Extract from Existing Data:**
   - Parse existing episodes to extract structured entities
   - Create typed entities with explicit IDs
   - Create structured relationships
   - Old generic entities can remain or be cleared

### 8.2 For New Data

**Dual Storage Approach:**
1. Store narrative/episodes via `add_memory` (for semantic search)
2. Store structured entities via `add_entity` (for graph queries)
3. Link entities to source episodes if needed

**Example:**
```python
# Store narrative
add_memory(
    name="User Guide Document",
    episode_body="Full document content...",
    source="text"
)

# Store structured entity
add_entity(
    entity_id="doc:user-guide",
    entity_type="Document",
    name="User Guide",
    properties={"episode_name": "User Guide Document"}
)
```

---

## 9. COMPATIBILITY

### 9.1 Backward Compatibility

**Existing Functionality:**
- `add_memory` continues to work (episodes, auto-extraction)
- Existing query tools continue to work
- Existing data remains accessible

**New Functionality:**
- `add_entity` and `add_relationship` are additive
- Enhanced query tools work with both old and new entities
- Can query both auto-extracted and explicitly created entities

### 9.2 Integration with Existing Features

**Works With:**
- Existing episode storage (`add_memory`)
- Existing search capabilities (`search_nodes`, `search_facts`)
- Existing Neo4j backend
- Existing MCP protocol

**Does Not Break:**
- Existing workflows
- Existing data
- Existing query patterns

---

## 10. CONCLUSION

**Summary:**
Graphiti MCP server needs direct APIs for creating structured entities and relationships to support any structured knowledge graph use case (documents, code, requirements, rules, processes, etc.).

**Recommended Solution:**
Add `add_entity` and `add_relationship` MCP tools that mirror the Python library's `add_triplet` capability, enabling programmatic creation of typed entities with explicit IDs and structured relationships.

**Benefits:**
- Universal applicability (any domain, any use case)
- Enables structured knowledge graph creation
- Allows explicit control over entity IDs and types
- Supports complex relationship queries
- Maintains backward compatibility

**Next Steps:**
1. Implement `add_entity` and `add_relationship` MCP tools
2. Enhance query tools to work with typed entities
3. Test with multiple use cases (documents, code, requirements, etc.)
4. Update documentation with examples for different domains

---

**Document End**
