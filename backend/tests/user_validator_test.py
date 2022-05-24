import unittest

from backend.model.user import User
from backend.validator.user_validator import UserValidator


class TestUserValidator(unittest.TestCase):
    userValidator = UserValidator()

    def testNameValidation(self):
        user = User(id=1, name="", email="email@mail.com", password="password", role="USER")
        self.assertRaises(ValueError, self.userValidator.validate, user)
        user = User(id=1, name="name", email="email@mail.com", password="password", role="USER")
        try:
            self.userValidator.validate(user)
        except ValueError:
            self.fail("Encountered an unexpected exception.")

    def testEmailValidation(self):
        user = User(id=1, name="name", email="", password="password", role="USER")
        self.assertRaises(ValueError, self.userValidator.validate, user)
        user = User(id=1, name="name", email="email", password="password", role="USER")
        self.assertRaises(ValueError, self.userValidator.validate, user)
        user = User(id=1, name="name", email="email@mail.com", password="password", role="USER")
        try:
            self.userValidator.validate(user)
        except ValueError:
            self.fail("Encountered an unexpected exception.")

    def testRoleValidation(self):
        user = User(id=1, name="name", email="email@mail.com", password="password", role="role")
        self.assertRaises(ValueError, self.userValidator.validate, user)
        user = User(id=1, name="name", email="email@mail.com", password="password", role="USER")
        try:
            self.userValidator.validate(user)
        except ValueError:
            self.fail("Encountered an unexpected exception.")
        user = User(id=1, name="name", email="email@mail.com", password="password", role="ADMIN")
        try:
            self.userValidator.validate(user)
        except ValueError:
            self.fail("Encountered an unexpected exception.")

if __name__ == '__main__':
    unittest.main()
