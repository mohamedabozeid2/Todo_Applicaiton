import 'package:final_todo2/shared/constants/constants.dart';
import 'package:final_todo2/shared/cubit/states.dart';
import 'package:final_todo2/styles/icons_broken.dart';
import 'package:final_todo2/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../shared/cubit/cubit.dart';

class DoneTasks extends StatefulWidget {
  const DoneTasks({Key? key}) : super(key: key);

  @override
  State<DoneTasks> createState() => _DoneTasksState();
}

class _DoneTasksState extends State<DoneTasks> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){
        return Column(
          children: [
            Expanded(
              child: doneTasks.length == 0 ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.menu_sharp, size: 40, color: Colors.grey,),
                  SizedBox(height: 10,),
                  Text("No Done Tasks", style: TextStyle(color: Colors.grey, fontSize: 25),textAlign: TextAlign.center,)
                ],
              ) : ListView.separated(
                  itemBuilder: (context, index) {
                    return buildTaskItem(index);
                  },
                  separatorBuilder: (context, index) => SizedBox(),
                  itemCount: doneTasks.length),
            )
          ],
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
            onPressed: (context){
              AppCubit.get(context).deleteDatabase(id: doneTasks[index]['id']);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),SlidableAction(
            onPressed: (context){
              AppCubit.get(context).updateData(status: "new",id: doneTasks[index]['id']);
            },
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            icon: Icons.redo,
            label: 'Redo',
          ),

        ],
      ),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context){
              AppCubit.get(context).updateData(status: 'archive', id: doneTasks[index]['id']);
            },
            backgroundColor: Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
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
                height: MediaQuery.of(context).size.height * 0.07,
                width: 3,
                decoration: BoxDecoration(
                    color: defaultBlueColor,
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
                      doneTasks[index]['title'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: defaultBlueColor),
                    ),
                    SizedBox(
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
                        Text(doneTasks[index]['time'],
                            style: Theme.of(context).textTheme.caption),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(doneTasks[index]['date'], style: Theme.of(context).textTheme.caption,)
                      ],
                    )
                  ],
                ),
              ),
              doneTasks[index]['status'] != "done"
                  ? Container(
                child: IconButton(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  icon: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    AppCubit.get(context).updateData(status: 'done', id: doneTasks[index]['id']);
                  },
                ),
                decoration: BoxDecoration(
                    color: defaultBlueColor,
                    borderRadius: BorderRadius.circular(8)),
              )
                  : const Text("Done!",
                  style: TextStyle(
                      color: Color(0xff61e757), fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}
