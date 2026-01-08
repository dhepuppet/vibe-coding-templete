# 기술 스택 컨텍스트

## 개요
이 파일은 프로젝트에서 사용하는 기술 스택을 정의합니다.
에이전트는 여기 명시된 스택을 기준으로 작업하고, 변경 시 승인을 받아야 합니다.

---

## 기술 스택

### 언어/프레임워크
- **Language**: (예: Python 3.10+)
- **Web Framework**: (예: Streamlit, FastAPI, Next.js)
- **Core Library**: (예: librosa, pandas, React)

### 의존성
```
# requirements.txt 또는 package.json 주요 항목
# 예시:
# streamlit>=1.30.0
# librosa>=0.10.0
```

### 시스템 의존성
```
# packages.txt 또는 시스템 레벨 의존성
# 예시:
# ffmpeg
# libsndfile1
```

---

## 개발 환경

### IDE
- **Primary**: Google Antigravity
- **Model**: Gemini 3 Flash

### 로컬 환경
- **OS**: (예: Windows 11, macOS, Ubuntu)
- **Python/Node**: (예: Python 3.10+)
- **GPU**: (선택사항)

### 배포 환경 (예정)
- **Platform**: (예: Streamlit Cloud, Vercel, 없음)
- **제약**: (예: 무료 티어 메모리 한계)

---

## 스택 변경 규칙

### 승인 필요 (금지)
- 새 라이브러리 추가
- 기존 라이브러리 버전 변경
- 프레임워크 변경

### 승인 불필요 (허용)
- 기존 라이브러리 내 새 기능 사용
- CSS/스타일 수정
- 함수/로직 추가

### 변경 요청 형식
```
## 스택 변경 요청

**추가/변경**: [라이브러리명]
**이유**: [왜 필요한지]
**대안**: [다른 방법은 없는지]
**영향**: [기존 코드에 미치는 영향]
```

---

## 아키텍처 패턴

### 파일 구조
```
project-name/
├── app.py (또는 index.js)  # 메인 앱
├── requirements.txt        # 의존성
├── .memory/                # 프로젝트 문서
└── .agent/rules/           # 에이전트 규칙
```

### 코드 패턴
- **상태 관리**: (예: st.session_state, useState)
- **에러 처리**: (예: try-except + 사용자 알림)
- **진행 표시**: (예: 로딩 스피너, 프로그레스 바)

---

## 참고사항

- 이 파일은 프로젝트 시작 시 작성하고, 스택 변경 시 업데이트
- 에이전트가 새 라이브러리를 제안하면 이 파일 먼저 확인
- 버전 충돌 발생 시 이 파일 기준으로 해결
