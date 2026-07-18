CREATE TABLE pharmacies (
    id            BIGINT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(255)   NOT NULL,
    phone         VARCHAR(20)    NOT NULL,
    address       VARCHAR(500)   NOT NULL,
    district      VARCHAR(100)   NOT NULL,
    latitude      DOUBLE         NOT NULL,
    longitude     DOUBLE         NOT NULL,
    is_on_duty    BOOLEAN        NOT NULL DEFAULT FALSE,
    opening_time  TIME           NULL,
    closing_time  TIME           NULL,
    created_at    DATETIME       NOT NULL,
    updated_at    DATETIME       NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE INDEX idx_pharmacies_district ON pharmacies (district);
CREATE INDEX idx_pharmacies_is_on_duty ON pharmacies (is_on_duty);
