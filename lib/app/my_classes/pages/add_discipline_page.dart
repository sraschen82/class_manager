import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:flutter/material.dart';

class AddDiscipliePage extends StatelessWidget {
  const AddDiscipliePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    void validator(String value) {
      if (value.length > 2) {
        addDisciplineAction.setValue(value);
      }
    }

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: nameController,
              autofocus: true,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) => validator(value),
              cursorColor: Colors.white,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null) {
                  return 'Please enter some text';
                } else if (value.length < 3) {
                  return 'Name short';
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
                prefixIcon: const Icon(Icons.add_card, color: Colors.white),
                hoverColor: Colors.white,
                errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                contentPadding: const EdgeInsets.all(30),
                // hintText: '  Nestor Raschen',
                hintStyle: const TextStyle(color: Colors.white),
                label: const Text('Discipline Name',
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
                  backgroundColor: MaterialStatePropertyAll(Colors.blueAccent),
                  elevation: MaterialStatePropertyAll(30),
                  minimumSize: MaterialStatePropertyAll(
                    Size(300, 60),
                  ),
                  maximumSize: MaterialStatePropertyAll(Size(400, 80)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))))),
              onPressed: () {
                validator(nameController.text);
                // if (nameController.text.length > 3) {
                //   addDisciplineAction.setValue(nameController.text);
                // }
              },
              child: const Text('Create Discilpine')),
          Divider(color: Colors.white.withOpacity(0)),
          Divider(color: Colors.white.withOpacity(0)),
        ],
      ),
    );
  }
}
