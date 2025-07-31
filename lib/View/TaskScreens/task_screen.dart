import 'package:flutter/material.dart';
import 'package:task_management_app/Database/dbHelper.dart';
import 'package:task_management_app/Model/task_model.dart';
import 'package:task_management_app/View/TaskScreens/add_task_screen.dart';
import 'package:task_management_app/View/detail_screen.dart';
import 'package:task_management_app/View/root_screen.dart';

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
        title: Text('Task'),
        actions: [IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=> AddTaskScreen()));
        }, icon: Icon(Icons.add))],
      ),
      body: FutureBuilder<List<Task>>(
  future:dbHelper.fetchTasks(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return Text('No tasks');
    } else {
      final tasks = snapshot.data!;
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
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
                  trailing: Wrap(
                    children: [
                      Icon(
                        task.status == 'pending'
                
                ? Icons.check_box_outline_blank 
                : Icons.check_box 
               
                        ),
                       const SizedBox(width: 4,),
                     InkWell(
                      onTap: (){
                        dbHelper.deleteTask(task.id!).then((val){
                          dbHelper.fetchTasks();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> RootScreen()));
                        });
                      },
                      child: Icon(Icons.delete , color: Colors.red,))
                    ],
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