import 'package:flutter/material.dart';
import 'package:frontend/controllers/employees_controller.dart';
import 'package:frontend/controllers/working_time_controller.dart';

import '../../screens/my_employees_screen.dart';

class MyEmployeesNavigationWidget extends StatelessWidget {
  final EmployeesController employeesController;
  final WorkingTimeController workingTimeController;
  const MyEmployeesNavigationWidget(
      {Key? key,
      required this.employeesController,
      required this.workingTimeController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              _openMyEmployeesScreen(context);
            },
            child: const Icon(
              Icons.people,
              size: 100,
            ),
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15), shape: const CircleBorder()),
          ),
          const Text(
            "My Employees",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  _openMyEmployeesScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => MyEmployeesScreen(
                  employeesController: employeesController,
                  workingTimeController: workingTimeController,
                )));
  }
}
