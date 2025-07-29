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

  final List<String> priorityOptions = ['High', 'Medium', 'Low'];
  final DateTime today = DateTime.now(); // ✅ Added this line

  Future<void> _pickDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(today.year - 1),
      lastDate: DateTime(today.year + 5),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
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
              emailController: titleController,
              hintText: 'Task title',
              validatorText: 'Task title is required',
            ),
            SizedBox(height: media.height * 0.03),
            ReuseableTextform(
              emailController: descriptionController,
              hintText: 'Description',
              validatorText: 'Description is required',
              maxline: 5,
            ),
            SizedBox(height: media.height * 0.03),
            DropdownButtonFormField<String>(
              value: priority,
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
                setState(() {
                  priority = val;
                });
              },
            ),
            SizedBox(height: media.height * 0.03),
            InkWell(
              onTap: () => _pickDueDate(context),
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
            ReuseableBtn(title: "Add Task", ontap: (){
              final task = Task(
    title: titleController.text,
    description: descriptionController.text,
    priority: priority ?? 'Low',
    dueDate: _selectedDate ?? DateTime.now(),
  );
  taskProvier.addTask(task).then((val)=>{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data is saved into the database')))
  }).onError((StackTrace , error)=>{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())))
  });
  Navigator.pop(context);
            })
          ],
        ),
       
        ) 
        ),
    );
  }
}
