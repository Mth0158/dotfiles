#!/bin/bash
set -euo pipefail

PG_VERSION="17"
PG_PREFIX="/opt/homebrew/opt/postgresql@${PG_VERSION}"
DATA_DIR="/opt/homebrew/var/postgresql@${PG_VERSION}"
PIDFILE="${DATA_DIR}/postmaster.pid"

if [[ -f "$PIDFILE" ]] && ! "${PG_PREFIX}/bin/pg_isready" -q 2>/dev/null; then
  pid="$(sed -n '1p' "$PIDFILE")"
  if ! ps -p "$pid" -o comm= 2>/dev/null | grep -qE 'postgres'; then
    rm -f "$PIDFILE"
  fi
fi

exec "${PG_PREFIX}/bin/postgres" -D "$DATA_DIR"
