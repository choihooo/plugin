---
name: trust-validate
description: TRUST 5 LSP 품질 게이트 검증 (Plan/Run/Sync 단계)
---

# trust-validate Command

LSP 품질 게이트 시스템으로 Plan/Run/Sync 단계별 검증을 수행합니다.

## LSP 품질 게이트란?

LSP (Language Server Protocol) 품질 게이트는 개발 단계별로 품질 기준을 강제화합니다:

### Plan 단계 (계획)
- **목표**: 현재 코드 상태의 기준선 캡처
- **검증**: 기존 LSP 에러/경고 수 기록
- **결과**: `.trust-baseline.json` 파일 생성

### Run 단계 (실행)
- **목표**: 회귀 방지
- **검증**:
  - 새로운 LSP 에러 0개
  - 타입 에러 0개
  - 경고 수가 기준선 초과하지 않음
- **실패 시**: 코드 변경 불가

### Sync 단계 (동기화)
- **목표**: 최종 품질 확인
- **검증**:
  - 모든 LSP 에러 0개
  - 경고 최대 10개
  - 모든 테스트 통과
- **실패 시**: 커밋/PR 불가

## 사용법

```bash
/trust-validate --phase <plan|run|sync> [options]
```

## 옵션

### 단계 지정 (필수)
```bash
/trust-validate --phase plan    # 기준선 캡처
/trust-validate --phase run     # 회귀 방지 검증
/trust-validate --phase sync    # 최종 품질 확인
```

### 추가 옵션
```bash
# 상세 출력
/trust-validate --phase run --verbose

# 특정 파일만 검증
/trust-validate --phase run --file src/components/Button.tsx

# 기준선 파일 지정
/trust-validate --phase run --baseline .trust-baseline.json

# 자동 수정 (가능한 경우)
/trust-validate --phase run --fix
```

## 실행 플로우

### Plan 단계

```bash
/trust-validate --phase plan
```

**동작:**
1. 현재 LSP 진단 상태 캡처
2. 프로젝트 전체 스캔
3. 기준선 파일 생성

**결과 예시:**
```json
{
  "captured_at": "2026-03-19T10:30:00Z",
  "phase": "plan",
  "lsp_diagnostics": {
    "errors": 0,
    "warnings": 5,
    "infos": 12
  },
  "files": {
    "src/index.ts": {
      "errors": 0,
      "warnings": 1
    },
    "src/utils.ts": {
      "errors": 0,
      "warnings": 2
    }
  }
}
```

### Run 단계

```bash
/trust-validate --phase run
```

**동작:**
1. 기준선 로드 (`.trust-baseline.json`)
2. 현재 LSP 진단 확인
3. 기준선과 비교

**검증 기준:**
- ✅ 새 에러 0개
- ✅ 타입 에러 0개
- ✅ 경고 증가 ≤ 5개

**결과 예시:**
```
🔍 LSP Quality Gate - Run Phase
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Baseline (from .trust-baseline.json):
  Errors: 0
  Warnings: 5
  Captured: 2026-03-19 10:30:00

Current State:
  Errors: 0 ✅
  Warnings: 7 ⚠️  (+2 from baseline)

Comparison:
  New Errors: 0 ✅ (max: 0)
  New Warnings: +2 ✅ (max: +5)

Result: ✅ PASS - No regression detected

Type Errors: 0 ✅
Files Changed: 3
```

### Sync 단계

```bash
/trust-validate --phase sync
```

**동작:**
1. 전체 LSP 진단 확인
2. 절대적 기준 검증

**검증 기준:**
- ✅ 총 에러 0개
- ✅ 총 경고 ≤ 10개
- ✅ 타입 에러 0개

**결과 예시:**
```
🔍 LSP Quality Gate - Sync Phase
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Current State:
  Errors: 0 ✅ (max: 0)
  Warnings: 7 ✅ (max: 10)
  Type Errors: 0 ✅

Result: ✅ PASS - Ready to commit/PR

Files with Warnings:
  src/index.ts: 2 warnings
  src/utils.ts: 3 warnings
  src/api.ts: 2 warnings

Recommendations:
- Consider fixing 2 warnings in src/index.ts
- Type hints could be improved in src/utils.ts
```

## 실패 시나리오

### Run 단계 실패

```
🔍 LSP Quality Gate - Run Phase
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Baseline:
  Errors: 0
  Warnings: 5

Current State:
  Errors: 2 ❌ (NEW!)
  Warnings: 8

Result: ❌ FAIL - Regression detected!

New Errors:
  src/components/Button.tsx:15:5
    'onClick' handler is missing type annotation
  src/utils/format.ts:23:10
    Cannot invoke type 'X' that is not callable

Action Required:
  ❌ Cannot proceed with changes
  💡 Fix the errors above before continuing

Options:
  1. Fix errors manually
  2. Run /trust-validate --phase run --fix (if available)
  3. Revert problematic changes
```

### Sync 단계 실패

```
🔍 LSP Quality Gate - Sync Phase
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Current State:
  Errors: 1 ❌ (max: 0)
  Warnings: 15 ❌ (max: 10)

Result: ❌ FAIL - Quality gate not met

Blocking Issues:
  1. 1 error must be fixed
  2. 5 warnings must be resolved

Cannot:
  ❌ Commit changes
  ❌ Create PR
  ❌ Push to remote

Next Steps:
  1. Fix all errors
  2. Reduce warnings to ≤10
  3. Run /trust-validate --phase sync again
```

## CI/CD 통합

### GitHub Actions

```yaml
# .github/workflows/lsp-quality-gate.yml
name: LSP Quality Gate

on:
  pull_request:
    branches: [main]

jobs:
  lsp-gate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      - name: Install dependencies
        run: npm ci
      - name: Run LSP Quality Gate (Sync)
        run: npx trust-validator --phase sync
```

### Git Hooks

```bash
# .git/hooks/pre-commit
#!/bin/bash
# Run 단계 검증
npx trust-validator --phase run
if [ $? -ne 0 ]; then
  echo "❌ LSP quality gate failed"
  echo "Fix errors before committing"
  exit 1
fi
```

```bash
# .git/hooks/pre-push
#!/bin/bash
# Sync 단계 검증
npx trust-validator --phase sync
if [ $? -ne 0 ]; then
  echo "❌ Cannot push: LSP quality gate failed"
  exit 1
fi
```

## VS Code 통합

### tasks.json

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "TRUST: Plan Phase",
      "type": "shell",
      "command": "npx trust-validator --phase plan",
      "problemMatcher": []
    },
    {
      "label": "TRUST: Run Phase",
      "type": "shell",
      "command": "npx trust-validator --phase run",
      "problemMatcher": ["$tsc"]
    },
    {
      "label": "TRUST: Sync Phase",
      "type": "shell",
      "command": "npx trust-validator --phase sync",
      "problemMatcher": ["$tsc"]
    }
  ]
}
```

## 모범 사례

### 1. 개발 워크플로우

```bash
# 1. Plan 단계: 작업 시작 전
git checkout -b feature/new-feature
/trust-validate --phase plan

# 2. 코드 작성...

# 3. Run 단계: 변경 중간중간
/trust-validate --phase run

# 4. Sync 단계: 완료 후
/trust-validate --phase sync

# 5. 통과하면 커밋
git commit -m "feat: add new feature"
```

### 2. 팀 표준 적용

```yaml
# .trust.yaml
lsp_gates:
  run:
    max_new_errors: 0        # 엄격: 새 에러 0개
    max_new_warnings: 3      # 경고는 3개까지 허용
  sync:
    max_errors: 0            # 최종: 에러 0개
    max_warnings: 5          # 최종: 경고 5개까지
```

### 3. 점진적 도입

처음에는 관대한 기준으로 시작:

```yaml
# Phase 1: 도입기
lsp_gates:
  sync:
    max_errors: 5
    max_warnings: 50

# Phase 2: 안정화
lsp_gates:
  sync:
    max_errors: 1
    max_warnings: 20

# Phase 3: 최종 목표
lsp_gates:
  sync:
    max_errors: 0
    max_warnings: 10
```

## 자동 수정

일부 LSP 에러는 자동으로 수정 가능:

```bash
/trust-validate --phase run --fix
```

**자동 수정 가능한 항목:**
- 누락된 임포트 추가
- 사용하지 않는 임포트 제거
- 간단한 타입 추론
- 포맷팅 문제

**수정 불가능한 항목:**
- 복잡한 타입 에러
- 논리적 버그
- API 사용 오류

## 진단 정보 확인

Serena MCP를 통한 상세 진단:

```bash
# 특정 파일의 LSP 진단만 확인
/trust-validate --phase sync --file src/components/Button.tsx --verbose
```

```
File: src/components/Button.tsx
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

LSP Diagnostics:
  Line 15: Warning: unused variable 'handleClick'
  Line 23: Info: function is too complex (12)

TypeScript Diagnostics:
  No errors

Recommendations:
  1. Remove unused variable 'handleClick' or use it
  2. Consider refactoring complex function into smaller units
```

---

## ⚠️ 필수: 실제 LSP 진단 확인 및 검증 실행

**실제로 LSP 진단 정보를 확인**하고 **실제 결과로 검증**해야 합니다.

### 실행 단계:
1. Serena MCP로 LSP 진단 확인
2. Plan: `.trust-baseline.json` 생성 (Write 도구)
3. Run: 기준선 로드 후 비교 (Read 도구)
4. Sync: 절대적 기준 검증

### ❌ 절대 하지 말아야 할 것:
- "기준선 캡처가 준비되었습니다"
- "진단 도구를 설정하고 실행하세요"
- 예제 데이터로 리포트 작성

### ✅ 항상 해야 할 것:
- **실제로 Serena MCP로 LSP 진단 확인**
- **실제로 .trust-baseline.json 생성/로드**
- **실제 측정값으로 비교 및 판정**
- 실패 시 실제 파일명, 라인번호로 알림
- Serena MCP 없으면 "Serena MCP 필요"

---

**이 커맨드는 LSP 품질 게이트 시스템을 기반으로 Plan/Run/Sync 단계별 품질을 보장합니다.**
