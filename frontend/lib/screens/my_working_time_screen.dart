import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/domain/user.dart';

import '../controllers/working_time_controller.dart';
import '../domain/attendance.dart';
import '../widgets/navigation_bar_widget.dart';

class MyWorkingTimeScreen extends StatefulWidget {
  final WorkingTimeController workingTimeController;
  final User user;
  const MyWorkingTimeScreen(
      {Key? key, required this.workingTimeController, required this.user})
      : super(key: key);

  @override
  State<MyWorkingTimeScreen> createState() => _MyWorkingTimeScreenState();
}

class _MyWorkingTimeScreenState extends State<MyWorkingTimeScreen> {
  final ScrollController _scrollController = ScrollController();
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text("${widget.user.name}'s Working Time"),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Column(
        children: [
          const NavigationBarWidget(),
          CalendarDatePicker(
            onDateChanged: (DateTime value) {
              setState(() {
                selectedDate = value;
              });
            },
            lastDate: DateTime.now(),
            firstDate: DateTime(2013),
            initialDate: DateTime.now(),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "TIME EVENTS",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          StreamBuilder(
            stream: Stream.periodic(const Duration(seconds: 5))
                .asyncMap((i) => _getAttendanceList(selectedDate)),
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
                    Attendance attendance = snapshot.data![index];
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        leading: const Icon(Icons.watch_later_outlined),
                        title: Text(
                          attendance.type,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("${attendance.date} ${attendance.time}"),
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

  Future<List<Attendance>> _getAttendanceList(DateTime selectedDate) {
    return widget.workingTimeController
        .getAttendanceList(widget.user.id, selectedDate);
  }
}
