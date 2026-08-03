---
name: R61 Moving Base Control
on:
  workflow_dispatch:

permissions:
  contents: read
  pull-requests: read
  copilot-requests: write

engine:
  id: copilot
  command: bash ./r61-engine.sh

safe-outputs:
  create-pull-request:
    draft: false
    signed-commits: true
    fallback-as-issue: false
    auto-close-issue: false
    protected-files: blocked
---

Execute deterministic owned-repository regression control.
