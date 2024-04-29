import 'package:flutter_application_2/models/todo_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_provider.g.dart';

@riverpod
class Todo extends _$Todo {
  @override
  List<TodoModel> build() {
    return [];
  }

  void addTodo(TodoModel todo) {
    state = [todo, ...state];
  }

  void toggle(int id, bool isCompleted) {
    state = [
      for (final todo in state)
        if (todo.id == id) todo.copyWith(completed: isCompleted) else todo
    ];
  }

  void removeTodo(int id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void editTodo(int id, String newDescription) {
    state = state.map((todo) {
      return todo.id == id ? todo.copyWith(description: newDescription) : todo;
    }).toList();
  }
}
