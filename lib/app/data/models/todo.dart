import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String title;
  final String time;
  final String color;
  final List<dynamic>? todos;
  const Todo(
      {required this.title,
      required this.time,
      required this.color,
      this.todos});

  Todo copyWith({
    String? title,
    String? time,
    String? color,
    List<dynamic>? todos,
  }) =>
      Todo(
        title: title ?? this.title,
        time: time ?? this.time,
        color: color ?? this.color,
        todos: todos ?? this.todos,
      );

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        title: json['title'],
        time: json['time'],
        color: json['color'],
        todos: json['todos'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'time': time,
        'color': color,
        'todos': todos,
      };

  @override
  List<Object?> get props => [title, time, color];
}
