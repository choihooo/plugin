---
name: spec-list
description: List all SPEC documents with their status, lifecycle stage, and key information
---

# SPEC List Command

This command displays all feature specifications in your project with their current status and key information.

## What it does

Scans the `docs/specs/` directory and displays:
- Feature name and description
- SPEC lifecycle stage (DRAFT, ACTIVE, IN_PROGRESS, COMPLETED, REJECTED)
- Current version
- Last update date
- Quick summary if available

## Usage

```bash
/spec-list
```

## Output Format

```
Feature Specifications
======================

📋 user-authentication
   Status: IN_PROGRESS | Version: 1.2.0 | Updated: 2026-03-19
   Summary: 사용자 로그인, OAuth, 2FA 기능
   Progress: ████████░░ 80% (4/5 tasks complete)

📋 shopping-cart
   Status: COMPLETED | Version: 2.0.0 | Updated: 2026-03-18
   Summary: 장바구니 관리, 수량 변경, 결제 연동
   Progress: ██████████ 100% (All acceptance criteria passed)

📋 payment-gateway
   Status: DRAFT | Version: 0.1.0 | Updated: 2026-03-19
   Summary: 결제 게이트웨이 연동 (카드, 간편결제)
   Progress: ░░░░░░░░░░ 0% (Requirements gathering)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Total: 3 specs (1 DRAFT, 1 IN_PROGRESS, 1 COMPLETED)
```

## Filtering

Filter by lifecycle stage:

```bash
/spec-list --status=DRAFT        # Show only draft specs
/spec-list --status=ACTIVE       # Show only active specs
/spec-list --status=IN_PROGRESS  # Show only specs in progress
/spec-list --status=COMPLETED    # Show only completed specs
/spec-list --status=REJECTED     # Show only rejected specs
```

Filter by recency:

```bash
/spec-list --days=7              # Show specs updated in last 7 days
/spec-list --recent              # Show 5 most recently updated
```

## Status Indicators

- **📋 DRAFT**: Requirements being defined, not ready for implementation
- **✅ ACTIVE**: Requirements finalized, ready to start implementation
- **🚧 IN_PROGRESS**: Implementation in progress
- **✅ COMPLETED**: Feature implemented and acceptance criteria passed
- **❌ REJECTED**: Feature cancelled or rejected

## Use Cases

### Project Overview

Get a quick overview of all features:
```bash
/spec-list
# See: What features are planned?
# See: What's currently being worked on?
# See: What's been completed?
```

### Planning Meeting

Show stakeholders project status:
```bash
/spec-list
# Display: All features with progress
# Discuss: Priorities and timelines
```

### Before Starting Work

Check if spec is ready for implementation:
```bash
/spec-list --status=ACTIVE
# Find: Specs ready to start
# Avoid: Starting on DRAFT specs
```

### Impact Analysis

See what might be affected by changes:
```bash
/spec-list
# Identify: Related features
# Assess: Change impact scope
```

## Lifecycle Management

Update spec status as you progress:

```bash
# When requirements are finalized
/spec-update
# Change status: DRAFT → ACTIVE

# When you start implementation
/spec-update
# Change status: ACTIVE → IN_PROGRESS

# When implementation is complete
/spec-update
# Change status: IN_PROGRESS → COMPLETED
```

## Progress Tracking

Each spec can show progress based on:

- **Tasks completed** in plan.md
- **Acceptance criteria passed** in acceptance.md
- **Manual progress percentage** in spec.md

## Statistics

The command also shows project-level statistics:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Project Statistics
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Total specs: 8
Completed: 3 (37.5%)
In Progress: 2 (25%)
Active (ready to start): 2 (25%)
Draft (not ready): 1 (12.5%)

Average completion time: 12 days
Most changed spec: payment-gateway (7 versions)
Least stable spec: user-profile (3 changes this week)

Recommendations:
  • Start on: email-notifications (ACTIVE, stable)
  • Review: payment-gateway (too many changes)
  • Archive: old-mobile-api (REJECTED)
```

## Best Practices

1. **Keep status current**: Update status as specs progress
2. **Review regularly**: Check if draft specs need attention
3. **Track metrics**: Monitor completion times and change frequency
4. **Use filters**: Focus on relevant specs for your context
5. **Archive completed**: Keep completed specs for reference

## Export Options

Export spec list for documentation:

```bash
/spec-list --format=markdown > SPECS.md
/spec-list --format=json > spec-list.json
/spec-list --format=csv > specs.csv
```

## Example Session

```bash
/spec-list --status=IN_PROGRESS

Currently Implementing
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚧 user-authentication
   Status: IN_PROGRESS | Version: 1.2.0 | Updated: 2026-03-19
   Progress: 80% (4/5 tasks)
   Blocking: OAuth provider API limit
   Next: 2FA implementation

🚧 order-management
   Status: IN_PROGRESS | Version: 1.0.0 | Updated: 2026-03-18
   Progress: 60% (3/5 tasks)
   Blocking: Database schema pending approval
   Next: Order status workflow

Total: 2 specs in progress

Action items:
  • Unblock user-authentication: Contact OAuth provider
  • Unblock order-management: Schedule schema review
```

---

**Tip**: Use `/spec-list` daily to track project progress and identify blocked specs.
