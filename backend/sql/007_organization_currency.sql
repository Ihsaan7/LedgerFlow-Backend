ALTER TABLE organizations
    ADD COLUMN currency TEXT NOT NULL
    CHECK (currency IN ('PKR', 'USD'));