import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'bloc/task_bloc.dart';
import 'bloc/task_event.dart';
import 'repositories/task_repository.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('tasks');

  runApp(const TodoApp());
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskBloc(TaskRepository())..add(LoadTasksEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: isDark ? ThemeData.dark() : ThemeData.light(),
        home: HomeScreen(
          toggleTheme: () => setState(() => isDark = !isDark),
        ),
      ),
    );
  }
}
