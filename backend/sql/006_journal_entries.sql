CREATE TABLE journal_entries (
    id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    organization_id  UUID NOT NULL REFERENCES organizations(id) ON DELETE RESTRICT,
    customer_id      UUID,
    description      TEXT NOT NULL,
    created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE (organization_id, id),
    FOREIGN KEY (organization_id, customer_id)
        REFERENCES customers (organization_id, id) ON DELETE RESTRICT
);