ARG BUILDPLATFORM=linux/amd64

FROM --platform=$BUILDPLATFORM golang:1.26 AS builder
ARG TARGETARCH=amd64
ARG TARGETOS=linux
WORKDIR /src
COPY go.mod go.sum ./
RUN apt add --no-cache go
RUN go mod download
COPY . .
ARG SKAFFOLD_GO_GCFLAGS

RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH}  CGO_ENABLED=0 go build -ldflags="-s -w" -gcflags="${SKAFFOLD_GO_GCFLAGS}" -o /checkoutservice .
FROM gcr.io/distroless/static
WORKDIR /src
COPY --from=builder /checkoutservice  /src/checkoutservice
EXPOSE 5050
ENTRYPOINT ["/src/checkoutservice"]