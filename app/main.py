from flask import Flask
import os

app = Flask(__name__)

@app.route("/")
def home():
    return f"This is version: {os.getenv('APP_VERSION', 'unknown')}"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
