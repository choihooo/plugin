---
name: spec-create
description: Create a new SPEC document with 3-file structure (spec.md, plan.md, acceptance.md) based on EARS methodology
---

# SPEC Create Command

This command helps you create a new feature SPEC document with 3-file structure.

## What it does

1. Creates the `docs/specs/` directory if it doesn't exist
2. Prompts you for the feature name and description
3. Generates a properly formatted SPEC directory with:
   - **spec.md**: EARS format requirements
   - **plan.md**: Implementation plan
   - **acceptance.md**: Given/When/Then criteria
   - **CHANGELOG.md**: Change tracking history

## Usage

```bash
/spec-create
```

You'll be asked to provide:
- **Feature name**: e.g., "user-authentication", "shopping-cart"
- **Feature description**: Brief overview of what this feature does

## Output

A new SPEC directory will be created at: `docs/specs/{feature-name}/`

Example structure:
```
docs/specs/user-authentication/
├── spec.md          # EARS requirements
├── plan.md          # Implementation plan
├── acceptance.md    # Acceptance criteria
└── CHANGELOG.md     # Change history
```

## SPEC Lifecycle

Each SPEC progresses through these stages:

1. **DRAFT** - Initial requirements gathering
2. **ACTIVE** - Requirements finalized, ready for implementation
3. **IN_PROGRESS** - Implementation started
4. **COMPLETED** - Feature implemented and tested
5. **REJECTED** - Feature cancelled or rejected

## File Structure

### spec.md - Requirements

Uses **EARS format** (Easy Approach to Requirements Syntax):

- **Ubiquitous**: "시스템은 ~해야 한다" (always true requirements)
- **Event-driven**: "WHEN ~하면, IF ~라면, THEN ~해야 한다" (event response)
- **State-driven**: "WHILE ~인 동안, ~해야 한다" (state maintenance)
- **Unwanted**: "시스템은 ~하면 안 된다" (prohibited behaviors)
- **Optional**: "가능하다면, ~해야 한다" (nice-to-have)

### plan.md - Implementation Plan

- Technical approach
- Architecture decisions
- Task breakdown
- Dependencies
- Estimated effort

### acceptance.md - Acceptance Criteria

Uses **Given/When/Then** format:

- **Given**: Preconditions and context
- **When**: Action or event
- **Then**: Expected outcome

## Next Steps

After creating the SPEC:

1. **Fill in spec.md**: Define requirements using EARS format
2. **Create plan.md**: Break down implementation tasks
3. **Write acceptance.md**: Define test scenarios
4. **Update lifecycle**: Change status as you progress
5. **Track changes**: Use `/spec-update` when requirements change

## Best Practices

1. **One feature per SPEC**: Keep specs focused and manageable
2. **Use EARS format**: Write clear, unambiguous requirements
3. **Define acceptance criteria**: Make features testable
4. **Update CHANGELOG**: Track all changes with dates and reasons
5. **Link to ADRs**: Reference related architecture decisions

## Example

```bash
/spec-create
# Enter feature name: user-authentication
# Enter description: 사용자 로그인, 로그아웃, 세션 관리 기능
# SPEC created: docs/specs/user-authentication/
```

---

## ⚠️ 필수: 실제 파일 생성

사용자 입력을 받은 후 **반드시 Write 도구로 실제 파일들을 생성**해야 합니다.

### 실행 단계:
1. `mkdir -p docs/specs/{feature-name}` 디렉토리 생성
2. Write 도구로 생성:
   - `spec.md`: EARS 형식 요구사항 (5-10개)
   - `plan.md`: 구현 계획 (5-10 tasks)
   - `acceptance.md`: Given/When/Then 시나리오 (3-5개)
   - `CHANGELOG.md`: v0.1.0 - DRAFT

### ❌ 절대 하지 말아야 할 것:
- "템플릿이 준비되었습니다"
- "파일 구조가 생성되었습니다"

### ✅ 항상 해야 할 것:
- **실제로 4개 파일 모두 Write 도구로 생성**
- 실제 내용 채워서 생성 (빈 템플릿 NO)
- 생성 경로와 파일 개수 명시

---

**Tip**: Use natural language when writing requirements. The EARS format helps structure them clearly.
