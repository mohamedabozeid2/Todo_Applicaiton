import 'package:final_todo2/modules/CalendarScreen/Event.dart';
import 'package:final_todo2/modules/CalendarScreen/TaskDataSource.dart';
import 'package:final_todo2/shared/constants/constants.dart';
import 'package:final_todo2/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatefulWidget {
  final ZoomDrawerController drawerController;

  CalendarScreen({
    required this.drawerController,
  });

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar"),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        leading: IconButton(
          onPressed: () {
            widget.drawerController.toggle!.call();
          },
          icon: Icon(
            Icons.menu,
            size: 30,
          ),
        ),
      ),
      body: SfCalendar(
        dataSource: TaskDataSource(tasks),
        onTap: (value) {
          print(value.date);
        },
        view: CalendarView.month,
        initialSelectedDate: DateTime.now(),
      ),
    );
  }
}
