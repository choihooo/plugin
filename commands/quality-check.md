---
name: quality-check
description: TRUST 5 품질 검증 실행 및 리포트 생성
---

# quality-check Command

TRUST 5 품질 기준으로 프로젝트를 검증하고 리포트를 생성합니다.

## 사용법

```bash
/quality-check [options]
```

## 옵션

### 전체 검증 (기본)
```bash
/quality-check
```
모든 TRUST 5 항목을 검증합니다.

### 특정 항목만 검증
```bash
/quality-check --tested
/quality-check --readable
/quality-check --unified
/quality-check --secured
/quality-check --trackable
```

### LSP 페이즈 지정
```bash
/quality-check --phase plan    # 기준선 캡처
/quality-check --phase run     # 회귀 방지 검증
/quality-check --phase sync    # 최종 품질 확인
```

### 상세 모드
```bash
/quality-check --verbose
```
모든 검증 결과를 상세히 표시합니다.

### 파일/디렉토리 지정
```bash
/quality-check src/components/Button.tsx
/quality-check src/
```

### 자동 수정
```bash
/quality-check --fix
```
자동으로 수정 가능한 항목을 수정합니다.

### 설정 파일 지정
```bash
/quality-check --config .trust.yaml
```

## 실행 단계

### 1단계: 환경 확인

프로젝트 타입을 감지하고 해당 도구들을 확인합니다:

```javascript
// 프로젝트 타입 감지
if (exists('package.json')) {
  // Node.js 프로젝트
  frameworks = ['jest', 'vitest', 'eslint', 'prettier', 'npm']
} else if (exists('pyproject.toml') || exists('requirements.txt')) {
  // Python 프로젝트
  frameworks = ['pytest', 'ruff', 'black', 'pip']
} else if (exists('go.mod')) {
  // Go 프로젝트
  frameworks = ['go test', 'gofmt', 'golint']
}
```

### 2단계: TRUST 5 검증 실행

#### Tested (테스트 완료)

```bash
# TypeScript/JavaScript
npm run test -- --coverage --watchAll=false

# Python
pytest --cov=src --cov-report=term-missing --cov-fail-under=85

# Go
go test -coverprofile=coverage.out && go tool cover -func=coverage.out
```

**기준:**
- ✅ PASS: 85%+ 커버리지
- ⚠️ WARN: 70-84% 커버리지
- ❌ FAIL: <70% 커버리지

#### Readable (가독성)

```bash
# TypeScript/JavaScript
npm run lint

# Python
ruff check src/
flake8 src/ --max-complexity=10

# Go
golint ./...
```

**기준:**
- ✅ PASS: 0 에러
- ⚠️ WARN: 0 에러, 경고 10개 이하
- ❌ FAIL: 1개 이상 에러

#### Unified (통일성)

```bash
# TypeScript/JavaScript
npm run format:check

# Python
ruff format --check src/
black --check src/

# Go
gofmt -l .
```

**기준:**
- ✅ PASS: 0 포맷 불일합
- ❌ FAIL: 1개 이상 불일합

#### Secured (보안)

```bash
# TypeScript/JavaScript
npm audit --production
snyk test

# Python
safety check
bandit -r src/

# Go
go run golang.org/x/vuln/cmd/govulncheck@latest ./...
```

**기준:**
- ✅ PASS: 0 취약점
- ⚠️ WARN: 낮은 심각성 취약점
- ❌ FAIL: 높은/중간 심각성 취약점

#### Trackable (추적 가능성)

```bash
# 커밋 메시지 검증
git log -1 --pretty=%B | commitlint

# CHANGELOG 확인
if [ ! -f "CHANGELOG.md" ]; then
  echo "❌ CHANGELOG.md not found"
fi

# SPEC 버전 확인 (해당하는 경우)
if [ -d "docs/specs" ]; then
  # SPEC 버전이 업데이트되었는지 확인
fi
```

**기준:**
- ✅ PASS: 커밋 형식 준수, CHANGELOG 업데이트됨
- ❌ FAIL: 커밋 형식 오류

### 3단계: LSP 진단 확인

Serena MCP 또는 LSP 도구를 사용하여 진단 정보를 가져옵니다:

```javascript
// Serena의 get_symbols_overview 또는 search_for_pattern 사용
// LSP 진단 에러/경고 수 확인

const diagnostics = await getLSPPDiagnostics();
const errors = diagnostics.filter(d => d.severity === 'error').length;
const warnings = diagnostics.filter(d => d.severity === 'warning').length;
```

**기준:**
- ✅ PASS: 0 에러, 경고 10개 이하
- ⚠️ WARN: 0 에러, 경고 11-20개
- ❌ FAIL: 1개 이상 에러 또는 경고 20개 초과

### 4단계: 결과 리포트 생성

```
🔍 TRUST 5 Quality Gate Report
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ Tested: PASS (87.3% coverage)
   ├─ Statements: 89.2%
   ├─ Branches: 85.1%
   ├─ Functions: 88.4%
   └─ Lines: 86.5%

✅ Readable: PASS (0 errors, 3 warnings)
   ├─ ESLint: 0 errors, 2 warnings
   ├─ TypeScript: 0 errors
   └─ Complexity: avg 4.2 (max 10)

✅ Unified: PASS (0 format issues)
   ├─ Prettier: All files formatted
   └─ Import order: Consistent

⚠️  Secured: WARN (1 moderate vulnerability)
   ├─ npm audit: 1 moderate
   │  └─ lodash 4.17.15 → 4.17.21 (Prototype Pollution)
   ├─ Snyk: 0 vulnerabilities
   └─ Secrets scan: 0 found

   💡 Recommendations:
   - Run: npm update lodash
   - Or: npm audit fix

✅ Trackable: PASS
   ├─ Commit format: ✅ feat(shopping-cart): add item removal
   ├─ CHANGELOG: ✅ Updated
   └─ Issue reference: N/A

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
LSP Diagnostics:
   ├─ Errors: 0 ✅
   ├─ Warnings: 3 ✅
   └─ Info: 12

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Overall Result: ⚠️  WARN with suggestions

Phase: sync
Time: 2.3s

Next Steps:
1. Update lodash to fix security vulnerability
2. (Optional) Address 3 lint warnings
3. You're good to commit! 🚀
```

### 5단계: 자동 수정 (선택)

`--fix` 옵션이 있는 경우 자동 수정 가능한 항목을 수정:

```bash
# 포맷팅 수정
npm run format

# Lint 자동 수정
npm run lint -- --fix

# 보안 취약점 수정 (주의 필요)
npm audit fix
```

수정 후 재검증하여 결과를 표시합니다.

## 종료 코드

- **0**: 모든 항목 PASS
- **1**: 하나 이상 FAIL
- **2**: 치명적 에러 (보안, 타입 에러)
- **3**: 설정 파일 오류

## 예시

### 예시 1: 전체 검증 (성공)

```bash
/quality-check
```

```
✅ Tested: PASS (91% coverage)
✅ Readable: PASS (0 errors)
✅ Unified: PASS (0 format issues)
✅ Secured: PASS (0 vulnerabilities)
✅ Trackable: PASS (commit OK)

Overall: ✅ PASS - Ready to commit!
```

### 예시 2: 보안 취약점 발견

```bash
/quality-check
```

```
✅ Tested: PASS
✅ Readable: PASS
✅ Unified: PASS
❌ Secured: FAIL (2 high severity vulnerabilities)
   └─ axios 0.21.1: SSRF vulnerability
   └─ lodash 4.17.15: Prototype Pollution

Overall: ❌ FAIL - Fix security issues first

Recommendations:
- npm audit fix --force
- Or manually update packages
```

### 예시 3: 테스트 커버리지 부족

```bash
/quality-check --tested
```

```
❌ Tested: FAIL (64% coverage, required: 85%)

Uncovered files:
- src/components/Button.tsx: 45%
- src/utils/format.ts: 32%
- src/api/cart.ts: 78%

Recommendations:
- Add tests for Button component
- Add tests for format utility
- Improve cart API tests coverage
```

## CI/CD 통합

```yaml
# .github/workflows/quality.yml
name: Quality Gate

on:
  pull_request:
    branches: [main]

jobs:
  quality-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - run: npm ci
      - name: Run TRUST 5 Validation
        run: npm run quality-check
        env:
          PHASE: sync
```

## Git Hook 통합

```bash
# .git/hooks/pre-commit
#!/bin/bash
npm run quality-check --phase run
if [ $? -ne 0 ]; then
  echo "❌ Quality gate failed. Commit aborted."
  exit 1
fi
```

---

**이 커맨드는 TRUST 5 프레임워크를 기반으로 자동으로 품질을 검증합니다.**
