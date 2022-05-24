import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/controllers/camera_controller.dart';
import 'package:frontend/controllers/employees_controller.dart';
import 'package:frontend/controllers/login_controller.dart';
import 'package:frontend/controllers/working_time_controller.dart';
import 'package:frontend/screens/welcome_screen.dart';
import 'package:wakelock/wakelock.dart';
import 'package:dcdg/dcdg.dart';

import 'controllers/network_controller.dart';

void main() async {
  NetworkController networkController = NetworkController();
  LoginController loginController = LoginController(networkController);
  CamController camController = CamController(networkController);
  WorkingTimeController workingTimeController =
      WorkingTimeController(networkController);
  EmployeesController employeesController =
      EmployeesController(networkController);
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  final frontCamera = (await availableCameras()).firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(MyApp(
            frontCamera: frontCamera,
            loginController: loginController,
            camController: camController,
            workingTimeController: workingTimeController,
            employeesController: employeesController,
          )));
}

class MyApp extends StatelessWidget {
  final CameraDescription frontCamera;
  final LoginController loginController;
  final CamController camController;
  final WorkingTimeController workingTimeController;
  final EmployeesController employeesController;
  const MyApp(
      {Key? key,
      required this.frontCamera,
      required this.loginController,
      required this.camController,
      required this.workingTimeController,
      required this.employeesController})
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
          frontCamera: frontCamera,
          loginController: loginController,
          camController: camController,
          workingTimeController: workingTimeController,
          employeesController: employeesController,
        )
        // home: CameraScreen(
        //     frontCamera: frontCamera, networkController: networkController),
        );
  }
}
