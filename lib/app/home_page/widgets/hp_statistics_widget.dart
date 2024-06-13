import 'package:class_manager_two/app/home_page/atoms/page_status_atoms.dart';
import 'package:class_manager_two/app/home_page/home_page_states.dart';
import 'package:flutter/material.dart';

class HpStatisticsWidget extends StatelessWidget {
  const HpStatisticsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: const Color.fromARGB(255, 248, 193, 200),
        child: SizedBox(
            width: 150,
            child: SizedBox(
              width: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      'Statistics',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                  IconButton(
                    style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(50)),
                    onPressed: () =>
                        pageStatusAtom.setValue(PageStates.STATISTICS),
                    icon: const Icon(Icons.insert_chart_outlined_rounded),
                    alignment: Alignment.centerRight,
                    color: Colors.red[900],
                    iconSize: 30,
                  ),
                ],
              ),
            )));
  }
}
