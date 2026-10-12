#!/bin/bash
set -euo pipefail

DOCKER_APP="/Applications/Docker.app"
DOCKER_BIN="/usr/local/bin/docker"

if [[ ! -d "$DOCKER_APP" ]]; then
  echo "Docker Desktop not found at $DOCKER_APP" >&2
  exit 1
fi

# Already running
if [[ -x "$DOCKER_BIN" ]] && "$DOCKER_BIN" info >/dev/null 2>&1; then
  exit 0
fi

if [[ -x "$DOCKER_BIN" ]] && "$DOCKER_BIN" desktop start >/dev/null 2>&1; then
  exit 0
fi

open -a Docker
exit 0
