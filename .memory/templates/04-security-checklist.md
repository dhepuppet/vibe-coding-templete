# 보안 체크리스트

---

## 인증
- [ ] 직접 구현 금지 → Supabase/NextAuth
- [ ] 비밀번호 평문 금지
- [ ] 권한 체크 모든 API

## 비밀정보
- [ ] API 키 → .env만
- [ ] .env → .gitignore
- [ ] 프론트 노출 금지

## 입력검증
- [ ] Zod (TS) / Pydantic (Python)
- [ ] ORM 사용 (SQL Injection 방지)

## 금지 패턴
```js
❌ const key = "sk-xxx"
❌ localStorage.setItem('token', pwd)
❌ `SELECT * WHERE id=${id}`
```