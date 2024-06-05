import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './tasks_provider.dart';
import './task_form.dart';
import './task_preview.dart';
import '../models/task.dart';

class TasksMaster extends StatefulWidget {
  const TasksMaster({super.key});

  @override
  State<TasksMaster> createState() => _TasksMasterState();
}

class _TasksMasterState extends State<TasksMaster> {

  @override
  void initState(){
    super.initState();
    _init();
  }

  void _init() async{
    TasksProvider  tasksProvider = TasksProvider();
    await tasksProvider.fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TasksProvider>(builder: (context, taskProvider, child){
        return FutureBuilder(
          future: taskProvider.getTasks(),
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
        );
      }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            final result = Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TaskForm()));
          },
          child: const Icon(Icons.task),
      ),
    );
  }
}