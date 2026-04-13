#!/usr/bin/env sh
set -eu
trap 'kill -TERM 0; wait' TERM INT

DIR_MAX_AGE_DAYS="${DIR_MAX_AGE_DAYS:-30}"
CLEANUP_INTERVAL_SECONDS="${CLEANUP_INTERVAL_SECONDS:-1800}"
PRINT_DELETED="${PRINT_DELETED:-1}"

cleanup_once() {
  if [ "$PRINT_DELETED" = "1" ]; then
    find . -mindepth 1 -maxdepth 1 -type d -mtime +"$DIR_MAX_AGE_DAYS" -print -exec rm -rf {} \;
  else
    find . -mindepth 1 -maxdepth 1 -type d -mtime +"$DIR_MAX_AGE_DAYS" -exec rm -rf {} \;
  fi
}

echo "Started"
cd /app/workspace

while true; do
  cleanup_once
  sleep "$CLEANUP_INTERVAL_SECONDS"
done &

wait
