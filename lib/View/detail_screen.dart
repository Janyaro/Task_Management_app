import 'package:flutter/material.dart';
import 'package:task_management_app/Database/dbHelper.dart';
import 'package:task_management_app/Model/task_model.dart';
import 'package:task_management_app/View/edit_screen.dart';

class DetailScreen extends StatefulWidget {
  final Task task;
  const DetailScreen({super.key,required this.task});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final dbhelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title:const Text('Task Detail') ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Text( 'Title : ${widget.task.title}' , style:const TextStyle(fontSize: 20),),
              SizedBox(height: media.height * 0.01,),
              Text('Description :${widget.task.description}', style:const TextStyle(fontSize: 20)),
              SizedBox(height: media.height * 0.01,),
              Text('Duedate :${widget.task.dueDate.toString()}', style:const TextStyle(fontSize: 20)),
              SizedBox(height: media.height * 0.01,),
              Text('Priority :  ${widget.task.priority}', style:const TextStyle(fontSize: 20)),
              SizedBox(height: media.height * 0.01,),
              Text('Status :  ${widget.task.status}', style:const TextStyle(fontSize: 20)),
              SizedBox(height: media.height * 0.02,),
              Row(
                children:[
                  TextButton(
                    onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> EditScreen(task: widget.task)));
                    },
                    child:const Text('Edit')
                  ),
                  TextButton(
                    onPressed:(){
                      dbhelper.deleteTask(widget.task.id!)
                      .then((val){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Delete Successfully')));
                      })
                      .onError((error, StackTrace){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error will occur during deletion the task')));
                      });
                    },
                    child:Text('Delete')
                  ),
                ]
               ),
            //  Consumer<AuthenticationProvider>(builder: (context,value,child){
            //   return ReuseableBtn(title: 'Update', ontap: (){
            //     Navigator.push(context, MaterialPageRoute(builder: (context)=> EditScreen(task: widget.task)));
            //   }, isloading: value.isloading);
          
            //  })
              
            ],
          ),
        ),
      ),
    );
  }
}