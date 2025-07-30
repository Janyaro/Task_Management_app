import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/Model/task_model.dart';
import 'package:task_management_app/Widget/reuseable_btn.dart';
import 'package:task_management_app/Widget/reuseable_textform.dart';
import 'package:task_management_app/provider/TaskProvider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String? priority;
  DateTime? _selectedDate;
  final formkey = GlobalKey<FormState>();
  String? status; 
  final List<String> statusOption = ['pending' , 'complete'];
  final List<String> priorityOptions = ['High', 'Medium', 'Low'];
  final DateTime today = DateTime.now(); // ✅ Added this line

  Future<void> _pickDueDate(BuildContext context, TaskProvider taskprovider) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(today.year - 1),
      lastDate: DateTime(today.year + 5),
    );
    if (picked != null) {
      taskprovider.setDueDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
     final taskProvier = Provider.of<TaskProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title:const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child:Form(
          key: formkey,
          child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: media.height * 0.04,),
            ReuseableTextform(
              controller: titleController,
              hintText: 'Task title',
              validatorText: 'Task title is required',
            ),
            SizedBox(height: media.height * 0.03),
            ReuseableTextform(
              controller: descriptionController,
              hintText: 'Description',
              validatorText: 'Description is required',
              maxline: 5,
            ),
            SizedBox(height: media.height * 0.03),
            Consumer<TaskProvider>(builder: (context , value , child){
              return 
            DropdownButtonFormField<String>(
              value: value.priority,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'Select Priority',
                  fillColor: Colors.grey.shade300,
                  filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none
                ),
              ),
              dropdownColor: Colors.grey.shade200,
              items: priorityOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (val) {
                taskProvier.setPriority(val);
              },
            );
            }),
            SizedBox(height: media.height * 0.02,),
InkWell(
              onTap: () => _pickDueDate(context, taskProvier),
              child: InputDecorator(
                decoration: InputDecoration(
                  
                  fillColor: Colors.grey.shade300,
                  filled: true,
                  labelText: 'Due Date',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(4)
                  ),
                ),
                child: Text(
                  _selectedDate == null
                      ? 'Select Due Date'
                      : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                  style: TextStyle(
                    color: _selectedDate == null ? Colors.grey : Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: media.height * 0.04,),
            ReuseableBtn(isloading: false, title: "Add Task", ontap: (){
              final task = Task(
    title: titleController.text,
    description: descriptionController.text,
    priority: priority ?? 'Low',
    dueDate: _selectedDate ?? DateTime.now(),

  );

            })
          ],
        ),
       
        ) 
        ),
    );
  }
}
