import 'package:class_manager_two/app/comum/my_colors.dart';
import 'package:flutter/material.dart';

Column emptyRevaluationsWidget(int trim, BuildContext context) {
  return Column(
    children: [
      DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.black, width: 3),
            gradient: MyColors().gradientBackground_4()),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: SizedBox(
              height: 50,
              width: 60,
              child: Center(
                child: Text(
                  '${trim + 1}º TRI',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      Card(
        elevation: 15,
        color: const Color.fromARGB(255, 163, 13, 3),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .71,
          width: double.infinity,
          child: const Center(
            child: Text('No students in re-evaluation.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                )),
          ),
        ),
      ),
    ],
  );
}
