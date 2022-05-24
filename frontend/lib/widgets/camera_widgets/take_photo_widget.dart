import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/attendance_type.dart';

import '../../controllers/camera_controller.dart';

class TakePhotoWidget extends StatefulWidget {
  final CameraController cameraController;
  final Future<void> initializeControllerFuture;
  final CamController camController;
  const TakePhotoWidget(
      {Key? key,
      required this.cameraController,
      required this.initializeControllerFuture,
      required this.camController})
      : super(key: key);

  @override
  State<TakePhotoWidget> createState() => _TakePhotoWidgetState();
}

class _TakePhotoWidgetState extends State<TakePhotoWidget> {
  String _attendanceType = CHECK_IN;
  late XFile _capturedImage;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Padding(
            padding: EdgeInsets.all(10.0),
            child: CircularProgressIndicator(),
          )
        : Column(
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
                          setAttendanceType(CHECK_IN);
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
                          setAttendanceType(CHECK_OUT);
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

  void setAttendanceType(String text) {
    setState(() {
      _attendanceType = text;
    });
  }

  void setCapturedImage(XFile image) {
    setState(() {
      _capturedImage = image;
    });
  }

  void _changeLoadingState() {
    setState(() {
      _isLoading == true ? _isLoading = false : _isLoading = true;
    });
  }

  void _takePhoto() async {
    _changeLoadingState();
    await widget.initializeControllerFuture;
    var image = await widget.cameraController.takePicture();
    setCapturedImage(image);
    _attendanceType == CHECK_IN
        ? widget.camController
            .checkIn(context, _capturedImage, _changeLoadingState)
        : widget.camController
            .checkOut(context, _capturedImage, _changeLoadingState);
  }
}
