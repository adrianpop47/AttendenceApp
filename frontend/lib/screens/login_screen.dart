import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/camera_controller.dart';
import 'package:frontend/controllers/employees_controller.dart';
import 'package:frontend/controllers/working_time_controller.dart';
import 'package:frontend/widgets/login_widgets/login_button_widget.dart';
import 'package:frontend/widgets/login_widgets/login_text_input_widget.dart';
import 'package:frontend/widgets/login_widgets/no_account_widget.dart';
import 'package:move_to_background/move_to_background.dart';

import '../controllers/login_controller.dart';

class LoginScreen extends StatefulWidget {
  final CameraDescription frontCamera;
  final LoginController loginController;
  final CamController camController;
  final WorkingTimeController workingTimeController;
  final EmployeesController employeesController;
  const LoginScreen(
      {Key? key,
      required this.frontCamera,
      required this.loginController,
      required this.camController,
      required this.workingTimeController,
      required this.employeesController})
      : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.43,
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(100))),
              child: Stack(children: [
                Center(
                  child: Image.asset("assets/logo.png"),
                ),
                const Positioned(
                    bottom: 20,
                    right: 20,
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ))
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              height: MediaQuery.of(context).size.height * 0.55,
              child: Column(
                children: [
                  LoginTextInputWidget(
                      controller: _emailController,
                      hint: "Email Address",
                      obscureText: false,
                      margin: 10),
                  LoginTextInputWidget(
                      controller: _passwordController,
                      hint: "Password",
                      obscureText: true,
                      margin: 23),
                  const Spacer(),
                  LoginButtonWidget(
                    context: context,
                    frontCamera: widget.frontCamera,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    loginController: widget.loginController,
                    camController: widget.camController,
                    workingTimeController: widget.workingTimeController,
                    employeesController: widget.employeesController,
                  ),
                  NoAccountWidget(
                      frontCamera: widget.frontCamera,
                      loginController: widget.loginController),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
