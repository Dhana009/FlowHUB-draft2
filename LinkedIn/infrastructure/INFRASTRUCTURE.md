# FlowHub Infrastructure – Final Version

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
| **CI/CD**                   | GitHub Actions         | Testing + production deployment         |
| **Logging**                 | Logtail                | Frontend + backend log pipeline        |
| **Error Monitoring**        | Rollbar                | Exceptions, crashes, runtime failures   |
| **Realtime (Flow 16)**      | WebSockets (socket.io) | For chat simulation and realtime events |
| **Domain**                  | Namecheap/Route53      | For public access                       |

## 2. Backend Architecture

### Backend Framework

* Node.js (Express/Fastify)

### API

* Base URL: `/api/v1`

* Port: `4000`

### Fly.io Configuration

* Region: **Mumbai (bom)**

* Resources:

  * 512MB RAM

  * Shared CPU

* Features:

  * Scale-to-zero

  * Auto-sleep when idle

  * Cold start: 0.5–1.0 seconds

## 3. Frontend Architecture

### Hosting

* Vercel static deployments

* Three parallel UI versions: `/v1`, `/v2`, `/v3`

### Frontend API Config

* `NEXT_PUBLIC_API_URL=https://backend.yourdomain.com/api/v1`

### Build Output

* Pure static assets

* Fast CDN distribution

## 4. Real-Time System (Flow 16: Chat Simulation)

### Technology

* `socket.io` on backend

* `socket.io-client` on frontend

### Use Cases

* Chat simulation

* Typing indicators

* Online/offline presence

* Realtime delivery of events

### No extra cost

* Fully supported on Fly.io

* No additional billing for WebSocket connections

## 5. Redis Usage (30MB Upstash Limit)

Redis is used **only for ephemeral state**, not persistent storage.

See `REDIS-USAGE.md` for detailed patterns and key structures.

### Allowed Use Cases

1. **Rate Limiting**

   ```
   rate:<userId>:login    TTL=60s
   rate:<userId>:api      TTL=60s
   ```

2. **Presence (Realtime)**

   ```
   presence:<userId>      TTL=10s
   ```

3. **Typing Indicator**

   ```
   typing:<roomId>:<userId>   TTL=3s
   ```

4. **Short Cache**

   ```
   cache:user:<id>   TTL=300s
   ```

5. **OTP / Verification Flags**

   ```
   otp:<userId>         TTL=300s
   session:<userId>:otp TTL=300s
   ```

### Not Allowed in Redis

* Chat history

* Logs

* Files or images

* Large JSON objects

* Long-term data

Redis usage stays under ~2–5MB total.

## 6. Logging Strategy

### Logtail (Logs Only)

All **non-error** logs go here:

* `INFO`

* `DEBUG`

* `WARN`

* Workflow logs

* User actions

* API lifecycle logs

Both frontend and backend send logs to Logtail.

**Frontend token:** `NEXT_PUBLIC_LOGTAIL_TOKEN`

**Backend token:** `LOGTAIL_TOKEN`

## 7. Error Monitoring Strategy

### Rollbar (Errors Only)

Used for:

* Exceptions

* Crashes

* Backend runtime failures

* Frontend JavaScript runtime errors

* Promise rejections

* Uncaught exceptions

Limit:

* **5,000 events/month** (free)

If limit is reached → Rollbar stops accepting new events (no cost impact).

## 8. CI/CD Pipeline (GitHub Actions)

### Triggers

* Runs on every push to `main`

### Pipeline Steps

1. Install dependencies

2. Run unit tests

3. Run integration tests

4. Run API tests

5. Run Playwright E2E tests

6. Build backend

7. Deploy to Fly.io only if all tests pass

### Cost

* Free

## 9. AWS Services

### AWS S3

* Store uploaded files

* Store images, PDFs, documents

* Public or presigned download URLs

### AWS SES

* Send OTP emails

* Used for Flow 2 and Flow 15

* Domain verified

* DKIM/SPF configured

## 10. Environment Variables

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

## 11. System Constraints

| Service | Limit                   | Approach                            |
| ------- | ----------------------- | ----------------------------------- |
| MongoDB | 512MB                   | Metadata only, no large documents   |
| Redis   | 30MB                    | Ephemeral keys only; TTL everywhere |
| Fly.io  | 512MB RAM               | Scale-to-zero, short burst loads   |
| Logtail | 3GB/month               | Log only info/debug/warn            |
| Rollbar | 5K errors/month         | Error-only events                   |
| Render  | Sleeps after 15 minutes | Used only for dev                   |

## 12. Health Check Endpoint

```
GET /health
```

Used by Fly.io and Render for monitoring.

## 13. Monthly Cost Estimate

| Service         | Estimated Cost |
| --------------- | -------------- |
| Fly.io          | ₹250–₹400      |
| Domain          | ₹60–₹100       |
| AWS SES         | ₹40–₹80        |
| S3              | ₹5–₹20         |
| Redis (Upstash) | Free           |
| MongoDB (Atlas) | Free           |
| Vercel          | Free           |
| Logtail         | Free           |
| Rollbar         | Free           |

### Total: ₹900–₹1400 per month

---

## Verification

- Date: 2025-11-16
- Time: 21:20 IST
- Verified by: Assistant
- Proof:
  - All required services documented: Vercel, Fly.io, Render (dev), MongoDB, Upstash Redis, S3, SES, GitHub Actions, Logtail, Rollbar, WebSockets, Domain.
  - Backend API base `/api/v1`, port 4000, Fly.io region (bom), scale-to-zero behavior noted.
  - Environment variables listed for backend and frontend, including CORS and observability tokens.
  - Real-time (socket.io) supports Flow 16; SES supports Flows 2 & 15; S3 covers file flows; MongoDB covers data flows; Redis usage scoped to ephemeral state.
  - Constraints and cost breakdown align with free tiers and budget; health check route documented.
  - Consistent with flows in `LinkedIn/complete-flows/FLOWS-SIMPLE.md` and Redis limits in `LinkedIn/infrastructure/REDIS-USAGE.md`.
