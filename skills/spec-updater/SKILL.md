---
name: spec-updater
description: 스펙 변경을 감지하고 CHANGELOG를 자동으로 업데이트하여 변경 이력을 추적합니다
version: 1.0.0
---

# SPEC Updater Skill

스펙 문서의 변경을 감지하고 CHANGELOG.md를 자동으로 업데이트합니다.

## 활성화 조건

다음 상황에서 자동으로 활성화됩니다:

- "요구사항 변경", "스펙 수정" 같은 변경 언급
- spec.md, plan.md, acceptance.md 파일 수정 시
- "이거 스펙에 반영해줘", "변경사항 업데이트해줘"
- "/spec-update" 커맨드 사용 시

## 작업 방식

### 1단계: 변경 감지

기존 스펙과 새로운 요구사항을 비교하여 변경 사항을 파악합니다:

**변경 유형:**
- **Added**: 새로운 요구사항, 기능 추가
- **Changed**: 기존 요구사항 수정, 내용 변경
- **Removed**: 요구사항 삭제, 기능 제거
- **Fixed**: 오타 수정, 오류 clarification

### 2단계: 변경 영향 분석

변경이 무엇에 영향을 주는지 분석합니다:

**영향 범위:**
- **구현**: plan.md의 태스크에 영향
- **테스트**: acceptance.md의 시나리오에 영향
- **다른 스펙**: 의존관계 있는 다른 피처
- **ADR**: 새로운 아키텍처 결정 필요 여부

### 3단계: 버전 결정

변경의 크기에 따라 버전을 결정합니다:

- **Major (X.0.0)**: breaking change, 기존 기능 삭제
- **Minor (0.X.0)**: 새로운 기능 추가, 하위 호환
- **Patch (0.0.X)**: 버그 수정, 문서화, typo

**Semantic Versioning 규칙:**
```
1.0.0 → 1.1.0 (Minor): 새로운 요구사항 추가
1.1.0 → 2.0.0 (Major): 기존 요구사항 크게 변경
1.1.0 → 1.1.1 (Patch): 오타 수정, clarification
```

### 4단계: CHANGELOG 업데이트

CHANGELOG.md에 변경 내역을 추가합니다:

**템플릿:**
```markdown
## [version] - YYYY-MM-DD

### Added
- 새로운 요구사항 추가

### Changed
- 기존 요구사항 수정

### Removed
- 삭제된 요구사항

### Fixed
- 오타 수정, clarification

**Status**: DRAFT | ACTIVE | IN_PROGRESS | COMPLETED
**Reason**: 변경 이유
**Impact**: 영향 받는 부분
```

### 5단계: 관련 문서 업데이트

변경에 따라 관련 문서도 업데이트합니다:

- **spec.md**: 요구사항 내용 수정
- **plan.md**: 구현 계획 수정 (필요시)
- **acceptance.md**: 인수 기준 수정 (필요시)

## CHANGELOG 작성 가이드

### Added (추가)

**사용 경우:**
- 새로운 기능 추가
- 새로운 요구사항 정의
- 새로운 제약 조건

**예시:**
```markdown
### Added
- [E-005] OAuth 2.0 구글 로그인 지원
- [P-003] API 응답 시간 100ms 이하 요구사항 추가
```

### Changed (변경)

**사용 경우:**
- 기존 요구사항 내용 수정
- 기준 수치 변경
- 조건 수정

**예시:**
```markdown
### Changed
- [U-001] 세션 만료: 24시간 → 1시간로 단축
- [E-003] 페이지네이션: 20개 → 50개로 증가
```

### Removed (삭제)

**사용 경우:**
- 기능 삭제
- 요구사항 제거
- 제약 조건 완화

**예시:**
```markdown
### Removed
- [O-002] 오프라인 모드 지원 (기술적 제약으로 제거)
- [UW-003] 이메일 인증 필수 (간편 가입으로 변경)
```

### Fixed (수정)

**사용 경우:**
- 오타 수정
- 모호한 표현 clarification
- 문서화 오류 수정

**예시:**
```markdown
### Fixed
- [E-001] 비밀번호 복잡도 기준 clarification (최소 8자 → 최소 8자, 영문+숫자 필수)
- [U-003] "API" 오타 수정
```

## 버전 관리 예시

### 예시 1: Minor Update (새 기능)

```markdown
## [1.1.0] - 2026-03-20

### Added
- [E-010] 비밀번호 찾기 기능
- [U-005] 이메일 인증 링크 1시간 유효

**Status**: ACTIVE
**Reason**: 사용자 요구로 비밀번호 찾기 기능 추가
**Impact**: plan.md에 이메일 발송 태스크 추가, acceptance.md에 비밀번호 찾기 시나리오 추가
```

### 예시 2: Major Update (Breaking Change)

```markdown
## [2.0.0] - 2026-03-25

### Changed
- [U-001] JWT 세션 기반으로 완전히 변경
- [E-005] 로그인 응답: 토큰 → 세션 쿠키로 변경

### Removed
- [E-010] 토큰 갱신 기능 (세션 자동 갱신으로 대체)

**Status**: IN_PROGRESS
**Reason**: 보안 강화 및 세션 관리 단순화
**Impact**: 기존 토큰 기반 인증 완전히 제거, 프론트엔드/백엔드 모두 수정 필요
```

### 예시 3: Patch Update (Clarification)

```markdown
## [1.0.1] - 2026-03-19

### Fixed
- [E-003] 로그인 실패 메시지 clarification (계정 없음/비밀번호 틀림 구분)
- [U-002] "인증" → "인가"로 용어 수정

**Status**: COMPLETED
**Reason**: 사용자 피드백 반영, 용어 정확성 개선
**Impact**: UI 메시지만 변경, 기능 동작은 동일
```

## 변경 사항 예시

### 예시 1: 요구사항 추가

**사용자:**
> "OAuth 2.0으로 구글 로그인 추가할거야"

**스킬 동작:**
1. 현재 스펙 확인 (user-authentication)
2. Event-driven 요구사항으로 추가 작성:
   ```
   [E-010] WHEN 사용자가 "구글로 로그인"을 클릭하면,
   IF 구글 인증이 성공하면,
   THEN 시스템은 사용자를 자동 로그인하고 프로필을 생성해야 한다.
   ```
3. CHANGELOG.md 업데이트:
   ```markdown
   ## [1.1.0] - 2026-03-20

   ### Added
   - [E-010] OAuth 2.0 구글 로그인 지원

   **Status**: ACTIVE
   **Reason**: 사용자 편의성 개선
   **Impact**: plan.md에 OAuth 통합 태스크 추가
   ```

### 예시 2: 요구사항 수정

**사용자:**
> "세션 만료를 24시간에서 1시간로 줄여야 해"

**스킬 동작:**
1. 기존 요구사항 찾기:
   ```
   [S-001] WHILE 사용자가 로그인되어 있는 동안,
   시스템은 세션을 24시간마다 갱신해야 한다.
   ```
2. 수정:
   ```
   [S-001] WHILE 사용자가 로그인되어 있는 동안,
   시스템은 세션을 1시간마다 갱신해야 한다.
   ```
3. CHANGELOG.md 업데이트:
   ```markdown
   ## [1.2.0] - 2026-03-21

   ### Changed
   - [S-001] 세션 갱신: 24시간 → 1시간로 단축

   **Status**: ACTIVE
   **Reason**: 보안 강화 (세션 하이재킹 방지)
   **Impact**: 프론트엔드 자동 로그아웃 1시간로 조정 필요
   ```

## 완료 기준

다음이 완료되면 스킬 작업을 종료합니다:

1. ✅ 변경 사항이 명확히 파악됨
2. ✅ CHANGELOG.md에 엔트리 추가됨
3. ✅ 버전이 올바르게 결정됨 (Major/Minor/Patch)
4. ✅ 영향 받는 문서가 식별됨
5. ✅ 사용자가 변경 내용을 확인함

## 모범 사례

### 1. 변경 이유를 명확히

❌ **나쁨:**
```markdown
### Changed
- [U-001] 세션 만료 변경
```

✅ **좋음:**
```markdown
### Changed
- [U-001] 세션 만료: 24시간 → 1시간

**Reason**: 보안 강화를 위해 세션 하이재킹 위험 감소
**Impact**: 사용자 경험 저하 가능성 있으나 보안 우선
```

### 2. 영향 분석을 포함

❌ **나쁨:**
```markdown
### Added
- [E-010] OAuth 로그인
```

✅ **좋음:**
```markdown
### Added
- [E-010] OAuth 2.0 구글 로그인 지원

**Impact**:
- plan.md: OAuth 통합 태스크 3개 추가
- acceptance.md: OAuth 로그인 시나리오 2개 추가
- ADR: OAuth 제공자 선택 필요 (ADR-003)
```

### 3. Semantic Versioning 준수

❌ **나쁨:**
```markdown
## [1.0.0] → [1.0.1] (사실은 Breaking Change)

### Changed
- 인증 방식: JWT → Session (완전히 변경)
```

✅ **좋음:**
```markdown
## [2.0.0] - Breaking Change

### Changed
- 인증 방식을 JWT에서 Session 기반으로 완전히 변경

**Reason**: 보안 강화 및 세션 관리 단순화
**Migration**: 기존 토큰 사용자는 재로그인 필요
```

## 트리거 예시

다음 말들을 하면 이 스킬이 자동으로 활성화됩니다:

- "세션 만료 시간 수정할건데 CHANGELOG 업데이트해줘"
- "요구사항 추가됐어, 스펙 반영해줘"
- "/spec-update user-authentication"
- "이거 스펙에 변경사항 있어"

## 주의사항

1. **매 변경마다 업데이트**: 작은 변경이라도 CHANGELOG에 기록
2. **버전을 건너뛰지 않기**: 1.0.0 → 1.1.0 → 1.2.0 (1.0.0 → 1.3.0 X)
3. **영향 분석 필수**: 변경이 다른 부분에 미치는 영향을 항상 고려
4. **이유를 명확히**: 왜 변경했는지 항상 기록
5. **날짜는 항상 오늘**: 변경한 날짜를 기록

---

**이 스킬은 모든 스펙 변경을 추적하여 프로젝트 진행 상황을 투명하게 만들고, 나중에 왜 그런 결정을 내렸는지 알 수 있도록 도와드립니다.**
