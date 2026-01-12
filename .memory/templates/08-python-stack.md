# Python 스택 가이드

## 🐍 권장 구조

```
project/
├── AGENTS.md
├── MAIN_PROMPT.md
├── README.md
├── requirements.txt      # 또는 pyproject.toml
├── .env.example          # 환경변수 예시
├── .gitignore
├── main.py               # 진입점
├── src/
│   ├── __init__.py
│   ├── api/              # API 라우트 (FastAPI)
│   ├── services/         # 비즈니스 로직
│   ├── models/           # 데이터 모델
│   └── utils/            # 유틸리티
├── tests/
│   ├── __init__.py
│   └── test_*.py
├── venv/                 # 가상환경 (gitignore)
└── .memory/
```

---

## 📦 패키지 매니저

### pip + venv (기본)
```bash
# 가상환경 생성
python -m venv venv

# 활성화
source venv/bin/activate      # Mac/Linux
venv\Scripts\activate         # Windows

# 의존성 설치
pip install -r requirements.txt

# 의존성 추가 후 저장
pip install [패키지명]
pip freeze > requirements.txt
```

### poetry (권장 - 복잡한 프로젝트)
```bash
# 설치
pip install poetry

# 프로젝트 초기화
poetry init

# 의존성 추가
poetry add [패키지명]
poetry add --dev pytest ruff

# 실행
poetry run python main.py
```

---

## 🚀 주요 프레임워크

### FastAPI (API 서버)
```bash
pip install fastapi uvicorn[standard]
```

```python
# main.py
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "안녕!"}

# 실행: uvicorn main:app --reload
```

### Streamlit (웹 대시보드)
```bash
pip install streamlit
```

```python
# app.py
import streamlit as st

st.title("내 앱")
st.write("안녕, 랩하이!")

# 실행: streamlit run app.py
```

### Flask (간단한 웹서버)
```bash
pip install flask
```

```python
# main.py
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return "안녕!"

# 실행: flask run
```

---

## 🧪 테스트

### pytest
```bash
pip install pytest pytest-cov
```

```python
# tests/test_main.py
def test_example():
    assert 1 + 1 == 2

# 실행: pytest
# 커버리지: pytest --cov=src
```

---

## 🔍 린트 & 포매터

### ruff (빠름, 권장)
```bash
pip install ruff
```

```bash
# 린트 체크
ruff check .

# 자동 수정
ruff check . --fix

# 포맷
ruff format .
```

### 대안: flake8 + black
```bash
pip install flake8 black
flake8 .
black .
```

---

## 🔐 환경변수

### python-dotenv
```bash
pip install python-dotenv
```

```python
# .env
API_KEY=your-secret-key

# main.py
from dotenv import load_dotenv
import os

load_dotenv()
api_key = os.getenv("API_KEY")
```

### .env.example (커밋용)
```
# .env.example
API_KEY=your-api-key-here
DATABASE_URL=postgresql://localhost/db
```

---

## 📝 requirements.txt 예시

```
# 웹 프레임워크 (하나 선택)
fastapi
uvicorn[standard]
# streamlit
# flask

# 유틸리티
requests
python-dotenv

# 데이터
# pandas
# sqlalchemy

# AI/ML
# openai
# langchain

# 개발 도구
pytest
ruff
```

---

## ⚠️ .gitignore 필수 항목

```
# 가상환경
venv/
.venv/

# 캐시
__pycache__/
*.pyc
.pytest_cache/
.ruff_cache/

# 환경변수
.env

# IDE
.vscode/
.idea/

# 빌드
dist/
build/
*.egg-info/
```

---

## 🎯 바이브코딩 팁

### 1. 가상환경 항상 활성화 확인
```bash
# 프롬프트에 (venv) 있는지 확인
(venv) $ python main.py  ✅
$ python main.py          ❌
```

### 2. 의존성 추가 후 바로 기록
```bash
pip install [새패키지]
pip freeze > requirements.txt
git add requirements.txt
git commit -m "deps: [새패키지] 추가"
```

### 3. 에러 시 가상환경 재생성
```bash
rm -rf venv
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

---

<!-- 한국어 주석 포함 완료 -->