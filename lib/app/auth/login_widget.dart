import 'dart:async';

import 'package:asp/asp.dart';
import 'package:class_manager_two/app/auth/auth_atoms.dart';
import 'package:class_manager_two/app/auth/auth_states.dart';
import 'package:class_manager_two/app/home_page/atoms/home_page_atoms.dart';

import 'package:class_manager_two/app/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    context.select(() => {authOptionsAtom, loggedUserAction});

    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmpasswordController = TextEditingController();

    validarForm() async {
      if (authOptionsAtom.value == AuthChengePage.REGISTER) {
        if (passwordController.text == confirmpasswordController.text) {
          final newUser = User(
              name: nameController.text, password: passwordController.text);
          authUserCreateAction.setValue(newUser);
        } else {
          authStatusAtom.setValue(AuthState.LOADING);
          await Future.delayed(const Duration(seconds: 2));
          errorAtom.setValue('Unconfirmed password.');
          authStatusAtom.setValue(AuthState.ERROR);
          await Future.delayed(const Duration(seconds: 5));

          authStatusAtom.setValue(AuthState.LOGIN);
        }
      } else {
        final newUser =
            User(name: nameController.text, password: passwordController.text);
        loggedUserAction.setValue(newUser);
        fetchSchedulesAction();

        await Future.delayed(const Duration(milliseconds: 200));
      }
    }

    return SafeArea(
      maintainBottomViewPadding: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: Image.asset(
                'assets/image/logoMaua1.gif',
              )
                  .animate()
                  .align()
                  .slideX()
                  .scaleXY(
                      begin: 0.5, end: 1, duration: const Duration(seconds: 3))
                  .shakeX(
                      delay: const Duration(seconds: 5),
                      duration: const Duration(milliseconds: 300))
                  .shimmer(
                      delay: const Duration(seconds: 3), color: Colors.white)
                  .then()
                  .animate(onPlay: (c) => c.repeat())
                  .shimmer(
                      delay: const Duration(seconds: 8), color: Colors.white)),
          Flexible(
              flex: 10,
              child: SingleChildScrollView(
                child: Card(
                  margin: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                  borderOnForeground: true,
                  color: Colors.white.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                          heightFactor: 2,
                          child: Text(authOptionsAtom.value.inView,
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                        ),
                        if (authOptionsAtom.value == AuthChengePage.LOGIN)
                          Column(
                            children: [
                              const Text('Wellcome'),
                              Text(userAtom.value.name,
                                  style: const TextStyle(
                                    fontSize: 30,
                                  )),
                            ],
                          ),
                        if (authOptionsAtom.value == AuthChengePage.REGISTER)
                          TextFormField(
                            controller: nameController,
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              alignLabelWithHint: true,
                              prefixIcon:
                                  const Icon(Icons.person, color: Colors.white),
                              hoverColor: Colors.white,
                              errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              contentPadding: const EdgeInsets.all(30),
                              // hintText: '  Nestor Raschen',
                              hintStyle: const TextStyle(color: Colors.white),
                              label: const Text('Name',
                                  style: TextStyle(color: Colors.white)),
                              border: const OutlineInputBorder(
                                gapPadding: 5,
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        Divider(color: Colors.white.withOpacity(0)),
                        TextFormField(
                          controller: passwordController,
                          autofocus:
                              authOptionsAtom.value == AuthChengePage.LOGIN
                                  ? true
                                  : false,
                          obscureText: true,
                          textInputAction:
                              authOptionsAtom.value == AuthChengePage.LOGIN
                                  ? TextInputAction.done
                                  : TextInputAction.next,
                          cursorColor: Colors.white,
                          onFieldSubmitted: (value) =>
                              authOptionsAtom.value == AuthChengePage.LOGIN
                                  ? validarForm()
                                  : {},
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            hoverColor: Colors.white,
                            prefixIcon:
                                const Icon(Icons.password, color: Colors.white),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            contentPadding: const EdgeInsets.all(30),
                            hintText: '  Your Password',
                            hintStyle: const TextStyle(color: Colors.white),
                            label: const Text('  Password',
                                style: TextStyle(color: Colors.white)),
                            border: const OutlineInputBorder(
                              gapPadding: 5,
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          enableSuggestions: true,
                        ),
                        if (authOptionsAtom.value == AuthChengePage.REGISTER)
                          TextFormField(
                            controller: confirmpasswordController,
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            cursorColor: Colors.white,
                            onFieldSubmitted: (value) => validarForm(),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              hoverColor: Colors.white,
                              prefixIcon: const Icon(Icons.password,
                                  color: Colors.white),
                              errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              contentPadding: const EdgeInsets.all(30),
                              hintText: '  Your Password',
                              hintStyle: const TextStyle(color: Colors.white),
                              label: const Text('  Confirm Password',
                                  style: TextStyle(color: Colors.white)),
                              border: const OutlineInputBorder(
                                gapPadding: 5,
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            enableSuggestions: true,
                          ),
                        Divider(color: Colors.white.withOpacity(0)),
                        TextButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.blueAccent),
                                elevation: MaterialStatePropertyAll(30),
                                minimumSize: MaterialStatePropertyAll(
                                  Size(300, 60),
                                ),
                                maximumSize:
                                    MaterialStatePropertyAll(Size(400, 80)),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))))),
                            onPressed: () async {
                              validarForm();
                            },
                            child: Text(authOptionsAtom.value.inView)),
                        if (authOptionsAtom.value == AuthChengePage.LOGIN)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don´t hava a accont?'),
                              TextButton(
                                  onPressed: () => authOptionsAtom
                                      .setValue(AuthChengePage.REGISTER),
                                  child: const Text(
                                    'SING UP',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        if (authOptionsAtom.value == AuthChengePage.REGISTER)
                          TextButton(
                              onPressed: () => authOptionsAtom
                                  .setValue(AuthChengePage.LOGIN),
                              child: const Text(
                                'Back to LOGIN.',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              )),
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
