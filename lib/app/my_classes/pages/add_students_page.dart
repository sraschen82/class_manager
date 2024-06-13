import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_page_atoms.dart';
import 'package:class_manager_two/app/my_classes/class_routes.dart';
import 'package:flutter/material.dart';

class AddStudentsPage extends StatefulWidget {
  const AddStudentsPage({super.key});

  @override
  State<AddStudentsPage> createState() => _AddStudentsPageState();
}

class _AddStudentsPageState extends State<AddStudentsPage> {
  bool? addListCase;

  @override
  void initState() {
    super.initState();
    addListCase = false;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();

    void validator(String value) {
      if (value.isNotEmpty) {
        addListCase!
            ? addStudentsByListAction.setValue(value)
            : addStudentsAction.setValue(value);
      }
    }

    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (selectedClassAtom.value != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Add Students - ${selectedClassAtom.value!.name}',
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: nameController,
                maxLines: addListCase! ? 50 : 1,
                minLines: 1,
                autofocus: true,
                textInputAction:
                    addListCase! ? TextInputAction.newline : TextInputAction.go,
                // onFieldSubmitted: (value) {
                //   addListCase!
                //       ? addStudentsByListAction.setValue(value)
                //       : addStudentsAction.setValue(value);
                // },
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
                  prefixIcon: const Icon(Icons.list, color: Colors.white),
                  hoverColor: Colors.white,
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  contentPadding: const EdgeInsets.all(30),
                  hintStyle: const TextStyle(color: Colors.white),
                  label: addListCase!
                      ? const Text('Students List',
                          style: TextStyle(color: Colors.white))
                      : const Text('Student Name',
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
                keyboardType:
                    addListCase! ? TextInputType.multiline : TextInputType.text,
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
                        borderRadius: BorderRadius.all(Radius.circular(10))))),
                onPressed: () {
                  validator(nameController.text);
                  // addListCase!
                  //     ? addStudentsByListAction.setValue(nameController.text)
                  //     : addStudentsAction.setValue(nameController.text);
                },
                child: addListCase!
                    ? const Text('Save Students.')
                    : const Text('Save Student.')),
            TextButton(
                onPressed: () {
                  addListCase!
                      ? setState(() {
                          addListCase = false;
                          FocusManager.instance.primaryFocus?.unfocus();
                        })
                      : setState(() {
                          addListCase = true;
                          FocusManager.instance.primaryFocus?.unfocus();
                        });
                },
                child: addListCase!
                    ? const Text(
                        'Add a single student',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      )
                    : const Text(
                        'Add one list of students',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      )),
            TextButton(
              onPressed: () => classPageAtom.setValue(ClassPageStatus.INICIAL),
              child: const Text(
                'CANCEL',
                style: TextStyle(color: Colors.red),
              ),
            ),
            Divider(color: Colors.white.withOpacity(0)),
            Divider(color: Colors.white.withOpacity(0)),
          ],
        ),
      ),
    );
  }
}
