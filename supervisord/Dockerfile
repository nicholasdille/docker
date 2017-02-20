FROM ubuntu:xenial
MAINTAINER nicholas.dille@mailbox.org

ARG BUILD_VENDOR
ARG BUILD_NAME
ARG BUILD_VERSION
ARG BUILD_DATE
ARG REPOSITORY_URL
ARG REPOSITORY_REF

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.name="${BUILD_NAME}" \
      org.label-schema.vendor="${BUILD_VENDOR}" \
      org.label-schema.version="${BUILD_VERSION}" \
      org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.vcs-ref="${REPOSITORY_REF}" \
      org.label-schema.vcs-url="${REPOSITORY_URL}"

RUN apt-get update \
 && apt-get -y install apt-utils \
 && apt-get -y install ca-certificates wget curl supervisor sudo

ADD etc /etc/

ENTRYPOINT [ "supervisord" ]
CMD [ "-c", "/etc/supervisord.conf" ]
