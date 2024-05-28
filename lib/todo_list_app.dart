import 'package:flutter/material.dart';
import './screens/tasks_master.dart';

class ToDoListApp extends StatefulWidget {
  const ToDoListApp({super.key});

  @override
  State<ToDoListApp> createState() => _ToDoListAppState();
}

class _ToDoListAppState extends State<ToDoListApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ToDo List'),
        ),
        body: const Center(
          child: TasksMaster(),
        ),
      ),
    );
  }
}
