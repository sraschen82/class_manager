import 'package:flutter/material.dart';

Future<void> showAlertDialog(
    {required BuildContext context,
    required String title,
    required String message,
    required String okButton,
    void action}) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          actionsAlignment: MainAxisAlignment.center,
          title: Center(child: Text(title)),
          content: SingleChildScrollView(
              child: Column(
            children: [
              Card(
                  color: Colors.red,
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text('       $message')),
                    ),
                  ))
            ],
          )),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel')),
            TextButton(
              onPressed: () async {
                () => action;
                Navigator.of(context).pop();
              },
              child: Text(okButton),
            ),
          ],
        );
      });
}
