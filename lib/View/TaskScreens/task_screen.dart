import 'package:flutter/material.dart';
import 'package:task_management_app/Database/dbHelper.dart';
import 'package:task_management_app/Model/task_model.dart';
import 'package:task_management_app/View/TaskScreens/add_task_screen.dart';
import 'package:task_management_app/View/detail_screen.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final DBHelper dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true
        ,
        title:const Text('Task'),
        actions: [IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=> AddTaskScreen()));
        }, icon:const Icon(Icons.add))],
      ),
      body: FutureBuilder<List<Task>>(
  future:dbHelper.fetchTasks(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return const Text('No tasks');
    } else {
      final tasks = snapshot.data!;
      return Padding(
        padding:const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(task: task)));
              },
              child: Card(
                elevation: 2,
                child: ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.priority),
                  trailing:  Icon(
                        task.status == 'pending'
                
                ? Icons.check_box_outline_blank 
                : Icons.check_box 
               
                        ),
                    
                ),
              ),
            );
          },
        ),
      );
    }
  },
)

    );
  }
}