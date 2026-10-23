#!/bin/sh
set -eu

AUTH_HASH="$(caddy hash-password --plaintext "$BASIC_AUTH_PASSWORD")"
export AUTH_HASH

python -m backend --host 127.0.0.1 --port 8000 &

exec caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
