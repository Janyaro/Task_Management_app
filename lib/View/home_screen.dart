import 'package:flutter/material.dart';
import 'package:task_management_app/Database/dbHelper.dart';
import 'package:task_management_app/Model/task_model.dart';
import 'package:task_management_app/Service/Auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dbhelper = DBHelper();
  final authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
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
          return Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10),
  child: SingleChildScrollView( // 🔁 Add this to avoid overflow
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: media.height * 0.03),
        Text(
          'Welcome Back, ${data['username']}',
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: media.height * 0.01),
        Text(
          DateTime.now().toString().split(' ')[0],
          style: const TextStyle(fontSize: 18 , color: Colors.blue),
        ),
        SizedBox(height: media.height * 0.03),

        /// Your second FutureBuilder inside scrollable content
        FutureBuilder<List<Task>>(
          future: dbhelper.fetchTasksByPriority('High'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No high-priority tasks.');
            }

            final totalTask = snapshot.data!.length;
            return Card(
              child: ListTile(
                title: const Text('Task Today'),
                subtitle: Text('$totalTask'),
              ),
            );
          },
        ),
      ],
    ),
  ),
);

        })
    );
  }
}