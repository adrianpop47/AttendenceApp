import 'dart:developer';

import 'package:frontend/controllers/network_controller.dart';
import 'package:frontend/utils/data_decoder.dart';

import '../domain/attendance.dart';

class WorkingTimeController {
  final NetworkController networkController;

  WorkingTimeController(this.networkController);

  Future<List<Attendance>> getAttendanceList(int userId, DateTime date) async {
    List<dynamic> response = await networkController.getAttendance(userId);
    List<Attendance> attendanceList = response
        .map((e) => attendanceFromCSV(e))
        .where((element) => selectedDate(element, date))
        .toList();
    return attendanceList;
  }

  bool selectedDate(Attendance attendance, DateTime date) {
    String attendanceDate = attendance.date;
    if (int.parse(attendanceDate.split('/')[0]) == date.day &&
        int.parse(attendanceDate.split('/')[1]) == date.month &&
        int.parse(attendanceDate.split('/')[2]) == date.year) {
      return true;
    }
    return false;
  }
}
