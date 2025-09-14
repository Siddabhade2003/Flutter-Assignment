import 'package:hive/hive.dart';
import '../models/task.dart';

class TaskRepository {
  final Box box = Hive.box('tasks');

  List<Task> loadTasks() {
    final tasksJson = box.values.cast<Map>().toList();
    return tasksJson.map((e) => Task.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  void saveTasks(List<Task> tasks) {
    box.clear();
    for (var t in tasks) {
      box.add(t.toJson());
    }
  }
}
