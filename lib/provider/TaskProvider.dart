import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {

String? _priority;
String? _status;
DateTime? _dueDate;


String? get priority => _priority;
String? get status => _status;
DateTime? get dueDate => _dueDate;


void setPriority(String? value) {
  _priority = value;
  notifyListeners();
}

void setStatus(String? value){
  _status = value;
  notifyListeners();
}
void setDueDate(DateTime? date) {
  _dueDate = date;
  notifyListeners();
}

}
