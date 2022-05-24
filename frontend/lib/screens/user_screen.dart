import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/camera_controller.dart';
import 'package:frontend/widgets/menu_widgets/my_employees_navigation_widget.dart';
import 'package:frontend/widgets/menu_widgets/my_working_time_navigation_widget.dart';
import 'package:frontend/widgets/navigation_bar_widget.dart';

import '../controllers/working_time_controller.dart';
import '../domain/user.dart';
import '../widgets/menu_widgets/camera_navigation_widget.dart';

class UserScreen extends StatefulWidget {
  final WorkingTimeController workingTimeController;
  final User user;
  const UserScreen(
      {Key? key, required this.workingTimeController, required this.user})
      : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(widget.user.name),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Column(
        children: [
          const NavigationBarWidget(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
