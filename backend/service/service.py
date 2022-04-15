import logging

import cv2

from backend.face_recognition.recognition import Recognition
from backend.model.user import User
from backend.repository.database_repository import DatabaseRepository
from backend.utils.response import *
from backend.validator.user_validator import UserValidator


class Service:

    def __init__(self, faceRecognition: Recognition, userRepository: DatabaseRepository, userValidator: UserValidator):
        self.faceRecognition = faceRecognition
        self.userRepository = userRepository
        self.userValidator = userValidator

    def sign_up(self, name, email, password, image_file):
        logging.info("Sign up: {}".format(email))
        user = User(name=name, email=email, password=password, role="USER")
        try:
            self.userValidator.validate(user)
            self.userRepository.add(user)
            if user.id is not None:
                image_path = self.save_new_user_image(image_file, user)
                self.faceRecognition.write_face_encoding(image_path)
            else:
                return DuplicateSignUpEmailResponse()
        except ValueError as e:
            logging.error(e)
        else:
            logging.info("Signed up with success")
            return SignUpOkResponse()
        return SignUpFailedResponse()

    def sign_in(self, email, password):
        logging.info("Sign in: {}".format(email))
        user = self.find_user_by_email(email)
        if user is not None:
            print(user)
            print(password)
            if user.password == password:
                logging.info("Signed in with success")
                return SignInOkResponse(user.role)
        logging.info("There is no user with this email/password")
        return SignInFailedResponse()

    def find_user_by_email(self, email):
        users = self.userRepository.get_all()
        for user in users:
            if user.email == email:
                return user
        return None

    def check_in(self, image_file):
        logging.info("Trying to check in")
        response = self.recognize_face(image_file)
        # create new check-in event
        # add check-in
        return response

    def check_out(self, image_file):
        logging.info("Trying to check out")
        response = self.recognize_face(image_file)
        # create new check-out event
        # add check-out
        return response

    def recognize_face(self, image_file):
        image_file.save("temp.jpg")
        image = cv2.imread("temp.jpg")
        return self.faceRecognition.recognize_face(image)

    def save_new_user_image(self, image_file, user: User):
        first_name = user.name.split(' ')[0]
        last_name = user.name.split(' ')[1]
        file_name = "{}_{}_{}.jpg".format(user.id, first_name, last_name)
        image_path = "database/images/{}".format(file_name)
        logging.info("Saving new user image: {}".format(image_path))
        image_file.save(image_path)
        return image_path

