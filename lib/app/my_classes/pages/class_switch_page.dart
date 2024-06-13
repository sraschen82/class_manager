import 'package:asp/asp.dart';
import 'package:class_manager_two/app/comum/my_colors.dart';
import 'package:class_manager_two/app/home_page/atoms/page_status_atoms.dart';
import 'package:class_manager_two/app/home_page/home_page_states.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_page_atoms.dart';
import 'package:class_manager_two/app/my_classes/class_routes.dart';
import 'package:class_manager_two/app/my_classes/pages/add_class_page.dart';
import 'package:class_manager_two/app/my_classes/pages/add_discipline_page.dart';
import 'package:class_manager_two/app/my_classes/pages/add_students_page.dart';
import 'package:class_manager_two/app/my_classes/pages/class_home_page.dart';
import 'package:class_manager_two/app/my_classes/pages/initial_class_page.dart';
import 'package:class_manager_two/app/my_classes/pages/select_class_page.dart';
import 'package:class_manager_two/app/my_classes/widgets/edit_student.dart';

import 'package:flutter/material.dart';

class ClassSwitchPage extends StatefulWidget {
  const ClassSwitchPage({super.key});

  @override
  State<ClassSwitchPage> createState() => _ClassSwitchPageState();
}

class _ClassSwitchPageState extends State<ClassSwitchPage> {
  @override
  Widget build(BuildContext context) {
    context.select(
      () => {
        classPageAtom,
        pageStatusAtom,
        userDisciplinesAtom,
        classErrorAtom,
        selectedDisciplineAtom
      },
    );

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(gradient: MyColors().gradientHomePage()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Card(
                        elevation: 20,
                        margin: const EdgeInsets.only(left: 120),
                        color: Colors.black.withOpacity(0),
                        child: const Text(
                          'MY CLASSES',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          pageStatusAtom.setValue(PageStates.HOME_PAGE);
                          classPageAtom.setValue(ClassPageStatus.INICIAL);
                        },
                        icon: const Icon(Icons.home),
                      ),
                      IconButton(
                        onPressed: () => clearDiscilinesAction(),
                        icon: const Icon(
                          Icons.folder_delete,
                          semanticLabel: 'Discipline',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      userDisciplinesAtom.value.isEmpty
                          ? Card(
                              surfaceTintColor: Colors.amber,
                              semanticContainer: true,
                              elevation: 10,
                              margin: const EdgeInsets.only(left: 120),
                              color: Colors.black.withOpacity(0),
                              child: const Text('No discipline registered.'))
                          : SizedBox(
                              height: 30,
                              width: MediaQuery.of(context).size.width * 0.87,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: userDisciplinesAtom.value.length,
                                itemBuilder: (BuildContext context, index) {
                                  return ElevatedButton(
                                    style: ButtonStyle(
                                      elevation:
                                          const MaterialStatePropertyAll(10),
                                      backgroundColor: selectedDisciplineAtom
                                                  .value!.id ==
                                              userDisciplinesAtom
                                                  .value[index].id
                                          ? const MaterialStatePropertyAll(
                                              Color.fromARGB(255, 65, 53, 229))
                                          : MaterialStatePropertyAll(
                                              Colors.red[600]),
                                    ),
                                    onPressed: () {
                                      selectedDisciplineAtom.setValue(
                                          userDisciplinesAtom.value[index]);
                                    },
                                    onLongPress: () {
                                      editDisciplineAction.setValue((
                                        context: context,
                                        discipline:
                                            userDisciplinesAtom.value[index]
                                      ));
                                    },
                                    child: Text(
                                      userDisciplinesAtom.value[index].name,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                                },
                              ),
                            ),
                      IconButton(
                          alignment: Alignment.centerRight,
                          onPressed: () => classPageAtom
                              .setValue(ClassPageStatus.ADD_DISCIPLINE),
                          icon: const Icon(Icons.add))
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 14,
              child: Card(
                margin: const EdgeInsets.all(5),
                color: Colors.black.withOpacity(0.3),
                child: Container(
                  child: switch (classPageAtom.value) {
                    ClassPageStatus.INICIAL =>
                      const Center(child: InitialPage()),
                    ClassPageStatus.LOADING => const Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      )),
                    ClassPageStatus.CLASS_PAGE => const ClassHomePage(),
                    ClassPageStatus.ADD_CLASS => const AddClassPage(),
                    ClassPageStatus.SELECT_CLASS => const SelectClassPage(),
                    ClassPageStatus.ADD_DISCIPLINE => const AddDiscipliePage(),
                    ClassPageStatus.ADD_STUDENTS => const AddStudentsPage(),
                    ClassPageStatus.EDIT_STUDENT => const EditStudentWidget(),
                    ClassPageStatus.ERROR => Center(
                        child: Card(
                            color: Colors.red,
                            elevation: 20,
                            child: SizedBox(
                                height: 160,
                                width: 200,
                                child:
                                    Center(child: Text(classErrorAtom.value)))),
                      ),
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
