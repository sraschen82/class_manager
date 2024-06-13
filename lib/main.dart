import 'package:asp/asp.dart';

import 'package:class_manager_two/app/auth/auth_atoms.dart';
import 'package:class_manager_two/app/auth/auth_page.dart';
import 'package:class_manager_two/app/home_page/home_page.dart';
import 'package:class_manager_two/app/injector.dart';
import 'package:class_manager_two/app/user/initial_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await registerInstances();

  await initialConfig();

  runApp(const RxRoot(child: ClassManager()));
}

class ClassManager extends StatelessWidget {
  const ClassManager({super.key});

  final String appTitle = 'App Title';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    final isLogged = context.select(() => userIsLogAtom.value);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
        textButtonTheme: const TextButtonThemeData(
            style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(Colors.white))),
        //highlightColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        primaryIconTheme: const IconThemeData(color: Colors.white),

        textTheme: Typography(platform: TargetPlatform.iOS).white,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          elevation: 80,
          backgroundColor: Color.fromARGB(255, 1, 4, 34),
        ),
        colorScheme:
            const ColorScheme.light(background: Color.fromARGB(255, 2, 22, 39)),
        useMaterial3: true,
      ),
      home: isLogged ? const HomePage() : const AuthPage(),
    );
  }
}
