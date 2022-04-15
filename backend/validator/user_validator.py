import logging

from backend.model.user import User
from backend.model.user_roles import *
from backend.validator.abstract_validator import AbstractValidator
import re


class UserValidator(AbstractValidator):

    def validate(self, entity: User):
        logging.info("Validating user")
        errors = ""
        email_regex = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'
        if not entity.name:
            errors += "Name should not be empty!\n"
        if not entity.email:
            errors += "Email should not be empty!\n"
        if not re.fullmatch(email_regex, entity.email):
            errors += "Invalid email!\n"
        if str(entity.role).upper() not in USER_ROLES:
            errors += "Role should be {} or {}".format(USER, ADMIN)
        if len(errors) != 0:
            raise ValueError(errors)


