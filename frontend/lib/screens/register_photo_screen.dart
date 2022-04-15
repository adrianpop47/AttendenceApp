import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/login_controller.dart';
import 'package:frontend/controllers/network_controller.dart';
import 'package:frontend/widgets/camera_widgets/camera_preview_widget.dart';
import 'package:frontend/widgets/camera_widgets/take_photo_widget.dart';

import '../controllers/camera_controller.dart';
import '../widgets/login_widgets/take_register_photo_widget.dart';

class RegisterPhotoScreen extends StatefulWidget {
  final CameraDescription frontCamera;
  final Function callback;
  const RegisterPhotoScreen(
      {Key? key, required this.frontCamera, required this.callback})
      : super(key: key);

  @override
  State<RegisterPhotoScreen> createState() => _RegisterPhotoScreenState();
}

class _RegisterPhotoScreenState extends State<RegisterPhotoScreen> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;

  initializeCamera() async {
    _cameraController = CameraController(
      widget.frontCamera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  void initState() {
    initializeCamera();
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  CameraPreviewWidget(
                      cameraController: _cameraController,
                      initializeControllerFuture: _initializeControllerFuture),
                  TakeRegisterPhotoWidget(
                      cameraController: _cameraController,
                      initializeControllerFuture: _initializeControllerFuture,
                      callback: widget.callback)
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
