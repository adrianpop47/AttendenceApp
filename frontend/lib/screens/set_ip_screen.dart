import 'package:camera/camera.dart';
import "package:flutter/material.dart";
import 'package:frontend/screens/welcome_screen.dart';

import '../controllers/camera_controller.dart';
import '../controllers/employees_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/network_controller.dart';
import '../controllers/working_time_controller.dart';
import '../utils/config.dart';

class SetIpScreen extends StatefulWidget {
  final CameraDescription frontCamera;
  const SetIpScreen({Key? key, required this.frontCamera}) : super(key: key);

  @override
  State<SetIpScreen> createState() => _SetIpScreenState();
}

class _SetIpScreenState extends State<SetIpScreen> {
  final _ipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Set IP Address"),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          TextField(
            controller: _ipController,
            decoration: InputDecoration(
              hintText: "IP Address",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _start();
            },
            child: const Padding(
              padding:
                  EdgeInsets.only(top: 15, bottom: 15, left: 50, right: 50),
              child: Text("Start Application"),
            ),
          )
        ],
      ),
    );
  }

  void _start() {
    String host = _ipController.text;
    NetworkController networkController = NetworkController(host);
    LoginController loginController = LoginController(networkController);
    CamController camController = CamController(networkController);
    WorkingTimeController workingTimeController =
        WorkingTimeController(networkController);
    EmployeesController employeesController =
        EmployeesController(networkController);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => WelcomeScreen(
                frontCamera: widget.frontCamera,
                loginController: loginController,
                camController: camController,
                workingTimeController: workingTimeController,
                employeesController: employeesController)));
  }
}
