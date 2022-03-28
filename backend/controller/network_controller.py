from flask import Flask, request, jsonify


class NetworkController:

    def __init__(self, ip, port, service):
        self.ip = ip
        self.port = port
        self.service = service
        self.app = Flask(__name__)

    def run(self):
        @self.app.route('/check-in', methods=['POST'])
        def check_in():
            if request.method == "POST":
                imageFile = request.files['image']
                response = self.service.check_in(imageFile)
                print(response)
                return jsonify({
                    "type": response.type,
                    "data": str(response.data)
                })

        @self.app.route('/check-out', methods=['POST'])
        def check_out():
            if request.method == "POST":
                imageFile = request.files['image']
                response = self.service.check_out(imageFile)
                print(response)
                return jsonify({
                    "type": response.type,
                    "data": str(response.data)
                })

        self.app.run(debug=True, host=self.ip, port=self.port)

