# drp-reservation-db

Reservation schema. **Migrations only.** Engine: [`drp-infra-postgres`](https://github.com/code-corhuila/drp-infra-postgres). No database container here. `drp-reservation-api` must not own DDL.

Model: `drp-docs` `06-data/models.md` (schema `reservation`, user `reservation_app`). Overlap of **CONFIRMED** bookings lives here (BR-001). `PENDING` is not a reservation state.

## Layout (Anexo J)

| Folder | Content |
|--------|---------|
| `01_ddl/` | `reservations` (schema-qualified) |
| `02_dml/` | no Corte 2 seed |
| `03_dcl/` | grants for `reservation_app` (no DELETE; cancel is a state) |
| `04_tcl/` | reserved |
| `05_rollbacks/` | local undo |
| `deploy/compose.yml` | Flyway job only |

Control table: `reservation.flyway_reservation_history`.

## Run

```bash
# infra first
docker compose --env-file env/dev.env -f deploy/compose.yml up -d

# this repo
docker compose --env-file .env.example -f deploy/compose.yml run --rm reservation-migrate
```

Corte 2 UI (`drp-front`) does **not** need this migrate: it uses synthetic contract data.

## Branching

Child of `develop` named `feat/…`. Never commit on `develop` / `qa` / `main`. Promote with `cherry-pick -x`.
