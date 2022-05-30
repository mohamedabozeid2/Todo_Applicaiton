import 'package:final_todo2/shared/constants/constants.dart';
import 'package:final_todo2/shared/cubit/cubit.dart';
import 'package:final_todo2/shared/cubit/states.dart';
import 'package:final_todo2/styles/icons_broken.dart';
import 'package:final_todo2/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:table_calendar/table_calendar.dart';

class NewTasks extends StatefulWidget {
  @override
  State<NewTasks> createState() => _NewTasksState();
}

class _NewTasksState extends State<NewTasks> {
  DateTime focusedDay = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    color: defaultBlueColor,
                    height: 50,
                    width: double.infinity,
                  ),
                  TableCalendar(
                    firstDay:
                    DateTime.now().subtract(const Duration(days: 365)),
                    lastDay: DateTime.now().add(const Duration(days: 630)),
                    focusedDay: focusedDay,
                    selectedDayPredicate: (day) {
                      return isSameDay(AppCubit
                          .get(context)
                          .selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        AppCubit.get(context).setSelectedDate(selectedDay);
                        // this.selectedDay = selectedDay;
                        this.focusedDay =
                            focusedDay; // update `_focusedDay` here as well
                      });
                    },
                    onPageChanged: (focusedDay) {
                      focusedDay = focusedDay;
                    },
                    calendarFormat: calendarFormat,
                    daysOfWeekHeight: 50,
                    daysOfWeekStyle: const DaysOfWeekStyle(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20)))),
                    headerStyle: const HeaderStyle(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                    calendarStyle: CalendarStyle(
                        weekendTextStyle: const TextStyle(color: Colors.black),
                        holidayTextStyle: const TextStyle(color: Colors.black),
                        selectedTextStyle: TextStyle(
                            color: defaultBlueColor,
                            fontWeight: FontWeight.bold),
                        rowDecoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20.0))),
                        selectedDecoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0)),
                        isTodayHighlighted: false,
                        defaultDecoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0)),
                        holidayDecoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0)),
                        weekendDecoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0))),
                    headerVisible: false,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: selectedTasks.length == 0
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.menu_sharp,
                      size: 40,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "No Tasks",
                      style: TextStyle(color: Colors.grey, fontSize: 25),
                    )
                  ],
                )
                    : ListView.separated(
                    itemBuilder: (context, index) {
                      return buildTaskItem(index);
                    },
                    separatorBuilder: (context, index) => const SizedBox(),
                    itemCount: selectedTasks.length),
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildTaskItem(index) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              AppCubit.get(context)
                  .deleteDatabase(id: selectedTasks[index]['id']);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          if (selectedTasks[index]['status'] == 'done')
            SlidableAction(
              onPressed: (context) {
                AppCubit.get(context)
                    .updateData(status: "new", id: selectedTasks[index]['id']);
              },
              backgroundColor: Colors.grey,
              foregroundColor: Colors.white,
              icon: Icons.redo,
              label: 'Redo',
            ),
        ],
      ),
      endActionPane: ActionPane(
        motion: BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              selectedTasks[index]['status'] != 'archive' ? AppCubit.get(
                  context).updateData(
                  status: "archive", id: selectedTasks[index]['id']) : AppCubit
                  .get(context).updateData(
                  status: 'done', id: selectedTasks[index]['id']);
            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.archive_outlined ,
            label: selectedTasks[index]['status'] != "archive" ? 'Archive' : "Remove Archive",
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          margin: const EdgeInsets.only(left: 15, right: 15),
          padding: const EdgeInsets.all(18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.07,
                width: 3,
                decoration: BoxDecoration(
                    color: selectedTasks[index]['status'] == 'done' ? Color(0xff61e757) : defaultBlueColor,
                    borderRadius: BorderRadius.circular(8)),
              ),
              const SizedBox(
                width: 25,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedTasks[index]['title'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: selectedTasks[index]['status'] == 'done' ? Color(0xff61e757) : defaultBlueColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          IconBroken.Time_Circle,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(selectedTasks[index]['time'],
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          selectedTasks[index]['date'],
                          style: Theme
                              .of(context)
                              .textTheme
                              .caption,
                        )
                      ],
                    )
                  ],
                ),
              ),
              if (selectedTasks[index]['status'] == "archive")
                const Text(
                  'Archived',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                )
              else
                if (selectedTasks[index]['status'] == 'done')
                  const Text("Done!",
                      style: TextStyle(
                          color: Color(0xff61e757),
                          fontWeight: FontWeight.bold))
                else
                  Container(
                    child: IconButton(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      icon: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        AppCubit.get(context).updateData(
                            status: 'done', id: selectedTasks[index]['id']);
                        print(selectedTasks);
                      },
                    ),
                    decoration: BoxDecoration(
                        color: defaultBlueColor,
                        borderRadius: BorderRadius.circular(8)),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
