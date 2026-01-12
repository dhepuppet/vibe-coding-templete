# ARCHITECTURE.md

> 이 문서는 AI 에이전트와 개발자가 프로젝트 구조를 빠르게 파악하기 위한 설계도입니다.
> 구조가 변경되면 이 문서도 업데이트하세요.

---

## 1. 프로젝트 개요

- **프로젝트명**: [프로젝트명]
- **목적**: [1~2줄 설명]
- **주요 기술**: [예: Python + FastAPI + React]
- **최종 업데이트**: [YYYY-MM-DD]

---

## 2. 폴더 구조

```
[프로젝트명]/
├── frontend/                 # 프론트엔드 (UI)
│   ├── src/
│   │   ├── components/       # 재사용 UI 컴포넌트
│   │   ├── pages/            # 페이지/뷰
│   │   ├── services/         # API 호출 로직
│   │   └── store/            # 상태 관리
│   ├── public/               # 정적 파일
│   └── package.json
│
├── backend/                  # 백엔드 (API)
│   ├── src/
│   │   ├── api/              # API 엔드포인트
│   │   ├── services/         # 비즈니스 로직
│   │   ├── models/           # 데이터 모델
│   │   └── utils/            # 유틸리티
│   ├── tests/                # 백엔드 테스트
│   └── requirements.txt      # (Python) 또는 package.json (Node)
│
├── shared/                   # 프론트+백엔드 공통
│   ├── types/                # 공유 타입 정의
│   └── utils/                # 공통 유틸리티
│
├── docs/                     # 문서
├── scripts/                  # 자동화 스크립트
├── tests/                    # 통합 테스트
│
├── AGENTS.md                 # AI 에이전트 규칙
├── ARCHITECTURE.md           # 이 파일
├── MAIN_PROMPT.md            # 상세 방법론
└── README.md                 # 사용자 가이드
```

<!-- 한국어: 프로젝트 폴더 구조. 실제 구조에 맞게 수정 필요. -->

---

## 3. 시스템 다이어그램

```
[사용자] 
    ↓
[Frontend] ←→ [Backend API] ←→ [Database]
                   ↓
              [External API]
```

### 데이터 흐름
1. 사용자가 Frontend에서 액션
2. Frontend가 Backend API 호출
3. Backend가 DB 조회/저장 또는 외부 API 연동
4. 결과를 Frontend로 반환
5. 사용자에게 표시

<!-- 한국어: 실제 시스템 구조에 맞게 다이어그램 수정. -->

---

## 4. 핵심 컴포넌트

### 4.1 Frontend

| 항목 | 내용 |
|------|------|
| **이름** | [예: 웹 대시보드] |
| **설명** | [예: 사용자가 데이터를 조회하고 관리하는 UI] |
| **기술** | [예: React, Next.js, TailwindCSS] |
| **배포** | [예: Vercel, Netlify] |

### 4.2 Backend

| 항목 | 내용 |
|------|------|
| **이름** | [예: API 서버] |
| **설명** | [예: 인증, 데이터 처리, 외부 연동 담당] |
| **기술** | [예: Python, FastAPI, SQLAlchemy] |
| **배포** | [예: Railway, AWS Lambda] |

### 4.3 Database

| 항목 | 내용 |
|------|------|
| **이름** | [예: 메인 DB] |
| **타입** | [예: PostgreSQL, MongoDB, SQLite] |
| **용도** | [예: 사용자 정보, 분석 결과 저장] |
| **주요 테이블** | [예: users, projects, logs] |

---

## 5. 외부 연동

| 서비스 | 용도 | 연동 방식 |
|--------|------|----------|
| [예: OpenAI API] | [예: 텍스트 생성] | REST API |
| [예: YouTube API] | [예: 영상 정보 조회] | REST API |
| [예: Stripe] | [예: 결제 처리] | SDK |

---

## 6. 인증 & 보안

| 항목 | 방식 |
|------|------|
| **인증** | [예: JWT, OAuth2, API Key] |
| **권한** | [예: RBAC (역할 기반)] |
| **암호화** | [예: HTTPS (전송), AES-256 (저장)] |
| **민감정보** | [예: .env 파일, 환경변수] |

---

## 7. 개발 환경

### 로컬 실행

```bash
# Backend
cd backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
uvicorn main:app --reload

# Frontend
cd frontend
npm install
npm run dev
```

### 테스트

```bash
# Backend 테스트
cd backend
pytest

# Frontend 테스트
cd frontend
npm test
```

### 코드 품질

| 도구 | 용도 |
|------|------|
| [예: ruff] | Python 린트 |
| [예: ESLint] | JS/TS 린트 |
| [예: Prettier] | 코드 포맷 |

---

## 8. 배포

| 환경 | 플랫폼 | URL |
|------|--------|-----|
| Production | [예: Vercel + Railway] | [URL] |
| Staging | [예: 없음] | - |
| Local | localhost | http://localhost:3000 |

---

## 9. 향후 계획

- [ ] [예: 사용자 인증 추가]
- [ ] [예: 실시간 알림 기능]
- [ ] [예: 모바일 앱 버전]

---

## 10. 용어 정리

| 용어 | 설명 |
|------|------|
| [용어1] | [설명] |
| [용어2] | [설명] |

---

*이 문서는 프로젝트 구조가 변경될 때마다 업데이트되어야 합니다.*