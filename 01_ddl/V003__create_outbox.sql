-- Transactional outbox (norma 5.3 / instructor-norm). Same schema as the aggregate.
-- Publisher is drp-reservation-api; this repo only owns the table.

CREATE TABLE reservation.outbox (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  event_id       UUID NOT NULL UNIQUE,
  event_type     VARCHAR(64) NOT NULL,
  aggregate_id   UUID NOT NULL,
  aggregate_type VARCHAR(32) NOT NULL,
  topic          VARCHAR(128) NOT NULL,
  payload        JSONB NOT NULL,
  occurred_at    TIMESTAMPTZ NOT NULL,
  published      BOOLEAN NOT NULL DEFAULT FALSE,
  published_at   TIMESTAMPTZ,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_reservation_outbox_unpublished
  ON reservation.outbox (created_at)
  WHERE published = FALSE;
