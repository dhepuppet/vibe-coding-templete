#!/bin/bash

echo "🚀 바이브코딩 프로젝트 초기화"
echo ""

read -p "프로젝트 이름: " PROJECT_NAME
read -p "뭐 만들 거야? (1줄): " PROJECT_GOAL

TODAY=$(date +%Y-%m-%d)

# 00-description.md 생성
cat > .memory/project/00-description.md << EOF
# 프로젝트: $PROJECT_NAME

## 생성일
$TODAY

## 목표
$PROJECT_GOAL

## 기술 스택
- Preflight에서 결정

## 핵심 기능
- Preflight에서 정리

## 제약/범위
- v0.1 우선, 최소 기능만
EOF

# 50-progress.md 생성
cat > .memory/project/50-progress.md << EOF
# 진행 이력

## $TODAY
- [x] 프로젝트 초기화: $PROJECT_NAME
- [ ] Preflight 작성
- [ ] v0.1 구현
EOF

# 60-decisions.md 생성
cat > .memory/project/60-decisions.md << EOF
# 결정 로그

## $TODAY - 프로젝트 시작
- **결정**: $PROJECT_NAME 시작
- **이유**: $PROJECT_GOAL
EOF

# MAIN_PROMPT.md 프로젝트명 업데이트
sed -i '' "s/\[프로젝트명\]/$PROJECT_NAME/g" MAIN_PROMPT.md 2>/dev/null || \
sed -i "s/\[프로젝트명\]/$PROJECT_NAME/g" MAIN_PROMPT.md

# AGENTS.md 생성
cat > AGENTS.md << 'AGENTSEOF'
# AGENTS.md

> **For AI coding agents working on this project.**
> Human documentation: see `README.md`

---

## 🎯 Core Rules

You follow the **Vibe Coding Methodology**. These rules are non-negotiable:

### 1. Plan/Act Mode Separation
- **Plan mode**: Analyze only. No file changes.
- **Act mode**: Execute only after explicit user approval.
- Always clarify which mode you're in.

<!-- 한국어: Plan 모드에서는 분석만, Act 모드에서는 승인 후 실행만. 모드를 항상 명시할 것. -->

### 2. Gate System
- Complete each step fully before moving to the next.
- Wait for user approval at every gate.
- Never skip gates or auto-proceed.
- Details: `.memory/templates/02-gate-system.md`

<!-- 한국어: 각 단계 완료 후 사용자 승인 대기. 게이트를 건너뛰거나 자동 진행 금지. -->

### 3. Minimum Diff Rule
- Change only what is necessary.
- Max 2 files, max 30 lines per change.
- No unnecessary refactoring.
- No "while we're here" improvements.
- Details: `.memory/templates/03-minimum-diff.md`

<!-- 한국어: 필요한 것만 변경. 파일 2개, 30줄 이하. 불필요한 리팩토링 금지. -->

### 4. 2-Loop Rule
- If the same error occurs twice, **STOP**.
- Rollback + create Debug Packet.
- Report findings to the user.
- Do not attempt a third fix without new information.
- Details: `.memory/templates/01-debug-packet.md`

<!-- 한국어: 같은 에러 2번 발생 시 중단, 롤백 + 디버그 패킷 작성. 새 정보 없이 3번째 시도 금지. -->

### 5. Memory Bank
- Log all decisions in `.memory/project/60-decisions.md`
- Update progress in `.memory/project/50-progress.md`
- Keep `.memory/project/40-active.md` current
- Details: `.memory/templates/05-memory-bank-guide.md`

<!-- 한국어: 모든 결정은 60-decisions.md에, 진행상황은 50-progress.md에, 현재 작업은 40-active.md에 기록. -->

---

## 🔄 Workflow

```
Step 0: Preflight → Approval
Step 1: Tasks checklist → Approval
Step 2: Implement 1 Task at a time (v0.1 only, no extras)
Step 3: Gate verification → Pass → Next Task
```

### Task Completion Report Format
After each task, output:
```
- Gate X: Pass/Fail
- 40-active.md: Updated (Y/N)
- 50-progress.md: Logged (Y/N)
- "Proceed to next Task?"
```

<!-- 한국어: 매 태스크 완료 시 게이트 통과여부, 파일 업데이트 여부 보고 후 승인 요청. -->

---

## 📋 Before Every Task (Preflight)

1. Read `.memory/project/40-active.md` — current task
2. Check `.memory/project/00-description.md` — project context
3. Review `.memory/templates/00-preflight.md` — preflight checklist

<!-- 한국어: 작업 전 현재 태스크, 프로젝트 컨텍스트, 프리플라이트 체크리스트 확인. -->

---

## 🛠️ Dev Environment

```bash
# Install dependencies
npm install        # or pnpm install

# Run development server
npm run dev

# Run tests
npm test

# Build for production
npm run build

# Lint code
npm run lint
```

<!-- 한국어: 기본 개발 명령어들. 프로젝트 스택에 맞게 수정 필요. -->

---

## 🐛 Debug Protocol

When errors occur:

1. Follow `.memory/templates/01-debug-packet.md`
2. Apply the 2-loop rule (max 2 attempts)
3. Document findings in `.memory/project/50-progress.md`
4. If stuck, report to user with:
   - What you tried
   - What failed
   - Your hypothesis

<!-- 한국어: 에러 발생 시 디버그 패킷 양식 따르기. 2루프 룰 적용. 막히면 시도한 것, 실패한 것, 가설과 함께 보고. -->

---

## 🔐 Security Checklist

Before any commit:

- [ ] No secrets or API keys in code
- [ ] No hardcoded credentials
- [ ] User inputs validated
- [ ] Dependencies checked for vulnerabilities

Full checklist: `.memory/templates/04-security-checklist.md`

<!-- 한국어: 커밋 전 시크릿/API키 없음, 하드코딩된 인증정보 없음, 입력값 검증, 의존성 취약점 확인. -->

---

## 📝 Git & Version Control

### Commit format
```
vX.X 완료 - [기능 설명]
```

### Version complete workflow
```bash
git add .
git commit -m "vX.X 완료 - [기능 설명]"
git tag vX.X
git push origin main --tags
```

### Before commit
1. Run `npm run lint` (if available)
2. Run `npm test` (if available)
3. Update `.memory/project/50-progress.md`

### Rollback if needed
```bash
git checkout vX.X  # Go to specific version
git checkout main  # Return to latest
```

<!-- 한국어: 버전 완료 시 태그 필수. main 브랜치는 항상 동작 상태 유지. -->

---

## 📁 File Management Rules

### Version-based document separation
- Preflight, Plan, Tasks: save per version (no overwrite)
- Never modify templates in `.memory/templates/`

### File naming convention
```
.memory/project/
├── preflight-v0.1.md
├── preflight-v0.2.md
├── plan-v0.1.md
├── tasks-v0.1.md
└── ...
```

### Forbidden
- Overwriting previous version files
- Directly modifying template files
- Saving without version number

<!-- 한국어: 버전별 문서 분리. 이전 버전 덮어쓰기 금지. 템플릿 원본 수정 금지. -->

---

## 🗂️ Project Structure

```
.
├── AGENTS.md              ← You are here (agent instructions)
├── MAIN_PROMPT.md         ← Full methodology (detailed reference)
├── README.md              ← Human documentation
├── init.sh                ← Project initializer
├── .memory/
│   ├── templates/         ← Reference templates (READ-ONLY)
│   │   ├── 00-preflight.md
│   │   ├── 01-debug-packet.md
│   │   ├── 02-gate-system.md
│   │   ├── 03-minimum-diff.md
│   │   ├── 04-security-checklist.md
│   │   ├── 05-memory-bank-guide.md
│   │   └── 06-roadmap.md
│   └── project/           ← Project state (READ-WRITE)
│       ├── 00-description.md
│       ├── 00-user-manual.md
│       ├── 10-tech-context.md
│       ├── 40-active.md
│       ├── 50-progress.md
│       └── 60-decisions.md
└── .agent/
    └── rules/
        └── persona.md     ← Agent persona (optional)
```

<!-- 한국어: templates=읽기전용 참조, project=읽기쓰기 상태 저장소. -->

---

## 📖 Key References

| What | Where |
|------|-------|
| Full methodology | `MAIN_PROMPT.md` |
| Agent persona | `.agent/rules/persona.md` |
| Project overview | `.memory/project/00-description.md` |
| Tech stack | `.memory/project/10-tech-context.md` |
| Current task | `.memory/project/40-active.md` |
| Progress log | `.memory/project/50-progress.md` |
| Decision log | `.memory/project/60-decisions.md` |
| Preflight template | `.memory/templates/00-preflight.md` |
| Debug packet | `.memory/templates/01-debug-packet.md` |
| Gate system | `.memory/templates/02-gate-system.md` |
| Minimum diff | `.memory/templates/03-minimum-diff.md` |
| Security checklist | `.memory/templates/04-security-checklist.md` |
| Memory bank guide | `.memory/templates/05-memory-bank-guide.md` |
| Roadmap template | `.memory/templates/06-roadmap.md` |

---

## ✅ Self-Verification

- Uncertain? Mark as `[확인필요]` (needs verification)
- Assumption? Mark as `[가정]` (assumption)
- Modifying existing code? Alert impact + get approval first
- 10+ turns? Summarize key decisions
- Every session: Read Memory Bank first

<!-- 한국어: 불확실하면 [확인필요], 가정이면 [가정] 표시. 기존 코드 수정 시 영향 알림 + 승인. -->

---

## ⚠️ Forbidden Actions

- ❌ Changes beyond what was requested
- ❌ Full file rewrites
- ❌ Proceeding without Gate approval
- ❌ Stating uncertain things as facts
- ❌ Overwriting files without confirmation
- ❌ Skipping preflight checklist
- ❌ Ignoring the 2-loop rule
- ❌ Refactoring unrelated code

<!-- 한국어: 요청 외 수정, 전체 재작성, 게이트 미통과 진행, 불확실→사실, 확인 없이 덮어쓰기 금지. -->

---

## 🗣️ Language Settings

- All output in **Korean** (한국어)
- Code comments in **Korean**
- English terms with Korean in parentheses (예: "beat tracking(박자 추적)")

<!-- 한국어: 모든 출력 한국어. 코드 주석도 한국어. 영어 전문용어는 괄호 병기. -->

---

*This project uses the Vibe Coding Template.*
*Full documentation: `MAIN_PROMPT.md` | Human guide: `README.md`*
AGENTSEOF

# AGENTS.md 프로젝트명 업데이트
sed -i '' "s/\[프로젝트명\]/$PROJECT_NAME/g" AGENTS.md 2>/dev/null || \
sed -i "s/\[프로젝트명\]/$PROJECT_NAME/g" AGENTS.md

echo ""
echo "✅ 완료! 생성된 파일:"
echo "   📄 .memory/project/00-description.md"
echo "   📄 .memory/project/50-progress.md"
echo "   📄 .memory/project/60-decisions.md"
echo "   📄 AGENTS.md (NEW - AI 에이전트용)"
echo ""
echo "🎯 다음 스텝:"
echo "   1. Antigravity에서 '@AGENTS.md 읽고 시작해줘'"
echo "   2. 또는 '@MAIN_PROMPT.md 읽고 Preflight 작성해줘'"
echo ""
echo "💡 TIP: 다른 AI 도구 (Cursor, Copilot 등)도 AGENTS.md 자동 인식!"