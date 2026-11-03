-- Manual undo on empty local volumes only.

ALTER TABLE reservation.reservations
  DROP CONSTRAINT IF EXISTS reservations_confirmed_no_overlap;
