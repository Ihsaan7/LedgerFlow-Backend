# LedgerFlow — Database Test Report

## Scope

These were manual checks against PostgreSQL in a Docker container.
They used a separate database named `ledgerflow_schema_test`, not the
main `ledgerflow` database.

The checks cover selected schema constraints and migration execution.
They are not a complete production test suite.

## Migration verification

All 11 numbered SQL files were executed in order against a fresh test
database. Each completed successfully, and `\dt` showed all nine
planned tables.

## Manual test results

| Check | Expected result | Observed result |
|---|---|---|
| Insert organization with PKR | Accepted | Accepted |
| Insert organization with EUR | Rejected by currency check | Rejected |
| Insert user with nonexistent organization | Rejected by foreign key | Rejected |
| Insert product with negative stock | Rejected by stock check | Rejected |
| Link Acme journal entry to Global customer | Rejected by composite foreign key | Rejected |
| Use the same product SKU in different organizations | Accepted | Accepted |
| Repeat a product SKU within Acme | Rejected by unique constraint | Rejected |
| Insert ledger line with invalid direction | Rejected by direction check | Rejected |
| Insert ledger line with zero amount | Rejected by amount check | Rejected |
| Link Acme ledger line to Global account | Rejected by composite foreign key | Rejected |
| Link Acme ledger line to Global journal entry | Rejected by composite foreign key | Rejected |
| Insert valid processing idempotency record | Accepted | Accepted |
| Insert completed idempotency record without response | Rejected by consistency check | Rejected |
| Repeat an idempotency key within Acme | Rejected by unique constraint | Rejected |
| Complete a record with response fields | Accepted | Accepted |
| Use the same idempotency key in another organization | Accepted | Accepted |
| Link Acme audit event to Global user | Rejected by composite foreign key | Rejected |
| Insert user with invalid role | Rejected by role check | Rejected |
| Insert account with invalid type | Rejected by account-type check | Rejected |
| Insert idempotency record with invalid status | Rejected by a check constraint | Rejected by the consistency check |
| Insert a balanced pair of valid ledger lines | Accepted | Two lines accepted and inspected |
| Delete Acme while accounts reference it | Rejected by foreign key | Rejected |
| Insert organization without a name | Rejected by `NOT NULL` | Rejected |

## What these tests demonstrate

- Selected checks reject invalid values.
- Selected foreign keys reject nonexistent or cross-tenant references.
- Product SKUs and idempotency keys are unique within an organization.
- Valid test ledger lines can be stored and inspected.
- The migration files can recreate the initial schema on a fresh database.

## What these tests do not prove

- The database currently enforces balanced journal entries.
- Ledger or audit records are immutable or append-only.
- Concurrent requests cannot oversell inventory.
- Retry logic prevents duplicate transactions.
- API authorization and tenant filtering work correctly.
- Every schema constraint or business rule has been tested.

These require additional implementation and automated testing.