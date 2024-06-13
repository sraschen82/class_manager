import 'package:asp/asp.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_page_atoms.dart';
import 'package:class_manager_two/app/my_classes/class_routes.dart';

import 'package:flutter/material.dart';

class SelectClassPage extends StatelessWidget {
  const SelectClassPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.select(
      () => {
        classPageAtom,
        userClassesAtom,
      },
    );

    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(8, 20, 8, 30),
              child: Text('Select one class to add Students.'),
            ),
            if (userClassesAtom.value.isNotEmpty)
              SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .65,
                  child: GridView.builder(
                    itemCount: userClassesAtom.value.length,
                    addAutomaticKeepAlives: true,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 10,
                            childAspectRatio: .718,
                            crossAxisSpacing: 10,
                            mainAxisExtent: 50),
                    itemBuilder: (context, index) {
                      return ElevatedButton(
                          onPressed: () {
                            selectedClassAtom
                                .setValue(userClassesAtom.value[index]);
                            classPageAtom
                                .setValue(ClassPageStatus.ADD_STUDENTS);
                          },
                          style: const ButtonStyle(
                              fixedSize:
                                  MaterialStatePropertyAll(Size(10, 17))),
                          child: Text(userClassesAtom.value[index].name));
                    },
                  ),
                ),
              )
            else
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                child: const Text('First, let\'s create a class!'),
                onEnd: () => classPageAtom.setValue(ClassPageStatus.ADD_CLASS),
              ),
          ],
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () =>
                    classPageAtom.setValue(ClassPageStatus.ADD_CLASS),
                style: const ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(Size(180, 50)),
                  elevation: MaterialStatePropertyAll(30),
                ),
                child: const Text('NEW CLASS'),
              ),
            ))
      ],
    );
  }
}
