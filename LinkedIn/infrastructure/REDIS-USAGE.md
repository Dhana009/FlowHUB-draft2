# Redis Usage Guide - FlowHub

**Production-style Redis usage guide for FlowHub infrastructure**

---

## What is Redis? (Definition)

Redis is an **in-memory key–value store** used for **fast, temporary, low-latency data**.
It stores data in RAM, not disk → extremely fast but limited in size.

For your project:

* Redis acts as a **cache** and **ephemeral state store**
* NOT a permanent database
* NOT for storing actual data or files
* NOT for storing chat history or user records

---

## Core Theory You Must Understand

Redis excels at:

* storing **small keys** (few bytes → few KB)
* storing **short TTL (expire) values**
* handling **state that resets often**
* supporting **real-time features** for WebSockets
* doing **rate limiting** and **session tracking**

Redis fails at:

* storing large objects (MBs)
* storing arrays of data
* storing permanent logs
* storing chat history
* storing files or images

### Under 30MB, you must treat Redis as:

### **"Ephemeral memory for flags, counters, tokens and short-lived states."**

---

## Deep Usage Design for FlowHub (Exactly What to Store in Redis)

Below is the **final, production-ready list** of how you should use Redis across your entire system.

---

### 1. Rate Limiting (API Throttling)

Used to prevent spam, brute force, or abuse.

**Pattern:**
```
rate:<userId>:<action> = <count>
TTL = 1 minute
```

**Example:**
```
rate:123:login_attempts = 3
TTL 60s
```

**Why?**
* Safe
* Lightweight
* Protects APIs
* Uses only ~20 bytes

---

### 2. Session Flags (Short-Lived States)

Used for:
* temporary UI states
* verification flows
* One-time tokens

**Pattern:**
```
session:<userId>:<flag> = <value>
TTL = 5-30 minutes
```

**Example:**
```
session:789:otp_valid = true
TTL 300
```

---

### 3. Caching Database Lookups

Avoid hitting MongoDB repeatedly.

**Pattern:**
```
cache:user:<userId>
TTL = 5 minutes
```

**Example:**
```
cache:user:42 = { name: "Dhanunjaya", email: "x@x.com" }
TTL 300
```

**Rule:**
* Cache only **small JSON objects**, < 5KB
* Do NOT cache arrays, images, huge objects

---

### 4. WebSocket (Flow 16) — Presence (Online/Offline)

Tracks if user is currently online.

**Pattern:**
```
presence:<userId> = "online"
TTL = 10 seconds (refreshed every ping)
```

**Why?**
* Very cheap
* Perfect for WebSocket heartbeats
* Uses <50 bytes

---

### 5. WebSocket Typing Indicators

When a user is typing in chat.

**Pattern:**
```
typing:<roomId>:<userId> = true
TTL = 3 seconds
```

**Example:**
```
typing:room7:user123 = true
TTL 3
```

---

### 6. WebSocket Message Broadcast — DO NOT STORE MESSAGES

You **never** store chat messages in Redis.

**Why?**
* 30MB limit
* Messages grow fast
* Redis is RAM
* Use MongoDB ONLY if you want history

WebSocket messages should go:
* from sender → backend → recipients
* NOT stored in Redis
* NOT persisted anywhere unless Flow requires it

---

### 7. DO NOT Use Redis for:

* Logging
* Images
* Files
* JSON arrays
* Chat history
* Logs of WebSocket events
* Large objects > 10KB

These will break your 30MB limit quickly.

---

## Final Redis Key Structure (Full System)

Here's the **complete list** you should implement:

```
# Rate Limiting
rate:<userId>:login_attempts           TTL=60
rate:<userId>:api_hits                 TTL=60

# OTP / Verification
otp:<userId>                           TTL=300
session:<userId>:otp_valid             TTL=300

# Caching small objects
cache:user:<userId>                    TTL=300
cache:product:<id>                     TTL=300

# WebSocket presence
presence:<userId>                      TTL=10

# WebSocket typing states
typing:<roomId>:<userId>               TTL=3

# Feature flags (optional)
flag:<featureName>:<userId>            TTL=86400

# Temporary auth tokens
token:<userId>:login                   TTL=600
```

All these keys:
* are tiny
* expire automatically
* use <1 MB total
* work perfectly under Upstash 30MB

---

## Why This Fits Your 30MB Upstash Redis

Estimated usage:
* 10,000 keys max × 100 bytes each ≈ 1MB
* Even with 2–3x overhead → still <5MB
* Leaves 25MB untouched

You are extremely safe.

---

## Interview Explanation (use this in real interviews)

If an interviewer asks **"How are you using Redis?"**, you answer:

> "We use Redis strictly as an ephemeral in-memory store.
> Its job is to handle rate-limiting, WebSocket presence, typing indicators, and small cache objects with short TTLs.
> We never store large data or chat history in Redis because it's only a 30MB instance.
> MongoDB stores persistent data; Redis stores temporary state.
> This keeps Redis extremely fast and ensures we never hit memory limits."

This answer is **perfect**.

---

## Verification

- Date: 2025-11-16
- Time: 21:20 IST
- Verified by: Assistant
- Proof:
  - Redis restricted to ephemeral state only (rate limiting, presence, typing, small cache, OTP).
  - Key patterns and TTLs comply with 30MB Upstash limit; estimated usage < 5MB.
  - No chat history, logs, files, or large JSON stored in Redis.
  - Presence TTL (10s) and typing TTL (3s) align with WebSocket heartbeat strategy.
  - Consistent with `LinkedIn/infrastructure/INFRASTRUCTURE.md` (Redis usage, System Constraints).
