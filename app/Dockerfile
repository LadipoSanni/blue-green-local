FROM python:3.10-slim
WORKDIR /app
COPY main.py .
RUN pip install flask
ENV APP_VERSION=blue
CMD ["python", "main.py"]
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl --fail http://localhost:5000/health || exit 1
