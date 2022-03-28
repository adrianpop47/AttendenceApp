from backend.controller.network_controller import NetworkController
from backend.face_recognition.recognition import Recognition
from backend.service.service import Service

if __name__ == "__main__":
    faceRecognition = Recognition()
    service = Service(faceRecognition)
    network_controller = NetworkController("192.168.0.102", 4000, service)
    network_controller.run()
