import 'package:class_manager_two/app/notes/atoms/todo_atoms.dart';
import 'package:class_manager_two/app/notes/models/todomodel.dart';
import 'package:flutter/material.dart';

Future<void> editToDoDialog(BuildContext context, ToDoModel toDo) async {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  return showDialog(
      context: context,
      builder: (context) {
        validateForm() {
          ToDoModel newToDo = ToDoModel().copyWith(
              id: toDo.id,
              title: titleController.text.isEmpty
                  ? toDo.title
                  : titleController.text,
              description: descriptionController.text,
              check: false);

          final List<ToDoModel> inList = [];
          inList.addAll(toDoListAtom.value);
          inList.removeWhere((element) => element.id == toDo.id);

          inList.insert(
              toDoListAtom.value.indexWhere((element) => element.id == toDo.id),
              newToDo);

          toDoListAtom.setValue(inList);

          Navigator.pop(context);
        }

        return AlertDialog(
          title: const Center(child: Text('EDIT TO DO')),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onTap: () => titleController.text = toDo.title,
                      maxLength: 30,
                      showCursor: true,
                      controller: titleController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Edit Title',
                        hintText: toDo.title.toString(),
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
                      onTap: () =>
                          descriptionController.text = toDo.description ?? '',
                      maxLines: 5,
                      maxLength: 300,
                      showCursor: true,
                      controller: descriptionController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Edit Description',
                        hintText: toDo.description.toString(),
                      ),
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
