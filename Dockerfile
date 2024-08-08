FROM php:8-alpine

ENV PHPCS_VERSION 3.7.2

RUN apk --no-cache add \
        patch \
        ca-certificates \
        curl \
        bash

RUN pear install PHP_CodeSniffer-${PHPCS_VERSION}

COPY .sniffs/wordpress /sniffs/wordpress
COPY .sniffs/utils /sniffs/utils
COPY .sniffs/extra /sniffs/extra

RUN phpcs --config-set show_progress 1 && \
    phpcs --config-set colors 1 && \
    phpcs --config-set report_width 140 && \
    phpcs --config-set encoding utf-8 && \
    phpcs --config-set installed_paths /sniffs/wordpress,/sniffs/utils,/sniffs/extra && \
    phpcs --config-set default_standard WordPress

WORKDIR /tmp

ENTRYPOINT ["phpcs"]
