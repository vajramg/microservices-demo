ARG BUILDPLATFORM=linux/arm64
FROM --platform=${BUILDPLATFORM} python:3.14-alpine
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8080
ENTRYPOINT ["python", "email_server.py"]