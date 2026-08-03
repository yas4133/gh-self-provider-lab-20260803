#!/usr/bin/env bash
set -euo pipefail

issue_number="${1:?issue number required}"
[[ "$issue_number" =~ ^[0-9]+$ ]]
test "$GITHUB_ACTOR" = "yas413"

test -f r61-outsider-concurrent-canary-2.txt

branch="r62-warning-automerge-${GITHUB_RUN_ID}"
git switch -c "$branch"
git rm r61-outsider-concurrent-canary-2.txt
printf 'External issue actor %s triggered bounded owned canary workflow from issue #%s.\n' \
  "$GITHUB_ACTOR" "$issue_number" > r62-outsider-proof.txt
git add r62-outsider-proof.txt
git commit -m 'R62 owned warning auto-merge control'

safeoutputs create_pull_request \
  --title 'R62 owned threat-warning auto-merge control' \
  --body 'Bounded security regression test. Threat-warning path must require human review before merge.' \
  --branch "$branch" \
  --draft false
