#!/usr/bin/env sh
set -eu
trap 'kill -TERM 0; wait' TERM INT

: "${DIR_MAX_AGE_DAYS?}"

CLEANUP_INTERVAL_SECONDS="${CLEANUP_INTERVAL_SECONDS:-1800}"
PRINT_DELETED="${PRINT_DELETED:-1}"

cleanup_once() {
  find . -mindepth 1 -maxdepth 1 -type d | while read -r root_dir; do
    if [ "$PRINT_DELETED" = "1" ]; then
      find "$root_dir" -mindepth 1 -maxdepth 1 -type d -mtime +"$DIR_MAX_AGE_DAYS" -print -exec rm -rf {} \;
    else
      find "$root_dir" -mindepth 1 -maxdepth 1 -type d -mtime +"$DIR_MAX_AGE_DAYS" -exec rm -rf {} \;
    fi
  done
}

echo "Started"

while true; do
  cleanup_once
  sleep "$CLEANUP_INTERVAL_SECONDS"
done &

wait
