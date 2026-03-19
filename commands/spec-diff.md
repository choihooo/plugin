---
name: spec-diff
description: Compare different versions of a SPEC using CHANGELOG history
---

# SPEC Diff Command

This command shows you how a SPEC has evolved over time by comparing different versions.

## What it does

1. Lists all available specs
2. Shows CHANGELOG history for selected spec
3. Displays differences between versions
4. Highlights requirement changes, plan updates, and acceptance criteria modifications

## Usage

```bash
/spec-diff
```

You'll be prompted to:
1. **Select spec**: Choose which feature to compare
2. **Select versions**: Choose two versions to compare (optional)

## Output Format

```
SPEC: user-authentication
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Version History:
  v1.0.0 (2026-03-15) - Initial
  v1.1.0 (2026-03-17) - Added OAuth
  v1.2.0 (2026-03-19) - Added 2FA

Changes between v1.0.0 and v1.2.0:

spec.md:
  + Added: OAuth 2.0 지원 (Event-driven)
  + Added: 2단계 인증 (Ubiquitous)
  ~ Modified: 세션 만료 24시간 → 1시간

plan.md:
  + Added: OAuth provider integration tasks
  ~ Changed: JWT implementation → Session + JWT hybrid

acceptance.md:
  + Added: OAuth login scenario
  + Added: 2FA verification scenario
```

## Legend

- **+ Added**: New requirement/task/criteria
- **~ Changed**: Modified content
- **- Removed**: Deleted content
- **✓ Fixed**: Corrections or clarifications

## Use Cases

### Before Implementation

Check if requirements are stable:
```bash
/spec-diff
# Select: payment-gateway
# See: How many changes in past week?
# Decide: Is it stable enough to implement?
```

### During Development

See what changed since you started:
```bash
/spec-diff
# Select: shopping-cart
# Compare: v1.0.0 (when started) vs v1.3.0 (current)
# Identify: What new requirements were added?
```

### Post-Implementation

Review what changed during development:
```bash
/spec-diff
# Select: user-authentication
# See full history: From DRAFT to COMPLETED
# Learn: What requirements evolved and why?
```

### Team Handoff

Show new team member the evolution:
```bash
/spec-diff
# Select: feature-name
# Export: Send diff to new developer
# Context: "This is how we got here"
```

## Filtering Options

```bash
/spec-diff --file=spec.md         # Show only requirement changes
/spec-diff --file=plan.md         # Show only plan changes
/spec-diff --days=7               # Show changes in last 7 days
/spec-diff --status=IN_PROGRESS   # Show only active specs
```

## Analyzing Change Patterns

Use `/spec-diff` to identify:

1. **Unstable requirements**: Frequent changes indicate unclear requirements
2. **Scope creep**: New requirements constantly being added
3. **Plan volatility**: Implementation approach keeps changing
4. **Acceptance drift**: Test criteria evolving late in process

## Best Practices

1. **Review before implementing**: Ensure requirements are stable
2. **Check impact**: Understand what changes affect what
3. **Document decisions**: Use CHANGELOG to explain "why"
4. **Communicate changes**: Share diffs with team
5. **Learn from history**: See patterns in requirement evolution

## Example Session

```bash
/spec-diff

Available specs:
  1. user-authentication (v1.2.0, ACTIVE)
  2. shopping-cart (v2.0.0, COMPLETED)
  3. payment-gateway (v1.0.0, DRAFT)

Select spec: 1

╸ SPEC: user-authentication ╺
Version: v1.2.0 | Status: ACTIVE | Last updated: 2026-03-19

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Version History:
  v1.0.0 (2026-03-15) - Initial requirements
  v1.1.0 (2026-03-17) - Added OAuth support
  v1.2.0 (2026-03-19) - Added 2FA

Recent changes (v1.1.0 → v1.2.0):

spec.md:
  + [Ubiquitous] 시스템은 모든 사용자에게 2단계 인증을 제공해야 한다
  + [Event-driven] WHEN 로그인 시도가 3회 실패하면, THEN 2FA 요구해야 한다
  ~ [Event-driven] 세션 만료: 24시간 → 1시간

Impact:
  - Plan: 2FA implementation tasks added
  - Acceptance: 2FA scenarios added
  - Effort: +3 days estimated

Recommendation: Requirements appear stable. Safe to implement.
```

---

## ⚠️ 필수: 실제 파일 읽기 및 비교

**실제로 CHANGELOG.md 파일을 읽고** **실제 버전 차이를 표시**해야 합니다.

### 실행 단계:
1. Bash 도구로 `find docs/specs -name "CHANGELOG.md"`
2. Read 도구로 CHANGELOG.md 읽기
3. 실제 버전 히스토리, 변경사항 비교

### ❌ 절대 하지 말아야 할 것:
- 예제 diff 데이터 표시
- "변경 추적 형식입니다"

### ✅ 항상 해야 할 것:
- **실제로 Read 도구로 CHANGELOG.md 읽기**
- **실제 버전 히스토리 표시**
- CHANGELOG 없으면 "No change history found"

---

**Tip**: Use `/spec-diff` before starting implementation to ensure requirements won't change mid-development.
