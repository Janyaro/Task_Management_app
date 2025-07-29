import 'package:flutter/material.dart';
import 'package:task_management_app/Database/dbHelper.dart';
import '../Model/task_model.dart';

class TaskProvider extends ChangeNotifier {
  final DBHelper _dbHelper = DBHelper();

  Future<void> addTask(Task task) async {
    await _dbHelper.insertTask(task);
    notifyListeners(); 
  }

  Future<List<Task>> getTasks() async {
    return await _dbHelper.fetchTasks();
  }

  Future<void> deleteTask(int id) async {
    await _dbHelper.deleteTask(id);
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    await _dbHelper.updateTask(task);
    notifyListeners();
  }
}
