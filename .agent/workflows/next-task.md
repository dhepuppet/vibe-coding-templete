---
trigger: manual
description: 다음 Task 실행
---

# /next-task

1. @.memory/project/40-active.md 에서 현재 Task 확인
2. 해당 Task 구현 (Act 모드)
3. Gate 검증
4. 완료 보고 형식으로 출력:

**출력 형식:**
```
📋 Task X 완료

**Gate**: ✅/❌
**변경 파일**: 파일명 (N줄)
**Memory Bank**: 40-active.md ✅ / 50-progress.md ✅

다음 Task 진행해도 될까?
```
