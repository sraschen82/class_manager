import 'package:asp/asp.dart';

import 'package:class_manager_two/app/auth/auth_atoms.dart';
import 'package:class_manager_two/app/auth/auth_states.dart';
import 'package:class_manager_two/app/auth/login_widget.dart';
import 'package:class_manager_two/app/comum/my_colors.dart';

import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.select(
        () => {authStatusAtom, userIsLogAtom, authUserCreateAction, errorAtom});
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(gradient: MyColors().gradientAuth()),
      child: switch (authStatusAtom.value) {
        AuthState.LOGIN => const LoginWidget(),
        AuthState.LOADING => const Center(
            child: CircularProgressIndicator(),
          ),
        AuthState.SUCCESS => const Center(
            child: Text('Loggin success.'),
          ),
        AuthState.ERROR => Center(
            child: Card(
              margin: const EdgeInsets.all(20),
              borderOnForeground: true,
              elevation: 30,
              color: Colors.red,
              child: SizedBox(
                height: 120,
                width: 250,
                child: Center(
                  child: Text(errorAtom.value,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
            ),
          ),
      },
    ));
  }
}
