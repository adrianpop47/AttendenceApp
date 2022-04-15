import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend/controllers/login_controller.dart';
import 'package:frontend/utils/show_message.dart';

class LoginButtonWidget extends StatelessWidget {
  final BuildContext context;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final LoginController loginController;
  const LoginButtonWidget(
      {Key? key,
      required this.context,
      required this.emailController,
      required this.passwordController,
      required this.loginController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _login();
        },
        child: const Padding(
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 50, right: 50),
          child: Text("Login"),
        ),
      ),
    );
  }

  void _login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showEmptyEmailPasswordMessage(context);
    } else {
      loginController.login(
          context, emailController.text, passwordController.text);
    }
  }
}
