# FlowHub - 18 Flows Overview

## What is a Flow?

A flow is a complete user journey - the step-by-step path a user takes to accomplish a task.

**Example:** Login Flow = User enters email/password → clicks submit → gets authenticated → redirected to dashboard

## How Flows Help FlowHub

FlowHub proves that the **same automated test** can work across 3 different UI designs (Bootstrap, Tailwind, Custom CSS) if flows have identical accessibility semantics (roles, names, states).

## The 18 Flows

1. **User Login & Signup** - User logs in or creates account
2. **Registration & Email Verification** - User verifies email after signup
3. **Role & Permission** - Admin manages user roles and permissions
4. **Task Flow** - Create, view, edit, delete tasks
5. **Kanban Board** - Visual workflow (To-Do → Doing → Done)
6. **Comment & Activity Feed** - Add comments and see activity
7. **File Upload & Preview** - Upload files and preview them
8. **Media Gallery** - Browse files in gallery view
9. **Advanced Search & Filter** - Find tasks using filters and search
10. **Dynamic Table & Inline Edit** - View tasks in table, edit inline
11. **Approval Workflow** - Submit and approve requests
12. **Form Builder / Multi-Step Wizard** - Create multi-step forms
13. **Analytics Dashboard** - View KPIs, charts, and insights
14. **Report Download** - Generate and download reports
15. **Notifications** - In-app and email notifications
16. **Chat Simulation** - Real-time messaging
17. **Drag-Resize-Sort Grid** - Drag and drop tasks in Kanban
18. **Theme & Layout Switcher** - Switch between UI themes

## What Each Flow Accomplishes

1. **User Login & Signup** - User enters credentials to access the system or creates a new account
2. **Registration & Email Verification** - User confirms their email address to activate their account
3. **Role & Permission** - Admin assigns roles (user, admin) and controls what users can do
4. **Task Flow** - User creates tasks, views them, updates details, and removes completed ones
5. **Kanban Board** - User moves tasks through stages (New → In Progress → Done) visually
6. **Comment & Activity Feed** - User adds comments on tasks and sees what others are doing
7. **File Upload & Preview** - User attaches files to tasks and views them without downloading
8. **Media Gallery** - User browses all uploaded files in a visual gallery
9. **Advanced Search & Filter** - User finds specific tasks by searching or applying filters
10. **Dynamic Table & Inline Edit** - User views tasks in a table and edits them directly in the table
11. **Approval Workflow** - User submits requests (like leave requests) and approvers approve or reject them
12. **Form Builder / Multi-Step Wizard** - User fills out complex forms step-by-step
13. **Analytics Dashboard** - User sees key metrics, charts, and insights about their work
14. **Report Download** - User generates reports and downloads them as files
15. **Notifications** - User receives alerts about important events (new comments, approvals, etc.)
16. **Chat Simulation** - User sends and receives real-time messages with team members
17. **Drag-Resize-Sort Grid** - User reorganizes tasks by dragging and dropping them
18. **Theme & Layout Switcher** - User switches between different visual themes (light/dark, layouts)

## How Flows Connect

Flows are not random - they work together to create complete user experiences. Users typically use multiple flows in sequence to accomplish their goals.

**Example:** A user might Login → Create Task → Upload File → Add Comment → Search for Task → View in Kanban → Download Report

**Key Interconnections:**
- Authentication flows (1-3) enable all other flows
- Task flows (4-5, 9-10, 17) work together for task management
- File flows (7-8) support tasks and comments
- Communication flows (6, 15-16) connect users around tasks
- Dashboard flows (13-14) aggregate data from all other flows

## User Flow Scenarios

These scenarios show how flows interconnect and help identify business requirements:

### Scenario 1: New User Onboarding
**User:** New team member  
**Flows Used:** 1 (Login/Signup) → 2 (Email Verification) → 4 (View Tasks) → 13 (Dashboard)  
**What Happens:** User creates account, verifies email, logs in, sees dashboard, views existing tasks

### Scenario 2: Task Manager Creating Work
**User:** Project manager  
**Flows Used:** 1 (Login) → 4 (Create Task) → 7 (Upload File) → 6 (Add Comment) → 5 (Move to Kanban)  
**What Happens:** Manager logs in, creates new task, attaches project file, adds instructions as comment, moves task to "In Progress" column

### Scenario 3: Team Member Finding and Working on Task
**User:** Developer/Team member  
**Flows Used:** 1 (Login) → 9 (Search Tasks) → 10 (View Table) → 4 (Edit Task) → 6 (Add Comment) → 15 (Get Notification)  
**What Happens:** User logs in, searches for assigned tasks, views in table, edits task status, adds progress comment, receives notification when manager responds

### Scenario 4: Admin Managing Team
**User:** System administrator  
**Flows Used:** 1 (Login) → 3 (Role Management) → 4 (View All Tasks) → 13 (Analytics) → 14 (Generate Report)  
**What Happens:** Admin logs in, assigns roles to new users, reviews all team tasks, checks analytics dashboard, downloads team productivity report

### Scenario 5: Approval Request Workflow
**User:** Employee requesting approval  
**Flows Used:** 1 (Login) → 12 (Multi-Step Form) → 11 (Submit Approval) → 15 (Wait for Notification) → 14 (View Status Report)  
**What Happens:** User logs in, fills multi-step leave request form, submits for approval, receives notification when approved, downloads approval confirmation

### Scenario 6: Collaborating on Complex Task
**User:** Team working together  
**Flows Used:** 1 (Login) → 4 (View Task) → 6 (Comment Thread) → 16 (Chat Discussion) → 7 (Share Files) → 8 (View Gallery) → 17 (Reorganize Kanban)  
**What Happens:** Team logs in, views shared task, discusses in comments, uses chat for quick questions, shares files, browses file gallery, reorganizes tasks in Kanban board

### Scenario 7: Manager Reviewing Team Performance
**User:** Department manager  
**Flows Used:** 1 (Login) → 13 (Analytics Dashboard) → 9 (Filter by Team) → 10 (View Details Table) → 14 (Export Report) → 15 (Share via Notification)  
**What Happens:** Manager logs in, views team analytics, filters tasks by team members, reviews detailed table, exports performance report, notifies team with report

### Scenario 8: User Customizing Experience
**User:** Power user  
**Flows Used:** 1 (Login) → 18 (Switch Theme) → 5 (Customize Kanban) → 9 (Save Filter Presets) → 15 (Configure Notifications)  
**What Happens:** User logs in, switches to dark theme, customizes Kanban columns, saves favorite filter combinations, sets up notification preferences

### Scenario 9: File-Heavy Project Workflow
**User:** Designer/Content creator  
**Flows Used:** 1 (Login) → 4 (Create Task) → 7 (Upload Multiple Files) → 8 (Organize in Gallery) → 6 (Add File Descriptions) → 9 (Search by File Type)  
**What Happens:** User logs in, creates design task, uploads multiple design files, organizes in gallery, adds descriptions in comments, searches for specific file types later

### Scenario 10: End-to-End Project Completion
**User:** Project lead  
**Flows Used:** 1 (Login) → 4 (Create Project Tasks) → 5 (Organize in Kanban) → 6 (Assign via Comments) → 11 (Request Approvals) → 13 (Track Progress) → 14 (Final Report) → 15 (Notify Stakeholders)  
**What Happens:** Lead logs in, creates all project tasks, organizes in Kanban, assigns via comments, requests approvals for milestones, tracks progress on dashboard, generates final report, notifies all stakeholders

---

## Verification

- Date: 2025-11-16
- Time: 21:20 IST
- Verified by: Assistant
- Proof:
  - 18 flows enumerated with clear one-line purpose and interconnections.
  - Infra mappings:
    - Flows 2 & 15 → AWS SES (email verification/notifications).
    - Flow 16 → WebSockets (socket.io) + Redis presence/typing TTLs.
    - File flows → AWS S3; data flows → MongoDB; caching/ephemeral → Redis (30MB).
  - Supports 3 UI variants; tests focus on accessibility semantics (roles/names/states).
  - Document aligns with `LinkedIn/infrastructure/INFRASTRUCTURE.md` services and constraints.
