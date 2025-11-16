# Software Development Life Cycle (SDLC) - Flow 1

## Stage Overview

This folder follows the standard SDLC progression from business needs to technical design.

### Stage 0: Business Requirements
**Purpose**: Define WHY we're building this - business problems, objectives, value proposition
**Document**: BRD.md (Business Requirements Document)
**Focus**: Business goals, target users, success metrics, constraints

### Stage 1: Product Requirements  
**Purpose**: Define WHAT we're building - features, user stories, acceptance criteria
**Document**: PRD.md (Product Requirements Document)
**Focus**: User personas, user stories, major flows, UI expectations, accessibility

### Stage 2: Functional Requirements
**Purpose**: Define HOW features work - detailed technical specifications
**Document**: FRD.md (Functional Requirements Document)
**Focus**: System behavior, API specifications, data models, functional capabilities

### Stage 3: System Design
**Purpose**: Define HOW to build it - architecture, infrastructure, non-functional requirements
**Document**: system-design.md
**Focus**: 
- **Architecture**: Frontend/backend design, API structure, data flow
- **Non-Functional Requirements**: Performance, scalability, security, reliability, maintainability
- **Infrastructure**: Deployment, constraints, resource management
- **Technical Stack**: Technologies, frameworks, tools

**Note**: System Design includes both functional architecture AND non-functional requirements (performance, security, scalability, etc.)

## Supporting Documents

- **Clarifications.md**: Addresses ambiguities and provides detailed explanations
- **Finalized_Requirements.md**: Consolidated approved requirements from all stages

## Flow Structure

```
flow-1/
  version-1/
    - Stage 0: Business Requirements
    - Stage 1: Product Requirements  
    - Stage 2: Functional Requirements
    - Stage 3: System Design
    - Supporting Documents
```

## Document Flow

```
Business Needs → Product Features → Functional Specs → System Design
     (BRD)           (PRD)            (FRD)         (System Design)
```

