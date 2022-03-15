from flask import Flask, request, jsonify

app = Flask(__name__)


@app.route('/upload', methods=['POST'])
def upload():
    if request.method == "POST":
        imageFile = request.files['image']
        imageFile.save("temp.jpg")
        return jsonify({
            "message": "Image Uploaded Successfully"
        })


if __name__ == "__main__":
    app.run(debug=True, host="192.168.0.104", port=4000)
