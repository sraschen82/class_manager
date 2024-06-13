import 'dart:async';

import 'package:asp/asp.dart';
import 'package:class_manager_two/app/auth/auth_atoms.dart';
import 'package:class_manager_two/app/auth/auth_states.dart';
import 'package:class_manager_two/app/home_page/atoms/page_status_atoms.dart';
import 'package:class_manager_two/app/home_page/home_page_states.dart';
import 'package:class_manager_two/app/injector.dart';
import 'package:class_manager_two/app/repositories/isar_repository.dart';
import 'package:class_manager_two/app/user/initial_config.dart';

import 'package:class_manager_two/app/user/user.dart';

class AuthReducer extends Reducer {
  IsarRepository authRepository = autoInjector.get(key: 'isar');
  AuthReducer() {
    on(() => [authUserCreateAction], _createAuthNewUser);
    on(() => [loggedUserAction], _login);
    on(() => [exitAppAction], _exitApp);
  }

  _createAuthNewUser() async {
    authStatusAtom.setValue(AuthState.LOADING);

    authUserCreateAction.value.name.isNotEmpty
        ? {
            await authRepository.createUser(authUserCreateAction.value),
            userIsLogAtom.setValue(true),
          }
        : {
            errorAtom.setValue('Empty name.'),
            authStatusAtom.setValue(AuthState.ERROR),
            await Future.delayed(const Duration(seconds: 2)),
            authStatusAtom.setValue(AuthState.LOGIN),
          };
  }

  _login() async {
    authStatusAtom.setValue(AuthState.LOADING);
    await Future.delayed(const Duration(seconds: 1));
    (loggedUserAction.value.password == userAtom.value.password)
        ? {
            userIsLogAtom.setValue(true),
          }
        : {
            errorAtom.setValue('Invalid password.'),
            authStatusAtom.setValue(AuthState.ERROR),
            await Future.delayed(const Duration(seconds: 2)),
            await initialConfig(),
            authStatusAtom.setValue(AuthState.LOGIN),
          };
  }

  _exitApp() {
    authUserCreateAction.setValue(User(name: '', password: ''));
    userIsLogAtom.setValue(false);
    pageStatusAtom.setValue(PageStates.HOME_PAGE);
  }
}
