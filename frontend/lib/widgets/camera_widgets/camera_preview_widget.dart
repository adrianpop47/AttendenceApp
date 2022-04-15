import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPreviewWidget extends StatelessWidget {
  final CameraController cameraController;
  final Future<void> initializeControllerFuture;
  const CameraPreviewWidget(
      {Key? key,
      required this.cameraController,
      required this.initializeControllerFuture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: CameraPreview(cameraController),
    );
  }
}
