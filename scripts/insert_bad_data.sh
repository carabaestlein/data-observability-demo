#!/usr/bin/env bash
set -euo pipefail

if [[ -f ".env" ]]; then
  set -a
  source .env
  set +a
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Run demo..."
docker run --rm \
  -e PGPASSWORD="${POSTGRES_PASSWORD}" \
  -v "$ROOT_DIR/scripts/demo.sql:/demo.sql:ro" \
  postgres:16 \
  psql "host=${POSTGRES_HOST} port=${POSTGRES_PORT} dbname=${POSTGRES_DB} user=${POSTGRES_USER} sslmode=${POSTGRES_SSLMODE:-require}" \
  -f /demo.sql -v ON_ERROR_STOP=1

echo "==> Running dbt (build)..."
docker compose run --rm dbt dbt-ol build --profiles-dir . --consume-structured-logs

echo "==> Done."

