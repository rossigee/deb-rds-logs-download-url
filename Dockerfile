FROM ubuntu:focal

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
  apt-get install make

COPY . /wd/build
RUN chown -R nobody /wd
WORKDIR /wd/build

RUN make prebuild

USER nobody

RUN make build

RUN ls -l /wd

