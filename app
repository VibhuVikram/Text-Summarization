from flask import Flask, render_template, request, jsonify
import requests

app = Flask(__name__)

COLAB_BACKEND_URL = 'https://esteban-nonalkaloidal-novella.ngrok-free.dev'

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/summarize', methods=['POST'])
def summarize():
    data = request.form['text']

    response = requests.post(COLAB_BACKEND_URL, json={'text': data})

    if response.status_code == 200:
        summary = response.json().get('summary')
        return jsonify({'summary': summary})
    else:
        return jsonify({'error': 'Failed to summarize text'}), 500

if __name__ == '__main__':
    app.run(port=8000, debug=True)
