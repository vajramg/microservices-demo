ARG BUILDPLATFORM = linux/amd64
FROM --platform=${BUILDPLATFORM } node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build
FROM --platform=${BUILDPLATFORM } node:20-alpine
COPY --from=builder




