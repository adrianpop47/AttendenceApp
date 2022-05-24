import 'dart:developer';

import 'package:frontend/controllers/network_controller.dart';
import 'package:frontend/utils/data_decoder.dart';

import '../domain/attendance.dart';
import '../domain/user.dart';

class EmployeesController {
  final NetworkController networkController;

  EmployeesController(this.networkController);

  Future<List<User>> getEmployeesList() async {
    List<dynamic> response = await networkController.getUsers();
    List<User> employeesList = response.map((e) => userFromCSV(e)).toList();
    return employeesList;
  }

  void deleteEmployee(int id) async {
    await networkController.deleteEmployee(id);
  }
}
