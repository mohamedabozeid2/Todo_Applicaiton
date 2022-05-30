// import 'package:final_todo2/modules/ArchivedTasks/ArchivedTasks.dart';
// import 'package:final_todo2/modules/DoneTasks/DoneTasks.dart';
// import 'package:final_todo2/modules/NewTasks/NewTasks.dart';
// import 'package:final_todo2/modules/all%20Tasks%20Screen/AllTasksScreen.dart';
// import 'package:final_todo2/modules/layout/layout.dart';
// import 'package:final_todo2/shared/components/components.dart';
// import 'package:final_todo2/shared/cubit/cubit.dart';
// import 'package:final_todo2/styles/icons_broken.dart';
// import 'package:flutter/material.dart';
//
// class NavigationDrawer extends StatelessWidget {
//   final BuildContext context;
//   NavigationDrawer(this.context);
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             buildHeader(),
//             buildMenuItem(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildHeader() {
//     return Container();
//   }
//
//   Widget buildMenuItem() {
//     return Container(
//       child: Column(
//         children: [
//           const SizedBox(
//             height: 50,
//           ),
//           ListTile(
//             onTap: () {
//               navigateAndFinish(context: context,widget:  TodoLayout());
//             },
//             leading: const Icon(IconBroken.Home),
//             title: const Text(
//               "Home",
//               style: TextStyle(fontSize: 17),
//             ),
//           ),
//           ListTile(
//             onTap: () {
//               navigateAndFinish(context: context, widget: ArchivedTasksScreen());
//               // print("Archive tasks ====> ${AppCubit.get(context).archivedTasks}");
//             },
//             leading: const Icon(Icons.archive_outlined),
//             title: const Text(
//               "Archive",
//               style: TextStyle(fontSize: 17),
//             ),
//           ),
//           ListTile(
//             onTap: () {
//               navigateAndFinish(context: context, widget: AllTasksScreen());
//             },
//             leading: const Icon(IconBroken.Paper),
//             title: const Text(
//               "All Tasks",
//               style: TextStyle(fontSize: 17),
//             ),
//           ),
//           ListTile(
//             onTap: () {},
//             leading: const Icon(IconBroken.Calendar),
//             title: const Text(
//               "Calendar",
//               style: TextStyle(fontSize: 17),
//             ),
//           ),
//           ListTile(
//             onTap: () {},
//             leading: const Icon(IconBroken.Setting),
//             title: const Text(
//               "Settings",
//               style: TextStyle(fontSize: 17),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
