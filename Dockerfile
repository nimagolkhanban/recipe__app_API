FROM python:3.9-alpine3.13
LABEL maintainer="nima_golkhanban"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./requirements.txt /tmp/requirements.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN pip install --upgrade pip && \
    pip install -r /tmp/requirements.txt && \
    if [ "$DEV" = "true" ]; then \
        pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp

RUN adduser --disabled-password --no-create-home django-user

USER django-user

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

