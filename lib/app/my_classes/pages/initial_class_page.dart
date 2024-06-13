import 'package:asp/asp.dart';
import 'package:class_manager_two/app/comum/my_colors.dart';
import 'package:class_manager_two/app/home_page/atoms/page_status_atoms.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_page_atoms.dart';
import 'package:class_manager_two/app/my_classes/class_routes.dart';
import 'package:class_manager_two/app/my_classes/models/student.dart';
import 'package:class_manager_two/app/my_classes/widgets/student_card_widget.dart';

import 'package:flutter/material.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.select(
      () => {
        classPageAtom,
        pageStatusAtom,
        userDisciplinesAtom,
        userClassesAtom,
        userStudentsAtom,
        classErrorAtom,
        selectedDisciplineAtom,
      },
    );

    selectClass(int classIndex) {
      List<Student> list = userStudentsAtom.value
          .where(
            (element) =>
                element.classes.value?.id ==
                userClassesAtom.value
                    .where((element) => element.discipline
                        .contains(selectedDisciplineAtom.value))
                    .elementAt(classIndex)
                    .id,
          )
          .toList();
      list.isNotEmpty
          ? list.sort((a, b) => a.name.compareTo(b.name))
          : list = [];
      return list;
    }

    return SafeArea(
        child: Container(
      decoration: BoxDecoration(gradient: MyColors().gradientHomePage()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () =>
                          classPageAtom.setValue(ClassPageStatus.ADD_CLASS),
                      child: const Text('Add Class')),
                  TextButton(
                      onPressed: () =>
                          classPageAtom.setValue(ClassPageStatus.SELECT_CLASS),
                      child: const Text('Add Student'))
                ],
              )),
          Flexible(
            flex: 20,
            child: Card(
              margin: const EdgeInsets.all(5),
              color: const Color.fromARGB(
                  255, 26, 3, 68), //   Colors.black.withOpacity(0.3),
              child: ListView.builder(
                itemCount: userClassesAtom.value
                    .where((element) => element.discipline
                        .contains(selectedDisciplineAtom.value))
                    .length,
                itemBuilder: (context, indexC) {
                  return Column(
                    children: [
                      Card(
                          shadowColor: Colors.white,
                          elevation: 10,
                          child: SizedBox(
                              height: 30,
                              width: 150,
                              child: Center(
                                child: ElevatedButton(
                                  onLongPress: () => editClassAction.setValue((
                                    context: context,
                                    editClass: userClassesAtom.value
                                        .where((element) => element.discipline
                                            .contains(
                                                selectedDisciplineAtom.value))
                                        .elementAt(indexC)
                                  )),
                                  onPressed: () {},
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        userClassesAtom.value
                                            .where((element) => element
                                                .discipline
                                                .contains(selectedDisciplineAtom
                                                    .value))
                                            .elementAt(indexC)
                                            .name,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ))),
                      if (selectClass(indexC).isEmpty)
                        const SizedBox(
                          height: 50,
                        ),
                      if (selectClass(indexC).isNotEmpty)
                        SizedBox(
                          height: 350,
                          child: RotatedBox(
                            quarterTurns: -1,
                            child: ListWheelScrollView(
                                diameterRatio: 2,
                                perspective: 0.001,
                                itemExtent: 300,
                                children: List.generate(
                                    userStudentsAtom.value
                                        .where((student) =>
                                            student.classes.value?.name ==
                                            userClassesAtom.value
                                                .where((element) =>
                                                    element.discipline.contains(
                                                        selectedDisciplineAtom
                                                            .value))
                                                .elementAt(indexC)
                                                .name)
                                        .toList()
                                        .length,
                                    (index) => selectClass(indexC).isNotEmpty
                                        ? RotatedBox(
                                            quarterTurns: 1,
                                            child: StudentCardWidget(
                                              index: index,
                                              student:
                                                  selectClass(indexC)[index],
                                              //
                                            ))
                                        : const RotatedBox(
                                            quarterTurns: 1, child: null))),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
