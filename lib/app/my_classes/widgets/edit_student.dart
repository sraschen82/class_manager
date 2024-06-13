import 'package:asp/asp.dart';
import 'package:class_manager_two/app/home_page/atoms/page_status_atoms.dart';
import 'package:class_manager_two/app/home_page/home_page_states.dart';

import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_page_atoms.dart';
import 'package:class_manager_two/app/my_classes/class_routes.dart';
import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/my_classes/models/student.dart';
import 'package:class_manager_two/app/my_classes/widgets/set_grade_dialog.dart';
import 'package:flutter/material.dart';

class EditStudentWidget extends StatefulWidget {
  const EditStudentWidget({super.key});

  @override
  State<EditStudentWidget> createState() => _EditStudentWidgetState();
}

class _EditStudentWidgetState extends State<EditStudentWidget> {
  List<double?> grades = [];
  List<double?> revaluations = [];
  bool isGrade = true;
  double? finalRevaluationGrade;

  @override
  void initState() {
    super.initState();
    grades = [];
    grades.addAll(selectedStudentAtom.value.grades);
    revaluations = [];
    revaluations.addAll(selectedStudentAtom.value.revaluations);
    finalRevaluationGrade = selectedStudentAtom.value.finalRevaluation;
  }

  @override
  Widget build(BuildContext context) {
    context.select(() => [
          editStudentAction,
          selectedStudentAtom,
          userClassesAtom,
        ]);

    TextEditingController nameController = TextEditingController();

    Classes? newClass;

    TextEditingController finalRevaluationController = TextEditingController();

    validateForm() async {
      Student newStudent = Student()
        ..id = selectedStudentAtom.value.id
        ..name = nameController.text.isEmpty
            ? selectedStudentAtom.value.name
            : nameController.text
        ..classes.value = newClass ?? selectedStudentAtom.value.classes.value
        ..grades = selectedStudentAtom.value.grades //grades
        ..revaluations =
            selectedStudentAtom.value.revaluations // ?? revaluations
        ..user.value = selectedStudentAtom.value.user.value
        ..finalRevaluation = finalRevaluationGrade;

      editStudentAction.setValue(newStudent);
    }

    validateFinalGrade(String stringValue) async {
      if (stringValue.isNotEmpty) {
        stringValue = stringValue.replaceAll(',', '.');

        try {
          setState(() {
            double grade = double.parse(stringValue);
            if (grade <= 10 && grade >= 0) {
              finalRevaluationGrade = grade;
              selectedStudentAtom.value.finalRevaluation = grade;
            } else {
              classErrorAtom.setValue('Only grades between 0 and 10.');
              classPageAtom.setValue(ClassPageStatus.ERROR);
              // await Future.delayed(const Duration(seconds: 5));
              pageStatusAtom.setValue(PageStates.CLASSES);

              selectedStudentAtom.setValue(selectedStudentAtom.value);
              classPageAtom.setValue(ClassPageStatus.EDIT_STUDENT);
            }
          });

          backToEdictStudentAtom.setValue(true);
          validateForm();
        } catch (e) {
          classErrorAtom.setValue(e.toString());
          classPageAtom.setValue(ClassPageStatus.ERROR);
          await Future.delayed(const Duration(seconds: 5));
          pageStatusAtom.setValue(PageStates.CLASSES);

          selectedStudentAtom.setValue(selectedStudentAtom.value);
          classPageAtom.setValue(ClassPageStatus.EDIT_STUDENT);
        }
      }
    }

    Widget gradesWidget(
        String text, int index, List<double?> type, bool isGrade) {
      return Column(
        children: [
          Text(text),
          Row(
            children: [
              type[index] == null
                  ? IconButton(
                      style: const ButtonStyle(
                        side: MaterialStatePropertyAll(BorderSide(
                            color: Colors.black, strokeAlign: 3, width: 1)),
                        elevation: MaterialStatePropertyAll(30),
                      ),
                      onPressed: () async {
                        await setGradeDialog(
                            context, selectedStudentAtom.value, index, isGrade);
                      },
                      icon: const Icon(Icons.upload_outlined))
                  : TextButton(
                      style: ButtonStyle(
                          side: const MaterialStatePropertyAll(BorderSide(
                              color: Colors.black, strokeAlign: 2, width: 1)),
                          elevation: const MaterialStatePropertyAll(30),
                          backgroundColor: isGrade
                              ? selectedStudentAtom.value.grades[index] != null &&
                                      selectedStudentAtom.value.grades[index]! >=
                                          6
                                  ? const MaterialStatePropertyAll(Colors.blue)
                                  : const MaterialStatePropertyAll(
                                      Color.fromARGB(255, 231, 32, 32))
                              : selectedStudentAtom.value.revaluations[0] != null &&
                                      selectedStudentAtom
                                              .value.revaluations[index]! >=
                                          6
                                  ? const MaterialStatePropertyAll(Colors.blue)
                                  : const MaterialStatePropertyAll(
                                      Color.fromARGB(255, 231, 32, 32))),
                      onPressed: () async {
                        await setGradeDialog(
                            context, selectedStudentAtom.value, index, isGrade);
                      },
                      child: isGrade
                          ? Text(selectedStudentAtom.value.grades[index]
                              .toString())
                          : Text(selectedStudentAtom.value.revaluations[index]
                              .toString()))
            ],
          )
        ],
      );
    }

    Widget finalGrades(int index) {
      return Column(
        children: [
          Text('${index + 1}º TRI'),
          selectedStudentAtom.value.revaluations[index] != null
              ? selectedStudentAtom.value.grades[index]! < 6 &&
                      selectedStudentAtom.value.grades[index]! <
                          selectedStudentAtom.value.revaluations[index]!
                  ? Text('${selectedStudentAtom.value.revaluations[index]}')
                  : selectedStudentAtom.value.grades[index]! >= 6
                      ? const Text('')
                      : Text('${selectedStudentAtom.value.grades[index]}')
              : const Text(''),
        ],
      );
    }

    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                selectedStudentAtom.value.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              elevation: 5,
              color: Colors.red[800],
              shadowColor: Colors.white,
              surfaceTintColor: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onTap: () =>
                      nameController.text = selectedStudentAtom.value.name,
                  maxLength: 30,
                  showCursor: true,
                  controller: nameController,
                  keyboardType: TextInputType.none,
                  cursorColor: Colors.white,
                  style: const TextStyle(
                      decorationStyle: TextDecorationStyle.solid,
                      decorationColor: Color.fromARGB(255, 233, 219, 219),
                      color: Colors.white,
                      wordSpacing: 2),
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'Edit Name',
                    fillColor: Colors.white,
                    hintText: selectedStudentAtom.value.name,
                    hintStyle: const TextStyle(
                        fontSize: 20.0,
                        color: Color.fromARGB(255, 255, 254, 254)),
                    floatingLabelStyle: const TextStyle(color: Colors.white),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                ),
              ),
            ),
            Card(
                elevation: 5,
                color: Colors.red[900],
                shadowColor: Colors.white,
                surfaceTintColor: Colors.black,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(8, 20, 8, 30),
                          child: Text(
                            'Change Class.',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        GridView.builder(
                          itemCount: userClassesAtom.value.length,
                          addAutomaticKeepAlives: true,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: .718,
                                  crossAxisSpacing: 10,
                                  mainAxisExtent: 50),
                          itemBuilder: (context, index) {
                            return ElevatedButton(
                                onPressed: () {
                                  newClass = userClassesAtom.value[index];
                                  selectedStudentAtom.value.classes.value =
                                      userClassesAtom.value[index];
                                  setState(() {
                                    selectedStudentAtom.value.classes.value =
                                        userClassesAtom.value[index];
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor: userClassesAtom
                                              .value[index].id ==
                                          selectedStudentAtom
                                              .value.classes.value?.id
                                      ? const MaterialStatePropertyAll(
                                          Colors.blue)
                                      : const MaterialStatePropertyAll(
                                          Color.fromARGB(255, 240, 122, 122)),
                                ),
                                child: Text(userClassesAtom.value[index].name));
                          },
                        )
                      ],
                    ))),
            Card(
              elevation: 5,
              color: Colors.red[800],
              shadowColor: Colors.white,
              surfaceTintColor: Colors.black,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 15),
                            child: Text('Grades',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            gradesWidget('1º TRI', 0,
                                selectedStudentAtom.value.grades, true),
                            gradesWidget('2º TRI', 1,
                                selectedStudentAtom.value.grades, true),
                            gradesWidget('3º TRI', 2,
                                selectedStudentAtom.value.grades, true),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            Card(
              elevation: 5,
              color: Colors.red[800],
              shadowColor: Colors.white,
              surfaceTintColor: Colors.black,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 15),
                            child: Text('Revaluations',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            selectedStudentAtom.value.grades[0] == null ||
                                    selectedStudentAtom.value.grades[0]! >= 6
                                ? const Text('')
                                : gradesWidget(
                                    '1º TRI',
                                    0,
                                    selectedStudentAtom.value.revaluations,
                                    false),
                            selectedStudentAtom.value.grades[1] == null ||
                                    selectedStudentAtom.value.grades[1]! >= 6
                                ? const Text('')
                                : gradesWidget(
                                    '1º TRI',
                                    1,
                                    selectedStudentAtom.value.revaluations,
                                    false),
                            selectedStudentAtom.value.grades[2] == null ||
                                    selectedStudentAtom.value.grades[2]! >= 6
                                ? const Text('')
                                : gradesWidget(
                                    '1º TRI',
                                    2,
                                    selectedStudentAtom.value.revaluations,
                                    false),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            if (revaluations.any((element) => element != null && element < 6))
              Card(
                elevation: 5,
                color: Colors.red[800],
                shadowColor: Colors.white,
                surfaceTintColor: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 15),
                          child: Text('Final Revaluation',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold))),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            finalGrades(0),
                            finalGrades(1),
                            finalGrades(2),
                            if (finalRevaluationGrade != null)
                              Card(
                                elevation: 15,
                                surfaceTintColor: Colors.black,
                                shape: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(strokeAlign: 2),
                                ),
                                color: finalRevaluationGrade! < 6
                                    ? Colors.amber
                                    : Colors.blueAccent,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      const Text('Final'),
                                      Text('$finalRevaluationGrade'),
                                    ],
                                  ),
                                ),
                              )
                          ]),
                      const Divider(
                        height: 15,
                      ),
                      SizedBox(
                        width: 120,
                        child: TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.send,
                          onTap: () => validateFinalGrade(
                              finalRevaluationController.text),
                          maxLines: 1,
                          maxLength: 3,
                          showCursor: true,
                          controller: finalRevaluationController,
                          cursorColor: Colors.white,
                          onSubmitted: (value) {
                            validateFinalGrade(value);
                          },
                          style: const TextStyle(
                              decorationStyle: TextDecorationStyle.solid,
                              decorationColor:
                                  Color.fromARGB(255, 233, 219, 219),
                              color: Colors.white,
                              wordSpacing: 2),
                          decoration: const InputDecoration(
                              alignLabelWithHint: true,
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              labelText: 'Final Grade',
                              fillColor: Colors.white,
                              counterStyle: TextStyle(color: Colors.white),
                              floatingLabelStyle:
                                  TextStyle(color: Colors.white),
                              contentPadding: EdgeInsets.all(5),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.white,
                              )),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.white,
                                ),
                                gapPadding: 4,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 120,
                      )
                    ],
                  ),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      pageStatusAtom.setValue(PageStates.CLASSES);
                      classPageAtom.setValue(ClassPageStatus.INICIAL);
                    },
                    child: const Text(
                      'Cancel',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                TextButton(
                  onPressed: () async {
                    await validateForm();
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
