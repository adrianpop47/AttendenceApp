import 'package:camera/camera.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../utils/show_message.dart';

class UserValidator {
  bool validate(BuildContext context, String name, String email,
      String password, String confirmPassword, XFile image) {
    if (validateName(context, name) == false) {
      return false;
    }
    if (validateEmail(context, email) == false) {
      return false;
    }
    if (validatePassword(context, password, confirmPassword) == false) {
      return false;
    }
    return true;
  }

  validateName(BuildContext context, String name) {
    String pattern = r'(^[A-Za-z]+\s[A-Za-z]+$)';
    RegExp regExp = RegExp(pattern);
    if (name.isEmpty) {
      showEmptyFieldMessage(context);
      return false;
    }
    if (!regExp.hasMatch(name)) {
      showInvalidNameMessage(context);
      return false;
    }
    return true;
  }

  validateEmail(BuildContext context, String email) {
    if (email.isEmpty) {
      showEmptyFieldMessage(context);
      return false;
    }
    if (EmailValidator.validate(email) == false) {
      showInvalidEmailMessage(context);
      return false;
    }
    return true;
  }

  validatePassword(
      BuildContext context, String password, String confirmPassword) {
    if (password.isEmpty || confirmPassword.isEmpty) {
      showEmptyFieldMessage(context);
      return false;
    }
    if (password.length < 8) {
      showInvalidPasswordLengthMessage(context);
      return false;
    }
    if (password != confirmPassword) {
      showPasswordsDontMatchMessage(context);
      return false;
    }
    return true;
  }
}
