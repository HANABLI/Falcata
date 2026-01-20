#!/usr/bin/env bash
set -euo pipefail

# Render config.json from template using env vars.
# Required: JWT_SECRET (and optionally PG_CONNINFO, PLUGINS_DIR, PLUGINS_RUNTIME_DIR)
: "${JWT_SECRET:?JWT_SECRET env var is required}"

export PG_CONNINFO="${PG_CONNINFO:-dbname=iot user=postgres password=admin host=postgres port=5432}"
export PLUGINS_DIR="${PLUGINS_DIR:-/opt/falcata/plugins}"
export PLUGINS_RUNTIME_DIR="${PLUGINS_RUNTIME_DIR:-/opt/falcata/plugins/runtime}"

envsubst < /opt/falcata/config.release.json > /opt/falcata/config.json

echo "[Falcata] Config rendered (JwtSecret hidden)"

# If your main server binary name differs, change here.
exec /opt/falcata/bin/WebServer -c /opt/falcata/config.json
