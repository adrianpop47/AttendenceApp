from backend.controller.network_controller import NetworkController
from backend.face_recognition.recognition import Recognition
from backend.model.attendance import Attendance
from backend.model.user import User
from backend.repository.database_repository import DatabaseRepository
from backend.service.service import Service
from backend.utils.config import *
from backend.validator.user_validator import UserValidator

if __name__ == "__main__":
    faceRecognition = Recognition()
    userRepository = DatabaseRepository(DATABASE_CONNECTION_STRING, User)
    userValidator = UserValidator()
    attendanceRepository = DatabaseRepository(DATABASE_CONNECTION_STRING, Attendance)
    service = Service(faceRecognition, userRepository, userValidator, attendanceRepository)
    network_controller = NetworkController(IP, PORT, service)
    network_controller.run()
