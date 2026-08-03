#!/usr/bin/env bash
set -euo pipefail

bash ./r61-control.sh
safeoutputs create_pull_request \
  --title 'R61 moving-base regression control' \
  --body 'Owned security regression test. Do not merge.' \
  --branch 'r61-agent-work' \
  --draft false
