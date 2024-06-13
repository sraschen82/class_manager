// ignore_for_file: unused_local_variable

import 'package:class_manager_two/app/auth/auth_atoms.dart';
import 'package:class_manager_two/app/auth/auth_reducer.dart';
import 'package:class_manager_two/app/auth/auth_states.dart';
import 'package:class_manager_two/app/home_page/atoms/home_page_atoms.dart';
import 'package:class_manager_two/app/home_page/home_page_reducer.dart';
import 'package:class_manager_two/app/my_classes/class_reducer.dart';
import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/my_classes/models/discipline.dart';
import 'package:class_manager_two/app/my_classes/models/student.dart';
import 'package:class_manager_two/app/notes/reducers/notes_reducer.dart';
import 'package:class_manager_two/app/user/user.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

Future<void> initialConfig() async {
  final todoReducer = NotesReducer();
  final authReducer = AuthReducer();
  final homePageReducer = HomePageReducer();
  final classReducer = ClassReducer();

  final dir = await getApplicationDocumentsDirectory();

  final isar = await Isar.open(
      [UserSchema, DisciplineSchema, ClassesSchema, StudentSchema],
      directory: dir.path, inspector: true);

  try {
    await isar.txn(() async {
      User? user = await isar.user.where().findFirst();

      user == null
          ? authOptionsAtom.setValue(AuthChengePage.REGISTER)
          : {
              userAtom.setValue(user),
              authOptionsAtom.setValue(AuthChengePage.LOGIN),
              fetchSchedulesAction(),
              await Future.delayed(const Duration(milliseconds: 200)),
            };
    });
  } catch (e) {
    authOptionsAtom.setValue(AuthChengePage.REGISTER);
  }

  await isar.close();
}
