#!/usr/bin/env bash
set -euo pipefail

trap 'docker compose down -v --remove-orphans 2>/dev/null || true; rm -rf clean' EXIT

rm -rf clean

mkdir -p clean/test{1..5}

touch -d "0 days ago" clean/test1
touch -d "1 days ago" clean/test2
touch -d "2 days ago" clean/test3
touch -d "3 days ago" clean/test4
touch -d "4 days ago" clean/test5

docker compose up --build -d
sleep 1
docker compose down

actual="$(
  find clean -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort
)"

expected="$(
  printf '%s\n' test1 test2 test3 | sort
)"

if [ "$actual" = "$expected" ]; then
  echo "SUCCESS"
else
  echo "FAIL"
  echo
  echo "Expected:"
  printf '%s\n' "$expected"
  echo
  echo "Actual:"
  printf '%s\n' "$actual"
  exit 1
fi
