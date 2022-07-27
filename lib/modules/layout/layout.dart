import 'package:final_todo2/modules/ArchivedTasks/ArchivedTasks.dart';
import 'package:final_todo2/modules/CalendarScreen/CalendarScreen.dart';
import 'package:final_todo2/modules/SettingsScreen/SettingsScreen.dart';
import 'package:final_todo2/modules/all%20Tasks%20Screen/AllTasksScreen.dart';
import 'package:final_todo2/modules/layout/MainScreen.dart';
import 'package:final_todo2/modules/layout/MenuScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class TodoLayout extends StatefulWidget {
  @override
  State<TodoLayout> createState() => _TodoLayoutState();
}

class _TodoLayoutState extends State<TodoLayout> {
  final drawerController = ZoomDrawerController();
  MenuItemDetails currentItem = MenuItems.home;

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
              builder: (context) => MenuScreen(
                currentItem: currentItem,
                onSelectedItem: (item) {
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
            menuBackgroundColor: Color(0xff274472) /*0xff5860db*/,
          );
        },
      ),
    );
  }

  Widget getScreen() {
    if (currentItem == MenuItems.home)
      return MainScreen(drawerController);
    else if (currentItem == MenuItems.archive)
      return ArchivedTasksScreen(
        drawerController: drawerController,
      );
    else if (currentItem == MenuItems.allTasks)
      return AllTasksScreen(
        drawerController: drawerController,
      );
    else if (currentItem == MenuItems.calendar)
      return CalendarScreen(
        drawerController: drawerController,
      );
    else
      return SettingsScreen();
  }
}
