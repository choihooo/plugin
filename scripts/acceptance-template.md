# {{FEATURE_NAME}} - Acceptance Criteria

**Status:** DRAFT
**Version:** 0.1.0
**Last Updated:** {{DATE}}
**Related SPEC:** [spec.md](spec.md), [plan.md](plan.md)

---

## Overview

{{DESCRIPTION}} 피처의 **인수 기준 (Acceptance Criteria)**을 **Given/When/Then** 형식으로 정의합니다.

### Given/When/Then Format

- **Given (주어진 상황)**: 테스트의 전제 조건 및 컨텍스트
- **When (행동)**: 사용자 또는 시스템의 특정 동작
- **Then (기대 결과)**: 동작 후 발생해야 하는 결과

---

## Scenarios

### Scenario 1: [시나리오 제목]

**[AC-번호] [시나리오 설명]**

**Given:**
- [전제 조건 1]
- [전제 조건 2]

**When:**
- [사용자 행동]

**Then:**
- [기대 결과 1]
- [기대 결과 2]

---

*(추가 시나리오 필요)*

---

## Edge Cases

### Edge Case 1: [엣지 케이스 제목]

**[AC-EC-번호] [엣지 케이스 설명]**

**Given:**
- [전제 조건]

**When:**
- [행동]

**Then:**
- [기대 결과]

---

*(추가 엣지 케이스 필요)*

---

## Performance Criteria

### [AC-PERF-번호] [성능 기준 제목]
- [성능 요구사항]

---

## Security Criteria

### [AC-SEC-번호] [보안 기준 제목]
- [보안 요구사항]

---

## Accessibility Criteria

### [AC-A11Y-번호] [접근성 기준 제목]
- [접근성 요구사항]

---

## Testing Checklist

이 acceptance criteria가 충족되었는지 확인하기 위한 테스트 체크리스트:

### Manual Testing

- [ ] AC-[번호]: [시나리오]
- [ ] AC-[번호]: [시나리오]

### Automated Testing (E2E with Playwright)

- [ ] AC-[번호] ~ AC-[번호]: Playwright 테스트 작성
- [ ] Edge Cases: 자동화된 에러 시나리오 테스트
- [ ] Performance: Lighthouse 성능 테스트

### Security Testing

- [ ] AC-SEC-[번호]: 보안 테스트 통과

### Accessibility Testing

- [ ] AC-A11Y-[번호]: axe-core 검사 통과

---

**Change History**
- 변경 내역은 [CHANGELOG.md](CHANGELOG.md)를 참고하세요.
