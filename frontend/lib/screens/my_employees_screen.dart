import 'package:flutter/material.dart';
import 'package:frontend/controllers/working_time_controller.dart';
import 'package:frontend/domain/user.dart';

import '../controllers/employees_controller.dart';
import '../domain/attendance.dart';
import '../widgets/navigation_bar_widget.dart';
import 'my_working_time_screen.dart';

class MyEmployeesScreen extends StatefulWidget {
  final EmployeesController employeesController;
  final WorkingTimeController workingTimeController;
  const MyEmployeesScreen(
      {Key? key,
      required this.employeesController,
      required this.workingTimeController})
      : super(key: key);

  @override
  State<MyEmployeesScreen> createState() => _MyEmployeesScreenState();
}

class _MyEmployeesScreenState extends State<MyEmployeesScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text("My Employees"),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Column(
        children: [
          const NavigationBarWidget(),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "EMPLOYEES",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          StreamBuilder(
            stream: Stream.periodic(const Duration(seconds: 2))
                .asyncMap((i) => _getEmployeesList()),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center();
              } else {
                return Expanded(
                    child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    User employee = snapshot.data![index];
                    return GestureDetector(
                      onTap: () {
                        _openMyWorkingTimeScreen(context, employee);
                      },
                      child: Card(
                        elevation: 5,
                        child: ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(
                            employee.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(employee.email),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              widget.employeesController
                                  .deleteEmployee(employee.id);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ));
              }
            },
          )
        ],
      ),
    );
  }

  Future<List<User>> _getEmployeesList() {
    return widget.employeesController.getEmployeesList();
  }

  _openMyWorkingTimeScreen(BuildContext context, User user) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => MyWorkingTimeScreen(
                workingTimeController: widget.workingTimeController,
                user: user)));
  }
}
