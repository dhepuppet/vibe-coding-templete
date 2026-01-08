랩하이, 둘 다 만들어줄게!
# 운영 매뉴얼

이 문서는 프로젝트를 운영하는 방법을 단계별로 설명합니다.

---

## 1. 새 세션 시작

### 1-1. Antigravity 실행
1. Antigravity 앱 열기
2. File → Open Folder → 프로젝트 폴더 선택

### 1-2. 에이전트 컨텍스트 주입
채팅창에 입력:
```
@MAIN_PROMPT.md 읽고 규칙 따라줘.
@.memory/project/00-description.md 보고 프로젝트 파악해.
@.memory/project/10-tech-context.md 기술 스택 확인해.

준비되면 "준비 완료"라고 말해.
```

### 1-3. 에이전트 응답 확인
- "준비 완료" 나오면 → 다음 단계
- 안 나오면 → 다시 요청

---

## 2. 새 버전 시작 (Preflight)

### 2-1. Preflight 요청
```
v0.X 시작할게.

## 추가할 기능
- [기능 설명]

@.memory/templates/00-preflight.md 참고해서
Preflight 작성해줘. (Plan 모드)
```

### 2-2. 검토 포인트
- [ ] I/O 명세가 명확한가?
- [ ] 실패모드가 현실적인가?
- [ ] Gate 조건이 검증 가능한가?
- [ ] Task가 10~30분 단위인가?

### 2-3. 승인
```
Preflight 승인. Plan 작성해줘.
```

---

## 3. Plan → Tasks 승인

### 3-1. Plan 검토 후
```
Plan 승인. Tasks 작성해줘.
```

### 3-2. Tasks 검토 후
```
Tasks 승인. Task 1부터 시작해. (Act 모드)
```

---

## 4. Task 진행 (Act 모드)

### 4-1. Task 완료 확인
에이전트가 아래 형식으로 보고해야 함:
```
📋 Task X 완료

**Gate X**: ✅ 통과 / ❌ 미통과
**변경 파일**: [파일명] (N줄)
**Memory Bank 업데이트**:
- 40-active.md: ✅
- 50-progress.md: ✅

다음 Task 진행해도 될까?
```

### 4-2. Gate 확인 후 승인
1. 실제로 테스트 (브라우저/터미널에서 확인)
2. 정상이면:
```
Gate X 통과 확인. Task X+1 진행해.
```

### 4-3. 문제 발생 시
같은 에러 2번 반복되면:
```
@.memory/templates/01-debug-packet.md 참고해서 Debug Packet 작성해줘.
```

---

## 5. 버전 완료

### 5-1. 전체 Gate 통과 확인
에이전트가 아래 형식으로 보고해야 함:
```
🎉 vX.X 완료!

**Gate 전체**: ✅ 통과
**Memory Bank 업데이트**:
- 50-progress.md: 버전 완료 기록
- 60-decisions.md: 주요 결정 기록

**Git 명령어**:
git add .
git commit -m "vX.X 완료 - [기능]"
git tag vX.X
git push origin main --tags
```

### 5-2. Git 커밋
터미널에서 실행:
```bash
git add .
git commit -m "vX.X 완료 - [기능 설명]"
git tag vX.X
git push origin main --tags
```

---

## 6. 다른 환경에서 이어서 작업

### 6-1. Clone
```bash
git clone https://github.com/[계정]/[프로젝트].git
cd [프로젝트]
```

### 6-2. 컨텍스트 복원
```
@MAIN_PROMPT.md 읽고 규칙 따라줘.
@.memory/project/40-active.md 현재 상태 확인해.

이어서 작업할게. 현재 상태 요약해줘.
```

---

## 7. 자주 쓰는 명령어

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

## 8. 문제 해결

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

## 9. 체크리스트

### 세션 시작 전
- [ ] Antigravity 폴더 열었는가?
- [ ] 컨텍스트 주입했는가?
- [ ] "준비 완료" 받았는가?

### 버전 시작 전
- [ ] Preflight 검토했는가?
- [ ] Plan 검토했는가?
- [ ] Tasks 검토했는가?

### 버전 완료 후
- [ ] 모든 Gate 통과했는가?
- [ ] Memory Bank 업데이트됐는가?
- [ ] Git tag 찍었는가?
