import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/my_classes/models/discipline.dart';
import 'package:class_manager_two/app/statistics/widgets/charts_widget.dart';
import 'package:class_manager_two/app/statistics/widgets/tables_widget.dart';
import 'package:flutter/material.dart';

class DataAnalysisWidget extends StatefulWidget {
  final Discipline discipline;
  final List<Classes> classes;
  const DataAnalysisWidget(
      {super.key, required this.discipline, required this.classes});

  @override
  State<DataAnalysisWidget> createState() => _DataAnalysisWidgetState();
}

class _DataAnalysisWidgetState extends State<DataAnalysisWidget> {
  bool isTables = true;
  @override
  void initState() {
    super.initState();
    isTables = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Classes> classes = widget.classes;

    return Card(
        elevation: 15,
        color: const Color.fromARGB(255, 163, 13, 3),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isTables
                        ? Text(
                            'Data analysis - ${widget.discipline.name}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        : Text(
                            'Charts - ${widget.discipline.name}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isTables = !isTables;
                          });
                        },
                        icon: const Icon(Icons.swap_horiz_sharp))
                  ],
                ),
              ),
            ),
            if (classes.any((element) => element.student.isNotEmpty))
              isTables ? TablesWidget(classes: classes) : const ChartsWidget()
          ],
        ));
  }
}
