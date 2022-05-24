import 'dart:developer';

import 'package:camera/camera.dart';
import "package:flutter/material.dart";
import 'package:frontend/widgets/login_widgets/take_face_photo_widget.dart';
import 'package:frontend/widgets/navigation_bar_widget.dart';

import '../controllers/login_controller.dart';
import '../utils/show_message.dart';
import '../widgets/login_widgets/already_have_account_widget.dart';
import '../widgets/login_widgets/login_text_input_widget.dart';

class RegisterScreen extends StatefulWidget {
  final CameraDescription frontCamera;
  final LoginController loginController;
  const RegisterScreen(
      {Key? key, required this.frontCamera, required this.loginController})
      : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  late XFile _capturedImage;
  bool _imageLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          const NavigationBarWidget(),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
            height: MediaQuery.of(context).size.height * 0.85,
            child: Column(
              children: [
                LoginTextInputWidget(
                    controller: _nameController,
                    hint: "Full Name",
                    obscureText: false,
                    margin: 10),
                LoginTextInputWidget(
                    controller: _emailController,
                    hint: "Email Address",
                    obscureText: false,
                    margin: 23),
                LoginTextInputWidget(
                    controller: _passwordController,
                    hint: "Password",
                    obscureText: true,
                    margin: 23),
                LoginTextInputWidget(
                    controller: _confirmPasswordController,
                    hint: "Confirm Password",
                    obscureText: true,
                    margin: 23),
                TakeFacePhotoWidget(
                    frontCamera: widget.frontCamera,
                    callback: setCapturedImage),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    _register();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(
                        top: 15, bottom: 15, left: 50, right: 50),
                    child: Text("Register"),
                  ),
                ),
                const AlreadyHaveAccountWidget(),
              ],
            ),
          )
        ],
      ),
    );
  }

  void setCapturedImage(XFile image) {
    setState(() {
      _capturedImage = image;
      _imageLoaded = true;
    });
  }

  void _register() async {
    if (_imageLoaded == true) {
      widget.loginController.register(
          context,
          _nameController.text,
          _emailController.text,
          _passwordController.text,
          _confirmPasswordController.text,
          _capturedImage);
    } else {
      showEmptyImageMessage(context);
    }
  }
}
