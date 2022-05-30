import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_todo2/modules/ArchivedTasks/ArchivedTasks.dart';
import 'package:final_todo2/modules/CalendarScreen/CalendarScreen.dart';
import 'package:final_todo2/modules/DoneTasks/DoneTasks.dart';
import 'package:final_todo2/modules/NewTasks/NewTasks.dart';
import 'package:final_todo2/modules/SettingsScreen/SettingsScreen.dart';
import 'package:final_todo2/modules/all%20Tasks%20Screen/AllTasksScreen.dart';
import 'package:final_todo2/modules/layout/MainScreen.dart';
import 'package:final_todo2/modules/layout/MenuScreen.dart';
import 'package:final_todo2/modules/layout/NavigationDrawer.dart';
import 'package:final_todo2/shared/components/components.dart';
import 'package:final_todo2/shared/constants/constants.dart';
import 'package:final_todo2/styles/icons_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:intl/intl.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class TodoLayout extends StatefulWidget {
  @override
  State<TodoLayout> createState() => _TodoLayoutState();
}

class _TodoLayoutState extends State<TodoLayout> {
  final drawerController = ZoomDrawerController();
  MenuItemDetails currentItem = MenuItem.home;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ZoomDrawer(
            style: DrawerStyle.defaultStyle,
            menuScreen: Builder(
              builder: (context)=> MenuScreen(
                currentItem: currentItem,
                onSelectedItem: (item){
                  setState(() {
                    currentItem = item;
                    ZoomDrawer.of(context)!.close();
                  });
                },
              ),
            ),
            mainScreen: getScreen(),
            controller: drawerController,

            borderRadius: 24.0,
            showShadow: true,
            angle: 0.0,
            drawerShadowsBackgroundColor: Colors.grey,
            slideWidth: MediaQuery.of(context).size.width * 0.55,
            openCurve: Curves.fastOutSlowIn,
            menuBackgroundColor: Color(0xff274472)/*0xff5860db*/,
          );
        },

      ),
    );
  }

  Widget getScreen(){
    if(currentItem == MenuItem.home)
      return MainScreen(drawerController);
    else if(currentItem == MenuItem.archive)
      return ArchivedTasksScreen(drawerController: drawerController,);
    else if(currentItem == MenuItem.allTasks)
      return AllTasksScreen(drawerController: drawerController,);
    else if(currentItem == MenuItem.calendar)
      return CalendarScreen(drawerController: drawerController,);
    else
      return SettingsScreen();
  }
}

/*BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase()..setSelectedDate(DateTime.now()),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if(state is TodoInsertIntoDatabase){
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            drawer: NavigationDrawer(context),
            key: scaffoldKey,
            appBar: AppBar(
              toolbarHeight: MediaQuery.of(context).size.height * 0.1,
              title: const Text(
                "To Do",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            body: state is TodoAppLoadingState ? const Center(child: CircularProgressIndicator(color: Colors.white,)) : AppCubit.get(context)
                .screens[AppCubit.get(context).currentIndex],
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (AppCubit.get(context).isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    AppCubit.get(context).insertToDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text,
                    ).then((value){
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
                          (context) => Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(20.0),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      textFormField(
                                        controller: titleController,
                                        lable: "Task Title",
                                        validation: "Enter your title please",
                                        type: TextInputType.text,
                                        prefixIcon: Icons.title_sharp,
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      textFormField(
                                          controller: timeController,
                                          lable: "Task Time",
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
                                              timeController.text = value!
                                                  .format(context)
                                                  .toString();
                                            });
                                          }),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      textFormField(
                                        controller: dateController,
                                        lable: "Date Title",
                                        onTap: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.parse(
                                                      '2024-05-03'))
                                              .then((value) {
                                            dateController.text =
                                                DateFormat.yMd()
                                                    .format(value!);
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
                AppCubit.get(context).fabIcon,
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
                currentIndex: AppCubit.get(context).currentIndex,
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
    )*/
