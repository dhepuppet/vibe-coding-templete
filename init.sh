#!/bin/bash

echo "🚀 바이브코딩 프로젝트 초기화"
echo ""

# Monorepo 여부 확인
read -p "Monorepo 구조로 만들까? (y/N): " IS_MONOREPO
IS_MONOREPO=${IS_MONOREPO:-N}

# 스택 선택
echo ""
echo "기술 스택 선택:"
echo "  1) Node.js (npm/pnpm)"
echo "  2) Python (pip/poetry)"
echo "  3) 둘 다"
read -p "선택 (1/2/3, 기본 1): " STACK_CHOICE
STACK_CHOICE=${STACK_CHOICE:-1}

read -p "프로젝트 이름: " PROJECT_NAME
read -p "뭐 만들 거야? (1줄): " PROJECT_GOAL

TODAY=$(date +%Y-%m-%d)

# 스택 문자열 설정
case $STACK_CHOICE in
    1) STACK_NAME="Node.js" ;;
    2) STACK_NAME="Python" ;;
    3) STACK_NAME="Node.js + Python" ;;
    *) STACK_NAME="Node.js" ;;
esac

# (추가) 필수 디렉토리 보장: 템플릿 복사/빈 폴더 실행 둘 다 안전하게
mkdir -p .memory/project
mkdir -p .memory/templates
mkdir -p .agent/rules
mkdir -p .agent/skills/code-reviewer

# (추가) skill.md가 없을 때만 시드 생성 (기존 파일 보호)
if [ ! -f ".agent/skills/code-reviewer/skill.md" ]; then
  cat > ".agent/skills/code-reviewer/skill.md" << 'EOF'
---
name: code-reviewer
description: Review the current project code with surgical precision. Flag only high-severity issues (bugs, security, performance, breaking changes) via succinct inline comments on specific lines. Skip style, nits, and minor improvements. High signal, low noise.
---

# Code Reviewer

High-precision code review for the current project. Flag critical issues only.
EOF
fi

# 00-description.md 생성
cat > .memory/project/00-description.md << EOF
# 프로젝트: $PROJECT_NAME

## 생성일
$TODAY

## 목표
$PROJECT_GOAL

## 기술 스택
- 기본: $STACK_NAME
- 상세: Preflight에서 결정

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
- [x] 스택 선택: $STACK_NAME
- [ ] Preflight 작성
- [ ] v0.1 구현
EOF

# 60-decisions.md 생성
cat > .memory/project/60-decisions.md << EOF
# 결정 로그

## $TODAY - 프로젝트 시작
- **결정**: $PROJECT_NAME 시작
- **이유**: $PROJECT_GOAL
- **스택**: $STACK_NAME
EOF

# MAIN_PROMPT.md 프로젝트명 업데이트
sed -i '' "s/\[프로젝트명\]/$PROJECT_NAME/g" MAIN_PROMPT.md 2>/dev/null || \
sed -i "s/\[프로젝트명\]/$PROJECT_NAME/g" MAIN_PROMPT.md

# AGENTS.md 생성 (스택에 따라 다른 Dev Environment)
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

### Node.js
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

### Python
```bash
# 가상환경 생성 및 활성화
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# 의존성 설치
pip install -r requirements.txt
# or poetry install

# 실행
python main.py
# or uvicorn main:app --reload (FastAPI)
# or streamlit run app.py (Streamlit)

# 테스트
pytest

# 린트
ruff check .
# or flake8
```

### Python 상세 가이드
See `.memory/templates/08-python-stack.md`

<!-- 한국어: Node.js는 npm/pnpm, Python은 venv+pip 또는 poetry 사용. 상세 가이드는 08-python-stack.md 참고. -->

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
1. Run lint (npm run lint / ruff check .)
2. Run tests (npm test / pytest)
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

### Node.js
```
.
├── AGENTS.md
├── MAIN_PROMPT.md
├── README.md
├── package.json
├── src/
│   └── ...
└── .memory/
```

### Python
```
.
├── AGENTS.md
├── MAIN_PROMPT.md
├── README.md
├── requirements.txt    # or pyproject.toml
├── main.py
├── src/
│   └── ...
├── tests/
│   └── ...
├── venv/               # 가상환경 (gitignore)
└── .memory/
```

<!-- 한국어: Node.js는 package.json 기반, Python은 requirements.txt 또는 pyproject.toml 기반. -->

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
| Sub-project AGENTS.md | `.memory/templates/07-agents-subproject.md` |
| Python stack guide | `.memory/templates/08-python-stack.md` |

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

## 🏗️ Monorepo Support

This template supports monorepo structures with hierarchical AGENTS.md files.

### How it works
```
project-root/
├── AGENTS.md              ← Global rules (this file)
├── packages/
│   ├── app/
│   │   └── AGENTS.md      ← App-specific rules
│   └── api/
│       └── AGENTS.md      ← API-specific rules
```

### Rule priority
1. **Nearest AGENTS.md** — Check current directory first
2. **Parent AGENTS.md** — Fallback to parent directories
3. **Root AGENTS.md** — Global rules apply to all

### Creating sub-project AGENTS.md
Use `.memory/templates/07-agents-subproject.md` as template.

<!-- 한국어: Monorepo 구조에서는 가장 가까운 AGENTS.md가 우선 적용됨. 서브프로젝트용 템플릿은 07-agents-subproject.md 참고. -->

---

*This project uses the Vibe Coding Template.*
*Full documentation: `MAIN_PROMPT.md` | Human guide: `README.md`*
AGENTSEOF

# AGENTS.md 프로젝트명 업데이트
sed -i '' "s/\[프로젝트명\]/$PROJECT_NAME/g" AGENTS.md 2>/dev/null || \
sed -i "s/\[프로젝트명\]/$PROJECT_NAME/g" AGENTS.md

# Python 선택 시 기본 파일 생성
if [[ "$STACK_CHOICE" == "2" || "$STACK_CHOICE" == "3" ]]; then
    # requirements.txt 생성
    cat > requirements.txt << 'REQEOF'
# 기본 의존성 (필요한 것만 주석 해제)
# fastapi
# uvicorn[standard]
# streamlit
# requests
# python-dotenv
# pytest
# ruff
REQEOF

    # .gitignore에 Python 관련 추가
    cat >> .gitignore << 'GITEOF'

# Python
venv/
__pycache__/
*.pyc
.pytest_cache/
.ruff_cache/
*.egg-info/
dist/
build/
.env
GITEOF

    echo "   ✅ Python 기본 파일 생성 (requirements.txt, .gitignore 추가)"
fi

# Node.js 선택 시 기본 파일 생성
if [[ "$STACK_CHOICE" == "1" || "$STACK_CHOICE" == "3" ]]; then
    # package.json이 없으면 생성
    if [ ! -f "package.json" ]; then
        cat > package.json << PKGEOF
{
  "name": "$PROJECT_NAME",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "echo 'Add dev script'",
    "build": "echo 'Add build script'",
    "test": "echo 'Add test script'",
    "lint": "echo 'Add lint script'"
  }
}
PKGEOF
        echo "   ✅ Node.js package.json 생성"
    fi
fi

# Monorepo 설정
if [[ "$IS_MONOREPO" =~ ^[Yy]$ ]]; then
    echo ""
    echo "📦 Monorepo 구조 생성 중..."
    
    read -p "서브프로젝트 개수 (기본 2): " SUB_COUNT
    SUB_COUNT=${SUB_COUNT:-2}
    
    mkdir -p packages
    
    for ((i=1; i<=SUB_COUNT; i++)); do
        read -p "서브프로젝트 $i 이름: " SUB_NAME
        read -p "서브프로젝트 $i 타입 (frontend/backend/shared/cli): " SUB_TYPE
        echo "서브프로젝트 $i 스택:"
        echo "  1) Node.js"
        echo "  2) Python"
        read -p "선택 (1/2, 기본 1): " SUB_STACK
        SUB_STACK=${SUB_STACK:-1}
        
        mkdir -p "packages/$SUB_NAME/src"
        
        # 서브프로젝트 AGENTS.md 생성
        cat > "packages/$SUB_NAME/AGENTS.md" << SUBEOF
# AGENTS.md — $SUB_NAME

> **Sub-project specific rules.**
> Inherits from: \`../../AGENTS.md\` (root)

---

## 📍 Scope

This AGENTS.md applies to: \`packages/$SUB_NAME/\`

**Inherits all rules from root AGENTS.md, plus:**

---

## 🎯 Sub-project Overview

- **Name**: $SUB_NAME
- **Type**: $SUB_TYPE
- **Stack**: $([ "$SUB_STACK" == "2" ] && echo "Python" || echo "Node.js")
- **Purpose**: [1줄 설명 추가 필요]

<!-- 한국어: 이 서브프로젝트의 이름, 타입, 스택, 목적 -->

---

## 🛠️ Dev Environment (Override)

\`\`\`bash
cd packages/$SUB_NAME
$(if [ "$SUB_STACK" == "2" ]; then
cat << 'PYENV'

# Python 환경
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# 실행
python main.py

# 테스트
pytest
PYENV
else
cat << 'NODEENV'

# Node.js 환경
npm install
npm run dev
npm test
NODEENV
fi)
\`\`\`

<!-- 한국어: 이 서브프로젝트 전용 명령어 -->

---

## 📁 Sub-project Structure

\`\`\`
packages/$SUB_NAME/
├── AGENTS.md
├── src/
│   └── ...
$([ "$SUB_STACK" == "2" ] && echo "├── requirements.txt" || echo "├── package.json")
└── $([ "$SUB_STACK" == "2" ] && echo "main.py" || echo "index.js")
\`\`\`

---

## ⚠️ Sub-project Specific Rules

- [이 서브프로젝트에만 적용되는 규칙 추가]

<!-- 한국어: 이 서브프로젝트에만 적용되는 특수 규칙 -->

---

## 📖 References

| What | Where |
|------|-------|
| Root rules | \`../../AGENTS.md\` |
| Full methodology | \`../../MAIN_PROMPT.md\` |

---

*Inherits from root AGENTS.md.*
SUBEOF

        # 서브프로젝트 스택별 파일 생성
        if [ "$SUB_STACK" == "2" ]; then
            # Python
            cat > "packages/$SUB_NAME/requirements.txt" << 'REQEOF'
# 의존성 추가
REQEOF
            touch "packages/$SUB_NAME/main.py"
        else
            # Node.js
            cat > "packages/$SUB_NAME/package.json" << PKGEOF
{
  "name": "@$PROJECT_NAME/$SUB_NAME",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "echo 'Add dev script'",
    "build": "echo 'Add build script'",
    "test": "echo 'Add test script'"
  }
}
PKGEOF
        fi

        echo "   ✅ packages/$SUB_NAME/ 생성 완료 ($([ "$SUB_STACK" == "2" ] && echo "Python" || echo "Node.js"))"
    done
    
    # 루트 package.json 생성 (Node.js 포함 시)
    if [[ "$STACK_CHOICE" == "1" || "$STACK_CHOICE" == "3" ]]; then
        cat > package.json << ROOTPKGEOF
{
  "name": "$PROJECT_NAME",
  "version": "0.1.0",
  "private": true,
  "workspaces": [
    "packages/*"
  ],
  "scripts": {
    "dev": "echo 'Run all packages'",
    "build": "echo 'Build all packages'",
    "test": "echo 'Test all packages'"
  }
}
ROOTPKGEOF
        echo "   ✅ 루트 package.json (workspaces) 생성"
    fi
fi

echo ""
echo "✅ 완료! 생성된 파일:"
echo "   📄 .memory/project/00-description.md"
echo "   📄 .memory/project/50-progress.md"
echo "   📄 .memory/project/60-decisions.md"
echo "   📄 AGENTS.md"
echo "   📄 스택: $STACK_NAME"

if [[ "$STACK_CHOICE" == "2" || "$STACK_CHOICE" == "3" ]]; then
    echo "   📄 requirements.txt (Python)"
fi

if [[ "$IS_MONOREPO" =~ ^[Yy]$ ]]; then
    echo "   📦 packages/ (Monorepo 구조)"
fi

echo ""
echo "🎯 다음 스텝:"
echo "   1. Antigravity에서 '@AGENTS.md 읽고 시작해줘'"
echo "   2. 또는 '@MAIN_PROMPT.md 읽고 Preflight 작성해줘'"
echo ""
echo "💡 TIP: 다른 AI 도구 (Cursor, Copilot 등)도 AGENTS.md 자동 인식!"