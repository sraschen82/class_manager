import 'package:asp/asp.dart';
import 'package:class_manager_two/app/comum/my_colors.dart';
import 'package:class_manager_two/app/home_page/atoms/page_status_atoms.dart';
import 'package:class_manager_two/app/home_page/home_page_states.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_page_atoms.dart';
import 'package:class_manager_two/app/my_classes/class_routes.dart';
import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/revaluations/widgets/discipline_widget.dart';
import 'package:class_manager_two/app/service.dart';
import 'package:class_manager_two/app/statistics/widgets/data_analysis.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.select(
      () => {
        userDisciplinesAtom,
        userClassesAtom,
        userStudentsAtom,
        selectedDisciplineAtom,
      },
    );

    List<Classes> classes = getDisciplineClasses(
        discipline: selectedDisciplineAtom.value,
        allClasses: userClassesAtom.value);

    return SafeArea(
        child: Container(
      decoration: BoxDecoration(gradient: MyColors().gradientHomePage()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                            margin: EdgeInsets.only(left: 60),
                            color: Color.fromARGB(255, 163, 13, 3),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'STATISTICS',
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
          userDisciplinesAtom.value.isEmpty
              ? const Text('')
              : disciplineWidget(context, userDisciplinesAtom.value,
                  selectedDisciplineAtom.value!),
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          classes.isNotEmpty
                              ? DataAnalysisWidget(
                                  discipline: selectedDisciplineAtom.value!,
                                  classes: classes)
                              : SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .75,
                                  width:
                                      MediaQuery.of(context).size.width * .97,
                                  child: const Center(
                                    child: Text('No classes registered.'),
                                  ),
                                ),
                          // const ChartsWidget(),
                          const Center(
                            child: Text('Class Manager II'),
                          ),
                          const Center(
                            child: Text('Developed by @sraschen'),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    ));
  }
}
