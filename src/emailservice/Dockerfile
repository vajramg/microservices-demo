ARG BUILDPLATFORM=linux/amd64
FROM --platform=${BUILDPLATFORM} python:3.13-alpine AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY .  .
EXPOSE 8080
CMD ["python", "server.py"]