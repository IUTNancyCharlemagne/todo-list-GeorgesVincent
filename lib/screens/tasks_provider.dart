import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/task.dart';

class TasksProvider extends ChangeNotifier{
  List<Task> _tasks = [];

  Future<List<Task>> getTasks() async{
    if(_tasks.isEmpty){
      await fetchTasks();
    }
    _tasks.sort((a, b) => b.id!.compareTo(a.id!));
    return _tasks;
  }
  
  Future<void> fetchTasks() async{
    final response = await Supabase.instance.client.from('Task').select();
    List<Task> tasks = [];
    for (var element in response) {
      tasks.add(Task(
        id: element['id'] as int,
        title: element['title'] as String,
        content: element['content'] as String,
        completed: element['completed'] as bool
      ));
    }
    _tasks = tasks;
  }

  Future<void> addTask(Task task) async{
    final response = await Supabase.instance.client.from('Task').upsert({
      'title': task.title,
      'content': task.content,
      'completed': task.completed
    });
    _tasks.add(task);
    notifyListeners();
  }

  Future<void> updateTask(Task task) async{
    final response = await Supabase.instance.client.from('Task').update({
      'title': task.title,
      'content': task.content,
      'completed': task.completed
    }).eq('id', task.id as int);
    int index = _tasks.indexWhere((element) => element.id == task.id);
    if(index != -1){
      _tasks[index] = task;
    }
    notifyListeners();
  }
}