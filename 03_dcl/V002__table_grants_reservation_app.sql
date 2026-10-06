-- reservation_app already has USAGE, CREATE on schema reservation (infra init).
-- Tables created by Flyway are owned by reservation_app.

GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA reservation TO reservation_app;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA reservation TO reservation_app;
-- No DELETE: lifecycle is PAYMENT_PENDING | CONFIRMED | CANCELLED.
