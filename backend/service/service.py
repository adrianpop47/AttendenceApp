import cv2


class Service:

    def __init__(self, faceRecognition):
        self.faceRecognition = faceRecognition

    def check_in(self, image_file):
        response = self.recognize_face(image_file)
        #create new check-in event
        #add check-in
        return response

    def check_out(self, image_file):
        response = self.recognize_face(image_file)
        #create new check-out event
        #add check-out
        return response

    def recognize_face(self, image_file):
        image_file.save("temp.jpg")
        image = cv2.imread("temp.jpg")
        return self.faceRecognition.recognize_face(image)
