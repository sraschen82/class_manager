import 'package:asp/asp.dart';

import 'package:class_manager_two/app/auth/auth_states.dart';
import 'package:class_manager_two/app/user/user.dart';

//Atoms
final userIsLogAtom = Atom<bool>(false);
final authStatusAtom = Atom<AuthState>(AuthState.LOGIN);

final authOptionsAtom = Atom<AuthChengePage>(AuthChengePage.LOGIN);
final errorAtom = Atom<String>('');
final rememberLoginAtom = Atom<bool>(false);
final userAtom = Atom<User>(User(
  name: '',
  password: 'dfvzdfvzsdv',
));

//Actions
final authUserCreateAction = Atom<User>(User(name: '', password: ''));

final loggedUserAction = Atom<User>(User(name: '', password: ''));
final exitAppAction = Atom.action();
