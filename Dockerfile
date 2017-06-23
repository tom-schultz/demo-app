FROM python:2.7-alpine
MAINTAINER Tom Schultz <tomschul@amazon.com>

COPY buggworks /app/buggworks
WORKDIR /app

RUN pip install gunicorn && pip install falcon

EXPOSE 8080

CMD ["gunicorn", "-b :8080", "buggworks.app:API"]
