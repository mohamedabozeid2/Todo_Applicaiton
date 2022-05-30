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

class ArchivedTasksScreen extends StatefulWidget {
  final ZoomDrawerController drawerController;

  ArchivedTasksScreen({required this.drawerController});

  @override
  State<ArchivedTasksScreen> createState() => _ArchivedTasksScreenState();
}

class _ArchivedTasksScreenState extends State<ArchivedTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                toolbarHeight: MediaQuery.of(context).size.height * 0.1,
                leading: IconButton(
                  icon: Icon(
                    Icons.menu,
                    size: 30,
                  ),
                  onPressed: () {
                    widget.drawerController.toggle?.call();
                  },
                ),
                title: const Text('Archive Tasks'),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: archivedTasks.length == 0
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
                                "No Archive Tasks",
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
                            itemCount: archivedTasks.length),
                  ),
                ],
              ));
        },
      ),
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
                  .deleteDatabase(id: archivedTasks[index]['id']);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              AppCubit.get(context)
                  .updateData(status: 'done', id: archivedTasks[index]['id']);
            },
            backgroundColor: Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Remove Archive',
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
                      archivedTasks[index]['title'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: defaultBlueColor),
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
                        Text(archivedTasks[index]['time'],
                            style: Theme.of(context).textTheme.caption),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          archivedTasks[index]['date'],
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    )
                  ],
                ),
              ),
              const Text(
                "Archived",
                style: TextStyle(
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:final_todo2/shared/constants/constants.dart';
// import 'package:final_todo2/shared/cubit/cubit.dart';
// import 'package:final_todo2/shared/cubit/states.dart';
// import 'package:final_todo2/styles/icons_broken.dart';
// import 'package:final_todo2/styles/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
//
// class ArchivedTasks extends StatefulWidget {
//   const ArchivedTasks({Key? key}) : super(key: key);
//
//   @override
//   State<ArchivedTasks> createState() => _ArchivedTasksState();
// }
//
// class _ArchivedTasksState extends State<ArchivedTasks> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) => AppCubit(),
//       child: BlocConsumer<AppCubit, AppStates>(
//         listener: (context, state){},
//         builder: (context, state){
//           return Scaffold(
//               appBar: AppBar(
//                 title: Text("Archive Tasks"),
//               ),
//               body: Column(
//                 children: [
//                   Expanded(
//                     child: archivedTasks.length == 0 ? Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const [
//                         Icon(Icons.menu_sharp, size: 40, color: Colors.grey,),
//                         SizedBox(height: 10,),
//                         Text("No Archive Tasks", style: TextStyle(color: Colors.grey, fontSize: 25),textAlign: TextAlign.center,)
//                       ],
//                     ) : ListView.separated(
//                         itemBuilder: (context, index) {
//                           return buildTaskItem(index);
//                         },
//                         separatorBuilder: (context, index) => SizedBox(),
//                         itemCount: archivedTasks.length),
//                   )
//                 ],
//               )
//
//           );
//         },
//       ),
//     );
//   }
//
//   Widget buildTaskItem(index) {
//     return Slidable(
//       startActionPane: ActionPane(
//         motion: const BehindMotion(),
//         children: [
//           SlidableAction(
//             onPressed: (context){
//               AppCubit.get(context).deleteDatabase(id: archivedTasks[index]['id']);
//             },
//             backgroundColor: Color(0xFFFE4A49),
//             foregroundColor: Colors.white,
//             icon: Icons.delete,
//             label: 'Delete',
//           ),
//
//         ],
//       ),
//       endActionPane: ActionPane(
//         motion: ScrollMotion(),
//         children: [
//           SlidableAction(
//             onPressed: (context){
//               print("Befor ==> ${archivedTasks[index]['id']}}");
//               AppCubit.get(context).updateData(status: 'done', id: archivedTasks[index]['id']);
//               print("after ==> $archivedTasks}");
//
//             },
//             backgroundColor: Color(0xFF7BC043),
//             foregroundColor: Colors.white,
//             icon: Icons.archive,
//             label: 'Remove Archive',
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(12.0),
//         child: Container(
//           decoration: BoxDecoration(
//               color: Colors.white, borderRadius: BorderRadius.circular(15)),
//           margin: const EdgeInsets.only(left: 15, right: 15),
//           padding: const EdgeInsets.all(18),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.07,
//                 width: 3,
//                 decoration: BoxDecoration(
//                     color: defaultBlueColor,
//                     borderRadius: BorderRadius.circular(8)),
//               ),
//               const SizedBox(
//                 width: 25,
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       archivedTasks[index]['title'],
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(color: defaultBlueColor),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       children: [
//                         const Icon(
//                           IconBroken.Time_Circle,
//                           size: 15,
//                         ),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         Text(archivedTasks[index]['time'],
//                             style: Theme.of(context).textTheme.caption),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         Text(archivedTasks[index]['date'], style: Theme.of(context).textTheme.caption,)
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               Text("Archived", style: TextStyle(color: Colors.grey),)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
