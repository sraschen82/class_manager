import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/my_classes/models/discipline.dart';
import 'package:class_manager_two/app/statistics/charts/chart_histogram.dart';
import 'package:class_manager_two/app/statistics/charts/chart_ogive.dart';
import 'package:flutter/material.dart';

class ChartClassWidget extends StatelessWidget {
  final Discipline discipline;
  final Classes selectedClass;
  const ChartClassWidget(
      {super.key, required this.discipline, required this.selectedClass});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 15,
        color: const Color.fromARGB(255, 26, 3, 68),
        child: SizedBox(
          // height: MediaQuery.of(context).size.height * .7,
          width: MediaQuery.of(context).size.width * .87,
          child: Column(
            children: [
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
                      child: Center(
                        child: Text('Class - ${selectedClass.name}'),
                      ),
                    ),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: selectedClass.student.any((element) =>
                                          element.grades[0] != null)
                                      ? ChartHistogram(
                                          selectedClass: selectedClass,
                                          tri: 0,
                                        )
                                      : null,
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: selectedClass.student.any(
                                      (element) => element.grades[1] != null,
                                    )
                                        ? ChartHistogram(
                                            selectedClass: selectedClass,
                                            tri: 1,
                                          )
                                        : null),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: selectedClass.student.any(
                                    (element) => element.grades[2] != null,
                                  )
                                      ? ChartHistogram(
                                          selectedClass: selectedClass,
                                          tri: 2,
                                        )
                                      : null,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: selectedClass.student.any(
                                    (element) => element.grades[0] != null,
                                  )
                                      ? ChartOgive(
                                          selectedClass: selectedClass,
                                          tri: 0,
                                        )
                                      : null,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: selectedClass.student.any(
                                    (element) => element.grades[1] != null,
                                  )
                                      ? ChartOgive(
                                          selectedClass: selectedClass,
                                          tri: 1,
                                        )
                                      : null,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: selectedClass.student.any(
                                    (element) => element.grades[2] != null,
                                  )
                                      ? ChartOgive(
                                          selectedClass: selectedClass,
                                          tri: 2,
                                        )
                                      : null,
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
