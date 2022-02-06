import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_app/app/core/values/constants.dart';
import 'package:multi_app/app/data/services/storage/repository.dart';
import 'package:multi_app/app/data/models/todo.dart';
import 'package:multi_app/app/core/utils/date_countdown.dart';

class CountdownHomeController extends GetxController {
  TaskRepository taskRepository;
  CountdownHomeController({required this.taskRepository});
  final formKey = GlobalKey<FormState>();
  final editingCtrl = TextEditingController();
  final tabIndex = 0.obs;
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final todos = <Todo>[].obs;
  final todo = Rx<Todo?>(null);
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    todos.assignAll(taskRepository.readTodos());
    ever(todos, (_) => taskRepository.writeTodos(todos));
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeTabIndex(int value) {
    tabIndex.value = value;
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void changeTask(Todo? select) {
    todo.value = select;
  }

  void changeTodos(List<dynamic> select) {
    doingTodos.clear();
    doneTodos.clear();
    for (int i = 0; i < select.length; i++) {
      var todo = select[i];
      var status = todo['done'];
      if (status == true) {
        doneTodos.add(todo);
      } else {
        doingTodos.add(todo);
      }
    }
  }

  bool addTask(Todo todo) {
    if (todos.contains(todo)) {
      return false;
    }
    todos.add(todo);
    return true;
  }

  void deleteTask(Todo todo) {
    todos.remove(todo);
  }

  updateTask(Todo _todo, String title) {
    var _todos = _todo.todos ?? [];
    if (containeTodo(_todos, title)) {
      return false;
    }
    var todo = {'title': title, 'done': false};
    _todos.add(todo);
    var newTask = _todo.copyWith(todos: _todos);
    int oldIndx = todos.indexOf(_todo);
    todos[oldIndx] = newTask;
    todos.refresh();
    return true;
  }

  bool containeTodo(List todos, String title) {
    return todos.any((element) => element['title'] == title);
  }

  bool addTodo(String title) {
    doingTodos.clear();
    var todo = {'title': title, 'done': false};
    doingTodos.add(todo);
    return true;
  }

  void updateTodo() {
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll([
      ...doingTodos,
      ...doneTodos,
    ]);
    var newTask = todo.value!.copyWith(todos: newTodos);
    int oldIdx = todos.indexOf(todo.value);
    todos[oldIdx] = newTask;
    todos.refresh();
  }

  void doneTodo(String title) {
    var doingTodo = {'title': title, 'done': false};
    int index = doingTodos.indexWhere(
        (element) => mapEquals<String, dynamic>(doingTodo, element));
    doingTodos.removeAt(index);
    var doneTodo = {'title': title, 'done': true};
    doneTodos.add(doneTodo);
    doingTodos.refresh();
    doneTodos.refresh();
  }

  void deleteDoneTodo(dynamic doneTodo) {
    int index = doneTodos
        .indexWhere((element) => mapEquals<String, dynamic>(doneTodo, element));
    doneTodos.removeAt(index);
    doneTodos.refresh();
  }

  bool isTodosEmpty(Todo todo) {
    return todo.todos == null || todo.todos!.isEmpty;
  }

  int getDoneTodo(Todo todo) {
    int res = 0;
    for (int i = 0; i < todo.todos!.length; i++) {
      if (todo.todos![i]['done'] == true) {
        res += 1;
      }
    }
    return res;
  }

  int getTotalTask() {
    int res = 0;
    for (int i = 0; i < todos.length; i++) {
      if (todos[i].todos != null) {
        res += todos[i].todos!.length;
      }
    }
    return res;
  }

  int getTotalDoneTask() {
    int res = 0;
    for (int i = 0; i < todos.length; i++) {
      if (todos[i].todos != null) {
        for (int j = 0; j < todos[i].todos!.length; j++) {
          if (todos[i].todos![j]['done'] == true) {
            res += 1;
          }
        }
      }
    }
    return res;
  }

  String convertToCountdownTime(time) {
    return time;
  }

  Widget countDownText(todo) {
    var position = todo.time.length == 21 ? 6 : 5;
    var month = monthName[todo.time.substring(0, 3)];
    var date = todo.time.substring(4, position).padLeft(2, '0');
    var year = todo.time.substring(position + 2, position + 6);
    var hours = todo.time.substring(position + 7, position + 9);
    var mintues = todo.time.substring(position + 10, position + 12);
    var seconds = 0;
    var is24Hrs = is24hours[todo.time.substring(position + 13, position + 15)];
    return CountDownText(
      due: DateTime.utc(
        int.parse(year.toString()),
        int.parse(month.toString()),
        int.parse(date.toString()),
        int.parse(hours.toString()),
        int.parse(mintues.toString()),
        int.parse(seconds.toString()),
      ),
      dateFormats: (todo.todos.runtimeType == Null
              ? todo.todos != null
              : todo.todos.isNotEmpty)
          ? todo.todos[0] != null
              ? todo.todos[0]['title'] != null
                  ? todo.todos[0]['title']
                  : '[]'
              : '[]'
          : '[]',
      finishedText: 'Date Arrived',
      showLabel: true,
      longDateName: true,
      style: TextStyle(fontSize: 32.0, color: Colors.black),
    );
  }

  List stringToList(String stringList, List referenceList) {
    List res = [];
    for (int i = 0; i < referenceList.length; i++) {
      if (stringList.indexOf(referenceList[i]) > -1) {
        res.add(referenceList[i]);
      }
    }
    return res;
  }

  DateTime getDateTime(todo) {
    var position = todo.time.length == 21 ? 6 : 5;
    var month = monthName[todo.time.substring(0, 3)];
    var date = todo.time.substring(4, position).padLeft(2, '0');
    var year = todo.time.substring(position + 2, position + 6);
    var hours = todo.time.substring(position + 7, position + 9);
    var mintues = todo.time.substring(position + 10, position + 12);
    var seconds = 0;
    var is24Hrs = is24hours[todo.time.substring(position + 13, position + 15)];
    return DateTime.utc(
      int.parse(year.toString()),
      int.parse(month.toString()),
      int.parse(date.toString()),
      int.parse(hours.toString()),
      int.parse(mintues.toString()),
      int.parse(seconds.toString()),
    );
  }
}
