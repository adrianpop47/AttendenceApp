import cv2
import os
import numpy as np
from PIL import Image

from FaceRecognition.model.person import Person


def assure_path_exists(path):
    dir = os.path.dirname(path)
    if not os.path.exists(dir):
        os.makedirs(dir)

recognizer = cv2.face.LBPHFaceRecognizer_create()
detector = cv2.CascadeClassifier("haarcascade_frontalface_default.xml")

def getImagesAndLabels(path):
    persons = []
    ids = []
    faceSamples = []

    for person in os.listdir(path):
        personId = person.split('_')[0]
        firstName = person.split('_')[1]
        lastName = person.split('_')[2]
        personFolder = person
        persons.append(Person(personId, firstName, lastName, personFolder))

    for person in persons:
        imageFolder = path+person.folder
        for image in os.listdir(imageFolder):
            imagePath = imageFolder + '/' + image
            PIL_img = Image.open(imagePath).convert('L')
            PIL_img.show()



getImagesAndLabels('../database/')
