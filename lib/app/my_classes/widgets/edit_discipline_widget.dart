import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/models/discipline.dart';
import 'package:flutter/material.dart';

Future<void> editDisciplineDialog(
    BuildContext context, Discipline discipline) async {
  TextEditingController nameController = TextEditingController();

  return showDialog(
      context: context,
      builder: (context) {
        validateForm() {
          Discipline newDiscipline = Discipline()
            ..id = discipline.id
            ..name = nameController.text.isEmpty
                ? discipline.name
                : nameController.text;

          sendDisciplineToEditAtom.setValue(newDiscipline);

          Navigator.pop(context);
        }

        return AlertDialog(
          title: const Center(child: Text('EDIT DISCIPLINE')),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onTap: () => nameController.text = discipline.name,
                      maxLength: 30,
                      showCursor: true,
                      controller: nameController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Edit Name',
                        hintText: discipline.name,
                      ),
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ),
                const Divider(
                  height: 20,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.red[800])),
                  onPressed: () {
                    deleteDisciplineAction.setValue(discipline);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Delete ${discipline.name}',
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  nameController.text = discipline.name;
                  validateForm();
                },
                child: const Text('Cancel')),
            TextButton(
              onPressed: () => validateForm(),
              child: const Text('Save'),
            ),
          ],
        );
      });
}
