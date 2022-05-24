import logging

import cv2
from datetime import date, datetime

from backend.face_recognition.recognition import Recognition
from backend.model.attendance import Attendance
from backend.model.attendance_types import CHECK_IN, CHECK_OUT
from backend.model.user import User
from backend.repository.database_repository import DatabaseRepository
from backend.utils.response import *
from backend.validator.user_validator import UserValidator


def save_new_user_image(image_file, user: User):
    first_name = user.name.split(' ')[0]
    last_name = user.name.split(' ')[1]
    file_name = "{}_{}_{}.jpg".format(user.id, first_name, last_name)
    image_path = "database/images/{}".format(file_name)
    logging.info("Saving new user image: {}".format(image_path))
    image_file.save(image_path)
    return image_path


class Service:

    def __init__(self, faceRecognition: Recognition, userRepository: DatabaseRepository, userValidator: UserValidator,
                 attendanceRepository: DatabaseRepository):
        self.faceRecognition = faceRecognition
        self.userRepository = userRepository
        self.userValidator = userValidator
        self.attendanceRepository = attendanceRepository

    def sign_up(self, name, email, password, image_file):
        logging.info("Sign up: {}".format(email))
        user = User(name=name, email=email, password=password, role="USER")
        try:
            self.userValidator.validate(user)
            self.userRepository.add(user)
            if user.id is not None:
                image_path = save_new_user_image(image_file, user)
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
            if user.password == password:
                logging.info("Signed in with success")
                return SignInOkResponse(user)
        logging.info("There is no user with this email/password")
        return SignInFailedResponse()

    def get_all_non_admin_users(self):
        logging.info("Return all users that are non admin")
        users = self.userRepository.get_all()
        non_admin_users = []
        for user in users:
            if user.role == "USER":
                non_admin_users.append(str(user))
        logging.info(non_admin_users)
        return non_admin_users

    def delete_employee(self, id_):
        logging.info("Delete employee with id {}".format(id))
        self.userRepository.delete(id_)
        logging.info("Delete attendances of user with id {}".format(id))
        for attendance in self.get_user_attendance(id_):
            self.attendanceRepository.delete(attendance.id)

    def find_user_by_email(self, email):
        logging.info("Finding user with the email {}".format(email))
        users = self.userRepository.get_all()
        for user in users:
            if user.email == email:
                return user
        return None

    def check_in(self, image_file):
        logging.info("Trying to check in")
        response = self.recognize_face(image_file)
        if response.type == "FOUND_PERSON":
            today = date.today()
            now = datetime.now()
            attendance = Attendance(userId=response.data.id, date=today.strftime("%d/%m/%Y"),
                                    time=now.strftime("%H:%M:%S"), type=CHECK_IN)
            self.attendanceRepository.add(attendance)
        return response

    def check_out(self, image_file):
        logging.info("Trying to check out")
        response = self.recognize_face(image_file)
        if response.type == "FOUND_PERSON":
            today = date.today()
            now = datetime.now()
            attendance = Attendance(userId=response.data.id, date=today.strftime("%d/%m/%Y"),
                                    time=now.strftime("%H:%M:%S"), type=CHECK_OUT)
            self.attendanceRepository.add(attendance)
        return response

    def get_user_attendance(self, user_id):
        logging.info("Getting the attendances of user with id {}".format(user_id))
        attendances = self.attendanceRepository.get_all()
        user_attendances = []
        for attendance in attendances:
            if attendance.userId == user_id:
                user_attendances.append(str(attendance))
        logging.info(user_attendances)
        return user_attendances

    def recognize_face(self, image_file):
        image_file.save("temp.jpg")
        image = cv2.imread("temp.jpg")
        return self.faceRecognition.recognize_face(image)
