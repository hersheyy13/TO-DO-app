import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  final List<Map<String, String>> _tasks = [];

  List<Map<String, String>> get tasks => _tasks;

  void addTask(Map<String, String> task) {
    _tasks.add(task);
    notifyListeners(); // Notify listeners of the change
  }
}
