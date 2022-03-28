import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/response.dart';

import 'attendance_type.dart';

void showAttendanceMessage(BuildContext context, String message, String name) {
  Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          messageText: Text(
            "$message, $name!",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          backgroundColor: Colors.transparent,
          forwardAnimationCurve: Curves.decelerate,
          reverseAnimationCurve: Curves.bounceIn,
          duration: const Duration(seconds: 2))
      .show(context);
}

void showNoPersonMessage(BuildContext context, String message) {
  Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          messageText: Text(
            "$message!",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          backgroundColor: Colors.transparent,
          forwardAnimationCurve: Curves.decelerate,
          reverseAnimationCurve: Curves.bounceIn,
          duration: const Duration(seconds: 2))
      .show(context);
}

void handleAttendanceMessage(
    BuildContext context, String attendanceType, Response response) {
  if (response.type == FOUND_PERSON) {
    if (attendanceType == CHECK_IN) {
      showAttendanceMessage(context, "Welcome", response.data!.split(',').last);
    }
    if (attendanceType == CHECK_OUT) {
      showAttendanceMessage(
          context, " Have a nice day", response.data!.split(',').last);
    }
  }
  if (response.type == UNKNOWN_PERSON) {
    showNoPersonMessage(context, "Unknown person!");
  }
  if (response.type == NO_FACE_DETECTED) {
    showNoPersonMessage(context, "We could not detect any face!");
  }
}
