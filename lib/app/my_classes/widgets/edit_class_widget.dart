import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/my_classes/widgets/set_class_grade_widget.dart';
import 'package:flutter/material.dart';

Future<void> editClassDialog(BuildContext context, Classes editedClass) async {
  TextEditingController nameController = TextEditingController();

  return showDialog(
      context: context,
      builder: (context) {
        validateForm() {
          Classes newClass = editedClass;
          newClass
            ..id = editedClass.id
            ..name = nameController.text.isEmpty
                ? editedClass.name
                : nameController.text;

          selectedDisciplineAtom.setValue(newClass.discipline.first);
          sendClassToEditAtom.setValue(newClass);
          Navigator.pop(context);
        }

        return AlertDialog(
          title: Center(child: Text('CLASS ${editedClass.name}')),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onTap: () => nameController.text = editedClass.name,
                      maxLength: 30,
                      showCursor: true,
                      controller: nameController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Edit Name',
                        hintText: editedClass.name,
                      ),
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ),
                const Divider(
                  height: 20,
                ),
                Column(
                  children: [
                    const Text('Set Grades',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          style: const ButtonStyle(
                              side: MaterialStatePropertyAll(BorderSide(
                                  color: Colors.black,
                                  strokeAlign: 2,
                                  width: 1)),
                              elevation: MaterialStatePropertyAll(30),
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 231, 32, 32))),
                          onPressed: () async {
                            setClassGradeDialog(context, editedClass, 0, 0);
                          },
                          child: const Text('1º TRI'),
                        ),
                        TextButton(
                          style: const ButtonStyle(
                              side: MaterialStatePropertyAll(BorderSide(
                                  color: Colors.black,
                                  strokeAlign: 2,
                                  width: 1)),
                              elevation: MaterialStatePropertyAll(30),
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 231, 32, 32))),
                          onPressed: () async {
                            setClassGradeDialog(context, editedClass, 1, 0);
                          },
                          child: const Text('2º TRI'),
                        ),
                        TextButton(
                          style: const ButtonStyle(
                              side: MaterialStatePropertyAll(BorderSide(
                                  color: Colors.black,
                                  strokeAlign: 2,
                                  width: 1)),
                              elevation: MaterialStatePropertyAll(30),
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 231, 32, 32))),
                          onPressed: () async {
                            setClassGradeDialog(context, editedClass, 2, 0);
                          },
                          child: const Text('3º TRI'),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(
                  height: 40,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.red[800])),
                  onPressed: () {
                    deleteClassAction.setValue(editedClass);

                    Navigator.pop(context);
                  },
                  child: Text(
                    'Delete ${editedClass.name}',
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  nameController.text = editedClass.name;
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
