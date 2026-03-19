---
name: project-init
description: 프로젝트 전체 설계 및 초기화 - 시스템 아키텍처, 기술 스택, 전체 기능 목록 정의
---

# project-init Command

새 프로젝트의 전체 설계를 하고 초기화합니다. 피처별 스펙 작성 전에 **시스템 전체의 큰 그림**을 그립니다.

## 사용법

```bash
/project-init
```

## 프로젝트 전체 설계 프로세스

### 1단계: 프로젝트 개요 수집

다음 정보를 수집합니다:

1. **프로젝트 이름**: 프로젝트를 어떻게 부를까요?
2. **프로젝트 목적**: 이 프로젝트가 무엇을 해결하나요?
3. **타겟 사용자**: 누가 이 프로젝트를 사용하나요?
4. **핵심 기능**: 가장 중요한 기능 3-5가지는 무엇인가요?
5. **비기능 요구사항**:
   - 성능 요구사항이 있나요? (예: 100ms 응답 시간)
   - 보안 요구사항이 있나요? (예: GDPR 준수)
   - 확장성 요구사항이 있나요? (예: 10만 동시 사용자)

### 2단계: 시스템 아키텍처 설계

**아키텍처 패턴 결정:**
- 모놀리식 vs 마이크로서비스
- MVC vs Clean Architecture vs Hexagonal
- 프론트엔드: SPA vs SSR vs CSR
- 백엔드: REST vs GraphQL vs tRPC

**기술 스택 결정:**
- 프론트엔드 프레임워크 (React, Vue, Svelte, Next.js)
- 백엔드 프레임워크 (Express, NestJS, FastAPI, Django)
- 데이터베이스 (PostgreSQL, MongoDB, Redis)
- 인증 (JWT, Session, OAuth, Auth0)
- 배포 (Vercel, AWS, Docker, Kubernetes)

### 3단계: 전체 기능 목록 정의

피처별로 기능을 분류합니다:

**예시: 전자상거래 플랫폼**
```
1. 사용자 관리 (user-management)
   - 회원가입/로그인
   - 프로필 관리
   - 비밀번호 찾기

2. 제품 관리 (product-catalog)
   - 제품 등록/수정/삭제
   - 제품 검색/필터
   - 카테고리 관리

3. 장바구니 (shopping-cart)
   - 장바구니 추가/삭제
   - 수량 수정
   - 장바구니 조회

4. 주문/결제 (order-payment)
   - 주문 생성
   - 결제 처리
   - 주문 내역 조회

5. 배송 관리 (shipping)
   - 배송지 관리
   - 배송 추적
   - 배송 상태 업데이트
```

### 4단계: 데이터 모델 설계

전체 데이터베이스 스키마를 설계합니다:

```sql
-- 사용자
CREATE TABLE users (...);

-- 제품
CREATE TABLE products (...);

-- 장바구니
CREATE TABLE cart_items (...);

-- 주문
CREATE TABLE orders (...);

-- 배송
CREATE TABLE shipments (...);
```

### 5단계: API 설계

전체 API 엔드포인트를 설계합니다:

```
# 사용자 관리
POST   /api/auth/register
POST   /api/auth/login
GET    /api/users/me
PATCH  /api/users/me

# 제품 관리
GET    /api/products
GET    /api/products/:id
POST   /api/products

# 장바구니
GET    /api/cart
POST   /api/cart/items
PATCH  /api/cart/items/:id
DELETE /api/cart/items/:id

# 주문
POST   /api/orders
GET    /api/orders
GET    /api/orders/:id
```

### 6단계: 프로젝트 구조 정의

```
my-project/
├── docs/
│   ├── DESIGN.md           # 전체 설계 문서
│   ├── specs/              # 피처별 스펙
│   │   ├── user-management/
│   │   ├── product-catalog/
│   │   ├── shopping-cart/
│   │   └── order-payment/
│   └── adr/                # 아키텍처 의사결정
│       ├── 001-tech-stack.md
│       ├── 002-architecture.md
│       └── 003-database.md
├── src/
│   ├── components/         # 프론트엔드 컴포넌트
│   ├── services/           # API 서비스
│   ├── utils/              # 유틸리티
│   └── types/              # TypeScript 타입
├── tests/                  # 테스트
├── .trust.yaml            # 품질 설정
└── package.json
```

### 7단계: 개발 로드맵 작성

피처 개발 우선순위와 일정을 정합니다:

```markdown
## 개발 로드맵

### Phase 1: MVP (2주)
- [ ] 사용자 인증 (user-authentication)
- [ ] 제품 조회 (product-catalog-read)
- [ ] 장바구니 기본 (shopping-cart-basic)

### Phase 2: 핵심 기능 (3주)
- [ ] 장바구니 고급 (shopping-cart-advanced)
- [ ] 주문 생성 (order-create)
- [ ] 결제 연동 (payment-integration)

### Phase 3: 부가 기능 (2주)
- [ ] 배송 관리 (shipping)
- [ ] 리뷰 시스템 (reviews)
- [ ] 위시리스트 (wishlist)

### Phase 4: 고급 기능 (3주)
- [ ] 추천 시스템 (recommendations)
- [ ] 관리자 페이지 (admin-panel)
- [ ] 알림 시스템 (notifications)
```

### 8단계: 품질 기준 설정

프로젝트에 맞는 품질 기준을 정합니다:

```yaml
# .trust.yaml
tested:
  min_coverage: 85        # MVP는 70%, 프로덕션은 85%

lsp_gates:
  sync:
    max_errors: 0
    max_warnings:
      mvp: 20            # MVP는 관대하게
      production: 10     # 프로덕션은 엄격하게
```

## 생성되는 문서

### 1. docs/README.md

프로젝트 문서의 인덱스가 생성됩니다:

```markdown
# 프로젝트 문서

이 프로젝트의 모든 문서는 이 디렉토리에 정리되어 있습니다.

## 📋 문서 구조

```
docs/
├── README.md           # 이 파일 (문서 인덱스)
├── DESIGN.md           # 프로젝트 전체 설계
├── specs/              # 피처별 스펙 문서
│   ├── user-management/
│   ├── product-catalog/
│   └── ...
└── adr/                # 아키텍처 의사결정 기록
    ├── 001-tech-stack.md
    └── ...
```

## 🚀 빠른 시작

1. **전체 설계 확인**: [DESIGN.md](./DESIGN.md) 읽기
2. **아키텍처 의사결정 확인**: [adr/](./adr/) 디렉토리 확인
3. **피처별 스펙 확인**: [specs/](./specs/)에서 원하는 피처 선택

## 📚 주요 문서

### [DESIGN.md](./DESIGN.md)
프로젝트 전체 설계 문서
- 시스템 아키텍처
- 기술 스택
- 전체 기능 목록
- 데이터 모델
- API 설계
- 개발 로드맵

### [specs/](./specs/)
피처별 상세 스펙 (EARS 형식)

### [adr/](./adr/)
아키텍처 의사결정 기록 (ADR)

## 🔄 문서 작성 플로우

```
1. 프로젝트 시작
   /project-init → DESIGN.md 생성

2. 피처 기획
   /spec-create → docs/specs/{feature}/ 생성

3. 의사결정
   /adr-create → docs/adr/ 생성

4. 변경 추적
   /spec-update → CHANGELOG.md 업데이트
```

## 📊 현재 진행 상황

### 피처 목록
- [ ] user-management
- [ ] product-catalog
- [ ] shopping-cart
- [ ] order-payment
- [ ] shipping

### 최근 변경사항
- 2026-03-19: 프로젝트 초기화

---

**문서 관리**: 이 문서는 `/project-init` 실행 시 자동으로 생성되며, 새로운 피처가 추가될 때마다 업데이트됩니다.
```

```markdown
# 프로젝트 설계 문서

## 개요
- 프로젝트 이름: My E-commerce Platform
- 목적: 소규모 비즈니스를 위한 전자상거래 플랫폼
- 타겟: 하루 1만 방문자, 1000개 동시 사용자

## 아키텍처
- 패턴: 모놀리식 with Clean Architecture
- 프론트엔드: Next.js + TypeScript
- 백엔드: NestJS + GraphQL
- 데이터베이스: PostgreSQL + Redis
- 인증: JWT + OAuth 2.0

## 기능 목록
1. 사용자 관리 (user-management)
2. 제품 관리 (product-catalog)
3. 장바구니 (shopping-cart)
4. 주문/결제 (order-payment)
5. 배송 관리 (shipping)

## 데이터 모델
[전체 ERD]

## API 설계
[전체 API 목록]

## 개발 로드맵
[Phase별 일정]
```

### 2. docs/DESIGN.md

프로젝트 전체 설계 문서가 생성됩니다:

주요 아키텍처 의사결정이 ADR로 기록됩니다:

```
docs/adr/
├── 001-tech-stack.md          # 기술 스택 선정
├── 002-architecture-pattern.md # 아키텍처 패턴 결정
├── 003-database-choice.md     # 데이터베이스 선정
└── 004-authentication.md      # 인증 방식 결정
```

### 3. docs/adr/ 디렉토리

각 피처의 스펙 디렉토리가 생성됩니다:

```
docs/specs/
├── user-management/
│   ├── spec.md
│   ├── plan.md
│   ├── acceptance.md
│   └── CHANGELOG.md
├── product-catalog/
│   └── ...
└── shopping-cart/
    └── ...
```

### 4. docs/specs/ 디렉토리 구조

1. **ADR 검토**: 주요 의사결정 확인
   ```bash
   /adr-list
   ```

2. **첫 번째 피처 기획**: 가장 우선순위가 높은 피처부터
   ```bash
   /spec-create
   Feature: user-authentication
   ```

3. **개발 시작**: 피처별 개발 플로우 진행

## 완료 후 다음 단계

프로젝트 전체 설계가 완료되면:

## 예시: 전자상거래 플랫폼

```bash
/project-init

# 질문 응답:
# 프로젝트 이름: my-shop
# 목적: 소규모 온라인 스토어
# 핵심 기능: 사용자, 제품, 장바구니, 주문, 결제

# 생성됨:
# ✅ docs/README.md (문서 인덱스)
# ✅ docs/DESIGN.md (전체 설계)
# ✅ docs/adr/ (4개 ADR)
# ✅ docs/specs/ (5개 피처 디렉토리)
# ✅ 개발 로드맵
# ✅ .trust.yaml

# 다음:
/spec-create
Feature: user-authentication
```

## 프로젝트 시작 플로우 (정리)

```
1. /project-init
   ↓
   프로젝트 전체 설계
   - 아키텍처 결정
   - 기술 스택 선정
   - 전체 기능 목록
   - 데이터 모델 설계
   - API 설계
   - 개발 로드맵
   ↓
2. /spec-create (첫 번째 피처)
   ↓
   피처별 개발 (반복)
   ↓
프로젝트 완성!
```

---

**이 커맨드는 프로젝트의 "큰 그림"을 먼저 그리고, 그 다음 피처별로 나누어 개발할 수 있게 도와줍니다.**
