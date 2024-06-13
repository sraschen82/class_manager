import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/models/discipline.dart';
import 'package:flutter/material.dart';

Widget disciplineWidget(BuildContext context, List<Discipline> disciplines,
    Discipline selectedDiscipline) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        disciplines.isEmpty
            ? Card(
                surfaceTintColor: Colors.amber,
                semanticContainer: true,
                elevation: 10,
                margin: const EdgeInsets.only(left: 120),
                color: Colors.black.withOpacity(0),
                child: const Text('No discipline registered.'))
            : SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width * 0.87,
                child: ListView.builder(
                  shrinkWrap: true,
                  addAutomaticKeepAlives: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: disciplines.length,
                  itemBuilder: (BuildContext context, index) {
                    return ElevatedButton(
                      style: ButtonStyle(
                        elevation: const MaterialStatePropertyAll(10),
                        backgroundColor:
                            selectedDiscipline.id == disciplines[index].id
                                ? const MaterialStatePropertyAll(
                                    Color.fromARGB(255, 65, 53, 229))
                                : MaterialStatePropertyAll(Colors.red[600]),
                      ),
                      onPressed: () async {
                        selectedDisciplineAtom.setValue(disciplines[index]);

                        getCLassesDataAction();

                        await Future.delayed(
                            const Duration(milliseconds: 1600));
                      },
                      onLongPress: () {
                        editDisciplineAction.setValue(
                            (context: context, discipline: disciplines[index]));
                      },
                      child: Text(
                        disciplines[index].name,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              ),
      ],
    ),
  );
}






// import 'package:asp/asp.dart';
// import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';

// import 'package:flutter/material.dart';

// class DisciplineWidget extends StatelessWidget {
//   DisciplineWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     context.select(
//       () => {
//         userDisciplinesAtom,
//         selectedDisciplineAtom,
//       },
//     );

//     return Padding(
//       padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           userDisciplinesAtom.value.isEmpty
//               ? Card(
//                   surfaceTintColor: Colors.amber,
//                   semanticContainer: true,
//                   elevation: 10,
//                   margin: const EdgeInsets.only(left: 120),
//                   color: Colors.black.withOpacity(0),
//                   child: const Text('No discipline registered.'))
//               : SizedBox(
//                   height: 30,
//                   width: MediaQuery.of(context).size.width * 0.87,
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     addAutomaticKeepAlives: true,
//                     scrollDirection: Axis.horizontal,
//                     itemCount: userDisciplinesAtom.value.length,
//                     itemBuilder: (BuildContext context, index) {
//                       return ElevatedButton(
//                         style: ButtonStyle(
//                           elevation: const MaterialStatePropertyAll(10),
//                           backgroundColor: selectedDisciplineAtom.value ==
//                                   userDisciplinesAtom.value[index]
//                               ? const MaterialStatePropertyAll(
//                                   Color.fromARGB(255, 65, 53, 229))
//                               : MaterialStatePropertyAll(Colors.red[600]),
//                         ),
//                         onPressed: () {
//                           selectedDisciplineAtom
//                               .setValue(userDisciplinesAtom.value[index]);
//                           print(selectedDisciplineAtom.value!.name);
//                         },
//                         onLongPress: () {
//                           editDisciplineAction.setValue((
//                             context: context,
//                             discipline: userDisciplinesAtom.value[index]
//                           ));
//                         },
//                         child: Text(
//                           userDisciplinesAtom.value[index].name,
//                           style: const TextStyle(
//                               fontSize: 15,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//         ],
//       ),
//     );
//   }
// }
