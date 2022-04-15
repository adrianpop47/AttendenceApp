import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../screens/register_photo_screen.dart';

class TakeFacePhotoWidget extends StatefulWidget {
  final CameraDescription frontCamera;
  final Function callback;
  const TakeFacePhotoWidget(
      {Key? key, required this.frontCamera, required this.callback})
      : super(key: key);

  @override
  State<TakeFacePhotoWidget> createState() => _TakeFacePhotoWidgetState();
}

class _TakeFacePhotoWidgetState extends State<TakeFacePhotoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 23),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              _openRegisterPhotoScreen(context);
            },
            child: const Icon(Icons.camera_alt),
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(), padding: const EdgeInsets.all(10)),
          ),
          const Text("Face Photo"),
        ],
      ),
    );
  }

  void _openRegisterPhotoScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => RegisterPhotoScreen(
                frontCamera: widget.frontCamera, callback: widget.callback)));
  }
}
