import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/camera_controller.dart';
import 'package:frontend/controllers/employees_controller.dart';
import 'package:frontend/controllers/network_controller.dart';
import 'package:frontend/controllers/working_time_controller.dart';
import 'package:frontend/domain/user.dart';
import 'package:frontend/utils/config.dart';
import 'package:frontend/validator/user_validator.dart';

import '../screens/admin_screen.dart';
import '../screens/user_screen.dart';
import '../utils/data_decoder.dart';
import '../utils/response.dart';
import '../utils/show_message.dart';
import '../utils/user_roles.dart';

class LoginController {
  final NetworkController _networkController;
  final UserValidator _userValidator = UserValidator();
  LoginController(this._networkController);

  void login(
      BuildContext context,
      CameraDescription frontCamera,
      CamController camController,
      WorkingTimeController workingTimeController,
      EmployeesController employeesController,
      String email,
      String password,
      Function callback) async {
    String passwordHash = _cryptPassword(password);
    Response response = await _networkController.login(email, passwordHash);
    callback();
    _handleLoginResponse(context, frontCamera, camController,
        workingTimeController, employeesController, response);
  }

  void register(BuildContext context, String name, String email,
      String password, String confirmPassword, XFile image) async {
    if (_userValidator.validate(
            context, name, email, password, confirmPassword, image) ==
        true) {
      String passwordHash = _cryptPassword(password);
      Response response =
          await _networkController.register(name, email, passwordHash, image);
      _handleRegisterResponse(context, response);
    }
  }

  String _cryptPassword(String password) {
    return Crypt.sha256(password,
            rounds: passwordHashRounds, salt: passwordHashSalt)
        .hash
        .toString();
  }

  void _handleLoginResponse(
      BuildContext context,
      CameraDescription frontCamera,
      CamController camController,
      WorkingTimeController workingTimeController,
      EmployeesController employeesController,
      Response response) {
    if (response.type == SIGN_IN_FAILED) {
      showInvalidEmailPasswordMessage(context);
    }
    if (response.type == SIGN_IN_OK) {
      User user = userFromCSV(response.data!);
      if (user.role == ADMIN) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => AdminScreen(
                    frontCamera: frontCamera,
                    camController: camController,
                    workingTimeController: workingTimeController,
                    employeesController: employeesController,
                    user: user)));
      }
      if (user.role == USER) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => UserScreen(
                      user: user,
                      workingTimeController: workingTimeController,
                    )));
      }
    }
  }

  void _handleRegisterResponse(BuildContext context, Response response) {
    if (response.type == SIGN_UP_OK) {
      Navigator.pop(context);
    }
    if (response.type == DUPLICATE_SIGN_UP_EMAIL) {
      showDuplicateSignUpEmail(context);
    }
    if (response.type == SIGN_UP_FAILED) {
      showSignUpFailedMessage(context);
    }
  }
}
