# LedgerFlow — Database Schema Reference

## Overview

LedgerFlow uses PostgreSQL to store tenant, inventory, accounting,
idempotency, and audit data.

Each tenant is an organization. Tenant-owned records include an
`organization_id`. Composite foreign keys help prevent references
between records belonging to different organizations.

## Relationship overview

```text
organizations
├── users ────────────────────────┐
├── accounts ───────────────┐     │
├── products                │     │
├── customers ───────┐      │     │
├── journal_entries ◄┘      │     │
│   └── ledger_lines ◄──────┘     │
├── idempotency_records           │
└── audit_events ◄────────────────┘