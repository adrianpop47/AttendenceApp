import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakeRegisterPhotoWidget extends StatefulWidget {
  final CameraController cameraController;
  final Future<void> initializeControllerFuture;
  final Function callback;
  const TakeRegisterPhotoWidget(
      {Key? key,
      required this.cameraController,
      required this.initializeControllerFuture,
      required this.callback})
      : super(key: key);

  @override
  State<TakeRegisterPhotoWidget> createState() =>
      _TakeRegisterPhotoWidgetState();
}

class _TakeRegisterPhotoWidgetState extends State<TakeRegisterPhotoWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(25),
          child: ElevatedButton(
            onPressed: () {
              _takePhoto();
            },
            child: const Icon(
              Icons.camera_alt_outlined,
              size: 25,
            ),
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(25),
                primary: Colors.white,
                onPrimary: Colors.black),
          ),
        ),
      ],
    );
  }

  void _takePhoto() async {
    await widget.initializeControllerFuture;
    var image = await widget.cameraController.takePicture();
    widget.callback(image);
    _closeScreen();
  }

  void _closeScreen() {
    Timer(const Duration(milliseconds: 1000), () {
      Navigator.pop(context);
    });
  }
}
