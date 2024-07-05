# Version of caddy to be used for hosting
ARG CADDY_VERSION=2.7.4

FROM node:lts-bookworm as builder
WORKDIR app
COPY --from=videah/zola-jxl:latest /bin/zola /bin/zola

# Install Tailwind and any dependencies/plugins
COPY package.json .
COPY yarn.lock .
RUN yarn install

# Compile the blog's CSS and static pages
COPY . .
RUN yarn build

FROM alpine:3.16 AS compressor
WORKDIR app
COPY --from=builder /app/public public

RUN apk add --no-cache brotli gzip zstd

# Precompress site content for faster delivery
RUN find ./public -type f -size +1400c \
    -regex ".*\.\(css\|html\|js\|json\|svg\|xml\)$" \
    -exec brotli --best {} \+ \
    -exec gzip --best -k {} \+ \
    -exec zstd --ultra -k {} \+

FROM caddy:${CADDY_VERSION}-alpine AS runtime
WORKDIR app
COPY Caddyfile /etc/caddy/Caddyfile
RUN rm -rf /usr/share/caddy
COPY --from=compressor /app/public /usr/share/caddy