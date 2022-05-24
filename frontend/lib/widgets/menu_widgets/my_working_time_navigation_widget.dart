import 'package:flutter/material.dart';
import 'package:frontend/controllers/working_time_controller.dart';
import 'package:frontend/domain/user.dart';
import 'package:frontend/screens/my_working_time_screen.dart';

class MyWorkingTimeNavigationWidget extends StatelessWidget {
  final WorkingTimeController workingTimeController;
  final User user;
  const MyWorkingTimeNavigationWidget(
      {Key? key, required this.workingTimeController, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              _openMyWorkingTimeScreen(context);
            },
            child: const Icon(
              Icons.watch_later,
              size: 100,
            ),
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15), shape: const CircleBorder()),
          ),
          const Text(
            "My Working Time",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  _openMyWorkingTimeScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => MyWorkingTimeScreen(
                workingTimeController: workingTimeController, user: user)));
  }
}
