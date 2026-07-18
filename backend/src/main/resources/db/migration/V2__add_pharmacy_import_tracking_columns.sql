ALTER TABLE pharmacies
    ADD COLUMN source      VARCHAR(100) NULL,
    ADD COLUMN external_id VARCHAR(100) NULL;

CREATE UNIQUE INDEX uq_pharmacies_source_external_id ON pharmacies (source, external_id);
