import 'dart:io';

import 'package:asp/asp.dart';
import 'package:class_manager_two/app/comum/my_colors.dart';
import 'package:class_manager_two/app/home_page/atoms/home_page_atoms.dart';
import 'package:flutter/material.dart';

class HpSchedulesWidget extends StatelessWidget {
  const HpSchedulesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    context.select(
      () => {imagePathAtom},
    );

    return Card(
      elevation: 30,
      color: color4,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(gradient: MyColors().gradientHomePage()),
        child: Column(
          children: [
            if (imagePathAtom.value == null)
              Column(
                children: [
                  const Text(
                    'My Schedules',
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () => uploadSchedulesAction(),
                    icon: const Icon(Icons.upload),
                    iconSize: 15,
                  ),
                ],
              ),
            if (imagePathAtom.value != null)
              Card(
                  elevation: 30,
                  shadowColor: Colors.black,
                  child: InteractiveViewer(
                    minScale: 0.1,
                    maxScale: 1.6,
                    child: GestureDetector(
                      onLongPress: () => uploadSchedulesAction(),
                      child: Image.file(
                        File(imagePathAtom.value!),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  )),
            if (imagePathAtom.value != null)
              SizedBox(
                height: 15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        uploadSchedulesAction();
                      },
                      icon: const Icon(Icons.upload),
                      iconSize: 15,
                    ),
                    IconButton(
                      onPressed: () => deleteSchedulesAction(),
                      icon: const Icon(Icons.delete),
                      iconSize: 15,
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
