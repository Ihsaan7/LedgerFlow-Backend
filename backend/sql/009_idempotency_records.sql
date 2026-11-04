CREATE TABLE idempotency_records (
    id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    organization_id   UUID NOT NULL REFERENCES organizations(id) ON DELETE RESTRICT,
    idempotency_key   TEXT NOT NULL,
    request_hash      TEXT NOT NULL,
    status            TEXT NOT NULL CHECK (status IN ('processing', 'completed')),
    response_status   INTEGER,
    response_body     JSONB,
    created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
    completed_at      TIMESTAMPTZ,
    UNIQUE (organization_id, idempotency_key),
    CHECK (
        (status = 'processing' AND response_status IS NULL
            AND response_body IS NULL AND completed_at IS NULL)
        OR
        (status = 'completed' AND response_status IS NOT NULL
            AND response_body IS NOT NULL AND completed_at IS NOT NULL)
    )
);