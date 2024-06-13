import 'package:asp/asp.dart';

import 'package:class_manager_two/app/home_page/atoms/page_status_atoms.dart';
import 'package:class_manager_two/app/home_page/home_page_states.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_page_atoms.dart';
import 'package:class_manager_two/app/my_classes/class_routes.dart';
import 'package:flutter/material.dart';

class HpClassesWidget extends StatelessWidget {
  const HpClassesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    context.select(
      () =>
          {userDisciplinesAtom, userClassesAtom, userStudentsAtom, errorHPAtom},
    );
    return Card(
        color: const Color.fromARGB(255, 248, 193, 200),
        child: SizedBox(
          width: 150,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(padding: EdgeInsets.only(left: 25)),
                  const Text(
                    'CLASSES',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  IconButton(
                    style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(50)),
                    onPressed: () {
                      if (userDisciplinesAtom.value.isEmpty) {
                        classPageAtom.setValue(ClassPageStatus.ADD_DISCIPLINE);
                      }
                      pageStatusAtom.setValue(PageStates.CLASSES);
                    },
                    icon: const Icon(Icons.add),
                    alignment: Alignment.centerRight,
                    color: Colors.black,
                    iconSize: 15,
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(5, 2, 2, 10),
                    itemCount: userDisciplinesAtom.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        child: Card(
                          elevation: 15,
                          color: Colors.red[900],
                          borderOnForeground: true,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    ' ${userDisciplinesAtom.value[index].name}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: userClassesAtom.value
                                          .where((element) => element.discipline
                                              .contains(userDisciplinesAtom
                                                  .value[index]))
                                          .length,
                                      itemBuilder:
                                          (BuildContext context, int cIndex) {
                                        return Text(
                                            '- ${userClassesAtom.value.where((element) => element.discipline.contains(userDisciplinesAtom.value[index])).toList()[cIndex].name} (${userStudentsAtom.value.where((element) => element.classes.value?.name == userClassesAtom.value.where((element) => element.discipline.contains(userDisciplinesAtom.value[index])).elementAt(cIndex).name).toList().length})');
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
