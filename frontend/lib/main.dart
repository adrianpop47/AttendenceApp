import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/controllers/camera_controller.dart';
import 'package:frontend/controllers/employees_controller.dart';
import 'package:frontend/controllers/login_controller.dart';
import 'package:frontend/controllers/working_time_controller.dart';
import 'package:frontend/screens/set_ip_screen.dart';
import 'package:frontend/screens/welcome_screen.dart';
import 'package:wakelock/wakelock.dart';
import 'package:dcdg/dcdg.dart';

import 'controllers/network_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  final frontCamera = (await availableCameras()).firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(MyApp(
            frontCamera: frontCamera,
          )));
}

class MyApp extends StatelessWidget {
  final CameraDescription frontCamera;
  const MyApp(
      {Key? key,
      required this.frontCamera})
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
        home: SetIpScreen(
          frontCamera: frontCamera
        )
        // home: CameraScreen(
        //     frontCamera: frontCamera, networkController: networkController),
        );
  }
}
