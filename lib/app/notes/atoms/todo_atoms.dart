import 'package:asp/asp.dart';

import 'package:class_manager_two/app/notes/models/todomodel.dart';
import 'package:flutter/material.dart';

//Atoms
final toDoListAtom = Atom<List<ToDoModel>>([]);
final newToDoAtom = Atom<ToDoModel?>(null);

//Actions
final fetchToTodosAction = Atom.action();
final checkAction = Atom<({int index, bool check})>((index: 0, check: false));
final deleteToDoAction = Atom<int>(0);
final createNewToDoAction = Atom<BuildContext?>(null);
final editToDoAction =
    Atom<({BuildContext? context, int index})>((context: null, index: 0));

final reorderListAction = Atom.action();
