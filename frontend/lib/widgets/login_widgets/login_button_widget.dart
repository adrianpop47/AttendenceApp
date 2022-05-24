import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/camera_controller.dart';
import 'package:frontend/controllers/login_controller.dart';
import 'package:frontend/controllers/working_time_controller.dart';
import 'package:frontend/utils/show_message.dart';

import '../../controllers/employees_controller.dart';

class LoginButtonWidget extends StatefulWidget {
  final BuildContext context;
  final CameraDescription frontCamera;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final LoginController loginController;
  final CamController camController;
  final WorkingTimeController workingTimeController;
  final EmployeesController employeesController;
  const LoginButtonWidget(
      {Key? key,
      required this.context,
      required this.frontCamera,
      required this.emailController,
      required this.passwordController,
      required this.loginController,
      required this.camController,
      required this.workingTimeController,
      required this.employeesController})
      : super(key: key);

  @override
  State<LoginButtonWidget> createState() => _LoginButtonWidgetState();
}

class _LoginButtonWidgetState extends State<LoginButtonWidget> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  _login();
                },
                child: const Padding(
                  padding:
                      EdgeInsets.only(top: 15, bottom: 15, left: 50, right: 50),
                  child: Text("Login"),
                ),
              ));
  }

  void _changeLoadingState() {
    setState(() {
      _isLoading == true ? _isLoading = false : _isLoading = true;
    });
  }

  void _login() async {
    if (widget.emailController.text.isEmpty ||
        widget.passwordController.text.isEmpty) {
      showEmptyEmailPasswordMessage(widget.context);
    } else {
      _changeLoadingState();
      widget.loginController.login(
          widget.context,
          widget.frontCamera,
          widget.camController,
          widget.workingTimeController,
          widget.employeesController,
          widget.emailController.text,
          widget.passwordController.text,
          _changeLoadingState);
    }
  }
}
