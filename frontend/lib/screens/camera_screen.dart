import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/network_controller.dart';
import 'package:frontend/widgets/camera_preview_widget.dart';
import 'package:frontend/widgets/take_photo_widget.dart';

class CameraScreen extends StatefulWidget {
  final CameraDescription frontCamera;
  final NetworkController networkController;
  const CameraScreen(
      {Key? key, required this.frontCamera, required this.networkController})
      : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  late XFile capturedImage;

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
      body: Column(
        children: [
          CameraPreviewWidget(
              cameraController: _cameraController,
              initializeControllerFuture: _initializeControllerFuture),
          TakePhotoWidget(
              cameraController: _cameraController,
              initializeControllerFuture: _initializeControllerFuture,
              networkController: widget.networkController)
        ],
      ),
    );
  }
}
