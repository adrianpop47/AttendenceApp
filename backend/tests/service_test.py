import datetime
import unittest
import random

from backend.face_recognition.recognition import Recognition, SignInOkResponse, SignInFailedResponse
from backend.model.attendance import Attendance
from backend.model.user import User
from backend.repository.database_repository import DatabaseRepository
from backend.service.service import Service
from backend.utils.config import DATABASE_CONNECTION_STRING
from backend.validator.user_validator import UserValidator


class TestService(unittest.TestCase):
    recognition = Recognition()
    userRepository = DatabaseRepository(DATABASE_CONNECTION_STRING, User)
    userValidator = UserValidator()
    attendanceRepository = DatabaseRepository(DATABASE_CONNECTION_STRING, Attendance)
    service = Service(recognition, userRepository, userValidator, attendanceRepository)

    def find_unused_id(self):
        user_id = random.randint(1000, 99999)
        while True:
            if self.userRepository.get(id) is None:
                return user_id
            user_id = random.randint(1000, 99999)

    def testSignIn(self):
        user_id = self.find_unused_id()
        user = User(id=user_id, name="name", email="email", password="password", role="USER")
        self.userRepository.add(user)
        response = self.service.sign_in("email", "password")
        self.assertTrue(isinstance(response, SignInOkResponse))
        self.userRepository.delete(user_id)
        self.userRepository.add(user)
        response = self.service.sign_in("wrong_email", "wrong_password")
        self.assertTrue(isinstance(response, SignInFailedResponse))
        self.userRepository.delete(user_id)

    def testDeleteEmployee(self):
        user_id = self.find_unused_id()
        user = User(id=user_id, name="name", email="email", password="password", role="USER")
        old_size = len(self.userRepository.get_all())
        self.userRepository.add(user)
        self.service.delete_employee(user_id)
        self.assertEqual(old_size, len(self.userRepository.get_all()))

    def testFindUserByEmail(self):
        user_id = self.find_unused_id()
        user = User(id=user_id, name="name", email="email", password="password", role="USER")
        self.userRepository.add(user)
        self.assertEqual(self.service.find_user_by_email("email").id, user_id)
        self.userRepository.delete(user_id)


if __name__ == '__main__':
    unittest.main()
