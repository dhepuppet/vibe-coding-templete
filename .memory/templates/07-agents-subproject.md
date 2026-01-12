# AGENTS.md — [서브프로젝트명]

> **Sub-project specific rules.**
> Inherits from: `../../AGENTS.md` (root)

---

## 📍 Scope

This AGENTS.md applies to: `packages/[서브프로젝트명]/`

**Inherits all rules from root AGENTS.md, plus:**

---

## 🎯 Sub-project Overview

- **Name**: [서브프로젝트명]
- **Type**: [frontend / backend / shared / cli / ...]
- **Purpose**: [1줄 설명]

<!-- 한국어: 이 서브프로젝트의 이름, 타입, 목적 -->

---

## 🛠️ Dev Environment (Override)

```bash
# This sub-project specific commands
cd packages/[서브프로젝트명]

# Install
npm install

# Dev
npm run dev

# Test
npm test

# Build
npm run build
```

<!-- 한국어: 이 서브프로젝트 전용 명령어. 루트와 다르면 여기에 명시. -->

---

## 📁 Sub-project Structure

```
packages/[서브프로젝트명]/
├── AGENTS.md          ← You are here
├── src/
│   ├── components/    # (if frontend)
│   ├── routes/        # (if backend)
│   └── ...
├── package.json
└── tsconfig.json
```

---

## 🎨 Sub-project Conventions

### Naming
- Components: `PascalCase`
- Functions: `camelCase`
- Files: `kebab-case`

### Imports
- Use relative imports within this package
- Use `@shared/` alias for shared package

<!-- 한국어: 이 서브프로젝트 전용 컨벤션. 네이밍, 임포트 규칙 등. -->

---

## ⚠️ Sub-project Specific Rules

- [이 서브프로젝트에만 적용되는 규칙]
- [예: "이 패키지는 외부 API 호출 금지"]
- [예: "React 18 기능만 사용"]

<!-- 한국어: 이 서브프로젝트에만 적용되는 특수 규칙 -->

---

## 📖 References

| What | Where |
|------|-------|
| Root rules | `../../AGENTS.md` |
| Full methodology | `../../MAIN_PROMPT.md` |
| Shared types | `../shared/src/types/` |

---

*Inherits from root AGENTS.md. Sub-project specific overrides above.*