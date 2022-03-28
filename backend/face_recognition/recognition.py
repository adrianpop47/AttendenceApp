import face_recognition
import cv2
import os
import numpy as np

from backend.model.person import Person
from backend.utils.response import *


class Recognition:

    def __init__(self):
        self.persons = []
        self.encodings = []
        self.images_path = 'database/images/'
        #self.write_data()
        self.load_data()

    def write_data(self):
        f = open("face_recognition/face_encodings.txt", "w")
        for image_path in os.listdir(self.images_path):
            image = cv2.imread(self.images_path + image_path)
            rgb_image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
            person_id = image_path.split('_')[0]
            person_name = image_path.split('_')[1] + ' ' + image_path.split('_')[2].split('.')[0]
            image_encoding = face_recognition.face_encodings(rgb_image)[0]
            f.write('{}, {}, {}; '.format(person_id, person_name, image_encoding))
        f.close()

    def load_data(self):
        f = open("face_recognition/face_encodings.txt", "r")
        lines = f.read().strip().split(';')
        lines.pop()
        for line in lines:
            fields = line.split(',')
            id = fields[0].strip()
            name = fields[1].strip()
            encoding = [float(i) for i in fields[2].strip()[1:-1].split()]
            self.persons.append(Person(id, name))
            self.encodings.append(encoding)
        f.close()

    def recognize_face(self, image):
        rgb_image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
        face_location = face_recognition.face_locations(rgb_image)
        if len(face_location) == 0:
            return NoFaceDetectedResponse()
        face_encoding = face_recognition.face_encodings(rgb_image, face_location)[0]
        matches = face_recognition.compare_faces(self.encodings, face_encoding)

        face_distances = face_recognition.face_distance(self.encodings, face_encoding)
        best_match_index = np.argmin(face_distances)
        if matches[best_match_index]:
            return FoundPersonResponse(self.persons[best_match_index])
        return UnknownPersonResponse()



