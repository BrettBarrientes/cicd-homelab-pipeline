from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def hello_cloud():
    return render_template('/app/templates/index.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
