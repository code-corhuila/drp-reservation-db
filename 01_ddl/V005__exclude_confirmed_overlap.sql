-- TD-002 / BR-001 / DEC-001: two CONFIRMED rows on the same space must not overlap.
-- btree_gist is owned by drp-infra-postgres (Anexo J). This script does not CREATE EXTENSION.

ALTER TABLE reservation.reservations
  ADD CONSTRAINT reservations_confirmed_no_overlap
  EXCLUDE USING gist (
    space_id WITH =,
    tstzrange(start_at, end_at, '[)') WITH &&
  )
  WHERE (state = 'CONFIRMED');
