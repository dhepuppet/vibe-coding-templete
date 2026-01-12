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

<!-- 한국어: 각 단계 완료 후 사용자 승인 대기. 게이트를 건너뛰거나 자동 진행 금지. -->

### 3. Minimum Diff Rule
- Change only what is necessary.
- No unnecessary refactoring.
- No "while we're here" improvements.

<!-- 한국어: 필요한 것만 변경. 불필요한 리팩토링 금지. "ついでに" 개선 금지. -->

### 4. 2-Loop Rule
- If the same error occurs twice, **STOP**.
- Report findings to the user.
- Do not attempt a third fix without new information.

<!-- 한국어: 같은 에러 2번 발생 시 중단. 사용자에게 보고. 새 정보 없이 3번째 시도 금지. -->

### 5. Memory Bank
- Log all decisions in `.memory/project/60-decisions.md`
- Update progress in `.memory/project/50-progress.md`
- Keep `.memory/project/40-active.md` current

<!-- 한국어: 모든 결정은 60-decisions.md에, 진행상황은 50-progress.md에, 현재 작업은 40-active.md에 기록. -->

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
npm install
# or
pnpm install

# Run development server
npm run dev

# Run tests
npm test

# Build for production
npm run build

# Lint code
npm run lint
```

<!-- 한국어: 기본 개발 명령어들. 프로젝트에 맞게 수정 필요. -->

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

## 📝 PR & Commit Instructions

**Commit format:**
```
[v<version>] <short description>

- Detail 1
- Detail 2
```

**Before commit:**
1. Run `npm run lint`
2. Run `npm test`
3. Update `.memory/project/50-progress.md`

<!-- 한국어: 커밋 형식 [v버전] 설명. 커밋 전 린트, 테스트, 진행기록 업데이트. -->

---

## 🗂️ Project Structure

```
.
├── AGENTS.md              ← You are here (agent instructions)
├── MAIN_PROMPT.md         ← Full methodology (detailed)
├── README.md              ← Human documentation
├── .memory/
│   ├── templates/         ← Reference templates (read-only)
│   └── project/           ← Project state (read-write)
└── .agent/
    └── rules/persona.md   ← Agent persona
```

<!-- 한국어: AGENTS.md=에이전트용, MAIN_PROMPT.md=상세방법론, README.md=사람용, .memory/templates=참조템플릿(읽기전용), .memory/project=프로젝트상태(읽기쓰기). -->

---

## 📖 Key References

| What | Where |
|------|-------|
| Full methodology | `MAIN_PROMPT.md` |
| Project overview | `.memory/project/00-description.md` |
| Tech stack | `.memory/project/10-tech-context.md` |
| Current task | `.memory/project/40-active.md` |
| Progress log | `.memory/project/50-progress.md` |
| Decision log | `.memory/project/60-decisions.md` |
| Gate system guide | `.memory/templates/02-gate-system.md` |
| Minimum diff guide | `.memory/templates/03-minimum-diff.md` |

<!-- 한국어: 상세 문서 위치 참조표. 필요한 정보는 해당 파일에서 확인. -->

---

## ⚠️ What NOT To Do

- ❌ Skip the preflight checklist
- ❌ Make changes without approval in Plan mode
- ❌ Ignore the 2-loop rule
- ❌ Refactor code that isn't related to the task
- ❌ Proceed without understanding the current task
- ❌ Forget to update Memory Bank after changes

<!-- 한국어: 프리플라이트 생략 금지, Plan모드에서 무단 변경 금지, 2루프룰 무시 금지, 관련없는 리팩토링 금지, 태스크 이해 없이 진행 금지, 메모리뱅크 업데이트 잊지 말 것. -->

---

*This project uses the Vibe Coding Template. For questions, see the full documentation in `MAIN_PROMPT.md`.*
