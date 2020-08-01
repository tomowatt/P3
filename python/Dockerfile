FROM python:3.8-alpine

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

WORKDIR /app/src
COPY src .

CMD gunicorn app:api -b 0.0.0.0:80
