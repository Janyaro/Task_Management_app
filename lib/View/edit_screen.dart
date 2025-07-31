import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/Database/dbHelper.dart';
import 'package:task_management_app/Model/task_model.dart';
import 'package:task_management_app/View/root_screen.dart';
import 'package:task_management_app/Widget/reuseable_btn.dart';
import 'package:task_management_app/Widget/reuseable_textform.dart';
import 'package:task_management_app/provider/Authentication_provider.dart';
import 'package:task_management_app/provider/TaskProvider.dart';

class EditScreen extends StatefulWidget {
  final Task task;

  const EditScreen({super.key, required this.task});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;

  final formkey = GlobalKey<FormState>();
  final dbhelper = DBHelper();
  final List<String> statusOption = ['pending', 'complete'];
  final List<String> priorityOptions = ['High', 'Medium', 'Low'];

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController = TextEditingController(text: widget.task.description);

    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    taskProvider.setPriority(widget.task.priority);
    taskProvider.setStatus(widget.task.status ?? 'pending');
    taskProvider.setDueDate(widget.task.dueDate);
  }

  Future<void> _pickDueDate(BuildContext context, TaskProvider taskProvider) async {
    final DateTime today = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: taskProvider.dueDate ?? today,
      firstDate: DateTime(today.year - 1),
      lastDate: DateTime(today.year + 5),
    );
    if (picked != null) {
      taskProvider.setDueDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Task')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: media.height * 0.04),
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
              DropdownButtonFormField<String>(
                value: taskProvider.priority,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: 'Select Priority',
                  fillColor: Colors.grey.shade300,
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
                ),
                dropdownColor: Colors.grey.shade200,
                items: priorityOptions.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (val) {
                  taskProvider.setPriority(val);
                },
              ),
              SizedBox(height: media.height * 0.03),
              DropdownButtonFormField<String>(
                value: taskProvider.status,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: 'Select Status',
                  fillColor: Colors.grey.shade300,
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
                ),
                dropdownColor: Colors.grey.shade200,
                items: statusOption.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (val) {
                  taskProvider.setStatus(val);
                },
              ),
              SizedBox(height: media.height * 0.03),
              InkWell(
                onTap: () => _pickDueDate(context, taskProvider),
                child: InputDecorator(
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    labelText: 'Due Date',
                    border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(4)),
                  ),
                  child: Text(
                    taskProvider.dueDate == null
                        ? 'Select Due Date'
                        : '${taskProvider.dueDate!.day}/${taskProvider.dueDate!.month}/${taskProvider.dueDate!.year}',
                    style: TextStyle(
                      color: taskProvider.dueDate == null ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: media.height * 0.04),
              Consumer<AuthenticationProvider>(
                builder: (context, value, child) {
                  return ReuseableBtn(
                    isloading: value.isloading,
                    title: "Update Task",
                    ontap: () async {
                      if (!formkey.currentState!.validate()) return;

                      final updatedTask = Task(
                        id: widget.task.id,
                        title: titleController.text,
                        description: descriptionController.text,
                        priority: taskProvider.priority ?? 'Low',
                        status: taskProvider.status ?? 'pending',
                        dueDate: taskProvider.dueDate ?? DateTime.now(),
                      );

                      await dbhelper.updateTask(updatedTask).then((val){
                        dbhelper.fetchTasks();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Task updated successfully")),
                        );
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> RootScreen()));
                      });

                      
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
