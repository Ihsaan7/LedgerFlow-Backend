CREATE TABLE products(
    id                  UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
    organization_id     UUID NOT NULL REFERENCES organizations(id) ON DELETE RESTRICT,
    sku                 TEXT NOT NULL,
    name                TEXT NOT NULL,
    quantity_on_hand    INTEGER NOT NULL DEFAULT 0 CHECK(quantity_on_hand >= 0),
    is_active           BOOLEAN NOT NULL DEFAULT true,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE(organization_id , sku),
    UNIQUE(organization_id , id)
)