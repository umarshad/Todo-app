import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/todo_model.dart';
import 'package:flutter_application_2/providers/todo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoItem extends ConsumerWidget {
  final TodoModel todo;

  const TodoItem({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: todo.completed ? Colors.grey[300] : Colors.white,
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          todo.description,
          style: TextStyle(
            decoration: todo.completed ? TextDecoration.lineThrough : null,
            color: todo.completed ? Colors.grey : Colors.black,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                _editTodoDialog(context, ref, todo);
              },
              icon: Icon(Icons.edit),
              color: Colors.blue,
            ),
            IconButton(
              onPressed: () {
                ref.read(todoProvider.notifier).removeTodo(todo.id);
                showSnackBar(context, "Todo deleted successfully");
              },
              icon: Icon(Icons.delete),
              color: Colors.red,
            ),
            Checkbox(
              value: todo.completed,
              onChanged: (value) {
                ref.read(todoProvider.notifier).toggle(todo.id, value!);
              },
              // Customize checkbox color based on its state
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              overlayColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Colors.blue.withOpacity(0.04); // Hover color
                  }
                  return null; // Default
                },
              ),
              fillColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (states.contains(MaterialState.selected)) {
                    return MaterialStateColor.resolveWith(
                      (states) => Colors.blue, // Selected color
                    );
                  }
                  return Colors.white; // Not selected color
                },
              ),
              checkColor: Colors.white, // Change check mark color
            ),
          ],
        ),
      ),
    );
  }

  void _editTodoDialog(BuildContext context, WidgetRef ref, TodoModel todo) {
    final TextEditingController controller =
        TextEditingController(text: todo.description);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Todo'),
          content: TextField(controller: controller),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
              style: ButtonStyle(
                foregroundColor: MaterialStateColor.resolveWith(
                  (states) => Colors.red, // Set cancel button text color
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                ref
                    .read(todoProvider.notifier)
                    .editTodo(todo.id, controller.text);
                Navigator.of(context).pop();
                showSnackBar(context, "Todo updated successfully");
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateColor.resolveWith(
                  (states) => Colors.blue, // Set save button text color
                ),
              ),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal, // Set snackbar background color
      ),
    );
  }
}
