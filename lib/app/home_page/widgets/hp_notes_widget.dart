import 'package:asp/asp.dart';

import 'package:class_manager_two/app/home_page/atoms/page_status_atoms.dart';
import 'package:class_manager_two/app/home_page/home_page_states.dart';
import 'package:class_manager_two/app/notes/atoms/todo_atoms.dart';
import 'package:flutter/material.dart';

class HpNotestWidget extends StatelessWidget {
  const HpNotestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    context.select(
      () => {toDoListAtom, errorHPAtom},
    );

    return Card(
        color: const Color.fromARGB(255, 248, 193, 200),
        child: SizedBox(
            width: 150,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 45)),
                    const Text(
                      'NOTES',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      style: const ButtonStyle(
                          elevation: MaterialStatePropertyAll(50)),
                      onPressed: () =>
                          pageStatusAtom.setValue(PageStates.NOTES),
                      icon: const Icon(Icons.open_in_full_sharp),
                      alignment: Alignment.centerRight,
                      color: Colors.black,
                      iconSize: 15,
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.fromLTRB(5, 2, 2, 10),
                      itemCount: toDoListAtom.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          child: Card(
                            elevation: 15,
                            color: Colors.red[900],
                            borderOnForeground: true,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${index + 1}.  ${toDoListAtom.value[index].title}',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      '${toDoListAtom.value[index].description}',
                                      style: const TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            )));
  }
}
