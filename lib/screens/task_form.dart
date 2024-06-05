import 'package:flutter/material.dart';
import 'package:todo_list_v1/screens/tasks_provider.dart';
import '../models/task.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  final _task = Task(title: '', content: '', completed: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Task'),),
      body: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter the title',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _task.title = value;
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter the description',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _task.content = value;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  // Process data
                  TasksProvider().addTask(_task);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task added')));
                  Navigator.pop(context, _task);
                }
              },
              child: const Text('Create a new task'),
            ),
          ),
        ],
      ),
    ),
    );
  }
}