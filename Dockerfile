# Version of caddy to be used for hosting
ARG CADDY_VERSION=2.6.1

FROM node:lts-alpine3.16 as builder
WORKDIR app
RUN apk add --no-cache --virtual .build-deps alpine-sdk python3 zola

COPY . .

# Installs Tailwind and any dependencies/plugins and compiles the blog's CSS
RUN yarn install
RUN yarn build

FROM alpine:3.16 AS compressor
WORKDIR app
COPY --from=builder /app/public public

RUN apk add --no-cache brotli gzip

# Precompress site content for faster delivery
RUN find ./public -type f -size +1400c \
    -regex ".*\.\(css\|html\|js\|json\|svg\|xml\)$" \
    -exec brotli --best {} \+ \
    -exec gzip --best -k {} \+

FROM videah/oxipng:latest AS optimizer
WORKDIR /app
COPY --from=compressor /app/public public

# Remove unnecessary screenshot
RUN rm public/images/screenshot.png

# find all PNGs and optimize them
RUN find ./public -type f -name "*.png" -exec oxipng --opt 3 --interlace 0 --strip safe {} \+

FROM caddy:${CADDY_VERSION}-builder AS embedder
RUN git clone https://github.com/mholt/caddy-embed.git && cd caddy-embed && git checkout 6bbec9d
WORKDIR caddy-embed
COPY --from=optimizer /app/public files

# Build a custom caddy binary with the site's files embedded.
# This is so we can serve the site straight from memory.
RUN xcaddy build \
    --with github.com/mholt/caddy-embed=.

FROM caddy:${CADDY_VERSION}-alpine AS runtime
WORKDIR app
COPY Caddyfile /etc/caddy/Caddyfile
COPY --from=embedder /usr/bin/caddy-embed/caddy /usr/bin/caddy