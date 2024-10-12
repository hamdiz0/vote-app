FROM python:3.12-slim AS base

WORKDIR /vote

COPY requirements.txt ./

RUN pip install -r requirements.txt

COPY . .

CMD ["gunicorn", "app:app", "-b", "0.0.0.0:80"]
