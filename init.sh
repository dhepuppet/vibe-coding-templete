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

echo ""
echo "✅ 완료! 입력 2개로 끝"
echo ""
echo "🎯 다음: Antigravity에서 'Memory Bank 읽고 Preflight 작성해줘'"
