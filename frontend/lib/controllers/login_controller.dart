import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/controllers/network_controller.dart';
import 'package:frontend/utils/config.dart';
import 'package:frontend/validator/user_validator.dart';

import '../utils/response.dart';
import '../utils/show_message.dart';

class LoginController {
  final NetworkController _networkController;
  final UserValidator _userValidator = UserValidator();
  LoginController(this._networkController);

  Future<void> login(
      BuildContext context, String email, String password) async {
    String passwordHash = _cryptPassword(password);
    Response response = await _networkController.login(email, passwordHash);
    _handleLoginResponse(context, response);
    log(response.toString());
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

  void _handleLoginResponse(BuildContext context, Response response) {
    if (response.type == SIGN_IN_FAILED) {
      showInvalidEmailPasswordMessage(context);
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
