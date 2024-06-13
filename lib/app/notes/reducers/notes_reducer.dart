import 'package:asp/asp.dart';

import 'package:class_manager_two/app/injector.dart';
import 'package:class_manager_two/app/notes/atoms/page_atoms.dart';
import 'package:class_manager_two/app/notes/atoms/todo_atoms.dart';
import 'package:class_manager_two/app/notes/dialogs/edit_todo_dialog.dart';
import 'package:class_manager_two/app/notes/dialogs/new_todo_dialog.dart';
import 'package:class_manager_two/app/notes/models/todomodel.dart';
import 'package:class_manager_two/app/notes/states/note_states.dart';
import 'package:class_manager_two/app/repositories/isar_repository.dart';

class NotesReducer extends Reducer {
  IsarRepository notesRepository = autoInjector.get(key: 'isar');
  NotesReducer() {
    on(() => [fetchToTodosAction], _fetchToDos);
    on(() => [checkAction], _checkAction);
    on(() => [deleteToDoAction], _deleteToDo);
    on(() => [createNewToDoAction], _newToDo);
    on(() => [editToDoAction], _editToDo);
    on(() => [reorderListAction], _reorderList);
  }

  _checkAction() async {
    notesStatusAtom.setValue(NoteStates.LOADING);
    final oldTodo = toDoListAtom.value[checkAction.value.index];

    ToDoModel uppDatedToDo = ToDoModel().copyWith(
        id: oldTodo.id,
        title: oldTodo.title,
        description: oldTodo.description,
        check: checkAction.value.check);

    List<ToDoModel> inList = [];
    inList.addAll(toDoListAtom.value);
    inList.removeWhere((element) => element.id == oldTodo.id);

    inList.insert(checkAction.value.index, uppDatedToDo);

    toDoListAtom.setValue(inList);
    try {
      await notesRepository.saveNotes(inList);
    } catch (e) {
      notesStatusAtom.setValue(NoteStates.HOME_PAGE);
    }
    notesStatusAtom.setValue(NoteStates.HOME_PAGE);
  }

  _fetchToDos() async {
    try {
      toDoListAtom.setValue(await notesRepository.fetchNotes());
    } catch (e) {
      notesStatusAtom.setValue(NoteStates.HOME_PAGE);
    }
  }

  _deleteToDo() async {
    notesStatusAtom.setValue(NoteStates.LOADING);
    List<ToDoModel> inList = [];
    inList.addAll(toDoListAtom.value);
    inList.removeAt(deleteToDoAction.value);
    toDoListAtom.setValue(inList);

    try {
      await notesRepository.saveNotes(inList);
    } catch (e) {
      notesStatusAtom.setValue(NoteStates.HOME_PAGE);
    }

    fetchToTodosAction();
    notesStatusAtom.setValue(NoteStates.HOME_PAGE);
  }

  _newToDo() async {
    notesStatusAtom.setValue(NoteStates.LOADING);
    await newToDoDialog(createNewToDoAction.value!);

    List<ToDoModel> inList = [];
    inList.addAll(toDoListAtom.value);
    inList.add(newToDoAtom.value!);

    // await Future.delayed(const Duration(milliseconds: 100));
    try {
      await notesRepository.saveNotes(inList);

      toDoListAtom.setValue(inList);
    } catch (e) {
      notesStatusAtom.setValue(NoteStates.HOME_PAGE);
    }

    fetchToTodosAction();

    notesStatusAtom.setValue(NoteStates.HOME_PAGE);
  }

  _editToDo() async {
    notesStatusAtom.setValue(NoteStates.LOADING);
    ToDoModel oldToDo =
        toDoListAtom.value.elementAt(editToDoAction.value.index);
    try {
      await editToDoDialog(editToDoAction.value.context!, oldToDo);
      await notesRepository.saveNotes(toDoListAtom.value);
    } catch (e) {
      notesStatusAtom.setValue(NoteStates.HOME_PAGE);
    }

    fetchToTodosAction();
    notesStatusAtom.setValue(NoteStates.HOME_PAGE);
  }

  _reorderList() async {
    try {
      await notesRepository.saveNotes(toDoListAtom.value);
    } catch (e) {
      notesStatusAtom.setValue(NoteStates.HOME_PAGE);
    }
  }
}
