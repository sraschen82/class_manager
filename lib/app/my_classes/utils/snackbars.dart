import 'package:flutter/material.dart';

SnackBar errorSnackBar(String msg, String e) => SnackBar(
      duration: const Duration(seconds: 5),
      content: Column(
        children: [
          Text(msg),
          const SizedBox(height: 10),
          Text('Firebase error:  $e'),
        ],
      ),
      backgroundColor: Colors.redAccent,
      elevation: 30,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
    );
