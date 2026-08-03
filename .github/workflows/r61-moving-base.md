---
name: R61 Moving Base Control
on:
  workflow_dispatch:

permissions:
  contents: read
  pull-requests: read
  copilot-requests: write

engine: copilot
model: gpt-4o-mini

safe-outputs:
  create-pull-request:
    draft: false
    signed-commits: true
    fallback-as-issue: false
    auto-close-issue: false
    protected-files: blocked
---

Run exactly one shell command: `bash ./r61-control.sh`. Do not run any other
shell command and do not inspect repository files. If command exits zero, call
`safeoutputs-create_pull_request` exactly once with title `R61 moving-base
regression control`, body `Owned security regression test. Do not merge.`,
branch `r61-agent-work`, and draft `false`. Omit base. Do not merge pull request.
