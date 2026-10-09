GRANT SELECT, INSERT, UPDATE ON reservation.outbox TO reservation_app;
-- No DELETE: lifecycle is published flag, not row removal.
