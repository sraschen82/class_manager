import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/statistics/tables/table_average.dart';
import 'package:class_manager_two/app/statistics/tables/table_cv.dart';
import 'package:class_manager_two/app/statistics/tables/table_reev.dart';
import 'package:class_manager_two/app/statistics/tables/table_reev_analysis.dart';
import 'package:class_manager_two/app/statistics/tables/table_stdev.dart';
import 'package:class_manager_two/app/statistics/widgets/freq_distrib_widget.dart';
import 'package:flutter/material.dart';

class TablesWidget extends StatelessWidget {
  const TablesWidget({
    super.key,
    required this.classes,
  });

  final List<Classes> classes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: ReEvaluationsTable(classes: classes, tri: 0),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ReEvaluationsTable(classes: classes, tri: 1),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ReEvaluationsTable(classes: classes, tri: 2),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: AverageTable(classes: classes),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: stDevTable(classes),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: cvTable(classes),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(8, 20, 8, 0),
          child: Center(
            child: Text('Frequency Distribution Table'),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: FrequencyDistributionWidget(
                  tri: 0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: FrequencyDistributionWidget(
                  tri: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: FrequencyDistributionWidget(
                  tri: 2,
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(8, 10, 8, 8),
          child: Text(
            'Analysis of students in re-evaluation',
            style: TextStyle(color: Colors.white),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: ReEvaluationsAnalysisTable(classes: classes, tri: 0),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ReEvaluationsAnalysisTable(classes: classes, tri: 1),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ReEvaluationsAnalysisTable(classes: classes, tri: 2),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
