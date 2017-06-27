FROM python:2.7-alpine
MAINTAINER Tom Schultz <tomschul@amazon.com>

COPY app /app/app
WORKDIR /app

RUN pip install gunicorn && pip install falcon && pip install boto3

EXPOSE 8080

CMD ["gunicorn", "-b :8080", "app.app:API"]
