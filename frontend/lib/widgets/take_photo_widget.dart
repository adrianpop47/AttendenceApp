import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/network_controller.dart';
import 'package:frontend/utils/attendance_type.dart';

import '../utils/response.dart';
import '../utils/show_message.dart';

class TakePhotoWidget extends StatefulWidget {
  final CameraController cameraController;
  final Future<void> initializeControllerFuture;
  final NetworkController networkController;
  const TakePhotoWidget(
      {Key? key,
      required this.cameraController,
      required this.initializeControllerFuture,
      required this.networkController})
      : super(key: key);

  @override
  State<TakePhotoWidget> createState() => _TakePhotoWidgetState();
}

class _TakePhotoWidgetState extends State<TakePhotoWidget> {
  String _attendanceType = CHECK_IN;
  late XFile capturedImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            _attendanceType,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              //Check In Button
              Align(
                alignment: const Alignment(-0.5, 0),
                child: ElevatedButton(
                  onPressed: () {
                    _changeActionText(CHECK_IN);
                  },
                  child: const Icon(
                    Icons.input,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(25),
                      primary: Colors.transparent,
                      onPrimary: Colors.black),
                ),
              ),

              //Take Photo Button
              Align(
                alignment: Alignment.center,
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

              //Check Out Button
              Align(
                alignment: const Alignment(0.5, 0),
                child: ElevatedButton(
                  onPressed: () {
                    _changeActionText(CHECK_OUT);
                  },
                  child: const Icon(
                    Icons.output,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(25),
                      primary: Colors.transparent,
                      onPrimary: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _changeActionText(String text) {
    setState(() {
      _attendanceType = text;
    });
  }

  void _takePhoto() async {
    await widget.initializeControllerFuture;
    var image = await widget.cameraController.takePicture();
    setState(() {
      capturedImage = image;
    });
    _attendanceType == CHECK_IN ? _checkIn() : _checkOut();
  }

  void _checkIn() async {
    Response response = await widget.networkController.checkIn(capturedImage);
    handleAttendanceMessage(context, CHECK_IN, response);
  }

  void _checkOut() async {
    Response response = await widget.networkController.checkOut(capturedImage);
    handleAttendanceMessage(context, CHECK_OUT, response);
  }
}
