import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/todo_model.dart';
import 'package:flutter_application_2/providers/todo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTodoForm extends ConsumerWidget {
  const AddTodoForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController todoTask = TextEditingController();

    void _addTodo(BuildContext context) {
      final String value = todoTask.text.trim();
      if (value.isNotEmpty) {
        ref.read(todoProvider.notifier).addTodo(TodoModel(
              id: Random().nextInt(9999),
              description: value,
              completed: false,
            ));
        showSnackBar(context, "Todo added successfully");
        todoTask.clear();
      }
    }

    return TextFormField(
      controller: todoTask,
      decoration: InputDecoration(
        hintText: "Add a new task...",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        filled: true,
        fillColor: Colors.white, // Set input field background color
        suffixIcon: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            _addTodo(context);
          },
        ),
      ),
      onFieldSubmitted: (_) {
        _addTodo(context);
      },
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal, // Set snackbar background color
      ),
    );
  }
}
