# LedgerFlow — Software Requirements Specification

## 1. Purpose

LedgerFlow is a multi-tenant B2B credit ledger and inventory engine.
It records wholesale sales, prevents inventory overselling, and maintains
an auditable double-entry financial ledger.

## 2. Users and scope

- Organizations represent tenants.
- Authorized organization users manage inventory and credit transactions.
- The system provides a REST API and a dashboard.

## 3. Functional requirements

### Multi-tenancy
- Tenant-owned records must be associated with an organization.
- API operations must only access data belonging to the authenticated
  user's organization.

### Inventory
- The system must track inventory quantities.
- Concurrent sales must not reduce available inventory below zero.
- Inventory changes must be performed atomically with the related sale.

### Double-entry ledger
- Financial transactions must create journal entries and ledger lines.
- Total debits must equal total credits for each journal entry.
- Posted ledger records must be immutable; corrections use new entries.
- Balances are derived from ledger lines, not directly updated.

### Idempotency
- Retrying a supported transaction with the same idempotency key and
  equivalent request must not create a second transaction.
- Reusing a key with a different request must be rejected.
- The stored response must be returned for a completed retry.

### Audit logging
- Critical state changes must create append-only audit records.
- Audit records must capture the actor, organization, action, timestamp,
  and relevant JSONB change details.

### Security
- The API must authenticate users using JWTs.
- Role-based access control must restrict privileged operations.
- Request data must be validated.

## 4. Non-functional requirements

- PostgreSQL is the source of truth for inventory and financial records.
- Related inventory, ledger, idempotency, and audit changes must commit
  or roll back together where applicable.
- Monetary calculations must not use floating-point arithmetic.
- Automated tests must cover tenant isolation, balanced entries,
  concurrent inventory access, and idempotent retries.
- The application must support containerized local development and CI.

## 5. Technology

- Backend: Node.js, NestJS, TypeScript
- Database: PostgreSQL, raw SQL and an ORM for basic CRUD
- Operations: Docker, Docker Compose, GitHub Actions
- Frontend: Next.js and Tailwind CSS

## 6. Acceptance criteria

1. Concurrent requests cannot sell more inventory than is available.
2. A posted journal entry cannot be unbalanced.
3. A retry with the same idempotency key cannot duplicate a transaction.
4. A user cannot access another organization's records.
5. A failed transaction leaves no partial inventory or ledger changes.
6. Critical committed changes have an audit trail.

## 7. Open design decisions

- Exact roles and permissions.
- Currency and monetary precision policy.
- Idempotency key scope, retention, and behavior for in-flight requests.
- Specific audit events and data-retention policy.
- Each organization uses one currency: PKR or USD.
- Financial amounts are stored as whole minor units: paisa for PKR
- and cents for USD.
- Currency conversion is out of scope for v1.
- An organization's currency must not change after financial activity begins.