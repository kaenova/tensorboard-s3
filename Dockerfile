FROM python:3.10-slim

WORKDIR /app

ENV AWS_REGION=default
ENV S3_VERIFY_SSL=0
ENV S3_USE_HTTPS=0
ENV PORT=6006

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY main.py main.py

EXPOSE 6006

CMD ["python", "main.py"]