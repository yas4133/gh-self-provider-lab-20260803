---
name: R62 Threat Warning Auto-Merge Control
on:
  issues:
    types: [opened]
  roles: all

permissions:
  contents: read
  pull-requests: read
  copilot-requests: write

engine:
  id: copilot
  model: gpt-5.4
  command: bash ./r62-engine.sh ${{ github.event.issue.number }}

safe-outputs:
  create-pull-request:
    draft: false
    signed-commits: true
    fallback-as-issue: false
    auto-close-issue: false
    auto-merge: true
    protected-files: blocked
---

Run bounded owned-repository detected-threat/auto-merge regression control.
