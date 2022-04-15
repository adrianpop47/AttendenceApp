import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/controllers/login_controller.dart';
import 'package:frontend/screens/welcome_screen.dart';
import 'package:wakelock/wakelock.dart';

import 'controllers/network_controller.dart';

void main() async {
  NetworkController networkController = NetworkController();
  LoginController loginController = LoginController(networkController);
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  final frontCamera = (await availableCameras()).firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
      (_) => runApp(
          MyApp(frontCamera: frontCamera, loginController: loginController)));
}

class MyApp extends StatelessWidget {
  final CameraDescription frontCamera;
  final LoginController loginController;
  const MyApp(
      {Key? key, required this.frontCamera, required this.loginController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Smart Attendance',
        theme: ThemeData(
          backgroundColor: Colors.black,
          primaryColor: Colors.white,
          primarySwatch: Colors.blue,
        ),
        home: WelcomeScreen(
            frontCamera: frontCamera, loginController: loginController)
        // home: CameraScreen(
        //     frontCamera: frontCamera, networkController: networkController),
        );
  }
}
