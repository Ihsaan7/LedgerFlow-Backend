ALTER TABLE users
    ADD CONSTRAINT users_organization_id_id_key
    UNIQUE (organization_id, id);