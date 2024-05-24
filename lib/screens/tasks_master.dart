import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_v1/screens/task_preview.dart';
import '../models/task.dart';

class TasksMaster extends StatefulWidget {
  const TasksMaster({super.key});

  @override
  State<TasksMaster> createState() => _TasksMasterState();
}

class _TasksMasterState extends State<TasksMaster> {

  Future<List<Task>> _fetchTask(){
    List<Task> tasks = [];
    for (var i = 0; i < 100; i++) {
      tasks.add(Task(
        id : i,
        content: faker.lorem.sentence(),
        completed: faker.randomGenerator.boolean(),
        title: faker.lorem.word()
      ));
    }
    return Future<List<Task>>.value(tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _fetchTask(),
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
    ));
  }
  
}