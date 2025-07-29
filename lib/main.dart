import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/View/Auth/login_screen.dart';
import 'package:task_management_app/View/Auth/signup_screen.dart';
import 'package:task_management_app/View/TaskScreens/add_task_screen.dart';
import 'package:task_management_app/View/TaskScreens/task_screen.dart';
import 'package:task_management_app/provider/TaskProvider.dart';

void main() {
 
  runApp(
 MultiProvider(providers: [
  ChangeNotifierProvider(create: (_)=> TaskProvider()),
 ],
 child:const MyApp() ,
 )   
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
        appBarTheme:const AppBarTheme(
          
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 23 , color: Colors.black , fontWeight: FontWeight.w500)),

      ),
      home: TaskScreen(),
    );
  }
}