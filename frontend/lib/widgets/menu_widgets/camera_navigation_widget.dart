import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/camera_controller.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../screens/camera_screen.dart';

class CameraNavigationWidget extends StatelessWidget {
  final CameraDescription frontCamera;
  final CamController camController;
  const CameraNavigationWidget(
      {Key? key, required this.frontCamera, required this.camController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              _openCameraScreen(context);
            },
            child: const Icon(
              Icons.camera_alt,
              size: 100,
            ),
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15), shape: const CircleBorder()),
          ),
          const Text(
            "Check In",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  _openCameraScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => CameraScreen(
                frontCamera: frontCamera, camController: camController)));
  }
}
