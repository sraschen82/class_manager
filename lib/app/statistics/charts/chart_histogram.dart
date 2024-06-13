// ignore_for_file: must_be_immutable

import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/statistics/stats_class.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartHistogram extends StatelessWidget {
  Classes selectedClass;
  int tri;
  ChartHistogram({super.key, required this.selectedClass, required this.tri});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * .87,
      width: MediaQuery.of(context).size.width * .87,
      child: BarChart(
        swapAnimationCurve: Curves.decelerate,
        swapAnimationDuration: const Duration(milliseconds: 1000),
        BarChartData(
          minY: 0,
          maxY: 100,
          alignment: BarChartAlignment.center,
          backgroundColor: const Color.fromARGB(255, 163, 13, 3),
          groupsSpace: 0,
          borderData: FlBorderData(
            border: const Border.fromBorderSide(
              BorderSide(color: Colors.white, width: 1),
            ),
          ),
          titlesData: FlTitlesData(
            rightTitles: const AxisTitles(axisNameWidget: Text('')),
            topTitles: AxisTitles(
                axisNameWidget: Text(
              '${tri + 1}º TRI - Student Percentage Histogram',
            )),
            bottomTitles: const AxisTitles(
                axisNameSize: 20,
                axisNameWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 80,
                    ),
                    Text('2'),
                    SizedBox(
                      width: 20,
                    ),
                    Text('4'),
                    SizedBox(
                      width: 20,
                    ),
                    Text('6'),
                    SizedBox(
                      width: 20,
                    ),
                    Text('8'),
                    SizedBox(
                      width: 20,
                    ),
                    Text('10'),
                  ],
                )),
          ),
          barGroups: List.generate(
              5,
              (index) => BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                          toY: selectedClass.student
                                  .where(
                                      (element) => element.grades[tri] != null)
                                  .isEmpty
                              ? 0
                              : (Stats.getIntervalFrequency(
                                          selectedClass: selectedClass,
                                          tri: tri,
                                          lowerLimit: 2 * index) /
                                      (selectedClass.student
                                          .where((element) =>
                                              element.grades[tri] != null)
                                          .length) *
                                      100)
                                  .roundToDouble(),
                          borderRadius: const BorderRadius.vertical(),
                          gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 2, 66, 5),
                                Color.fromARGB(255, 23, 148, 60),
                                Color.fromARGB(255, 29, 224, 88),
                                Color.fromARGB(255, 15, 136, 51),
                                Color.fromARGB(255, 2, 66, 5),
                              ],
                              // begin: Alignment.bottomLeft,
                              // end: Alignment.topCenter,
                              tileMode: TileMode.repeated),
                          borderSide: const BorderSide(
                            strokeAlign: 3,
                            width: 2,
                          ),
                          width: 55),
                    ],
                  )),
        ),
      ),
    );
  }
}
