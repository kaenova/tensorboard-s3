FROM python:3.8.16-slim-buster

WORKDIR /app

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY main.py main.py

ENV AWS_REGION=default
ENV S3_VERIFY_SSL=0
ENV S3_USE_HTTPS=0
ENV PORT=6006

EXPOSE 6006
ENV PYTHONUNBUFFERED=1

CMD ["python", "main.py"]