import 'dart:developer';

import '../domain/attendance.dart';
import '../domain/user.dart';

User userFromCSV(String data) {
  int id = int.parse(data.split(', ')[0]);
  String name = data.split(', ')[1];
  String email = data.split(', ')[2];
  String password = data.split(', ')[3];
  String role = data.split(', ')[4];
  return User(id, name, email, password, role);
}

Attendance attendanceFromCSV(String data) {
  int id = int.parse(data.split(', ')[0]);
  int userId = int.parse(data.split(', ')[1]);
  String date = data.split(', ')[2];
  String time = data.split(', ')[3];
  String type = data.split(', ')[4];
  return Attendance(id, userId, date, time, type);
}
