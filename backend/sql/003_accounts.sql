CREATE TABLE accounts(
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    organization_id UUID NOT NULL REFERENCES organizations(id) ON DELETE RESTRICT,
    code            TEXT NOT NULL,
    name            TEXT NOT NULL,
    account_type    TEXT NOT NULL CHECK(account_type IN ('asset' , 'liability','equity','revenue','expense')),
    is_active       BOOLEAN NOT NULL DEFAULT true,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE(organization_id , code),
    UNIQUE(organization_id, id)
)