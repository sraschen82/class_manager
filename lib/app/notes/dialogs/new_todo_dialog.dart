import 'package:class_manager_two/app/notes/atoms/todo_atoms.dart';
import 'package:class_manager_two/app/notes/models/todomodel.dart';
import 'package:flutter/material.dart';

Future<void> newToDoDialog(BuildContext context) async {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  return showDialog(
      context: context,
      builder: (context) {
        validateForm() {
          if (titleController.text.isNotEmpty) {
            ToDoModel newToDo = ToDoModel().copyWith(
                id: DateTime.now().microsecondsSinceEpoch,
                title: titleController.text,
                description: descriptionController.text,
                check: false);

            newToDoAtom.setValue(newToDo);

            Navigator.pop(context);
          }
        }

        return AlertDialog(
          title: const Center(child: Text('NEW TO DO')),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      maxLength: 30,
                      showCursor: true,
                      controller: titleController,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Title',
                      ),
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      maxLines: 5,
                      maxLength: 300,
                      showCursor: true,
                      controller: descriptionController,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                          alignLabelWithHint: true, labelText: 'Description'),
                      autofocus: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            TextButton(
              onPressed: () => validateForm(),
              child: const Text('Save'),
            ),
          ],
        );
      });
}
