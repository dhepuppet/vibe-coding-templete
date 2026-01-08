---
trigger: manual
description: 버전 완료 처리
---

# /finish-version

1. 전체 Gate 통과 확인
2. @.memory/project/50-progress.md 버전 완료 기록
3. @.memory/project/60-decisions.md 주요 결정 기록
4. Git 명령어 출력

**출력 형식:**
```
🎉 vX.X 완료!

**Gate 전체**: ✅
**Memory Bank**: 업데이트 완료

**Git:**
git add .
git commit -m "vX.X 완료 - [기능]"
git tag vX.X
git push origin main --tags
```
