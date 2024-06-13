import 'package:asp/asp.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';

import 'package:flutter/widgets.dart';

class ClassHomePage extends StatelessWidget {
  const ClassHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.select(
      () => {userDisciplinesAtom},
    );

    final disciplines = userDisciplinesAtom.value.toList();
    final classes = disciplines.first.classes.toList();
    return Container(
        child: disciplines.isEmpty
            ? const Center(
                child: Text('No registered students.'),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: classes.first.student.toList().length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container();
                }));
  }
}
