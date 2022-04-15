from flask import Flask, request, jsonify

from backend.model.user import User
from backend.repository.database_repository import DatabaseRepository
from backend.service.service import Service
from backend.utils.config import DATABASE_CONNECTION_STRING


class NetworkController:

    def __init__(self, ip, port, service: Service):
        self.ip = ip
        self.port = port
        self.service = service
        self.app = Flask(__name__)

    def run(self):
        @self.app.route('/sign-up', methods=['POST'])
        def sign_up():
            if request.method == "POST":
                name = request.form['name']
                email = request.form['email']
                password = request.form['password']
                image_file = request.files['image']
                print(name, email, password)
                response = self.service.sign_up(name, email, password, image_file)
                return jsonify({
                    "type": response.type,
                    "data": None
                })

        @self.app.route('/sign-in', methods=['POST'])
        def sign_in():
            if request.method == "POST":
                email = request.form['email']
                password = request.form['password']
                response = self.service.sign_in(email, password)
                return jsonify({
                    "type": response.type,
                    "data": str(response.data)
                })

        @self.app.route('/check-in', methods=['POST'])
        def check_in():
            if request.method == "POST":
                image_file = request.files['image']
                response = self.service.check_in(image_file)
                return jsonify({
                    "type": response.type,
                    "data": str(response.data)
                })

        @self.app.route('/check-out', methods=['POST'])
        def check_out():
            if request.method == "POST":
                imageFile = request.files['image']
                response = self.service.check_out(imageFile)
                return jsonify({
                    "type": response.type,
                    "data": str(response.data)
                })

        @self.app.route('/test', methods=['GET'])
        def test():
            if request.method == "GET":
                self.service.sign_up("Test Test", "test@gmail.com", "aaaassdf1", "admin", "temp.jpg")

        self.app.run(debug=True, host=self.ip, port=self.port)
