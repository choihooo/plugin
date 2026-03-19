---
name: trust-validator
description: TRUST 5 품질 기준 자동 검증 및 품질 게이트 강제화
version: 1.0.0
---

# TRUST Validator Skill

TRUST 5 품질 프레임워크를 자동으로 검증하고 강제화합니다.

## 활성화 조건

다음 상황에서 자동으로 활성화됩니다:

- 코드 변경 (Write, Edit 도구 사용)
- 커밋 메시지 작성
- PR 생성 시점
- "/quality-check" 커맨드 실행
- "/trust-validate" 커맨드 실행

## TRUST 5 원칙

### T - Tested (테스트 완료)
- **기준**: 테스트 커버리지 85% 이상
- **검증 항목**:
  - 유닛 테스트 존재 여부
  - 테스트 커버리지 비율
  - 타입 에러 0개
  - 실패하는 테스트 0개

### R - Readable (가독성)
- **기준**: Lint 에러 0개, 명확한 네이밍
- **검증 항목**:
  - ESLint/Flake8 에러 0개
  - 함수/변수 네이밍 컨벤션 준수
  - 복잡도 임계값 초과 여부
  - 주석 및 문서화 존재 여부

### U - Unified (통일성)
- **기준**: 일관된 코드 스타일, 프로젝트 표준 준수
- **검증 항목**:
  - 코드 포맷팅 (ruff/black, prettier)
  - 일관된 임포트 순서
  - 프로젝트 구조 표준 준수
  - EARS 형식 요구사항 준수 (SPEC 파일)

### S - Secured (보안)
- **기준**: OWASP Top 10 준수, 보안 경고 0개
- **검증 항목**:
  - SQL Injection 취약점
  - XSS 취약점
  - 하드코딩된 시크릿/키
  - 의존성 취약점 (npm audit, pip-audit)
  - 권한 검증 누락

### T - Trackable (추적 가능성)
- **기준**: Conventional Commits, 변경 추적 가능
- **검증 항목**:
  - 커밋 메시지 Conventional Commits 형식 준수
  - CHANGELOG.md 업데이트 여부
  - 이슈/PR 참조 포함 여부
  - SPEC 버전 업데이트 여부

## LSP 품질 게이트

### Plan 단계 (계획)
- **목표**: 기준 상태 캡처
- **검증**:
  - 현재 LSP 진단 캡처
  - 기존 에러/경고 수 기록
  - 테스트 커버리지 기준선 설정

### Run 단계 (실행)
- **목표**: 회귀 방지
- **검증**:
  - LSP 에러 0개 (新增)
  - 타입 에러 0개
  - 기존 경고 수 초과 금지
  - 테스트 커버리지 저하 금지

### Sync 단계 (동기화)
- **목표**: 최종 품질 확인
- **검증**:
  - LSP 에러 0개
  - 경고 최대 10개
  - 모든 테스트 통과
  - 커밋 메시지 형식 검증

## 검증 플로우

### 1단계: 변경 감지

코드 변경이 감지되면 자동으로 검증 시작:

```
파일 변경 감지
↓
파일 타입 식별 (TypeScript, Python, etc.)
↓
해당 언어의 LSP 진단 요청
↓
TRUST 5 항목별 검증 실행
```

### 2단계: 항목별 검증

**Tested 검증:**
```bash
# 테스트 커버리지 확인
npm run test -- --coverage
# 또
pytest --cov=src --cov-report=term-missing

# 기준: 85% 이상 통과
```

**Readable 검증:**
```bash
# Lint 검증
npm run lint
# 또
ruff check src/
flake8 src/

# 기준: 에러 0개
```

**Unified 검증:**
```bash
# 포맷팅 검증
npm run format:check
# 또
ruff format --check src/
black --check src/

# 기준: 포맷 불일합 0개
```

**Secured 검증:**
```bash
# 보안 스캔
npm audit
# 또
safety check
bandit -r src/

# 기준: 취약점 0개, 높은 심각성 0개
```

**Trackable 검증:**
```bash
# 커밋 메시지 검증 (Conventional Commits)
commitlint --edit

# CHANGELOG 확인
grep -q "## [0-9]" CHANGELOG.md

# 기준: 형식 준수, CHANGELOG 업데이트됨
```

### 3단계: 결과 판정

**PASS 조건 (모두 충족):**
- ✅ Tested: 85%+ 커버리지, 0 타입 에러
- ✅ Readable: 0 lint 에러
- ✅ Unified: 0 포맷 불일합
- ✅ Secured: 0 보안 취약점
- ✅ Trackable: 커밋 형식 준수, CHANGELOG 업데이트

**FAIL 조건 (하나라도 실패):**
- ❌ 어느 항목이든 기준 미충족

### 4단계: 자동 수정 (Ralph Engine 스타일)

수정 가능한 항목은 자동으로 수정 시도:

```bash
# 포맷팅 자동 수정
npm run format
# 또
ruff format src/
black src/

# 간단한 Lint 자동 수정
npm run lint -- --fix
# 또
ruff check --fix src/
```

수정 후 재검증 → PASS면 계속 진행

### 5단계: 결과 리포트

검증 결과를 사용자에게 표시:

```
🔍 TRUST 5 Quality Gate Report

✅ Tested: PASS (87% coverage)
✅ Readable: PASS (0 errors)
✅ Unified: PASS (0 format issues)
⚠️  Secured: WARN (1 moderate vulnerability found)
✅ Trackable: PASS (commit format OK)

Overall: ⚠️  WARN with suggestions

Recommendations:
- Update 'lodash' from 4.17.15 to 4.17.21 (npm audit fix)
```

## 에러 처리

### 치명적 에러 (작업 중단)

다음 경우는 즉시 작업 중단:

1. **Tested FAIL**:
   - 테스트 커버리지 70% 미만
   - 타입 에러 1개 이상

2. **Secured FAIL**:
   - 높은 심각성의 보안 취약점
   - 하드코딩된 시크릭 노출

3. **Trackable FAIL**:
   - 커밋 메시지 형식 오류

### 경고 (계속 진행 가능)

다음 경우는 경고로 표시하고 계속 진행:

1. 테스트 커버리지 70-84%
2. 보안 취약점 (낮은 심각성)
3. Lint 경고 10개 이하
4. 일부 포맷 불일합 (자동 수정 가능)

## 수동 검증

사용자가 직접 품질 검증을 실행할 때:

```bash
# 전체 검증
/quality-check

# 특정 항목만 검증
/quality-check --tested
/quality-check --secured

# 특정 파일만 검증
/quality-check src/components/Button.tsx

# 상세 리포트
/quality-check --verbose
```

## 설정 파일

프로젝트 루트에 `.trust.yaml` 생성:

```yaml
# TRUST 5 품질 설정
version: 1.0.0

# Tested 설정
tested:
  min_coverage: 85
  fail_below: 70
  frameworks:
    - jest
    - vitest
    - pytest

# Readable 설정
readable:
  linters:
    - eslint
    - ruff
    - flake8
  max_complexity: 10

# Unified 설정
unified:
  formatters:
    - prettier
    - ruff
    - black
  line_length: 100

# Secured 설정
secured:
  auditors:
    - npm
    - safety
    - bandit
  ignore_vulnerabilities:
    - low

# Trackable 설정
trackable:
  commit_format: conventional
  changelog_required: true
  issue_reference_required: false

# LSP 게이트 설정
lsp_gates:
  plan:
    capture_baseline: true
  run:
    max_new_errors: 0
    allow_type_errors: false
  sync:
    max_errors: 0
    max_warnings: 10

# 자동 수정 설정
auto_fix:
  format: true
  lint_fix: true
  security_fix: false  # 보안은 수동 검토
```

## 통합

### Git Hooks와 통합

```bash
# pre-commit: 포맷팅 & Lint
pre-commit → trust-validator --phase run

# pre-push: 전체 검증
pre-push → trust-validator --phase sync

# commit-msg: 커밋 메시지 검증
commit-msg → trust-validator --trackable
```

### CI/CD 파이프라인과 통합

```yaml
# .github/workflows/quality.yml
name: TRUST 5 Quality Gate

on: [pull_request]

jobs:
  quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run TRUST 5 Validation
        run: npx trust-validator --phase sync
```

## 완료 기준

다음이 완료되면 스킬 작업을 종료합니다:

1. ✅ TRUST 5 모든 항목 검증 완료
2. ✅ LSP 진단 결과 분석 완료
3. ✅ 품질 리포트 생성 완료
4. ✅ FAIL인 경우 명확한 가이드 제공
5. ✅ 자동 수정 가능한 항목 수정 완료

## 모범 사례

### 1. 품질 기준은 프로젝트에 맞게 조정

```yaml
# 엄격한 프로젝트
tested:
  min_coverage: 90

# 관대한 프로젝트
tested:
  min_coverage: 70
```

### 2. 점진적 도입

처음에는 경고만, 점차 기준 강화:
```yaml
# Phase 1: 경고만
enforcement: warn

# Phase 2: 실패 처리
enforcement: fail
```

### 3. 팀 표준 준수

프로젝트마다 다른 도구 지원:
- TypeScript: ESLint + Prettier
- Python: Ruff + Black
- Go: gofmt + golint

## 트리거 예시

다음 말들을 하면 이 스킬이 자동으로 활성화됩니다:

- "코드 품질 체크해줘"
- "커밋할 수 있을까?"
- "PR 보낼 준비 됐어?"
- "품질 게이트 통과했어?"
- "/quality-check"
- "/trust-validate"

---

**이 스킬은 TRUST 5 프레임워크를 기반으로 하며, 자동으로 품질을 검증하고 개선을 제안합니다.**
