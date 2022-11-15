# Version of caddy to be used for hosting
ARG CADDY_VERSION=2.6.1

FROM node:lts-alpine3.16 as constructer
WORKDIR app
COPY . .

RUN apk add --no-cache --virtual .build-deps alpine-sdk python3

RUN yarn install
RUN yarn construct

FROM ghcr.io/getzola/zola:v0.16.1 AS builder
WORKDIR app
COPY --from=constructer /app .

# The Zola docker image is distroless which means it doesn't have a shell
# This isn't helpful so we just grab a statically linked 'sh' from busybox
COPY --from=busybox:1.35.0-uclibc /bin/sh /bin/sh

# Build the site with Zola
RUN /bin/zola build

FROM tdewolff/minify:latest AS minifier
WORKDIR app
COPY --from=builder /app/public public

# Minify the sites content
RUN minify -r -a -s -o minified public

FROM caddy:${CADDY_VERSION}-builder AS embedder
RUN git clone https://github.com/mholt/caddy-embed.git && cd caddy-embed && git checkout 6bbec9d
WORKDIR caddy-embed
COPY --from=minifier /app/minified files
COPY 404.html files

# Build a custom caddy binary with the site's files embedded.
# This is so we can serve the site straight from memory.
RUN xcaddy build \
    --with github.com/mholt/caddy-embed=. \
    --with github.com/caddyserver/cache-handler


FROM caddy:${CADDY_VERSION}-alpine AS runtime
WORKDIR app
COPY Caddyfile /etc/caddy/Caddyfile
COPY --from=embedder /usr/bin/caddy-embed/caddy /usr/bin/caddy