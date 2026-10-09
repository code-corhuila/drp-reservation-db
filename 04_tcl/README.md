# Transaction boundaries for reservation writes live in `drp-reservation-api`.
# Aggregate row + `reservation.outbox` insert must be one transaction (instructor-norm).
