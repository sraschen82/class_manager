// ignore_for_file: empty_catches

import 'package:asp/asp.dart';
import 'package:class_manager_two/app/home_page/atoms/page_status_atoms.dart';
import 'package:class_manager_two/app/home_page/home_page_states.dart';
import 'package:class_manager_two/app/injector.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_page_atoms.dart';
import 'package:class_manager_two/app/my_classes/class_routes.dart';
import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/my_classes/models/discipline.dart';
import 'package:class_manager_two/app/my_classes/models/student.dart';
import 'package:class_manager_two/app/my_classes/widgets/edit_class_widget.dart';
import 'package:class_manager_two/app/my_classes/widgets/edit_discipline_widget.dart';
import 'package:class_manager_two/app/repositories/isar_repository.dart';

class ClassReducer extends Reducer {
  IsarRepository classRepository = autoInjector.get(key: 'isar');

  ClassReducer() {
    on(() => [addDisciplineAction], _addDiscipline);
    on(() => [clearDiscilinesAction], _clearDisciplines);
    on(() => [editDisciplineAction], _editDiscipline);
    on(() => [deleteDisciplineAction], _deleteDiscipline);

    on(() => [addClassAction], _addClass);
    on(() => [getCLassesDataAction], _getClassesData);
    on(() => [clearClassessAction], _clearClasses);
    on(() => [deleteClassAction], _deleteClass);
    on(() => [editClassAction], _editClass);

    on(() => [addStudentsAction], _addStudent);
    on(() => [addStudentsByListAction], _addStudentsByList);
    on(() => [deleteStudentAction], _deleteStudent);
    on(() => [editStudentAction], _editStudent);
  }

  _getClassesData() async {
    try {
      userDisciplinesAtom.setValue(await classRepository.fetchDisciplines());
      selectedDisciplineAtom.value == null
          ? selectedDisciplineAtom.setValue(userDisciplinesAtom.value.first)
          : selectedDisciplineAtom.setValue(selectedDisciplineAtom.value);
    } catch (e) {}

    try {
      userClassesAtom.setValue(await classRepository.fetchClasses());
    } catch (e) {}

    try {
      userStudentsAtom.setValue(await classRepository.fetchStudents());
    } catch (e) {}
  }

  _clearDisciplines() async {
    classPageAtom.setValue(ClassPageStatus.LOADING);
    try {
      classRepository.clearDisciplines();
    } catch (e) {}

    try {
      classRepository.clearClasses();
    } catch (e) {}

    try {
      classRepository.clearStudents();
    } catch (e) {}
    getCLassesDataAction();
    await Future.delayed(const Duration(milliseconds: 100));
    pageStatusAtom.setValue(PageStates.CLASSES);
    classPageAtom.setValue(ClassPageStatus.ADD_DISCIPLINE);
  }

// Disiciplines --------------------------------------------------------------
  _addDiscipline() async {
    classPageAtom.setValue(ClassPageStatus.LOADING);
    final newDiscipline = Discipline()..name = addDisciplineAction.value;

    if (userDisciplinesAtom.value.isEmpty ||
        userDisciplinesAtom.value
            .where((element) =>
                element.name.compareTo(addDisciplineAction.value) == 0)
            .isEmpty) {
      final List<Discipline> newList = [];
      newList.addAll(userDisciplinesAtom.value);
      newList.add(newDiscipline);
      userDisciplinesAtom.setValue(newList);
      selectedDisciplineAtom.setValue(newDiscipline);
      try {
        await classRepository.saveDiscipline(newDiscipline);
      } catch (e) {
        classErrorAtom.setValue(e.toString());
        classPageAtom.setValue(ClassPageStatus.ERROR);
        await Future.delayed(const Duration(seconds: 9));
        classPageAtom.setValue(ClassPageStatus.INICIAL);
      }
      await Future.delayed(const Duration(milliseconds: 100));
      pageStatusAtom.setValue(PageStates.CLASSES);
      classPageAtom.setValue(ClassPageStatus.ADD_CLASS);
    } else {
      pageStatusAtom.setValue(PageStates.CLASSES);
      classErrorAtom.setValue('That discipline already exists.');
      classPageAtom.setValue(ClassPageStatus.ERROR);
      await Future.delayed(const Duration(seconds: 5));
      classPageAtom.setValue(ClassPageStatus.ADD_DISCIPLINE);
    }
  }

  _editDiscipline() async {
    await editDisciplineDialog(editDisciplineAction.value.context!,
        editDisciplineAction.value.discipline);

    try {
      await classRepository.saveDiscipline(sendDisciplineToEditAtom.value);
    } catch (e) {
      classErrorAtom.setValue(e.toString());
      classPageAtom.setValue(ClassPageStatus.ERROR);
      await Future.delayed(const Duration(seconds: 5));
      pageStatusAtom.setValue(PageStates.CLASSES);
      classPageAtom.setValue(ClassPageStatus.INICIAL);
    }
    getCLassesDataAction();
    pageStatusAtom.setValue(PageStates.CLASSES);
    classPageAtom.setValue(ClassPageStatus.INICIAL);
  }

  _deleteDiscipline() async {
    classPageAtom.setValue(ClassPageStatus.LOADING);

    try {
      await classRepository.deleteDiscipline(deleteDisciplineAction.value);
    } catch (e) {
      classErrorAtom.setValue(e.toString());
      classPageAtom.setValue(ClassPageStatus.ERROR);
      await Future.delayed(const Duration(seconds: 5));
      pageStatusAtom.setValue(PageStates.CLASSES);
      classPageAtom.setValue(ClassPageStatus.INICIAL);
    }
    getCLassesDataAction();
    pageStatusAtom.setValue(PageStates.CLASSES);
    classPageAtom.setValue(ClassPageStatus.INICIAL);
  }

// Classes --------------------------------------------------------------------

  _addClass() async {
    classPageAtom.setValue(ClassPageStatus.LOADING);
    final Classes newClass = Classes()..name = addClassAction.value;

    try {
      if (selectedDisciplineAtom.value != null) {
        await classRepository.saveClass(
            selectedDisciplineAtom.value!, newClass);
      }
    } catch (e) {
      classErrorAtom.setValue(e.toString());
      classPageAtom.setValue(ClassPageStatus.ERROR);
      await Future.delayed(const Duration(seconds: 5));
      pageStatusAtom.setValue(PageStates.CLASSES);
      classPageAtom.setValue(ClassPageStatus.ADD_STUDENTS);
    }

    List<Classes> newClassList = [];
    newClassList.addAll(userClassesAtom.value);
    newClassList.add(newClass);
    selectedClassAtom.setValue(newClass);
    userClassesAtom.setValue(newClassList);

    pageStatusAtom.setValue(PageStates.CLASSES);
    classPageAtom.setValue(ClassPageStatus.ADD_STUDENTS);
  }

  _editClass() async {
    await editClassDialog(
        editClassAction.value.context!, editClassAction.value.editClass);

    try {
      if (selectedDisciplineAtom.value != null) {
        await classRepository.saveClass(
            selectedDisciplineAtom.value!, sendClassToEditAtom.value);
      }
    } catch (e) {
      classErrorAtom.setValue(e.toString());
      classPageAtom.setValue(ClassPageStatus.ERROR);
      await Future.delayed(const Duration(seconds: 5));
      pageStatusAtom.setValue(PageStates.CLASSES);
      classPageAtom.setValue(ClassPageStatus.INICIAL);
    }
    getCLassesDataAction();
    pageStatusAtom.setValue(PageStates.CLASSES);
    classPageAtom.setValue(ClassPageStatus.INICIAL);
  }

  _deleteClass() async {
    classPageAtom.setValue(ClassPageStatus.LOADING);

    try {
      await classRepository.deleteClass(deleteClassAction.value);
    } catch (e) {
      classErrorAtom.setValue(e.toString());
      classPageAtom.setValue(ClassPageStatus.ERROR);
      await Future.delayed(const Duration(seconds: 5));
      pageStatusAtom.setValue(PageStates.CLASSES);
      classPageAtom.setValue(ClassPageStatus.INICIAL);
    }
    getCLassesDataAction();
    pageStatusAtom.setValue(PageStates.CLASSES);
    classPageAtom.setValue(ClassPageStatus.INICIAL);
  }

  _clearClasses() async {
    classPageAtom.setValue(ClassPageStatus.LOADING);
    try {
      await classRepository.clearClasses();
    } catch (e) {}
    userClassesAtom.setValue([]);
    getCLassesDataAction();
    await Future.delayed(const Duration(milliseconds: 100));
    pageStatusAtom.setValue(PageStates.CLASSES);
    classPageAtom.setValue(ClassPageStatus.INICIAL);
  }

// Students --------------------------------------------------------------------

  _addStudent() async {
    classPageAtom.setValue(ClassPageStatus.LOADING);

    String regex =
        r'[^\p{Alphabetic}\p{Mark}\p{Decimal_Number}\p{Connector_Punctuation}\p{Join_Control}\s]+';

    String studentRegex =
        addStudentsAction.value.replaceAll(RegExp(regex, unicode: true), '');

    Student newStudent = Student()..name = studentRegex;

    try {
      await classRepository.saveStudents(selectedClassAtom.value!, newStudent);
    } catch (e) {
      classErrorAtom.setValue(e.toString());
      classPageAtom.setValue(ClassPageStatus.ERROR);
      await Future.delayed(const Duration(seconds: 2));
      pageStatusAtom.setValue(PageStates.CLASSES);
      classPageAtom.setValue(ClassPageStatus.ADD_STUDENTS);
    }
    List<Student> newList = [];
    newList.addAll(userStudentsAtom.value);
    newList.add(newStudent);
    userStudentsAtom.setValue(newList);
    final newClass = selectedClassAtom.value;
    newClass?.student.add(newStudent);
    selectedClassAtom.setValue(newClass);
    pageStatusAtom.setValue(PageStates.CLASSES);
    classPageAtom.setValue(ClassPageStatus.INICIAL);
  }

  _addStudentsByList() async {
    classPageAtom.setValue(ClassPageStatus.LOADING);
    List<Student> newList = [];
    newList.addAll(userStudentsAtom.value);
    newList.removeWhere(
        (element) => element.classes.value != selectedClassAtom.value!);

    List<String> studentNameList = addStudentsByListAction.value.split('\n');

    for (String studentName in studentNameList) {
      String regex =
          r'[^\p{Alphabetic}\p{Mark}\p{Decimal_Number}\p{Connector_Punctuation}\p{Join_Control}\s]+';

      String studentRegex =
          studentName.replaceAll(RegExp(regex, unicode: true), '');

      final Student newStudent = Student()..name = studentRegex;
      newList.add(newStudent);
    }
    newList.removeWhere((element) => element.name == '');

    for (Student student in newList) {
      try {
        await classRepository.saveStudents(selectedClassAtom.value!, student);
      } catch (e) {
        classErrorAtom.setValue(e.toString());
        classPageAtom.setValue(ClassPageStatus.ERROR);
        await Future.delayed(const Duration(seconds: 5));
        pageStatusAtom.setValue(PageStates.CLASSES);
        classPageAtom.setValue(ClassPageStatus.ADD_STUDENTS);
      }
    }
    userStudentsAtom.setValue(newList);
    final newClass = selectedClassAtom.value;
    newClass?.student.addAll(newList);

    selectedClassAtom.setValue(newClass);
    getCLassesDataAction();
    pageStatusAtom.setValue(PageStates.CLASSES);
    classPageAtom.setValue(ClassPageStatus.INICIAL);
  }

  _editStudent() async {
    PageStates myPage = pageStatusAtom.value;
    // pageStatusAtom.setValue(PageStates.LOADING);

    try {
      await classRepository.editStudent(editStudentAction.value);
    } catch (e) {
      classErrorAtom.setValue(e.toString());
      classPageAtom.setValue(ClassPageStatus.ERROR);
      await Future.delayed(const Duration(seconds: 5));
      pageStatusAtom.setValue(PageStates.HOME_PAGE);
      // classPageAtom.setValue(ClassPageStatus.INICIAL);
    }
    backToEdictStudentAtom.value == true
        ? {
            backToEdictStudentAtom.setValue(false),
            getCLassesDataAction(),
            await Future.delayed(const Duration(milliseconds: 500)),
            if (myPage == PageStates.CLASSES)
              {
                pageStatusAtom.setValue(PageStates.CLASSES),
                selectedStudentAtom.setValue(selectedStudentAtom.value),
                classPageAtom.setValue(ClassPageStatus.EDIT_STUDENT),
              }
            else if (myPage == PageStates.REVALUATION)
              {
                pageStatusAtom.setValue(PageStates.REVALUATION),
              }
            else
              {
                pageStatusAtom.setValue(myPage),
              }
          }
        : {
            getCLassesDataAction(),
            if (myPage == PageStates.CLASSES)
              {
                selectedDisciplineAtom.setValue(selectedDisciplineAtom.value),
                pageStatusAtom.setValue(PageStates.CLASSES),
                selectedStudentAtom.setValue(selectedStudentAtom.value),
                classPageAtom.setValue(ClassPageStatus.INICIAL),
              }
          };
  }

  _deleteStudent() async {
    classPageAtom.setValue(ClassPageStatus.LOADING);
    try {
      await classRepository.deleteStudent(deleteStudentAction.value);
    } catch (e) {
      classErrorAtom.setValue(e.toString());
      classPageAtom.setValue(ClassPageStatus.ERROR);
      await Future.delayed(const Duration(seconds: 5));
      pageStatusAtom.setValue(PageStates.CLASSES);
      classPageAtom.setValue(ClassPageStatus.INICIAL);
    }
    getCLassesDataAction();
    pageStatusAtom.setValue(PageStates.CLASSES);
    classPageAtom.setValue(ClassPageStatus.INICIAL);
  }
}
