import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../controllers/login_controller.dart';
import '../../screens/register_screen.dart';

class NoAccountWidget extends StatelessWidget {
  final CameraDescription frontCamera;
  final LoginController loginController;
  const NoAccountWidget(
      {Key? key, required this.frontCamera, required this.loginController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account ?"),
        TextButton(
            onPressed: () {
              _openRegisterScreen(context);
            },
            child: const Text("Register")),
      ],
    );
  }

  void _openRegisterScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => RegisterScreen(
                frontCamera: frontCamera, loginController: loginController)));
  }
}
