#!/usr/bin/env bash
set -euo pipefail

base_a="$(git rev-parse HEAD)"
origin_a="$(git rev-parse refs/remotes/origin/main)"
test "$base_a" = "$origin_a"

git switch -c r61-agent-work "$base_a"
printf 'agent change\n' > agent-file.txt
git add agent-file.txt
git commit -m 'R61 agent change'

remote_b=''
for _ in $(seq 1 36); do
  remote_b="$(git ls-remote origin refs/heads/main | awk '{print $1}')"
  if test -n "$remote_b" && test "$remote_b" != "$base_a"; then
    break
  fi
  sleep 5
done

test -n "$remote_b"
test "$remote_b" != "$base_a"
git fetch --no-write-fetch-head origin "$remote_b"
git update-ref refs/r61/base-b "$remote_b"
test "$(git rev-parse refs/r61/base-b)" = "$remote_b"
test "$(git rev-parse refs/remotes/origin/main)" = "$base_a"

git merge -s ours --no-ff refs/r61/base-b -m 'R61 agent merge commit'
test "$(git show -s --format=%P HEAD | wc -w)" -eq 2
git merge-base --is-ancestor "$remote_b" HEAD
test "$(git rev-parse refs/remotes/origin/main)" = "$base_a"

printf 'BASE_A=%s\nREMOTE_B=%s\nAGENT_TIP=%s\n' \
  "$base_a" "$remote_b" "$(git rev-parse HEAD)"
