import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

import '../utils/attendance_type.dart';
import '../utils/response.dart';
import '../utils/show_message.dart';
import 'network_controller.dart';

class CamController {
  final NetworkController _networkController;

  CamController(this._networkController);

  void checkIn(BuildContext context, XFile capturedImage) async {
    Response response = await _networkController.checkIn(capturedImage);
    handleAttendanceMessage(context, CHECK_IN, response);
  }

  void checkOut(BuildContext context, XFile capturedImage) async {
    Response response = await _networkController.checkOut(capturedImage);
    handleAttendanceMessage(context, CHECK_OUT, response);
  }
}
