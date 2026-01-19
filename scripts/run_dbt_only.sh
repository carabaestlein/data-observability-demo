#!/usr/bin/env bash
set -euo pipefail

if [[ -f ".env" ]]; then
  set -a
  source .env
  set +a
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Running dbt (build)..."
docker compose run --rm dbt dbt-ol build --profiles-dir . --consume-structured-logs

echo "==> Done."

