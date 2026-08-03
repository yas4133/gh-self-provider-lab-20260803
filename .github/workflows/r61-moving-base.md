---
name: R62 Threat Warning Auto-Merge Control
on:
  workflow_dispatch:

permissions:
  contents: read
  pull-requests: read
  copilot-requests: write

engine:
  id: copilot
  command: safeoutputs noop --message 'Owned regression workflow parked.'

safe-outputs:
  create-pull-request:
    draft: false
    signed-commits: true
    fallback-as-issue: false
    auto-close-issue: false
    auto-merge: false
    protected-files: blocked
---

Owned regression workflow parked after bounded test.
