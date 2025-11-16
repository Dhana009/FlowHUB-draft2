# System Design Document
**Stage 3: System Design & Non-Functional Requirements**

This document defines HOW to build the system, including:
- **Architecture**: System structure, components, and interactions
- **Non-Functional Requirements**: Performance, scalability, security, reliability, maintainability
- **Infrastructure**: Deployment strategy, constraints, resource management
- **Technical Stack**: Technologies, frameworks, and tools

## High-Level Architecture

- Frontend: Three React variants mounted at `/v1`, `/v2`, `/v3`
- Backend: Node.js + Express REST APIs secured via JWT (access + refresh)
- Database: MongoDB with Mongoose models
- Testing: Python Playwright for E2E, Python Requests for API black-box tests

## Frontend Design (3 Versions)

- Version 1 — Enterprise UI: Bootstrap components, production layouts, predictable interactions
- Version 2 — Startup UI: Tailwind + Headless UI, lightweight, fast, minimal patterns
- Version 3 — Experimental UI: Custom CSS; may use iframes, shadow DOM, autosuggestions, irregular layouts; intentionally complex to test resilience

All variants expose identical accessibility semantics and follow identical flows.

## Backend / Service / API Design

- Auth: `/api/v1/auth` (login, signup, refresh)
- Overview: `/api/v1/overview`
- Tasks: `/api/v1/tasks` CRUD
- Files: `/api/v1/files` (presigned URLs, uploads)
- Comments: `/api/v1/comments`
- Approvals: `/api/v1/approvals`
- Notifications: `/api/v1/notifications`
- Users/Settings: `/api/v1/users`, `/api/v1/settings`
- System/Audit: `/api/v1/system`, `/api/v1/audit`
- Analytics: `/api/v1/analytics`

## Infrastructure Approach

- Monorepo with variant-specific bundles
- CI with gates for contract validation and tests
- CSP, rate limiting, audit logging, health endpoints
- **MongoDB Free-Tier Constraint**: 512MB storage limit requires careful data management
- **Artifact Storage**: S3 for binary files (screenshots, logs), MongoDB for metadata only
- **Data Lifecycle**: TTL indexes and archival jobs to prevent unbounded growth

## State Management Strategy

- Frontend: React Query + Context for auth/session; variant-specific UI state
- Backend: Controller → Service → Repository (Mongoose) pattern

## Semantics and Accessibility Role

- Accessibility tree is the interface: role, accessible name, and state must be consistent across variants
- Keyboard navigation and focus management are mandatory

## Testability Enforcement in Every Layer

- Frontend components built with deterministic props/state and clear roles/names
- Backend modules expose pure functions where possible; error paths covered
- Contracts and `data-testid` used sparingly and predictably

## Layer Interactions

- Frontend calls REST APIs with JWT; no direct DB access
- Backend validates tokens, applies business rules, persists with MongoDB
- Tests target behavior and contracts, not DOM structure

## Project Constraints & Resource Management

### MongoDB Free-Tier Limitations (512MB)
- **No Binary Storage**: Screenshots, large logs, HAR files stored in S3 only
- **Metadata Only**: MongoDB stores URLs, hashes, summaries, not file contents
- **TTL Indexes**: Automatic expiration for runs collection (30 days default)
- **Limited Indexes**: Only essential fields indexed to minimize storage
- **Capped Collections**: High-volume logs use capped collections or external stores

### Storage Strategy
- **S3 for Artifacts**: Screenshots, HAR files, verbose logs stored in S3
- **MongoDB for Metadata**: File URLs, DOM signatures, selector hashes, test results
- **Archive Jobs**: Scheduled export of old run documents to S3, then deletion from Mongo
- **Pre-aggregation**: Analytics rely on pre-computed metrics, not full collection scans

### CI/CD Constraints
- **No Load Balancers**: Single instance deployments to minimize infrastructure costs
- **GitHub Actions**: Primary CI for PR gating (free tier for public repos)
- **Local Jenkins**: Optional for heavy jobs, but PR validation stays on GitHub Actions
- **Self-hosted Runner**: Optional for specific browser/network requirements

### Required Environment Variables
- `MONGO_URI`: MongoDB connection string
- `JWT_SECRET`, `JWT_REFRESH_SECRET`: Authentication tokens
- `FRONTEND_URL`, `BACKEND_URL`: Deployment URLs for E2E tests
- `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `S3_BUCKET`: Artifact storage
- `CI_SELF_HOSTED_RUNNER`: Flag for self-hosted runner usage