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
    // fetchSchedulesAction();
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
                    'assets/image/predioPrincipal.jpg', 15, Alignment.center),
                imageShimmerWidget(
                    'assets/image/logoMaua1.gif', 15, Alignment.bottomCenter),
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


// Schedules ------------------------------------------------

// Card(
                      //   elevation: 30,
                      //   color: color4,
                      //   child: Container(
                      //     width: double.maxFinite,
                      //     decoration: BoxDecoration(
                      //         gradient: MyColors().gradientHomePage()),
                      //     child: Column(
                      //       children: [
                      //         if (imagePathAtom.value == null)
                      //           Column(
                      //             children: [
                      //               const Text(
                      //                 'My Schedules',
                      //                 style: TextStyle(fontSize: 20),
                      //               ),
                      //               IconButton(
                      //                 onPressed: () => uploadSchedulesAction(),
                      //                 icon: const Icon(Icons.upload),
                      //                 iconSize: 15,
                      //               ),
                      //             ],
                      //           ),
                      //         if (imagePathAtom.value != null)
                      //           Card(
                      //               elevation: 30,
                      //               shadowColor: Colors.black,
                      //               child: GestureDetector(
                      //                 onLongPress: () =>
                      //                     uploadSchedulesAction(),
                      //                 child: InteractiveViewer(
                      //                   minScale: 0.1,
                      //                   maxScale: 1.6,
                      //                   child: Image.file(
                      //                     File(imagePathAtom.value!),
                      //                     fit: BoxFit.cover,
                      //                     filterQuality: FilterQuality.high,
                      //                   ),
                      //                 ),
                      //               )),
                      //         if (imagePathAtom.value != null)
                      //           SizedBox(
                      //             height: 15,
                      //             child: Row(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceAround,
                      //               children: [
                      //                 IconButton(
                      //                   onPressed: () =>
                      //                       uploadSchedulesAction(),
                      //                   icon: const Icon(Icons.upload),
                      //                   iconSize: 15,
                      //                 ),
                      //                 IconButton(
                      //                   onPressed: () =>
                      //                       deleteSchedulesAction(),
                      //                   icon: const Icon(Icons.delete),
                      //                   iconSize: 15,
                      //                 ),
                      //               ],
                      //             ),
                      //           )
                      //       ],
                      //     ),
                      //   ),
                      // ),



//Classes ---------------------------------------------------

// Card(
                                            //     color: const Color.fromARGB(
                                            //         255, 248, 193, 200),
                                            //     child: SizedBox(
                                            //       width: 150,
                                            //       child: Column(
                                            //         children: [
                                            //           Row(
                                            //             mainAxisAlignment:
                                            //                 MainAxisAlignment
                                            //                     .spaceBetween,
                                            //             children: [
                                            //               const Padding(
                                            //                   padding: EdgeInsets
                                            //                       .only(
                                            //                           left:
                                            //                               25)),
                                            //               const Text(
                                            //                 'CLASSES',
                                            //                 textAlign: TextAlign
                                            //                     .center,
                                            //                 style: TextStyle(
                                            //                     color: Colors
                                            //                         .black,
                                            //                     fontWeight:
                                            //                         FontWeight
                                            //                             .bold,
                                            //                     fontSize: 17),
                                            //               ),
                                            //               IconButton(
                                            //                 style: const ButtonStyle(
                                            //                     elevation:
                                            //                         MaterialStatePropertyAll(
                                            //                             50)),
                                            //                 onPressed: () {
                                            //                   if (userDisciplinesAtom
                                            //                       .value
                                            //                       .isEmpty) {
                                            //                     classPageAtom.setValue(
                                            //                         ClassPageStatus
                                            //                             .ADD_DISCIPLINE);
                                            //                   }
                                            //                   pageStatusAtom
                                            //                       .setValue(
                                            //                           PageStates
                                            //                               .CLASSES);
                                            //                 },
                                            //                 icon: const Icon(
                                            //                     Icons.add),
                                            //                 alignment: Alignment
                                            //                     .centerRight,
                                            //                 color: Colors.black,
                                            //                 iconSize: 15,
                                            //               ),
                                            //             ],
                                            //           ),
                                            //         ],
                                            //       ),
                                            //     )),


// Statistics ------------------------------------------------------------------

// Card(
                                            //     color: Color.fromARGB(
                                            //         255, 248, 193, 200),
                                            //     child: SizedBox(
                                            //       width: 150,
                                            //       child: Padding(
                                            //         padding: EdgeInsets.all(8),
                                            //         child: Text(
                                            //           'Statistics',
                                            //           textAlign:
                                            //               TextAlign.center,
                                            //           style: TextStyle(
                                            //               color: Colors.black,
                                            //               fontWeight:
                                            //                   FontWeight.bold,
                                            //               fontSize: 17),
                                            //         ),
                                            //       ),
                                            //     )),



// Revaluations ----------------------------------------------------------------

// Card(
                                            //     color: Color.fromARGB(
                                            //         255, 248, 193, 200),
                                            //     child: SizedBox(
                                            //       width: 150,
                                            //       child: Padding(
                                            //         padding: EdgeInsets.all(8),
                                            //         child: Text(
                                            //           'Revaluation',
                                            //           textAlign:
                                            //               TextAlign.center,
                                            //           style: TextStyle(
                                            //               color: Colors.black,
                                            //               fontWeight:
                                            //                   FontWeight.bold,
                                            //               fontSize: 17),
                                            //         ),
                                            //       ),
                                            //     )),





//Notes -----------------------------------------------------

// Card(
                                            //     color: const Color.fromARGB(
                                            //         255, 248, 193, 200),
                                            //     child: SizedBox(
                                            //         width: 150,
                                            //         // height: 200,
                                            //         child: Column(
                                            //           children: [
                                            //             Row(
                                            //               mainAxisAlignment:
                                            //                   MainAxisAlignment
                                            //                       .spaceBetween,
                                            //               children: [
                                            //                 const Padding(
                                            //                     padding: EdgeInsets
                                            //                         .only(
                                            //                             left:
                                            //                                 45)),
                                            //                 const Text(
                                            //                   'NOTES',
                                            //                   style: TextStyle(
                                            //                     fontSize: 17,
                                            //                     fontWeight:
                                            //                         FontWeight
                                            //                             .bold,
                                            //                     color: Colors
                                            //                         .black,
                                            //                   ),
                                            //                 ),
                                            //                 IconButton(
                                            //                   style: const ButtonStyle(
                                            //                       elevation:
                                            //                           MaterialStatePropertyAll(
                                            //                               50)),
                                            //                   onPressed: () =>
                                            //                       pageStatusAtom
                                            //                           .setValue(
                                            //                               PageStates
                                            //                                   .NOTES),
                                            //                   icon: const Icon(Icons
                                            //                       .open_in_full_sharp),
                                            //                   alignment: Alignment
                                            //                       .centerRight,
                                            //                   color:
                                            //                       Colors.black,
                                            //                   iconSize: 15,
                                            //                 ),
                                            //               ],
                                            //             ),
                                            //             Expanded(
                                            //               child: ListView
                                            //                   .builder(
                                            //                       shrinkWrap:
                                            //                           true,
                                            //                       padding:
                                            //                           const EdgeInsets
                                            //                               .fromLTRB(
                                            //                               5,
                                            //                               2,
                                            //                               2,
                                            //                               10),
                                            //                       itemCount:
                                            //                           toDoListAtom
                                            //                               .value
                                            //                               .length,
                                            //                       itemBuilder:
                                            //                           (BuildContext
                                            //                                   context,
                                            //                               int index) {
                                            //                         return SizedBox(
                                            //                           child:
                                            //                               Card(
                                            //                             elevation:
                                            //                                 15,
                                            //                             color: Colors
                                            //                                 .red[900],
                                            //                             borderOnForeground:
                                            //                                 true,
                                            //                             child:
                                            //                                 Padding(
                                            //                               padding: const EdgeInsets
                                            //                                   .all(
                                            //                                   8.0),
                                            //                               child:
                                            //                                   Column(
                                            //                                 mainAxisAlignment:
                                            //                                     MainAxisAlignment.start,
                                            //                                 crossAxisAlignment:
                                            //                                     CrossAxisAlignment.start,
                                            //                                 children: [
                                            //                                   Text(
                                            //                                     '${index + 1}.  ${toDoListAtom.value[index].title}',
                                            //                                     style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                            //                                   ),
                                            //                                   Padding(
                                            //                                     padding: const EdgeInsets.only(left: 20),
                                            //                                     child: Text(
                                            //                                       '${toDoListAtom.value[index].description}',
                                            //                                       style: const TextStyle(
                                            //                                         fontSize: 10,
                                            //                                       ),
                                            //                                     ),
                                            //                                   ),
                                            //                                 ],
                                            //                               ),
                                            //                             ),
                                            //                           ),
                                            //                         );
                                            //                       }),
                                            //             ),
                                            //           ],
                                            //         ))),