import 'package:asp/asp.dart';

//Atoms
final imagePathAtom = Atom<String?>(null);

//Actions

final fetchSchedulesAction = Atom.action();
final uploadSchedulesAction = Atom.action();
final deleteSchedulesAction = Atom.action();
