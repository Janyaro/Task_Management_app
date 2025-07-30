import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {

String? _priority;
DateTime? _dueDate;

String? get priority => _priority;
DateTime? get dueDate => _dueDate;


void setPriority(String? value) {
  _priority = value;
  notifyListeners();
}

void setDueDate(DateTime? date) {
  _dueDate = date;
  notifyListeners();
}

}
