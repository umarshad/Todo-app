import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/todo_provider.dart';
import 'package:flutter_application_2/screens/todo_items.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_2/screens/add_todo_form.dart';

class TodoList extends ConsumerWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          "Todos",
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Consumer(
                builder: (context, WidgetRef ref, child) {
                  final todos = ref.watch(todoProvider);
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return TodoItem(todo: todo);
                    },
                  );
                },
              ),
            ),
            AddTodoForm(),
          ],
        ),
      ),
    );
  }
}
