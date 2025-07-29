import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {

String? _status;
String? _priority;
DateTime? _dueDate;

String? get status => _status;
String? get priority => _priority;
DateTime? get dueDate => _dueDate;

void setstatus (String? value){
  _status = value;
  notifyListeners();
}

void setPriority(String? value) {
  _priority = value;
  notifyListeners();
}

void setDueDate(DateTime? date) {
  _dueDate = date;
  notifyListeners();
}

}
