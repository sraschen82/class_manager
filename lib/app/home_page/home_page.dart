import 'package:asp/asp.dart';
import 'package:class_manager_two/app/home_page/atoms/page_status_atoms.dart';
import 'package:class_manager_two/app/home_page/home_page_states.dart';
import 'package:class_manager_two/app/home_page/home_page_view.dart';
import 'package:class_manager_two/app/my_classes/pages/class_switch_page.dart';
import 'package:class_manager_two/app/notes/pages/notes_page.dart';
import 'package:class_manager_two/app/revaluations/revaluations_page.dart';
import 'package:class_manager_two/app/statistics/statistics_page.dart';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.select(
      () => {pageStatusAtom, errorHPAtom},
    );
    return Container(
        child: switch (pageStatusAtom.value) {
      PageStates.INITIAL => const Center(
          child: Text('Initial Page'),
        ),
      PageStates.HOME_PAGE => const HomePageView(),
      PageStates.NOTES => const NotesPage(),
      PageStates.CLASSES => const ClassSwitchPage(),
      PageStates.REVALUATION => const RevaluationPage(),
      PageStates.STATISTICS => const StatisticsPage(),
      PageStates.LOADING => const Center(child: CircularProgressIndicator()),
      PageStates.ERROR => Center(
          child: Card(
              color: Colors.red,
              elevation: 20,
              child: SizedBox(
                  height: 160,
                  width: 200,
                  child: Center(child: Text(errorHPAtom.value))))),
    });
  }
}
