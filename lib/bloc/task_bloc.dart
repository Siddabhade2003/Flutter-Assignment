import 'package:flutter_bloc/flutter_bloc.dart';
import 'task_event.dart';
import 'task_state.dart';
import '../repositories/task_repository.dart';
import '../models/task.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  TaskBloc(this.repository) : super(const TaskState()) {
    on<LoadTasksEvent>((event, emit) {
      emit(TaskState(tasks: repository.loadTasks()));
    });

    on<AddTaskEvent>((event, emit) {
      final updated = List<Task>.from(state.tasks)..add(event.task);
      repository.saveTasks(updated);
      emit(TaskState(tasks: updated));
    });

    on<ToggleTaskEvent>((event, emit) {
      final updated = state.tasks.map((t) {
        return t.id == event.taskId ? t.copyWith(isCompleted: !t.isCompleted) : t;
      }).toList();
      repository.saveTasks(updated);
      emit(TaskState(tasks: updated));
    });

    on<DeleteTaskEvent>((event, emit) {
      final updated = state.tasks.where((t) => t.id != event.taskId).toList();
      repository.saveTasks(updated);
      emit(TaskState(tasks: updated));
    });
  }
}
