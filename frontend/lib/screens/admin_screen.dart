import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/camera_controller.dart';
import 'package:frontend/controllers/working_time_controller.dart';
import 'package:frontend/widgets/menu_widgets/my_employees_navigation_widget.dart';
import 'package:frontend/widgets/menu_widgets/my_working_time_navigation_widget.dart';
import 'package:frontend/widgets/navigation_bar_widget.dart';

import '../controllers/employees_controller.dart';
import '../domain/user.dart';
import '../widgets/menu_widgets/camera_navigation_widget.dart';

class AdminScreen extends StatefulWidget {
  final CameraDescription frontCamera;
  final CamController camController;
  final WorkingTimeController workingTimeController;
  final EmployeesController employeesController;
  final User user;
  const AdminScreen(
      {Key? key,
      required this.frontCamera,
      required this.camController,
      required this.workingTimeController,
      required this.employeesController,
      required this.user})
      : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text("Admin"),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Column(
        children: [
          const NavigationBarWidget(),
          Center(
            child: Column(
              children: [
                CameraNavigationWidget(
                    frontCamera: widget.frontCamera,
                    camController: widget.camController),
                MyEmployeesNavigationWidget(
                  employeesController: widget.employeesController,
                  workingTimeController: widget.workingTimeController,
                ),
                MyWorkingTimeNavigationWidget(
                    workingTimeController: widget.workingTimeController,
                    user: widget.user),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
