import 'package:flutter/material.dart';
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
                      });
                    },
                    activeColor: Colors.green,
                    side: const BorderSide(
                      color: Colors.red,
                      width: 2.0
                    )
                  ),
                );
  }
}
