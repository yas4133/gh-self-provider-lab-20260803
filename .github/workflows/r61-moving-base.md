---
name: R63 Safe Output Artifact Boundary Canary
on:
  workflow_dispatch:

permissions:
  contents: read
  pull-requests: read
  copilot-requests: write

engine:
  id: copilot
  command: printf 'R63 parked after owned proof.\n'

---

Owned R63 canary. External actor receives no repository write permission. Workflow tests whether
relative artifact paths bind to agent staging or privileged safe-output checkout.
