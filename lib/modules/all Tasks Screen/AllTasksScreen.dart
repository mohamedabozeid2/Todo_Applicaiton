import 'package:final_todo2/modules/layout/NavigationDrawer.dart';
import 'package:final_todo2/shared/constants/constants.dart';
import 'package:final_todo2/shared/cubit/cubit.dart';
import 'package:final_todo2/shared/cubit/states.dart';
import 'package:final_todo2/styles/icons_broken.dart';
import 'package:final_todo2/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_zoom_drawer/config.dart';

class AllTasksScreen extends StatefulWidget {
  final ZoomDrawerController drawerController;

  AllTasksScreen({required this.drawerController});

  @override
  State<AllTasksScreen> createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          // drawer: NavigationDrawer(context),
          appBar: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height * 0.1,
            leading: IconButton(
              icon: const Icon(
                Icons.menu,
                size: 30,
              ),
              onPressed: () {
                widget.drawerController.toggle?.call();
              },
            ),
            title: const Text(
              "Tasks",
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: tasks.length == 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            style:
                                TextStyle(color: Colors.grey, fontSize: 25),
                            textAlign: TextAlign.center,
                          )
                        ],
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          return buildTaskItem(index);
                        },
                        separatorBuilder: (context, index) => SizedBox(),
                        itemCount: tasks.length),
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
              AppCubit.get(context).deleteDatabase(id: tasks[index]['id']);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          if (tasks[index]['status'] == 'done')
            SlidableAction(
              onPressed: (context) {
                AppCubit.get(context)
                    .updateData(status: "new", id: tasks[index]['id']);
              },
              backgroundColor: Colors.grey,
              foregroundColor: Colors.white,
              icon: Icons.redo,
              label: 'Redo',
            ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              tasks[index]['status'] == "archive"
                  ? AppCubit.get(context)
                      .updateData(status: 'done', id: tasks[index]['id'])
                  : AppCubit.get(context)
                      .updateData(status: 'archive', id: tasks[index]['id']);
            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.archive_outlined,
            label: tasks[index]['status'] != 'archive'
                ? "Archive"
                : "Remove Archive",
          )
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
                height: MediaQuery.of(context).size.height * 0.07,
                width: 3,
                decoration: BoxDecoration(
                    color: tasks[index]['status'] != 'done'
                        ? defaultBlueColor
                        : Color(0xff61e757),
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
                      tasks[index]['title'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: tasks[index]['status'] != 'done'
                              ? defaultBlueColor
                              : const Color(0xff61e757)),
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
                        Text(tasks[index]['time'],
                            style: Theme.of(context).textTheme.caption),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          tasks[index]['date'],
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    )
                  ],
                ),
              ),
              if (tasks[index]['status'] == "archive")
                const Text(
                  "Archived",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                )
              else if (tasks[index]['status'] == 'done')
                const Text("Done!",
                    style: TextStyle(
                        color: Color(0xff61e757), fontWeight: FontWeight.bold))
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
                    AppCubit.get(context)
                        .updateData(status: 'done', id: tasks[index]['id']);
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
