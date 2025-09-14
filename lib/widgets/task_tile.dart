import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/task.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final taskBloc = BlocProvider.of<TaskBloc>(context);

    return Dismissible(
      key: Key(task.id),
      background: Container(color: Colors.red),
      onDismissed: (_) {
        taskBloc.add(DeleteTaskEvent(task.id));
      },
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Checkbox(
          value: task.isCompleted,
          onChanged: (_) {
            taskBloc.add(ToggleTaskEvent(task.id));
          },
        ),
      ),
    );
  }
}
