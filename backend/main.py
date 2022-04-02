from backend.controller.network_controller import NetworkController
from backend.face_recognition.recognition import Recognition
from backend.model.user import User
from backend.repository.database_repository import DatabaseRepository
from backend.service.service import Service
from backend.utils.config import *

if __name__ == "__main__":
    faceRecognition = Recognition()
    userRepository = DatabaseRepository(DATABASE_CONNECTION_STRING, User)
    service = Service(faceRecognition, userRepository)
    network_controller = NetworkController(IP, PORT, service)
    network_controller.run()
