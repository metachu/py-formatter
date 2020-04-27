ARG PYTHON_VERSION=3.8

FROM python:${PYTHON_VERSION}-alpine
LABEL maintainer="william@metachu.com"

ARG POETRY_VERSION=1.0.5

RUN apk add --no-cache \
        gcc \
        libressl-dev \
        musl-dev \
        libffi-dev && \
    pip install --no-cache-dir poetry==${POETRY_VERSION} 

RUN mkdir /code
WORKDIR /code

ADD pyproject.toml /code
RUN poetry install --no-interaction --no-ansi -vvv && \
    apk del \
        gcc \
        libressl-dev \
        musl-dev \
        libffi-dev

ADD entrypoint.sh /code

ENTRYPOINT ["./entrypoint.sh"]

