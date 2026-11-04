CREATE TABLE ledger_lines (
    id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    organization_id   UUID NOT NULL REFERENCES organizations(id) ON DELETE RESTRICT,
    journal_entry_id  UUID NOT NULL,
    account_id        UUID NOT NULL,
    direction         TEXT NOT NULL CHECK (direction IN ('debit', 'credit')),
    amount_minor      BIGINT NOT NULL CHECK (amount_minor > 0),
    created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
    FOREIGN KEY (organization_id, journal_entry_id)
        REFERENCES journal_entries (organization_id, id) ON DELETE RESTRICT,
    FOREIGN KEY (organization_id, account_id)
        REFERENCES accounts (organization_id, id) ON DELETE RESTRICT
);