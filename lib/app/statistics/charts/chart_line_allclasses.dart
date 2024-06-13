// ignore_for_file: must_be_immutable

import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/my_classes/models/discipline.dart';
import 'package:class_manager_two/app/service.dart';
import 'package:class_manager_two/app/statistics/stats_class.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartLineAllClasses extends StatelessWidget {
  final Discipline discipline;
  int tri;
  ChartLineAllClasses({super.key, required this.discipline, required this.tri});

  @override
  Widget build(BuildContext context) {
    List<Color> listColors = [
      const Color.fromARGB(255, 19, 129, 23),
      const Color.fromARGB(255, 198, 201, 52),
      const Color.fromARGB(255, 15, 37, 110),
      const Color.fromARGB(255, 211, 35, 123),
      const Color.fromARGB(255, 252, 250, 252),
      const Color.fromARGB(255, 141, 94, 33),
      const Color.fromARGB(255, 9, 83, 12),
      const Color.fromARGB(255, 199, 128, 22),
      const Color.fromARGB(255, 16, 121, 112),
      const Color.fromARGB(255, 116, 9, 58),
    ];
    List<Classes> classes = getDisciplineClasses(
        discipline: discipline, allClasses: userClassesAtom.value);
    return Card(
      elevation: 15,
      color: const Color.fromARGB(255, 26, 3, 68),
      child: SizedBox(
        height: 350,
        width: 350,
        child: LineChart(
            curve: Curves.decelerate,
            duration: const Duration(seconds: 2),
            LineChartData(
                minY: 0,
                maxY: 100,
                backgroundColor: const Color.fromARGB(255, 163, 13, 3),
                borderData: FlBorderData(
                  border: const Border.fromBorderSide(
                    BorderSide(color: Colors.white, width: 1),
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    axisNameSize: 80,
                    axisNameWidget: RotatedBox(
                      quarterTurns: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < classes.length; i++)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 10,
                                  width: 10,
                                  color: listColors[i],
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: Text(
                                    classes[i].name,
                                    maxLines: 2,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  ),
                  topTitles: AxisTitles(
                      axisNameWidget: Text(
                    '${tri + 1}º TRI - Line chart of all classes',
                  )),
                  bottomTitles: AxisTitles(
                      axisNameSize: 20,
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 2,
                        getTitlesWidget: (value, meta) =>
                            Text('${value.toInt() + 2}'),
                      )),
                ),
                lineBarsData: List.generate(
                    classes.length,
                    (index) => LineChartBarData(
                        isStrokeCapRound: true,
                        barWidth: 4,
                        color: listColors[index],
                        spots: List.generate(
                            5,
                            (indexY) => FlSpot(
                                2.0 * indexY,
                                classes[index]
                                        .student
                                        .where((element) =>
                                            element.grades[tri] != null)
                                        .isEmpty
                                    ? 0
                                    : (Stats.getIntervalFrequency(
                                                selectedClass: classes[index],
                                                tri: tri,
                                                lowerLimit: 2 * indexY) /
                                            (classes[index]
                                                .student
                                                .where((element) =>
                                                    element.grades[tri] != null)
                                                .length) *
                                            100)
                                        .roundToDouble())))))),
      ),
    );
  }
}
