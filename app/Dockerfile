FROM python:3.10-slim
WORKDIR /app
COPY main.py .
RUN pip install flask
ENV APP_VERSION=blue
CMD ["python", "main.py"]
