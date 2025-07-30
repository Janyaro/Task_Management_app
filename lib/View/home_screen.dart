import 'package:flutter/material.dart';
import 'package:task_management_app/Service/Auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:const Text('Home'),
      ),
      body: FutureBuilder(
        future: authService.getUserInfo(), 
        builder: (context , snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: Text('Please wait'),
            );
          }
          else if (!snapshot.hasData){
            return const Center(
              child: Text('No user find'),
            );
          }
          final data = snapshot.data!;
          return Column(
            children: [
              Text('Welcome Back, $data',style:const TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
              Text(DateTime.now().toString(),style:const TextStyle(fontSize: 15),)
            ],
          );

        })
    );
  }
}