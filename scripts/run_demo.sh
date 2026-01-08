#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Starting Postgres..."
docker compose up -d postgres

echo "==> Seeding tables + mock data..."
docker run --rm \
  --network "$(basename "$ROOT_DIR")_default" \
  -e PGPASSWORD="${POSTGRES_PASSWORD:-demo}" \
  -v "$ROOT_DIR/scripts/seed.sql:/seed.sql:ro" \
  postgres:16 \
  psql -h postgres -U "${POSTGRES_USER:-demo}" -d "${POSTGRES_DB:-bank}" -f /seed.sql -v ON_ERROR_STOP=1

echo "==> Running dbt (build)..."
docker compose run --rm dbt dbt deps
docker compose run --rm dbt dbt build --profiles-dir .

echo "==> Verifying output rowcount..."
docker run --rm \
  --network "$(basename "$ROOT_DIR")_default" \
  -e PGPASSWORD="${POSTGRES_PASSWORD:-demo}" \
  postgres:16 \
  psql -h postgres -U "${POSTGRES_USER:-demo}" -d "${POSTGRES_DB:-bank}" \
  -c "select count(*) as customer_transactions_rows from marts.customer_transactions;"

echo "==> Done."
echo "Postgres is still running. Stop with: docker compose down -v"

