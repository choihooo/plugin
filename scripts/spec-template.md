# {{FEATURE_NAME}} - Requirements Specification (SPEC)

**Status:** DRAFT
**Version:** 0.1.0
**Last Updated:** {{DATE}}
**Description:** {{DESCRIPTION}}

---

## Overview

이 문서는 {{FEATURE_NAME}} 피처의 요구사항을 **EARS 형식** (Easy Approach to Requirements Syntax)으로 정의합니다.

### EARS 형식 가이드

EARS는 요구사항을 5가지 유형으로 분류하여 명확성을 높입니다:

1. **Ubiquitous (보편적)**: "시스템은 ~해야 한다" - 항상 참인 요구사항
2. **Event-driven (이벤트 기반)**: "WHEN ~하면, IF ~라면, THEN ~해야 한다" - 이벤트에 대한 응답
3. **State-driven (상태 기반)**: "WHILE ~인 동안, ~해야 한다" - 상태 유지
4. **Unwanted (바람직하지 않은)**: "시스템은 ~하면 안 된다" - 금지된 동작
5. **Optional (선택적)**: "가능하다면, ~해야 한다" - nice-to-have

---

## Requirements

### Ubiquitous Requirements (보편적 요구사항)

이 요구사항들은 항상 참이어야 하는 기본 동작을 정의합니다.

**[U-번호]**
시스템은 [요구사항]해야 한다.

*(추가 필요)*

---

### Event-driven Requirements (이벤트 기반 요구사항)

이벤트 발생 시 시스템의 응답을 정의합니다.

**[E-번호]**
WHEN [이벤트]하면,
IF [조건]라면,
THEN 시스템은 [응답]해야 한다.

*(추가 필요)*

---

### State-driven Requirements (상태 기반 요구사항)

특정 상태를 유지해야 하는 요구사항을 정의합니다.

**[S-번호]**
WHILE [상태]인 동안,
시스템은 [동작]해야 한다.

*(추가 필요)*

---

### Unwanted Requirements (바람직하지 않은 동작)

시스템이 해서는 안 되는 동작을 정의합니다.

**[UW-번호]**
시스템은 [금지된 동작]하면 안 된다.

*(추가 필요)*

---

### Optional Requirements (선택적 요구사항)

구현하면 좋지만 필수는 아닌 요구사항입니다.

**[O-번호]**
가능하다면, 시스템은 [선택적 기능]해야 한다.

*(추가 필요)*

---

## Non-Functional Requirements

### Performance

- **[P-번호]** [성능 요구사항]

### Security

- **[SEC-번호]** [보안 요구사항]

### Scalability

- **[SCAL-번호]** [확장성 요구사항]

---

## Dependencies

### 외부 의존성

- API: [관련 외부 API]
- 서비스: [데이터베이스, 캐시 서비스 등]

### 내부 의존성

- 다른 피처와의 관계
- 공유 컴포넌트

---

## Related ADRs

이 SPEC과 관련된 아키텍처 의사결정 기록:

- ADR-XXX: 관련된 의사결정 링크

---

## Glossary

| 용어 | 정의 |
|------|------|
| {{FEATURE_NAME}} | 이 피처의 핵심 개념 정의 |
| [도메인 용어] | 도메인 특화 용어 설명 |

---

**Change History**
- 변경 내역은 [CHANGELOG.md](CHANGELOG.md)를 참고하세요.
