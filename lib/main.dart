import 'package:final_todo2/modules/layout/layout.dart';
import 'package:final_todo2/shared/BlocObserver/BlocObserver.dart';
import 'package:final_todo2/styles/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  BlocOverrides.runZoned(
        () {
        runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );


}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do',
      themeMode: ThemeMode.light,
      theme: lightTheme,
      home: TodoLayout(),
    );
  }
}
