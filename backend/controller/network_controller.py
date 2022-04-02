from flask import Flask, request, jsonify

from backend.model.user import User
from backend.repository.database_repository import DatabaseRepository
from backend.utils.config import DATABASE_CONNECTION_STRING


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

        @self.app.route('/test', methods=['GET'])
        def test():
            if request.method == "GET":
                userRepository = DatabaseRepository(DATABASE_CONNECTION_STRING, User)
                user = User()
                user.name = "n"
                user.password = "pass"
                user.email = "mail1222"
                user.role = "role1113344"
                userRepository.delete(1)
                print(userRepository.get_all())

        self.app.run(debug=True, host=self.ip, port=self.port)
