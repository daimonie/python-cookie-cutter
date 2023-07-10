FROM python:3.11-slim

RUN apt-get update
RUN apt install pre-commit -y
RUN pip install poetry
RUN poetry --version

COPY container/ /opt/container
WORKDIR /opt/container
RUN mkdir /opt/config

RUN poetry install

ENTRYPOINT [ "/bin/bash", "-l", "-c" ]
