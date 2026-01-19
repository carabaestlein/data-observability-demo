#!/usr/bin/env bash
set -euo pipefail

if [[ -f ".env" ]]; then
  set -a
  source .env
  set +a
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ "${POSTGRES_HOST}" == "localhost" ]]; then
  docker compose up -d postgres
fi

echo "==> Seeding tables + mock data..."
docker run --rm \
  -e PGPASSWORD="${POSTGRES_PASSWORD}" \
  -v "$ROOT_DIR/scripts/seed.sql:/seed.sql:ro" \
  postgres:16 \
  psql "host=${POSTGRES_HOST} port=${POSTGRES_PORT} dbname=${POSTGRES_DB} user=${POSTGRES_USER} sslmode=${POSTGRES_SSLMODE:-require}" \
  -f /seed.sql -v ON_ERROR_STOP=1

echo "==> Running dbt (build)..."
docker compose run --rm dbt dbt deps
docker compose run --rm dbt dbt-ol build --profiles-dir . --consume-structured-logs

echo "==> Done."
echo "Postgres is still running. Stop with: docker compose down -v"

