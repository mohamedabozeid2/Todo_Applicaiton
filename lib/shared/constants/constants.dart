import 'package:sqflite/sqlite_api.dart';

List<Map> tasks = [];
List<Map> newTasks = [];
List<Map> doneTasks = [];
List<Map> selectedTasks = [];
List<Map> archivedTasks = [];
Database? database;
DateTime? taskDate;
int? taskHours;
int? taskMinutes;

