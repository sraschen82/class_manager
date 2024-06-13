import 'package:asp/asp.dart';

import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/my_classes/models/discipline.dart';
import 'package:class_manager_two/app/my_classes/models/student.dart';
import 'package:flutter/widgets.dart';

final userDisciplinesAtom = Atom<List<Discipline>>([]);
final userClassesAtom = Atom<List<Classes>>([]);
final userStudentsAtom = Atom<List<Student>>([]);

final selectedDisciplineAtom = Atom<Discipline?>(null);
final selectedClassAtom = Atom<Classes?>(null);
final selectedStudentAtom = Atom<Student>(Student());

final sendClassToEditAtom = Atom<Classes>(Classes());
final sendDisciplineToEditAtom = Atom<Discipline>(Discipline());

final classErrorAtom = Atom<String>('');
final backToEdictStudentAtom = Atom<bool>(false);

//Actions

final addDisciplineAction = Atom<String>('');
final editDisciplineAction =
    Atom<({BuildContext? context, Discipline discipline})>(
        (context: null, discipline: Discipline()));

final deleteDisciplineAction = Atom<Discipline>(Discipline());
final clearDiscilinesAction = Atom.action();

final getCLassesDataAction = Atom.action();
final addClassAction = Atom<String>('');
final clearClassessAction = Atom.action();
final deleteClassAction = Atom<Classes>(Classes());
final editClassAction = Atom<({BuildContext? context, Classes editClass})>(
    (context: null, editClass: Classes()));

final addStudentsAction = Atom<String>('[]');
final addStudentsByListAction = Atom<String>('[]');
final deleteStudentAction = Atom<int>(-1);
final editStudentAction = Atom<Student>(Student());
