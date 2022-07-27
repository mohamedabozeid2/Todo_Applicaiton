import 'package:final_todo2/Notifications/LocalNotifications.dart';
import 'package:final_todo2/modules/layout/NavigationDrawer.dart';
import 'package:final_todo2/shared/components/components.dart';
import 'package:final_todo2/shared/constants/constants.dart';
import 'package:final_todo2/shared/cubit/cubit.dart';
import 'package:final_todo2/shared/cubit/states.dart';
import 'package:final_todo2/styles/icons_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class MainScreen extends StatefulWidget {
  final ZoomDrawerController drawerController;

  MainScreen(this.drawerController);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();

  var timeController = TextEditingController();

  var dateController = TextEditingController();

  late final LocalNotificationService service;

  @override
  void initState() {
    service = LocalNotificationService();
    service.intialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      AppCubit()
        ..createDatabase()
        ..setSelectedDate(DateTime.now()),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is TodoInsertIntoDatabase) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            // drawer: NavigationDrawer(context),
            key: scaffoldKey,
            appBar: AppBar(
              actions: [
                TextButton(onPressed: (){
                  print(taskDate);
                }, child: Text("TEST", style: TextStyle(color: Colors.white),)),
                DateFormat.yMd().format(AppCubit
                    .get(context)
                    .selectedDay) !=
                    DateFormat.yMd().format(DateTime.now())
                    ? TextButton(
                    onPressed: () {
                      AppCubit.get(context).goToToday();
                    },
                    child: const Text(
                      "TODAY",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))
                    : Container()
              ],
              leading: IconButton(
                icon: const Icon(
                  Icons.menu,
                  size: 30,
                ),
                onPressed: () {
                  widget.drawerController.toggle?.call();
                },
              ),
              toolbarHeight: MediaQuery
                  .of(context)
                  .size
                  .height * 0.1,
              title: const Text(
                "ToDo",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            body: state is TodoAppLoadingState
                ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ))
                : AppCubit
                .get(context)
                .screens[AppCubit
                .get(context)
                .currentIndex],
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (AppCubit
                    .get(context)
                    .isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    AppCubit.get(context)
                        .insertToDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text,
                    ).then((value) async {

                      await service.showScheduledNotification(
                          id: 1,
                          title: 'Task',
                          body: 'You have a task now',
                          date: taskDate!,
                          minutes: taskMinutes!,
                        hours: taskHours!,
                      ).then((value){
                        print("DONE");
                      });

                      titleController.text = "";
                      timeController.text = "";
                      dateController.text = "";
                      print(selectedTasks);

                      // Navigator.pop(context);

                      setState(() {
                        AppCubit.get(context).getDatabase(database!);
                        AppCubit.get(context).changeBotSheet(
                            isShow: false, icon: IconBroken.Edit_Square);
                      });
                    });
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                          (context) =>
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(20.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  textFormField(
                                    controller: titleController,
                                    label: "Task Title",
                                    validation: "Enter your title please",
                                    type: TextInputType.text,
                                    prefixIcon: Icons.title_sharp,
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  textFormField(
                                      controller: timeController,
                                      label: "Task Time",
                                      validation: "Enter your time please",
                                      type: TextInputType.none,
                                      prefixIcon:
                                      Icons.watch_later_outlined,
                                      onTap: () {
                                        showTimePicker(
                                            context: context,
                                            initialTime:
                                            TimeOfDay.now())
                                            .then((value) {

                                              taskHours = value!.hour;
                                              taskMinutes = value.minute;
                                          timeController.text = value
                                              .format(context)
                                              .toString();
                                        });
                                      }),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  textFormField(
                                    controller: dateController,
                                    label: "Date Title",
                                    onTap: () {
                                      showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.parse(
                                              '2024-05-03'))
                                          .then((value) {
                                            taskDate = value!;
                                        dateController.text =
                                            DateFormat.yMd().format(value);
                                      });
                                    },
                                    validation: "Enter your date please",
                                    type: TextInputType.none,
                                    prefixIcon: IconBroken.Calendar,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      elevation: 20.0)
                      .closed
                      .then((value) {
                    AppCubit.get(context).changeBotSheet(
                        isShow: false, icon: IconBroken.Edit_Square);
                  }).catchError((error) {
                    print("Error in botsheet ====> ${error.toString()}");
                  });
                  AppCubit.get(context).changeBotSheet(
                      isShow: true, icon: IconBroken.Paper_Download);
                }

                // AppCubit.get(context).bottomSheet(context: context, key: scaffoldKey, formKey: formKey);
              },
              child: Icon(
                AppCubit
                    .get(context)
                    .fabIcon,
                color: Colors.white,
              ),
              shape: const StadiumBorder(
                  side: BorderSide(color: Colors.white, width: 4)),
            ),
            bottomNavigationBar: BottomAppBar(
              clipBehavior: Clip.antiAlias,
              shape: const CircularNotchedRectangle(),
              notchMargin: 7.0,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  AppCubit.get(context).changeBottomNavigationBar(index);
                },
                currentIndex: AppCubit
                    .get(context)
                    .currentIndex,
                elevation: 0.0,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(IconBroken.Paper), label: "Tasks"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.done_outline), label: "Done"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
