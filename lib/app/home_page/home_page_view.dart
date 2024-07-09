import 'package:asp/asp.dart';
import 'package:class_manager_two/app/comum/image_widget.dart';
import 'package:class_manager_two/app/comum/my_colors.dart';
import 'package:class_manager_two/app/home_page/atoms/home_page_atoms.dart';
import 'package:class_manager_two/app/home_page/atoms/page_status_atoms.dart';
import 'package:class_manager_two/app/home_page/widgets/hp_classes_widget.dart';
import 'package:class_manager_two/app/home_page/widgets/hp_notes_widget.dart';
import 'package:class_manager_two/app/home_page/widgets/hp_revaluations_widget.dart';
import 'package:class_manager_two/app/home_page/widgets/hp_schedules_widget.dart';
import 'package:class_manager_two/app/home_page/widgets/hp_statistics_widget.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/notes/atoms/todo_atoms.dart';

import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  void initState() {
    super.initState();
    fetchToTodosAction();
    getCLassesDataAction();
  }

  @override
  Widget build(BuildContext context) {
    context.select(
      () => {imagePathAtom, toDoListAtom, userDisciplinesAtom, errorHPAtom},
    );

    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(gradient: MyColors().gradientAuth()),
        child: SafeArea(
          child: Column(children: [
            Flexible(
              fit: FlexFit.loose,
              flex: 3,
              child: Stack(alignment: Alignment.bottomCenter, children: [
                imageWidget(
                    'assets/image/fundo02.png', 15, Alignment.bottomCenter),

                imageShimmerWidget(
                    'assets/image/nome01.png', 15, Alignment.bottomCenter),
                // imageWidget(
                //     'assets/image/predioPrincipal.jpg', 15, Alignment.center),
                // imageShimmerWidget(
                //     'assets/image/logoMaua1.gif', 15, Alignment.bottomCenter),
              ]),
            ),
            Flexible(
              flex: 8,
              child: Card(
                elevation: 30,
                margin: const EdgeInsets.fromLTRB(2, 5, 2, 2),
                color: Colors.black.withOpacity(0.1),
                child: FractionallySizedBox(
                  heightFactor: 1,
                  widthFactor: 1,
                  child: ListView(
                    children: [
                      const HpSchedulesWidget(),
                      Card(
                        margin: const EdgeInsets.all(10),
                        child: Container(
                          height: 450,
                          decoration: BoxDecoration(
                              gradient: MyColors().gradientHomePage()),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(padding: EdgeInsets.only(top: 5)),
                              Flexible(
                                flex: 1,
                                child: Text(
                                  'My Activities',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Flexible(
                                flex: 8,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: HpClassesWidget(),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: HpStatisticsWidget(),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: HpRevaluationsWidget(),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: HpNotestWidget(),
                                          )
                                        ],
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
