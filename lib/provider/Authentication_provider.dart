import 'package:flutter/material.dart';

class AuthenticationProvider extends ChangeNotifier{
 
 bool _isloading = false;
 bool _isVisibility = false;

bool get isloading => _isloading;
bool get isVisibility => _isVisibility;

void setloading (bool value){
_isloading = value;
notifyListeners();
}

void toogleVisibility (){
  _isVisibility = !_isVisibility;
  notifyListeners();
}
}