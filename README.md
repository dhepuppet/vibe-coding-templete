# 🎯 Vibe Coding Template for Antigravity

Google Antigravity에서 안전하고 체계적인 바이브코딩을 위한 템플릿입니다.

---

## 📋 목차

1. [이 템플릿은 뭔가요?](#이-템플릿은-뭔가요)
2. [폴더 구조](#폴더-구조)
3. [시작하기](#시작하기)
4. [운영 가이드](#운영-가이드)
5. [핵심 규칙](#핵심-규칙)
6. [자주 쓰는 명령어](#자주-쓰는-명령어)
7. [문제 해결](#문제-해결)

---

## 이 템플릿은 뭔가요?

바이브코딩할 때 흔히 겪는 문제들을 방지하는 구조화된 템플릿입니다:

| 문제 | 해결책 |
|------|--------|
| AI가 규칙을 까먹음 | Rules 파일 + Memory Bank |
| 승인 없이 막 진행함 | Plan/Act 모드 분리 |
| 이전 버전이 망가짐 | Git 태그 + 버전 관리 |
| 뭘 했는지 기억 안 남 | 진행 기록 자동화 |
| 디버깅 무한루프 | 2-루프 룰 + Debug Packet |

---

## 폴더 구조

```
vibe-coding-template/
│
├── 📄 MAIN_PROMPT.md          # 핵심 규칙서 (에이전트가 읽음)
├── 📄 README.md               # 이 파일 (사용자 가이드)
├── 📄 init.sh                 # 프로젝트 초기화 스크립트
│
├── 📁 .memory/
│   ├── 📁 templates/          # 참조용 템플릿 (수정 X)
│   │   ├── 00-preflight.md        # Preflight 양식
│   │   ├── 01-debug-packet.md     # 디버깅 양식
│   │   ├── 02-gate-system.md      # Gate 검증 가이드
│   │   ├── 03-minimum-diff.md     # 최소 변경 규칙
│   │   ├── 04-security-checklist.md  # 보안 체크리스트
│   │   └── 05-memory-bank-guide.md   # Memory Bank 가이드
│   │
│   └── 📁 project/            # 프로젝트 상태 (자주 업데이트)
│       ├── 00-description.md      # 프로젝트 개요
│       ├── 00-user-manual.md      # 운영 매뉴얼
│       ├── 10-tech-context.md     # 기술 스택
│       ├── 40-active.md           # 현재 작업
│       ├── 50-progress.md         # 진행 기록
│       └── 60-decisions.md        # 결정 로그
│
└── 📁 .agent/
    └── 📁 rules/
        └── persona.md         # 에이전트 페르소나 + 규칙
```

---

## 시작하기

### 1단계: 템플릿 복사

```bash
# 방법 1: 로컬 복사
cp -r ~/templates/vibe-coding-template my-new-project
cd my-new-project

# 방법 2: GitHub 템플릿 사용
# GitHub에서 "Use this template" 클릭
```

### 2단계: 초기화

```bash
./init.sh
```

프롬프트에 따라 입력:
- 프로젝트 이름: `my-project`
- 목표: `어떤 프로젝트인지 한 줄 설명`

### 3단계: Antigravity에서 열기

1. Antigravity 실행
2. File → Open Folder → 프로젝트 폴더 선택

### 4단계: 에이전트 준비

채팅창에 입력:

```
@MAIN_PROMPT.md 읽고 규칙 따라줘.
@.memory/project/00-description.md 보고 프로젝트 파악해.

준비되면 "준비 완료"라고 말해.
```

### 5단계: 기술 스택 설정

`.memory/project/10-tech-context.md` 열어서 사용할 기술 스택 작성

---

## 운영 가이드

### 새 버전 시작할 때

```
v0.1 시작할게.

## 목표
- [만들고 싶은 기능]

## 기술 스택
- [사용할 기술]

@.memory/templates/00-preflight.md 참고해서
Preflight 작성해줘. (Plan 모드)
```

### 승인 흐름

```
1) Preflight 받음 → 검토 → "승인. Plan 작성해줘."
2) Plan 받음 → 검토 → "승인. Tasks 작성해줘."
3) Tasks 받음 → 검토 → "승인. Task 1부터 시작해. (Act 모드)"
```

### Task 진행 중

```
에이전트가 Task 완료 보고 → Gate 확인 → "Gate 통과. 다음 Task 진행해."
```

### 버전 완료할 때

```bash
git add .
git commit -m "v0.1 완료 - [기능 설명]"
git tag v0.1
git push origin main --tags
```

### 다른 환경에서 이어서 할 때

```bash
git clone https://github.com/[계정]/[프로젝트].git
cd [프로젝트]
```

그 다음 Antigravity에서:

```
@MAIN_PROMPT.md 읽고 규칙 따라줘.
@.memory/project/40-active.md 현재 상태 확인해.

이어서 작업할게. 현재 상태 요약해줘.
```

---

## 핵심 규칙

### 1. Plan/Act 모드

| 모드 | 언제 | 뭘 함 |
|------|------|-------|
| **Plan** | 기본 | 계획만 작성, 코드 수정 X |
| **Act** | 승인 후 | 실제 코드 수정 |

### 2. Gate 시스템

- 매 Task마다 Gate 통과해야 다음 진행
- Gate 미통과 시 수정 → 재검증

### 3. 최소 diff 규칙

- 한 번에 파일 2개 이하
- 한 번에 30줄 이하
- 전체 재작성 금지

### 4. 2-루프 룰

- 같은 에러 2번 반복 → 롤백 + Debug Packet

### 5. Memory Bank 업데이트

| 시점 | 업데이트 파일 |
|------|---------------|
| Task 완료 | 40-active.md, 50-progress.md |
| 버전 완료 | 60-decisions.md |
| 중요 결정 | 60-decisions.md |

---

## 자주 쓰는 명령어

### 세션 관리

| 상황 | 입력 |
|------|------|
| 세션 시작 | `@MAIN_PROMPT.md 읽고 준비해` |
| 상태 확인 | `현재 진행 상태 요약해줘` |
| 규칙 상기 | `@MAIN_PROMPT.md 다시 읽어줘` |

### 버전 작업

| 상황 | 입력 |
|------|------|
| 새 버전 시작 | `v0.X Preflight 작성해줘 (Plan 모드)` |
| Plan 승인 | `승인. Plan 작성해줘.` |
| Tasks 승인 | `승인. Tasks 작성해줘.` |
| Build 시작 | `승인. Task 1부터 시작해. (Act 모드)` |

### Task 진행

| 상황 | 입력 |
|------|------|
| Gate 통과 | `Gate X 통과 확인. Task X+1 진행해.` |
| 문제 발생 | `Debug Packet 작성해줘` |
| 롤백 필요 | `이전 상태로 롤백하고 다시 시작하자` |

### Memory Bank

| 상황 | 입력 |
|------|------|
| 상태 저장 | `Memory Bank 업데이트해줘` |
| 기록 확인 | `50-progress.md 보여줘` |

---

## 문제 해결

### 에이전트가 규칙을 안 따를 때

```
@MAIN_PROMPT.md 다시 읽고 규칙 상기해줘.
특히 [안 지키는 규칙] 지켜줘.
```

### 에이전트가 승인 없이 진행할 때

```
잠깐. Act 모드로 넘어가기 전에 승인 받아야 해.
Plan 모드로 돌아가서 계획 먼저 보여줘.
```

### 같은 에러가 반복될 때

```
2-루프 룰 적용할게.
@.memory/templates/01-debug-packet.md 참고해서 Debug Packet 작성해줘.
```

### Memory Bank가 업데이트 안 될 때

```
Task 완료했으면 Memory Bank 업데이트 필수야.
40-active.md랑 50-progress.md 업데이트해줘.
```

### 이전 버전으로 돌아가고 싶을 때

```bash
# 태그 목록 확인
git tag

# 특정 버전으로 이동
git checkout v0.1

# 최신으로 복귀
git checkout main
```

---

## 커스터마이징

### 페르소나 변경

`.agent/rules/persona.md` 수정

### 규칙 추가

`MAIN_PROMPT.md` 또는 `.agent/rules/persona.md`에 추가

### 템플릿 수정

`.memory/templates/` 폴더 내 파일 수정 (원본 백업 권장)

---

## 참고 자료

- [Google Antigravity 공식 문서](https://antigravity.google/docs)
- [Cursor Memory Bank](https://github.com/tacticlaunch/cursor-memory-bank)
- [바이브코딩 베스트 프랙티스](https://vibecoding.app/blog/how-vibe-coding-works)

---

## 라이선스

MIT License - 자유롭게 사용, 수정, 배포 가능

---

Made with 💻 by 랩코딩 🙂
