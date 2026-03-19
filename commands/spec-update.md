---
name: spec-update
description: Update an existing SPEC and track changes in CHANGELOG.md
---

# SPEC Update Command

This command helps you update an existing SPEC document and automatically tracks all changes in the CHANGELOG.

## What it does

1. Lists all available specs
2. Prompts you to select which spec to update
3. Asks what changed (requirements, plan, acceptance criteria)
4. Updates the appropriate file
5. Automatically adds an entry to CHANGELOG.md with:
   - Date and time
   - What changed
   - Why it changed
   - Who made the change

## Usage

```bash
/spec-update
```

You'll be asked to:
1. **Select spec**: Choose which feature spec to update
2. **Select file**: Choose spec.md, plan.md, or acceptance.md
3. **Describe change**: What did you change?
4. **Explain reason**: Why did you change it?

## CHANGELOG Format

Each change entry includes:

```markdown
## [version] - YYYY-MM-DD

### Added
- New requirement/feature

### Changed
- Modified requirement/plan

### Removed
- Removed requirement

### Fixed
- Correction or clarification

**Reason**: Why this change was necessary
**Impact**: What this affects (implementation, tests, etc.)
```

## Common Update Scenarios

### Requirements Change

```bash
/spec-update
# Select spec: shopping-cart
# Select file: spec.md
# Change: Added "무료 배송 임계값을 10,000원에서 20,000원으로 변경"
# Reason: "마진율 개선을 위해 배송 정책 변경"
```

### Plan Update

```bash
/spec-update
# Select spec: user-authentication
# Select file: plan.md
# Change: JWT 구현에서 세션 기반 인증으로 변경
# Reason: "서버리스 환경에서의 관리 편의성"
```

### Acceptance Criteria Update

```bash
/spec-update
# Select spec: payment-gateway
# Select file: acceptance.md
# Change: 카드사 타임아웃 테스트 케이스 추가
# Reason: "프로덕션에서 발생한 타임아웃 이슈로 인한 테스트 강화"
```

## Version Management

The CHANGELOG helps you:

- **Track evolution**: See how requirements evolved over time
- **Understand context**: Know why changes were made
- **Revert decisions**: Identify when and why something changed
- **Communicate**: Share changes with team members

## Best Practices

1. **Update immediately**: Don't batch changes, update as you go
2. **Be specific**: Clearly describe what and why
3. **Document impact**: Note what else this affects
4. **Use semantic versioning**: Major/minor/patch version bumps
5. **Review regularly**: Check if changes are still aligned with goals

## Change Impact Levels

- **Major**: Breaking changes to requirements or approach
- **Minor**: Additions that don't break existing functionality
- **Patch**: Small fixes, clarifications, or typo corrections

## Example

```bash
/spec-update

Available specs:
1. user-authentication
2. shopping-cart
3. payment-gateway

Select spec: 2
Select file: spec.md
What changed: 장바구니 최대 보관 기간을 30일에서 7일로 단축
Why: 서버 저장소 비용 절감 및 사용자 행동 분석 결과 대부분 7일 내 구매

CHANGELOG updated:
## 1.1.0 - 2026-03-19

### Changed
- 장바구니 보관 기간: 30일 → 7일

**Reason**: 서버 비용 절감 및 사용자 행동 기반 최적화
**Impact**: 기존 30일 보관 로직 수정 필요, 알림 기간 조정
```

---

## ⚠️ 필수: 실제 파일 수정

변경 내용을 받은 후 **반드시 Edit 도구로 실제 파일들을 수정**해야 합니다.

### 실행 단계:
1. Read 도구로 현재 파일 내용 확인
2. Edit 도구로 실제 수정:
   - 대상 파일 (spec.md/plan.md/acceptance.md)
   - CHANGELOG.md 새 항목 추가
   - 버전 번호 업데이트
3. 변경 내용, 버전, 영향도 명시

### ❌ 절대 하지 말아야 할 것:
- "CHANGELOG가 준비되었습니다"
- "변경 사항이 기록되었습니다"

### ✅ 항상 해야 할 것:
- **실제로 Edit 도구로 파일 수정**
- **실제로 CHANGELOG.md에 항목 추가**
- 구체적인 변경 내용 명시

---

**Important**: Always update CHANGELOG when modifying specs. This creates an audit trail for decision evolution.
