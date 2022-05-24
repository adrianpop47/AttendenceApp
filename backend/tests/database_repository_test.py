import unittest
import random

from backend.model.user import User
from backend.repository.database_repository import DatabaseRepository
from backend.utils.config import DATABASE_CONNECTION_STRING


class TestDatabaseRepository(unittest.TestCase):
    userRepository = DatabaseRepository(DATABASE_CONNECTION_STRING, User)

    def find_unused_id(self):
        user_id = random.randint(1000, 99999)
        while True:
            if self.userRepository.get(id) is None:
                return user_id
            user_id = random.randint(1000, 99999)

    def testAdd(self):
        user_id = self.find_unused_id()
        user = User(id=user_id, name="name", email="email", password="password", role="USER")
        self.userRepository.add(user)
        self.assertEqual(self.userRepository.get(user_id).name, "name")
        self.assertEqual(self.userRepository.get(user_id).email, "email")
        self.assertEqual(self.userRepository.get(user_id).password, "password")
        self.assertEqual(self.userRepository.get(user_id).role, "USER")
        self.userRepository.delete(user_id)

    def testGetAll(self):
        old_size = len(self.userRepository.get_all())
        user_id = self.find_unused_id()
        user = User(id=user_id, name="name", email="email", password="password", role="USER")
        self.userRepository.add(user)
        self.assertEqual(len(self.userRepository.get_all()), old_size + 1)
        self.userRepository.delete(user_id)

    def testDelete(self):
        user_id = self.find_unused_id()
        user = User(id=user_id, name="name", email="email", password="password", role="USER")
        self.userRepository.add(user)
        old_size = len(self.userRepository.get_all())
        self.userRepository.delete(user_id)
        self.assertEqual(len(self.userRepository.get_all()), old_size - 1)


if __name__ == '__main__':
    unittest.main()
