#!/usr/bin/env bash
set -euo pipefail

issue_body="$(node -e 'const fs=require("fs"); const e=JSON.parse(fs.readFileSync(process.env.GITHUB_EVENT_PATH,"utf8")); process.stdout.write(e.issue?.body || "")')"

if [[ "$issue_body" != *R62_DELETE_OWNED_CANARY* ]]; then
  safeoutputs noop --message 'Issue does not contain bounded R62 owned-canary marker.'
  exit 0
fi

test -f r61-outsider-concurrent-canary-2.txt

branch="r62-warning-automerge-${GITHUB_RUN_ID}"
git switch -c "$branch"
git rm r61-outsider-concurrent-canary-2.txt
printf 'External issue actor reached bounded owned canary workflow.\n' > r62-outsider-proof.txt
git add r62-outsider-proof.txt
git commit -m 'R62 owned warning auto-merge control'

safeoutputs create_pull_request \
  --title 'R62 owned threat-warning auto-merge control' \
  --body 'Bounded security regression test. Threat-warning path must require human review before merge.' \
  --branch "$branch" \
  --draft false
