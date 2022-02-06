import 'dart:convert';
import 'package:multi_app/app/core/utils/keys.dart';
import 'package:multi_app/app/data/services/storage/service.dart';
import 'package:multi_app/app/data/models/task.dart';
import 'package:multi_app/app/data/models/todo.dart';
import 'package:get/get.dart';

class TaskProvider {
  final _storage = Get.find<StorageService>();

  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(_storage.read(taskKey).toString())
        .forEach((e) => tasks.add(Task.fromJson(e)));
    return tasks;
  }

  void writeTask(List<Task> tasks) {
    _storage.write(taskKey, jsonEncode(tasks));
  }

  List<Todo> readTodos() {
    var todos = <Todo>[];
    jsonDecode(_storage.read(todoKey).toString())
        .forEach((e) => todos.add(Todo.fromJson(e)));
    return todos;
  }

  void writeTodo(List<Todo> todos) {
    _storage.write(todoKey, jsonEncode(todos));
  }
}
