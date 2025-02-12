from flask import Flask, render_template
from flask_cors import CORS

app = Flask(__name__)

@app.route("/")
def home():
    return render_template("index.html")

if __name__ == "__main__":
    app.run(debug=True, port=5001, host='0.0.0.0')
