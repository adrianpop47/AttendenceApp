import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/response.dart';

import 'attendance_type.dart';

void showMessage(
    BuildContext context,
    FlushbarPosition position,
    String message,
    double fontSize,
    Color backgroundColor,
    Curve forwardAnimationCurve,
    Curve reverseAnimationCurve,
    Duration duration) {
  Flushbar(
          flushbarPosition: position,
          messageText: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: fontSize),
          ),
          backgroundColor: backgroundColor,
          forwardAnimationCurve: forwardAnimationCurve,
          reverseAnimationCurve: reverseAnimationCurve,
          duration: duration)
      .show(context);
}

void showBottomMessage(BuildContext context, String message) {
  showMessage(context, FlushbarPosition.BOTTOM, message, 15, Colors.red,
      Curves.decelerate, Curves.decelerate, const Duration(seconds: 3));
}

void showTopMessage(BuildContext context, String message) {
  showMessage(context, FlushbarPosition.TOP, message, 20, Colors.transparent,
      Curves.decelerate, Curves.bounceIn, const Duration(seconds: 2));
}

void showEmptyEmailPasswordMessage(BuildContext context) {
  showBottomMessage(context, "Please enter your email and password!");
}

void showEmptyImageMessage(BuildContext context) {
  showBottomMessage(context, "Please upload a photo of your face!");
}

void showEmptyFieldMessage(BuildContext context) {
  showBottomMessage(context, "All the fields are required!");
}

void showInvalidNameMessage(context) {
  showBottomMessage(context, "Invalid name!");
}

void showInvalidEmailMessage(context) {
  showBottomMessage(context, "Invalid email address!");
}

void showPasswordsDontMatchMessage(context) {
  showBottomMessage(context, "These passwords don't match!");
}

void showInvalidPasswordLengthMessage(context) {
  showBottomMessage(context, "Password should be at least 8 characters long!");
}

void showInvalidEmailPasswordMessage(context) {
  showBottomMessage(context, "Invalid email or password!");
}

void showSignUpFailedMessage(context) {
  showBottomMessage(context,
      "There was an error while trying to sign you up. Please try again in a few moments!");
}

void showDuplicateSignUpEmail(context) {
  showBottomMessage(
      context, "There is already an user with this email address!");
}

void showAttendanceMessage(BuildContext context, String message, String name) {
  showTopMessage(context, "$message, $name!");
}

void showNoPersonMessage(BuildContext context, String message) {
  showTopMessage(context, message);
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
