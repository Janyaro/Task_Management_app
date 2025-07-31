import 'package:flutter/material.dart';
import 'package:task_management_app/Service/Auth_service.dart';
import 'package:task_management_app/View/Auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authservice = AuthService();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3) , (){
  authservice.checkUser(context);
    });
  }
  @override
  Widget build(BuildContext context) {
   final media = MediaQuery.of(context).size;
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Center(child: Text('Task Management App', style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold),)),
             SizedBox(height: media.height * 0.03,),
             Center(child: Text(
              textAlign: TextAlign.center,
              'Your ultimate solution for managing tasks effortlessly', style: TextStyle(fontSize: 17),)),
             
              ],
            ),
          ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text('Made by Wasim Janyaro', style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold),),
            ),

        ],
      )
    );
  }
}