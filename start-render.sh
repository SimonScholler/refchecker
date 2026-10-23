#!/bin/sh
set -eu

: "${BASIC_AUTH_USER:?BASIC_AUTH_USER is not set}"
: "${BASIC_AUTH_PASSWORD:?BASIC_AUTH_PASSWORD is not set}"
: "${PORT:?PORT is not set}"

AUTH_HASH="$(caddy hash-password --plaintext "$BASIC_AUTH_PASSWORD")"
export AUTH_HASH

echo "Starting RefChecker behind Caddy Basic Auth on port ${PORT}"

caddy validate --config /etc/caddy/Caddyfile --adapter caddyfile

python -m backend --host 127.0.0.1 --port 8000 &

exec caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
