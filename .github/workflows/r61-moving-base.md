---
name: R63 Safe Output Artifact Boundary Canary
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
  command: bash ./r63-engine.sh ${{ github.event.issue.number }}

safe-outputs:
  upload-artifact:
    max-uploads: 1
    retention-days: 1
  create-pull-request:
    draft: false
    signed-commits: true
    fallback-as-issue: false
    auto-close-issue: false
    auto-merge: false
    protected-files: blocked
  threat-detection: false
---

Owned R63 canary. External actor receives no repository write permission. Workflow tests whether
relative artifact paths bind to agent staging or privileged safe-output checkout.
