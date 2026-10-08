-- Schema `reservation` already exists in drp-infra-postgres. Do not CREATE EXTENSION.
-- Qualify the schema so Flyway cannot land tables elsewhere.
-- user_id and space_id are references, not cross-domain FKs (Anexo J).
-- Exclusion constraint (btree_gist) is a later migration if the index is not enough.

CREATE TABLE reservation.reservations (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID NOT NULL,
  space_id    UUID NOT NULL,
  start_at    TIMESTAMPTZ NOT NULL,
  end_at      TIMESTAMPTZ NOT NULL,
  state       VARCHAR(32) NOT NULL
              CHECK (state IN ('PAYMENT_PENDING', 'CONFIRMED', 'CANCELLED')),
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CHECK (end_at > start_at)
);

CREATE INDEX idx_reservations_space_state
  ON reservation.reservations (space_id, state, start_at, end_at);
