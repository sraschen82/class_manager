// ignore_for_file: must_be_immutable

import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/statistics/stats_class.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartOgive extends StatelessWidget {
  Classes selectedClass;
  int tri;
  ChartOgive({super.key, required this.selectedClass, required this.tri});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            rightTitles: const AxisTitles(axisNameWidget: Text('')),
            topTitles: AxisTitles(
                axisNameWidget: Text(
              '${tri + 1}º TRI - Student Percentage Ogive',
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
          lineBarsData: [
            LineChartBarData(
                barWidth: 2,
                color: const Color.fromARGB(255, 4, 58, 6),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 2, 66, 5),
                        Color.fromARGB(255, 23, 148, 60),
                        Color.fromARGB(255, 29, 224, 88),
                        Color.fromARGB(255, 15, 136, 51),
                        Color.fromARGB(255, 3, 48, 5),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      tileMode: TileMode.repeated),
                ),
                spots: List.generate(
                    6,
                    (indexY) => FlSpot(
                          2.0 * indexY - 2,
                          selectedClass.student
                                  .where(
                                      (element) => element.grades[tri] != null)
                                  .isEmpty
                              ? 0
                              : (Stats.getCumulativeFrequency(
                                          selectedClass: selectedClass,
                                          tri: tri,
                                          lowerLimit: 2 * indexY - 2) /
                                      (selectedClass.student
                                          .where((element) =>
                                              element.grades[tri] != null)
                                          .length) *
                                      100)
                                  .roundToDouble(),
                        )))
          ],
        ),
      ),
    );
  }
}
