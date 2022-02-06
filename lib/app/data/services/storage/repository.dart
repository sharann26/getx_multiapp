import 'package:multi_app/app/data/providers/task/provider.dart';
import 'package:multi_app/app/data/models/task.dart';
import 'package:multi_app/app/data/models/todo.dart';

class TaskRepository {
  TaskProvider taskProvider;
  TaskRepository({required this.taskProvider});

  List<Todo> readTodos() => taskProvider.readTodos();
  void writeTodos(List<Todo> todos) => taskProvider.writeTodo(todos);

  List<Task> readTasks() => taskProvider.readTasks();
  void writeTasks(List<Task> tasks) => taskProvider.writeTask(tasks);
}