import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../controllers/login_controller.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  final CameraDescription frontCamera;
  final LoginController loginController;
  const WelcomeScreen(
      {Key? key, required this.frontCamera, required this.loginController})
      : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 4000), () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen(
                  frontCamera: widget.frontCamera,
                  loginController: widget.loginController)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset("assets/logo.png"),
        const LinearProgressIndicator(),
      ]),
    );
  }
}
