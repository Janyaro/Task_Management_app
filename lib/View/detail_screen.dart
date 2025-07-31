import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/Model/task_model.dart';
import 'package:task_management_app/View/edit_screen.dart';
import 'package:task_management_app/Widget/reuseable_btn.dart';
import 'package:task_management_app/provider/Authentication_provider.dart';

class DetailScreen extends StatefulWidget {
  final Task task;
  const DetailScreen({super.key,required this.task});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Task Detail') ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Text( 'Title : ${widget.task.title}' , style: TextStyle(fontSize: 20),),
              SizedBox(height: media.height * 0.01,),
              Text('Description :${widget.task.description}', style: TextStyle(fontSize: 20)),
              SizedBox(height: media.height * 0.01,),
              Text('Duedate :${widget.task.dueDate.toString()}', style: TextStyle(fontSize: 20)),
              SizedBox(height: media.height * 0.01,),
              Text('Priority :  ${widget.task.priority}', style: TextStyle(fontSize: 20)),
              SizedBox(height: media.height * 0.01,),
              Text('Status :  ${widget.task.status}', style: TextStyle(fontSize: 20)),
              SizedBox(height: media.height * 0.02,),

             Consumer<AuthenticationProvider>(builder: (context,value,child){
              return ReuseableBtn(title: 'Update', ontap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> EditScreen(task: widget.task)));
              }, isloading: value.isloading);
          
             })
              
            ],
          ),
        ),
      ),
    );
  }
}