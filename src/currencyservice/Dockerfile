ARG BUILDPLATFORM=linux/amd64
FROM --platform=${BUILDPLATFORM} node:20-alpine AS builder
RUN apk add --update --no-cache \
  python3 \
  make \
  g++

WORKDIR usr/src/app
COPY package*.json ./
RUN apk update && npm ci --only=production
COPY . .
RUN npm install --only=production
FROM --platform=${BUILDPLATFORM} node:20-alpine
RUN apk add --no-cache nodejs
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY . .
EXPOSE 7000
ENTRYPOINT [ "node" , " server.js" ]






