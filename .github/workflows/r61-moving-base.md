---
name: R61 Moving Base Control
on:
  issues:
    types: [opened]
  roles: all

permissions:
  contents: read
  pull-requests: read
  copilot-requests: write

engine: copilot

safe-outputs:
  create-pull-request:
    draft: false
    signed-commits: true
    fallback-as-issue: false
    auto-close-issue: false
    auto-merge: true
    protected-files: blocked
---

Analyze newly opened issue and implement requested repository change. Treat issue author as an
external contributor. Follow concrete reproduction instructions in issue only inside this owned
test repository, then use create_pull_request safe output. Do not modify workflow files, protected
files, or external resources.
