import 'package:asp/asp.dart';
import 'package:class_manager_two/app/comum/my_colors.dart';
import 'package:class_manager_two/app/comum/pdf/pdf_class_report_preview.dart';
import 'package:class_manager_two/app/home_page/atoms/page_status_atoms.dart';
import 'package:class_manager_two/app/home_page/home_page_states.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_page_atoms.dart';
import 'package:class_manager_two/app/my_classes/class_routes.dart';
import 'package:class_manager_two/app/revaluations/widgets/discipline_widget.dart';
import 'package:class_manager_two/app/revaluations/widgets/empty_revaluations_widget.dart';
import 'package:class_manager_two/app/revaluations/widgets/final_reevaluation_widget.dart';
import 'package:class_manager_two/app/revaluations/widgets/final_results.dart';
import 'package:class_manager_two/app/revaluations/widgets/students_in_revaluation_widget.dart';
import 'package:flutter/material.dart';

class RevaluationPage extends StatefulWidget {
  const RevaluationPage({super.key});

  @override
  State<RevaluationPage> createState() => _RevaluationPageState();
}

class _RevaluationPageState extends State<RevaluationPage> {
  @override
  void initState() {
    super.initState();
    if (userDisciplinesAtom.value.isNotEmpty) {
      selectedDisciplineAtom.setValue(
          selectedDisciplineAtom.value ?? userDisciplinesAtom.value.first);
    }
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

    checkStudentsInRevaluation(int trim) {
      bool haveStundent = false;
      if (userStudentsAtom.value
              .where((element) => element.grades.elementAt(trim) != null)
              .isNotEmpty &&
          userStudentsAtom.value.any((element) =>
              element.grades.elementAt(trim) != null &&
              element.grades.elementAt(trim)! < 6)) {
        haveStundent = true;
      }

      return haveStundent;
    }

    return SafeArea(
        child: Container(
      decoration: BoxDecoration(gradient: MyColors().gradientHomePage()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Center(
                        child: Card(
                            elevation: 15,
                            margin: EdgeInsets.only(left: 10),
                            color: Color.fromARGB(255, 163, 13, 3),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'RE-EVALUATIONS',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ))),
                    IconButton(
                      onPressed: () {
                        pageStatusAtom.setValue(PageStates.HOME_PAGE);
                        classPageAtom.setValue(ClassPageStatus.INICIAL);
                      },
                      icon: const Icon(Icons.home),
                    ),
                  ],
                ),
              )),
          const Divider(
            height: 10,
          ),
          userDisciplinesAtom.value.isNotEmpty
              ? disciplineWidget(context, userDisciplinesAtom.value,
                  selectedDisciplineAtom.value!)
              : const Text(''),
          Flexible(
            flex: 20,
            child: userDisciplinesAtom.value.isEmpty
                ? Card(
                    color: Colors.black.withOpacity(0.3),
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * .75,
                        width: MediaQuery.of(context).size.width * .97,
                        child:
                            const Center(child: Text('No data recorded yet.'))))
                : Card(
                    color: Colors.black.withOpacity(0.3),
                    child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        addAutomaticKeepAlives: true,
                        itemExtentBuilder: (index, dimensions) =>
                            dimensions.viewportMainAxisExtent,
                        itemBuilder: (context, trim) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (trim != 3 &&
                                  trim != 4 &&
                                  !checkStudentsInRevaluation(trim))
                                emptyRevaluationsWidget(trim, context),
                              if (trim != 3 &&
                                  trim != 4 &&
                                  checkStudentsInRevaluation(trim))
                                studentsInRevaluationWidget(trim, context),
                              if (trim == 3) finalRevaluationWidget(context),
                              if (trim == 4)
                                FinalResults(
                                  context: context,
                                ),
                            ],
                          );
                        }),
                  ),
          ),
        ],
      ),
    ));
  }
}
