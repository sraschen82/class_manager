import 'package:asp/asp.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_page_atoms.dart';
import 'package:class_manager_two/app/my_classes/class_routes.dart';

import 'package:flutter/material.dart';

class AddClassPage extends StatelessWidget {
  const AddClassPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    void validator(String value) {
      if (value.isNotEmpty) {
        addClassAction.setValue(value);
      }
    }

    context.select(
      () => {selectedDisciplineAtom},
    );
    return Container(
      alignment: Alignment.center,
      child: selectedDisciplineAtom.value == null
          ? const Center(
              child: Text('Please select one discipline.'),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Text(selectedDisciplineAtom.value!.name),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: nameController,
                    autofocus: true,
                    textInputAction: TextInputAction.send,
                    onFieldSubmitted: (value) => validator(value),
                    cursorColor: Colors.white,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      alignLabelWithHint: true,
                      prefixIcon: const Icon(Icons.school, color: Colors.white),
                      hoverColor: Colors.white,
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      contentPadding: const EdgeInsets.all(30),
                      hintStyle: const TextStyle(color: Colors.white),
                      label: const Text('Class Name',
                          style: TextStyle(color: Colors.white)),
                      border: const OutlineInputBorder(
                        gapPadding: 5,
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                TextButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.blueAccent),
                        elevation: MaterialStatePropertyAll(30),
                        minimumSize: MaterialStatePropertyAll(
                          Size(300, 60),
                        ),
                        maximumSize: MaterialStatePropertyAll(Size(400, 80)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))))),
                    onPressed: () {
                      validator(nameController.text);
                    },
                    child: const Text('Save class.')),
                TextButton(
                  onPressed: () =>
                      classPageAtom.setValue(ClassPageStatus.INICIAL),
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Divider(color: Colors.white.withOpacity(0)),
                Divider(color: Colors.white.withOpacity(0)),
              ],
            ),
    );
  }
}
