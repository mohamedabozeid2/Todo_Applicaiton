import 'package:final_todo2/modules/ArchivedTasks/ArchivedTasks.dart';
import 'package:final_todo2/modules/DoneTasks/DoneTasks.dart';
import 'package:final_todo2/modules/NewTasks/NewTasks.dart';
import 'package:final_todo2/shared/constants/constants.dart';
import 'package:final_todo2/shared/cubit/states.dart';
import 'package:final_todo2/styles/icons_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(TodoAppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    NewTasks(),
    DoneTasks(),
  ];
  int currentIndex = 0;

  void changeBottomNavigationBar(index) {
    currentIndex = index;
    emit(TodoChangeBotNavState());
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = IconBroken.Edit_Square;

  void changeBotSheet({
    required isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(TodoChangeFabState());
  }

  void createDatabase() {
    openDatabase(
      'todo.db',
      onCreate: (Database database, int version) async {
        print("Database is created");
        await database
            .execute(
                "CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)")
            .then((value) {
          print("Table is created");
        }).catchError((error) {
          print("error when creating the table ===>${error.toString()}");
        });
      },
      onOpen: (Database database) {
        getDatabase(database);
      },
      version: 1,
    ).then((value) {
      database = value;
      emit(TodoCreateDatabaseState());
    });
  }

  Future insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    return await database!
        .transaction((txn) async {
          txn
              .rawInsert(
                  'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date" , "$time" , "new" )')
              .then((value) {
            print("$value is inserted successfully");
            emit(TodoInsertIntoDatabase());
            getDatabase(database!);
          });
        })
        .then((value) {})
        .catchError((error) {
          print("error while inserting database ===> ${error.toString()}");
        });
  }

  void getDatabase(Database database) async {
    emit(TodoAppLoadingState());
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    tasks = [];
    await database.rawQuery('SELECT * FROM tasks').then((value) {
      tasks = value;

      selectedTasks = [];
      tasks.forEach((element) {
        if(element['date'] == DateFormat.yMd().format(selectedDay)){
          selectedTasks.add(element);
        }
      });

      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });
      emit(TodoGetDataFromDatabase());
    }).catchError((error){
      print("Error ====> ${error.toString()}");
    });
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    await database!.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?', [status, id]).then((value) {
      print("Updated");
      getDatabase(database!);
      emit(TodoUpdateDataFromDatabase());
    }).catchError((error) {
      print("Error in update ===> ${error.toString()}");
    });
  }

  void deleteDatabase({
    required int id,
  }) {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDatabase(database!);
      emit(TodoDeleteFromDatabase());
    });
  }


  DateTime selectedDay = DateTime.now();

  bool isSameTime({
    required DateTime date1,
    required DateTime date2,
  }) {
    if(date1.year == date2.year && date1.month == date2.month && date1.day == date2.day){
      return true;
    }else {
      return false;
    }
  }

  void goToToday(){
    selectedDay = DateTime.now();
    setSelectedDate(selectedDay);
    emit(TodoGoToTodayState());
  }

  void setSelectedDate(DateTime newDate){
    selectedDay = newDate;
    selectedTasks = [];
    tasks.forEach((element) {
      if(element['date'] == DateFormat.yMd().format(selectedDay)){
        selectedTasks.add(element);
      }
    });
    print(selectedTasks);
    // getDatabase(database!);
    emit(TodoSetNewDateState());
  }

// void addTask({
//   required String title,
//   required String time,
//   required String date,
//   required BuildContext context,
// }) {
//   TodoModel todoModel = TodoModel(
//     title: title,
//     time: time,
//     date: date,
//   );
//   FirebaseFirestore.instance
//       .collection('todo')
//       .add(todoModel.tojson())
//       .then((value) {
//     print(value.id);
//     Navigator.pop(context);
//   }).catchError((error) {
//     print("Error ===> ${error.toString()}");
//   });
//
//   // getTodoCollectionReference().add(todoModel.tojson());
// }
}
