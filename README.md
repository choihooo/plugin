# SET Tools

개인용 개발 자동화 및 생산성 도구 키트 - 개인 프로젝트와 실무 프로젝트 모두 지원

## 특징

- **커맨드**: 자주 사용하는 작업을 위한 슬래시 커맨드
- **에이전트**: 코드 리뷰, 테스트 생성 전문 AI 에이전트
- **스킬**: 리팩토링, 최적화, 품질 검증 자동 활성화 스킬
- **훅**: 파일 변경 검증, 로깅 이벤트 핸들러
- **MCP 통합**: 외부 서비스 연동 (Serena, Playwright, 4.5v Vision)
- **ADR 시스템**: 아키텍처 의사결정 기록 자동화
- **SPEC 시스템**: 피처 스펙 문서화 및 변경 추적 (EARS 기반)
- **TRUST 5**: 품질 게이트 자동화

## 설치

1. Claude Code 플러그인 디렉토리에 복사
2. Claude Code 설정에서 플러그인 활성화
3. Claude Code 재시작

## 플러그인 구조

```
set-tools/
├── .claude-plugin/
│   └── plugin.json          # 플러그인 매니페스트
├── commands/                 # 슬래시 커맨드
│   ├── adr-create.md        # ADR 생성
│   ├── adr-list.md          # ADR 목록
│   ├── spec-create.md       # SPEC 생성 (3-file structure)
│   ├── spec-update.md       # SPEC 변경 및 CHANGELOG 업데이트
│   ├── spec-diff.md         # SPEC 버전 비교
│   ├── spec-list.md         # SPEC 목록 조회
│   ├── quality-check.md     # TRUST 5 품질 검증
│   └── trust-validate.md    # LSP 품질 게이트
├── agents/                   # AI 에이전트
│   ├── code-reviewer.md
│   └── test-generator.md
├── skills/                   # 자동 활성화 스킬
│   ├── adr-generator/       # ADR 자동 생성
│   ├── spec-generator/      # SPEC 자동 생성 (EARS)
│   ├── spec-updater/        # SPEC 변경 추적 (CHANGELOG)
│   └── trust-validator/     # TRUST 5 품질 검증
├── hooks/                    # 이벤트 핸들러
│   ├── hooks.json
│   └── scripts/
│       ├── validate-change.sh
│       ├── check-command.sh
│       └── log-prompt.sh
├── scripts/                  # 헬퍼 유틸리티
│   ├── create-adr.sh        # ADR 파일 생성 스크립트
│   ├── adr-template.md      # ADR 템플릿
│   ├── create-spec.sh       # SPEC 파일 생성 스크립트
│   ├── spec-template.md     # SPEC 요구사항 템플릿 (EARS)
│   ├── plan-template.md     # 구현 계획 템플릿
│   ├── acceptance-template.md # 인수 기준 템플릿 (Given/When/Then)
│   ├── check-quality.sh     # TRUST 5 품질 검증 스크립트
│   └── helper.sh
├── .trust.example.yaml      # TRUST 5 설정 예시
└── README.md
```

## 사용법

### 커맨드

**ADR 관리**
- `/adr-create` - 새로운 ADR 문서 생성 (대화형)
- `/adr-list` - 모든 ADR 목록 표시

**SPEC 관리 (EARS 기반)**
- `/spec-create` - 새로운 피처 SPEC 생성 (3-file 구조)
- `/spec-update` - SPEC 변경 및 CHANGELOG 자동 업데이트
- `/spec-diff` - SPEC 버전별 변경사항 비교
- `/spec-list` - 모든 SPEC 목록 및 상태 조회

**TRUST 5 품질 관리**
- `/quality-check` - TRUST 5 품질 검증 실행
  - `--tested`: 테스트 커버리지 검증 (85%+)
  - `--readable`: 가독성 검증 (0 lint errors)
  - `--unified`: 통일성 검증 (0 format issues)
  - `--secured`: 보안 검증 (0 vulnerabilities)
  - `--trackable`: 추적 가능성 검증 (Conventional Commits)
  - `--fix`: 자동 수정 가능한 항목 수정
- `/trust-validate` - LSP 품질 게이트 검증
  - `--phase plan`: 기준선 캡처
  - `--phase run`: 회귀 방지 검증
  - `--phase sync`: 최종 품질 확인

### 에이전트

Claude Code가 자동으로 호출하는 전문 에이전트:
- **Code Reviewer**: 전문 코드 리뷰 및 품질 분석
- **Test Generator**: 포괄적인 테스트 스위트 생성

### 스킬

다음 작업 시 자동 활성화:

**의사결정 & 문서화**
- **ADR Generator**: 중요한 의사결정이 필요할 때 자동으로 제안하고 체계적으로 도와드립니다
  - "어떤 방식을 써야 할까?" 같은 질문에 자동 응답
  - 심도 있는 질문을 통해 결정을 명확하게
  - 결정 과정을 ADR 문서로 자동 정리
- **SPEC Generator**: 피처 개발 시 EARS 형식으로 요구사항 정의 도움
  - "새로운 기능 개발할게" → 자동으로 피처 이해 질문
  - EARS 5가지 유형으로 요구사항 작성
  - 3-file 구조 (spec.md, plan.md, acceptance.md) 생성
- **SPEC Updater**: 스펙 변경 감지 및 CHANGELOG 자동 업데이트
  - "요구사항 변경" → 자동으로 버전 결정
  - Semantic Versioning (Major/Minor/Patch)
  - 변경 이유와 영향 분석 기록

**품질 관리**
- **TRUST Validator**: 코드 변경 시 TRUST 5 품질 기준 자동 검증
  - 코드 변경 감지 → 자동으로 품질 검증
  - 5가지 품질 원칙 검증 (Tested, Readable, Unified, Secured, Trackable)
  - LSP 품질 게이트 (Plan/Run/Sync 단계)
  - 자동 수정 가능한 항목 자동 수정

**코드 품질**
- 코드 리팩토링
- 성능 최적화
- 코드 현대화
- 복잡도 감소

## SPEC 시스템 (EARS 기반)

EARS (Easy Approach to Requirements Syntax) 방법론을 차용한 3-file 구조로 피처 스펙을 관리합니다:

### 파일 구조

```
docs/specs/{feature-name}/
├── spec.md          # EARS 형식 요구사항
├── plan.md          # 구현 계획
├── acceptance.md    # Given/When/Then 인수 기준
└── CHANGELOG.md     # 변경 이력
```

### EARS 형식 (5가지 요구사항 유형)

1. **Ubiquitous (보편적)**: "시스템은 ~해야 한다" - 항상 참인 요구사항
2. **Event-driven (이벤트 기반)**: "WHEN ~하면, IF ~라면, THEN ~해야 한다" - 이벤트 응답
3. **State-driven (상태 기반)**: "WHILE ~인 동안, ~해야 한다" - 상태 유지
4. **Unwanted (바람직하지 않은)**: "시스템은 ~하면 안 된다" - 금지된 동작
5. **Optional (선택적)**: "가능하다면, ~해야 한다" - nice-to-have

### SPEC 라이프사이클

1. **DRAFT** - 요구사항 수집 중
2. **ACTIVE** - 요구사항 확정, 구현 준비 완료
3. **IN_PROGRESS** - 구현 진행 중
4. **COMPLETED** - 구현 완료 및 인수 기준 통과
5. **REJECTED** - 피처 취소 또는 거부

### 사용 예시

```bash
# 새로운 피처 스펙 생성
/spec-create
# Feature name: shopping-cart
# Description: 사용자가 구매할 제품을 임시 저장하고 수량을 관리하며 결제로 넘어갈 수 있는 기능

# docs/specs/shopping-cart/ 디렉토리 생성
# - spec.md: EARS 형식으로 요구사항 정의 (18개 요구사항)
# - plan.md: 구현 계획 (21 tasks, 51 hours)
# - acceptance.md: Given/When/Then 테스트 시나리오 (9 scenarios)

# 요구사항 변경 시
/spec-update
# 자동으로 CHANGELOG.md에 변경 이력 기록
```

## TRUST 5 시스템

TRUST 5 품질 프레임워크로 자동으로 코드 품질을 보장합니다:

### TRUST 5 원칙

1. **T - Tested (테스트 완료)**
   - 테스트 커버리지 85% 이상
   - 타입 에러 0개
   - 실패하는 테스트 0개

2. **R - Readable (가독성)**
   - Lint 에러 0개
   - 명확한 네이밍
   - 적절한 주석

3. **U - Unified (통일성)**
   - 일관된 코드 포맷팅
   - 프로젝트 표준 준수
   - EARS 형식 요구사항 준수

4. **S - Secured (보안)**
   - OWASP Top 10 준수
   - 보안 취약점 0개
   - 시크릿 노출 0개

5. **T - Trackable (추적 가능성)**
   - Conventional Commits 형식
   - CHANGELOG 업데이트
   - 이슈/PR 참조

### LSP 품질 게이트

#### Plan 단계 (계획)
- 기준 상태 캡처
- `.trust-baseline.json` 생성
- 기존 에러/경고 수 기록

#### Run 단계 (실행)
- 회귀 방지 검증
- 새 에러 0개 (필수)
- 경고 증가 ≤ 5개

#### Sync 단계 (동기화)
- 최종 품질 확인
- 총 에러 0개
- 총 경고 ≤ 10개

### 사용 예시

```bash
# 전체 품질 검증
/quality-check

# 특정 항목만 검증
/quality-check --tested    # 테스트 커버리지만
/quality-check --secured   # 보안만

# LSP 품질 게이트
/trust-validate --phase plan    # 작업 시작 전
/trust-validate --phase run     # 변경 중간중간
/trust-validate --phase sync    # 완료 후

# 자동 수정
/quality-check --fix
```

### Git Hooks 통합

```bash
# pre-commit: Run 단계 검증
pre-commit → /trust-validate --phase run

# pre-push: Sync 단계 검증
pre-push → /trust-validate --phase sync
```

### 설정 파일

```yaml
# .trust.yaml
tested:
  min_coverage: 85

lsp_gates:
  run:
    max_new_errors: 0
  sync:
    max_errors: 0
    max_warnings: 10
```

## MCP 서버 통합

현재 통합된 MCP 서버:

### Serena (시맨틱 코딩 도구)
- `mcp__serena__find_symbol`: 심볼 검색
- `mcp__serena__replace_symbol_body`: 심볼 내용 교체
- `mcp__serena__get_symbols_overview`: 파일 개요
- `mcp__serena__search_for_pattern`: 패턴 검색
- `mcp__serena__list_memories`: 메모리 관리
- `mcp__serena__write_memory`: 메모리 저장

### Playwright (브라우저 자동화)
- `mcp__playwright__browser_navigate`: 페이지 이동
- `mcp__playwright__browser_snapshot`: 접근성 스냅샷
- `mcp__playwright__browser_click`: 클릭
- `mcp__playwright__browser_type`: 텍스트 입력
- `mcp__playwright__browser_take_screenshot`: 스크린샷

### 4.5v Vision (이미지 분석)
- `mcp__4_5v_mcp__analyze_image`: 이미지 URL 분석

### Web Reader (웹 콘텐츠 추출)
- `mcp__web_reader__webReader`: URL에서 콘텐츠 추출

## 훅

자동으로 수행:
- 파일 쓰기 전 변경 사항 검증
- Bash 명령 로깅 (감사 추적)
- 프롬프트 분석 추적

## 설정

`.claude-plugin/plugin.json`에서 커스터마이즈:
- 플러그인 메타데이터
- 컴포넌트 경로
- 훅 설정
- MCP 서버 설정

## 개발

### 커맨드 추가

`commands/`에 새 `.md` 파일 생성:
```markdown
---
name: your-command
description: 커맨드 설명
---

커맨드 구현 내용...
```

### 에이전트 추가

`agents/`에 새 `.md` 파일 생성:
```markdown
---
description: 에이전트 전문 분야
capabilities:
  - 기능 1
  - 기능 2
---

에이전트 지시사항...
```

### 스킬 추가

`skills/`에 새 디렉토리와 `SKILL.md` 생성:
```markdown
---
name: 스킬 이름
description: 활성화 조건
version: 1.0.0
---

스킬 지시사항...
```

### 훅 추가

`hooks/hooks.json`에 항목 추가:
```json
{
  "EventName": [{
    "matcher": "ToolPattern",
    "hooks": [{
      "type": "command",
      "command": "bash ${CLAUDE_PLUGIN_ROOT}/hooks/scripts/script.sh"
    }]
  }]
}
```

## 베스트 프랙티스

1. **`${CLAUDE_PLUGIN_ROOT}`**: 모든 경로에 환경변수 사용
2. **Kebab-case 명명**: 일관된 파일/디렉토리 명명
3. **명확한 설명**: 모든 컴포넌트의 명확한 문서화
4. **에러 핸들링**: 훅의 적절한 에러 처리
5. **로깅**: 디버깅을 위한 포괄적인 로깅

## 라이선스

MIT

---

**개인용으로 제작되어 실무 프로젝트에서도 활용**

**SPEC 시스템**: EARS 형식 요구사항 정의
**TRUST 5 시스템**: LSP 품질 게이트 자동화
