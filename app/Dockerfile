# ---- Build Stage ----
FROM python:3.10-slim AS builder
WORKDIR /build
COPY requirements.txt .
RUN pip install --user -r requirements.txt

# ---- Runtime Stage ----
FROM python:3.10-slim
WORKDIR /app

RUN groupadd -r appuser && useradd -r -g appuser appuser
COPY --from=builder /root/.local /home/appuser/.local
COPY app.py .

ENV PATH=/home/appuser/.local/bin:$PATH
USER appuser

EXPOSE 5000
CMD ["python", "app.py"]
