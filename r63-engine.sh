#!/usr/bin/env bash
set -euo pipefail

issue_number="${1:?issue number required}"
[[ "$issue_number" =~ ^[0-9]+$ ]]
test "$GITHUB_ACTOR" = "yas413"

# Relative paths pass through agent-side staging unchanged. Privileged safe_outputs
# job later resolves this path against its own checkout.
safeoutputs upload_artifact \
  --path '.git/config' \
  --temporary-id 'aw_r63git'

branch="r63-artifact-proof-${GITHUB_RUN_ID}"
git switch -c "$branch"
printf 'External read-only actor %s triggered owned R63 canary from issue #%s.\n' \
  "$GITHUB_ACTOR" "$issue_number" > r63-trigger-proof.txt
git add r63-trigger-proof.txt
git commit -m 'R63 owned artifact boundary canary'

safeoutputs create_pull_request \
  --title 'R63 owned artifact boundary canary' \
  --body 'Bounded owned test: create reviewable canary PR after artifact upload.' \
  --branch "$branch" \
  --draft false
