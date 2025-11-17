# FlowHub Infrastructure

## 1. Services Overview

| Component                   | Service                | Notes                                   |
| --------------------------- | ---------------------- | --------------------------------------- |
| **Frontend**                | Vercel                 | Three UI variants: `/v1`, `/v2`, `/v3`  |
| **Backend (Prod)**          | Fly.io                 | 512MB RAM, shared CPU, scale-to-zero    |
| **Backend (Dev)**           | Render                 | Free tier, for development only         |
| **Database**                | MongoDB Atlas          | 512MB free tier                         |
| **Cache / Ephemeral Store** | Upstash Redis          | 30MB memory limit                       |
| **Storage**                 | AWS S3                 | For files, images, documents            |
| **Email**                   | AWS SES                | For OTPs and transactional emails       |
| **Webhooks**                | AWS SNS (optional)     | SES events → webhooks (free tier)       |
| **Webhook Hosting**         | Fly.io Backend         | Incoming/outgoing webhooks (no extra cost) |
| **CI/CD**                   | GitHub Actions         | Testing + production deployment         |
| **Logging**                 | Logtail                | Frontend + backend log pipeline        |
| **Error Monitoring**        | Rollbar                | Exceptions, crashes, runtime failures   |
| **Realtime**               | WebSockets (socket.io) | Chat, notifications, realtime events    |
| **Domain**                  | Namecheap/Route53      | For public access                       |

## 2. Backend Infrastructure

### Hosting

* **Production**: Fly.io
  * Region: Mumbai (bom)
  * Resources: 512MB RAM, shared CPU
  * Features: Scale-to-zero, auto-sleep when idle
  * Cold start: 0.5–1.0 seconds

* **Development**: Render
  * Free tier
  * Sleeps after 15 minutes of inactivity

### API Configuration

* Base URL: `/api/v1`
* Port: `4000`
* Framework: Node.js with TypeScript (Express/Fastify)

## 3. Frontend Infrastructure

### Hosting

* **Platform**: Vercel
* **Deployment**: Static assets with CDN distribution
* **UI Variants**: Three parallel versions (`/v1`, `/v2`, `/v3`)
* **Framework**: Next.js with TypeScript

### Configuration

* API endpoint: `NEXT_PUBLIC_API_URL`

## 4. Database Infrastructure

### MongoDB Atlas

* **Tier**: Free (512MB storage)
* **Usage**: Primary data storage (users, tasks, projects, messages, notifications)
* **Constraints**: Metadata only, no large documents
* **Region**: Mumbai (bom) or nearest

### Data Storage Strategy

* **MongoDB**: Persistent data (users, tasks, messages, notifications, webhooks)
* **Redis**: Ephemeral state only (presence, typing, rate limits, short cache)
* **S3**: File storage (images, documents, attachments)

## 5. Cache Infrastructure

### Upstash Redis

* **Tier**: Free (30MB memory limit)
* **Usage**: Ephemeral state only
* **Use Cases**: Rate limiting, presence, typing indicators, OTP flags, short cache
* **NOT Used For**: Chat history, logs, files, large objects, persistent data

**See `REDIS-USAGE.md` for detailed patterns and key structures.**

## 6. Storage Infrastructure

### AWS S3

* **Usage**: File storage (uploaded files, images, documents, attachments)
* **Access**: Public URLs or presigned download URLs
* **Lifecycle**: Optional archival policies for old files

## 7. Email Infrastructure

### AWS SES

* **Usage**: Transactional emails (OTPs, email verification, notifications)
* **Configuration**: Domain verified, DKIM/SPF configured
* **Region**: Mumbai or nearest
* **Limits**: Production mode after sandbox verification

## 8. Webhook Infrastructure

### AWS SNS (Optional)

* **Usage**: Receives SES email events (bounces, complaints, deliveries)
* **Tier**: Free (1M requests/month)
* **Endpoint**: Fly.io backend webhook endpoint

### Webhook Hosting

* **Platform**: Fly.io backend (no extra cost)
* **Incoming**: Handles webhooks from external services (SES via SNS, GitHub, etc.)
* **Outgoing**: Sends webhooks to user-configured URLs with HMAC signing
* **Retry Logic**: MongoDB-based queue with exponential backoff

## 9. Real-Time Infrastructure

### WebSocket (socket.io)

* **Platform**: Fly.io backend
* **Usage**: Chat messages, notifications, realtime events, presence
* **Cost**: ₹0 extra (fully supported on Fly.io)
* **No Limits**: No additional billing for WebSocket connections

## 10. Notification Infrastructure

### In-App Notifications

* **Storage**: MongoDB
* **Delivery**: WebSocket (socket.io) for real-time delivery
* **Retention**: 30-day history

### Email Notifications

* **Delivery**: AWS SES
* **Queue**: MongoDB notification queue
* **Tracking**: SNS webhooks for delivery status

## 11. Chat Infrastructure

### Message Storage

* **Database**: MongoDB (persistent storage)
* **Indexes**: Optimized for room-based queries
* **Archival**: Optional TTL with S3 archival

### Real-Time Delivery

* **Protocol**: WebSocket (socket.io)
* **Presence**: Redis (ephemeral, TTL-based)
* **Typing Indicators**: Redis (ephemeral, TTL-based)

## 12. Observability Infrastructure

### Logging (Logtail)

* **Usage**: All non-error logs (INFO, DEBUG, WARN, workflow logs)
* **Limit**: 3GB/month (free tier)
* **Integration**: Frontend and backend

### Error Monitoring (Rollbar)

* **Usage**: Exceptions, crashes, runtime failures
* **Limit**: 5,000 events/month (free tier)
* **Behavior**: Stops accepting events when limit reached (no cost impact)

## 13. CI/CD Infrastructure

### GitHub Actions

* **Usage**: Automated testing and deployment
* **Pipeline**: Unit tests → Integration tests → API tests → E2E tests → Build → Deploy
* **Deployment**: Automatic to Fly.io on successful tests
* **Cost**: Free

## 14. Environment Variables

### Backend

```
MONGODB_URI
REDIS_URL
JWT_SECRET
JWT_REFRESH_SECRET
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
S3_BUCKET_NAME
AWS_SES_REGION
FROM_EMAIL
AWS_SNS_TOPIC_ARN (optional, for SES webhooks)
WEBHOOK_SECRET (for signing outbound webhooks)
ROLLBAR_TOKEN
LOGTAIL_TOKEN
CORS_ORIGINS
```

### Frontend

```
NEXT_PUBLIC_API_URL
NEXT_PUBLIC_ROLLBAR_TOKEN
NEXT_PUBLIC_LOGTAIL_TOKEN
```

## 15. System Constraints

| Service | Limit                   | Approach                            |
| ------- | ----------------------- | ----------------------------------- |
| MongoDB | 512MB                   | Metadata only, no large documents   |
| Redis   | 30MB                    | Ephemeral keys only; TTL everywhere |
| Fly.io  | 512MB RAM               | Scale-to-zero, short burst loads   |
| Logtail | 3GB/month               | Log only info/debug/warn            |
| Rollbar | 5K errors/month         | Error-only events                   |
| Render  | Sleeps after 15 minutes | Used only for dev                   |
| SNS     | 1M requests/month       | Free tier covers SES webhooks       |

## 16. Health Check

* **Endpoint**: `GET /health`
* **Usage**: Fly.io and Render monitoring
* **Response**: Service status and dependencies

## 17. Monthly Cost Estimate

| Service         | Estimated Cost |
| --------------- | -------------- |
| Fly.io          | ₹250–₹400      |
| Domain          | ₹60–₹100       |
| AWS SES         | ₹40–₹80        |
| S3              | ₹5–₹20         |
| SNS             | Free (free tier) |
| Redis (Upstash) | Free           |
| MongoDB (Atlas) | Free           |
| Vercel          | Free           |
| Logtail         | Free           |
| Rollbar         | Free           |

### Total: ₹900–₹1400 per month

**Note:** Webhooks, notifications, and chat add ₹0 extra cost - all hosted on existing infrastructure.

## 18. MCP Server Infrastructure

### FlowHub MCP Server

* **Purpose**: AI assistant knowledge layer for FlowHub docs, policies, and automation
* **Platform**: Local Python server (runs on dev machine)
* **Port**: `3000` (or configured)
* **Framework**: Python MCP SDK

### Vector Database

* **Cloud**: Qdrant Cloud (1GB free tier)
  * Usage: Core stable docs (SDLC, policies, flows, infrastructure)
  * Size: ~50-100MB
  * Always available, fast queries
* **Local**: Qdrant Embedded (Python library, no Docker)
  * Usage: Cloud mirror + active work (decisions, logs, generated code)
  * Size: Unlimited (local storage)
  * Full control, offline capable

### Environment Variables

```
QDRANT_CLOUD_URL
QDRANT_API_KEY
```

### Cost

* **MCP Server**: Free (local Python process)
* **Qdrant Cloud**: Free (1GB tier)
* **Qdrant Local**: Free (local storage)

**Total MCP Infrastructure Cost: ₹0**

---

## Verification

- Date: 2025-11-17
- Verified by: Assistant
- All required services documented with infrastructure details
- MCP server and vector database infrastructure added
- Constraints and cost breakdown align with free tiers and budget
- Consistent with flows in `LinkedIn/complete-flows/FLOWS-SIMPLE.md` and Redis limits in `LinkedIn/infrastructure/REDIS-USAGE.md`
