import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import './task_form.dart';
import './task_preview.dart';
import '../models/task.dart';

class TasksMaster extends StatefulWidget {
  const TasksMaster({super.key});

  @override
  State<TasksMaster> createState() => _TasksMasterState();
}

class _TasksMasterState extends State<TasksMaster> {

  late Future<List<Task>> listTasks;

  _fetchTask(){
    List<Task> tasks = [];
    for (var i = 0; i < 100; i++) {
      tasks.add(Task(
        id : i,
        content: faker.lorem.sentence(),
        completed: faker.randomGenerator.boolean(),
        title: faker.lorem.word()
      ));
    }
    listTasks = Future<List<Task>>.value(tasks);
  }

  @override
  void initState(){
    super.initState();
    _fetchTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: listTasks,
        builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index){
                return TaskPreview(task : snapshot.data![index]);
              },
            );
          }else if(snapshot.hasError){
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        },
    ),
    floatingActionButton: FloatingActionButton(
          onPressed: () {
            final result = Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TaskForm()),);
              result.then((value) => setState(() {
                if(value != null){
                  listTasks.then((val) => val.insert(0, value));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task added')));
                }
              }));
          },
          child: const Icon(Icons.add),
      ),
    );
  }
}