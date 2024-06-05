import 'package:flutter/material.dart';
import 'package:todo_list_v1/screens/tasks_provider.dart';
import './tasks_details.dart';
import '../models/task.dart';

class TaskPreview extends StatefulWidget {
  final Task task;
  const TaskPreview({super.key, required this.task});

  @override
  State<TaskPreview> createState() => _TaskPreviewState();
}

class _TaskPreviewState extends State<TaskPreview> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.task.title!),
      subtitle: Text(widget.task.content),
      trailing: Checkbox(
        value: widget.task.completed,
        onChanged: (bool? value) {
          setState(() {
            widget.task.completed = value!;
            TasksProvider().updateTask(widget.task);
          });
        },
        activeColor: Colors.green,
        side: const BorderSide(
          color: Colors.red,
          width: 2.0
        )
      ),
      onTap: () {
        final result = Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TaskDetails(task: widget.task,)),
        );
        result.then((value) => setState(() {
          if(value != null){
            setState(() {
              widget.task.title = value.title;
              widget.task.content = value.content;
            });
            TasksProvider().updateTask(widget.task);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task updated')));
          }
        }));
      },
    );
  }
}
