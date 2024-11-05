FROM dockage/alpine:3.18.6

ENV MAILCATCHER_VERSION=0.9.0

RUN apk --no-cache add \
        build-base \
        ruby \
        ruby-dev \
        ruby-json \
        ruby-etc \
        sqlite-dev \
        gcompat && \
    # Conditional installation for ARM architecture
    ([ "$(uname -m)" != "aarch64" ] || gem install sqlite3 -v "~> 1.3" --no-document --platform ruby) && \
    gem install mailcatcher:${MAILCATCHER_VERSION} --no-document && \
    # Clean up build dependencies to reduce image size
    apk del build-base

EXPOSE 1025 1080

CMD ["mailcatcher", "-f", "--ip", "0.0.0.0"]
