import 'package:class_manager_two/app/auth/auth_atoms.dart';
import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/my_classes/models/discipline.dart';
import 'package:class_manager_two/app/my_classes/models/student.dart';
import 'package:class_manager_two/app/notes/models/todomodel.dart';
import 'package:class_manager_two/app/repositories/interface_repositoy.dart';
import 'package:class_manager_two/app/user/user.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarRepository implements IRepository {
  late Isar _isar;
  int i = 1;
  @override
  openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();

      _isar = await Isar.open(
          [UserSchema, DisciplineSchema, ClassesSchema, StudentSchema],
          directory: dir.path, inspector: true);
    } else {
      _isar = await Future.value(Isar.getInstance());
    }
  }

  @override
  createUser(User newUser) async {
    await openDB();
    await _isar.writeTxn(() async {
      await _isar.user.put(newUser);
    });
    // await _isar.close();
  }

  @override
  Future<String?> fetchSchedules() async {
    await openDB();

    String? path;

    await _isar.txn(() async {
      path = await _isar.user
          .where()
          .findFirst()
          .then((value) => value?.pathSchedules);
    });
    await _isar.close();
    return path;
  }

  @override
  saveSchedules(String? path) async {
    await openDB();

    final myUser = await _isar.user.where().findFirst();

    User editedUser = myUser!;
    editedUser.pathSchedules = path;

    await _isar.writeTxn(() async {
      await _isar.user.put(editedUser);
    });
    // await _isar.close();
  }

  @override
  deleteSchedules() async {
    await openDB();
    User editedUser;
    User? isUser = await _isar.user.where().findFirst();
    if (isUser != null) {
      editedUser = isUser;
    } else {
      editedUser = userAtom.value;
    }

    editedUser.pathSchedules = null;

    await _isar.writeTxn(() async {
      // final editedUser = await _isar.user.where().findFirst();

      await _isar.user.put(editedUser);
    });
    // await _isar.close();
  }

  // Notes ------------------------------------------
  @override
  Future<List<ToDoModel>> fetchNotes() async {
    await openDB();

    List<ToDoModel> isarList = [];

    await _isar.txn(() async {
      isarList =
          await _isar.user.where().findFirst().then((value) => value!.notes);
    });

    // await _isar.close();
    return isarList;
  }

  @override
  saveNotes(List<ToDoModel> list) async {
    await openDB();
    User? myUser = await _isar.user.where().findFirst();

    User newUser = myUser!;
    newUser.notes = list;
    await _isar.writeTxn(() async {
      await _isar.user.put(newUser);
    });
  }

  // Classes ------------------------------------------------------------------

  // Disciplines ------------

  @override
  Future<List<Discipline>> fetchDisciplines() async {
    await openDB();

    List<Discipline> disciplineList = [];
    await _isar.txn(() async {
      disciplineList = await _isar.discipline.where().findAll();
    });

    // await _isar.close();
    return disciplineList;
  }

  @override
  deleteDiscipline(Discipline discipline) async {
    await openDB();

    final user = await _isar.user.where().findFirst();

    List<Classes> classes = await _isar.classes
        .where()
        .filter()
        .discipline((q) => q.idEqualTo(discipline.id))
        .findAll();
    List<int> classesIds = [];
    for (var element in classes) {
      classesIds.add(element.id);
    }

    List<Student> students = await _isar.student
        .where()
        .filter()
        .classes((c) => c.discipline((d) => d.nameEqualTo(discipline.name)))
        .findAll();
    List<int> studentsIds = [];

    for (var element in students) {
      studentsIds.add(element.id);
    }
    user?.discipline.remove(discipline);
    user?.student.removeAll(students);

    await _isar.writeTxn(() async {
      await _isar.discipline.delete(discipline.id);
      await _isar.classes.deleteAll(classesIds);
      await _isar.student.deleteAll(studentsIds);
      await user?.discipline.save();
    });
  }

  @override
  clearDisciplines() async {
    await openDB();
    final user = await _isar.user.where().findFirst();
    user?.discipline.clear();
    await _isar.writeTxn(() async {
      await _isar.discipline.clear();
      await user?.discipline.save();
    });
  }

  @override
  saveDiscipline(Discipline discipline) async {
    await openDB();
    final user = await _isar.user.where().findFirst();
    user?.discipline.add(discipline);

    await _isar.writeTxn(() async {
      await _isar.discipline.put(discipline);
      await _isar.user.put(user!);
      await user.discipline.save();
    });
  }

  // Class -------------------

  @override
  Future<List<Classes>> fetchClasses() async {
    await openDB();

    List<Classes> classesList = [];
    await _isar.txn(() async {
      classesList = await _isar.classes.where().findAll();
    });
    classesList.isNotEmpty
        ? classesList.sort(
            (a, b) => a.name.compareTo(b.name),
          )
        : classesList = [];
    return classesList;
  }

  @override
  clearClasses() async {
    await openDB();
    final classes = await _isar.classes.where().findAll();

    for (Classes inClass in classes) {
      await _isar.writeTxn(() async {
        await _isar.classes.delete(inClass.id);
      });
    }
  }

  @override
  deleteClass(Classes classToDelete) async {
    await openDB();

    final user = await _isar.user.where().findFirst();

    List<Student> students = await _isar.student
        .where()
        .filter()
        .classes((c) => c.idEqualTo(classToDelete.id))
        .findAll();
    List<int> studentsIds = [];

    for (var element in students) {
      studentsIds.add(element.id);
    }

    user?.student.removeAll(students);

    await _isar.writeTxn(() async {
      await _isar.classes.delete(classToDelete.id);
      await _isar.student.deleteAll(studentsIds);
      await user?.discipline.save();
    });
  }

  @override
  saveClass(Discipline discipline, Classes newClass) async {
    await openDB();

    Discipline? isarDiscipline = await _isar.discipline
        .where()
        .filter()
        .nameEqualTo(discipline.name)
        .findFirst();
    isarDiscipline?.classes.add(newClass);
    await _isar.writeTxn(() async {
      await _isar.classes.put(newClass);
      await isarDiscipline?.classes.save();
    });
  }

  // Students -----------------

  @override
  Future<List<Student>> fetchStudents() async {
    await openDB();

    List<Student> studentsList = [];
    await _isar.txn(() async {
      studentsList = await _isar.student.where().findAll();
    });

    return studentsList;
  }

  @override
  clearStudents() async {
    await openDB();
    final students = await _isar.student.where().findAll();

    for (Student student in students) {
      await _isar.writeTxn(() async {
        await _isar.student.delete(student.id);
      });
    }
  }

  @override
  saveStudents(Classes saveInClass, Student newStudent) async {
    await openDB();
    final user = await _isar.user.where().findFirst();
    newStudent.classes.value = saveInClass;
    final isarClass = await _isar.classes
        .where()
        .filter()
        .nameEqualTo(saveInClass.name)
        .findFirst();
    isarClass?.student.add(newStudent);
    user?.student.add(newStudent);
    await _isar.writeTxn(() async {
      await _isar.student.put(newStudent);
      await isarClass?.student.save();
      await user?.student.save();
    });
  }

  @override
  deleteStudent(int id) async {
    await openDB();

    final user = await _isar.user.where().findFirst();

    await _isar.writeTxn(() async {
      await _isar.student.delete(id);
      await user?.student.save();
    });
  }

  @override
  editStudent(Student student) async {
    await openDB();

    final user = await _isar.user.where().findFirst();

    user?.student.add(student);
    final isarClass = await _isar.classes
        .where()
        .filter()
        .nameEqualTo(student.classes.value!.name)
        .findFirst();

    isarClass?.student.add(student);

    await _isar.writeTxn(() async {
      await _isar.student.put(student);
      await user?.student.save();
      isarClass?.student.save();
    });
  }
}











// import 'package:class_manager_two/app/auth/auth_atoms.dart';
// import 'package:class_manager_two/app/my_classes/models/class.dart';
// import 'package:class_manager_two/app/my_classes/models/discipline.dart';
// import 'package:class_manager_two/app/my_classes/models/student.dart';
// import 'package:class_manager_two/app/notes/models/todomodel.dart';
// import 'package:class_manager_two/app/repositories/interface_repositoy.dart';
// import 'package:class_manager_two/app/user/user.dart';
// import 'package:isar/isar.dart';
// import 'package:path_provider/path_provider.dart';

// class IsarRepository implements IRepository {
//   late final Isar _isar;
//   int i = 1;
//   @override
//   openDB() async {
//     print('openDB $i');
//     i++;
//     if (Isar.instanceNames.isEmpty) {
//       final dir = await getApplicationDocumentsDirectory();
//       print('openDB if $i');

//       _isar = await Isar.open(
//           [UserSchema, DisciplineSchema, ClassesSchema, StudentSchema],
//           directory: dir.path, inspector: true);
//     }
//   }

//   createUser(User newUser) async {
//     await openDB();
//     await _isar.writeTxn(() async {
//       await _isar.user.put(newUser);
//     });
//     await _isar.close();
//   }

//   Future<String?> fetchSchedules() async {
//     await openDB();

//     String? path;

//     await _isar.txn(() async {
//       path = await _isar.user
//           .where()
//           .findFirst()
//           .then((value) => value?.pathSchedules);
//     });
//     await _isar.close();
//     return path;
//   }

//   @override
//   saveSchedules(String? path) async {
//     await openDB();

//     final myUser = await _isar.user.where().findFirst();

//     User editedUser = myUser!;
//     editedUser.pathSchedules = path;

//     await _isar.writeTxn(() async {
//       await _isar.user.put(editedUser);
//     });
//     // await _isar.close();
//   }

//   @override
//   deleteSchedules() async {
//     await openDB();
//     User editedUser;
//     User? isUser = await _isar.user.where().findFirst();
//     if (isUser != null) {
//       editedUser = isUser;
//     } else {
//       editedUser = userAtom.value;
//     }

//     editedUser.pathSchedules = null;

//     await _isar.writeTxn(() async {
//       // final editedUser = await _isar.user.where().findFirst();

//       await _isar.user.put(editedUser);
//     });
//     // await _isar.close();
//   }

//   // Notes ------------------------------------------
//   @override
//   Future<List<ToDoModel>> fetchNotes() async {
//     await openDB();

//     List<ToDoModel> isarList = [];

//     await _isar.txn(() async {
//       isarList =
//           await _isar.user.where().findFirst().then((value) => value!.notes);
//     });

//     // await _isar.close();
//     return isarList;
//   }

//   @override
//   saveNotes(List<ToDoModel> list) async {
//     await openDB();
//     User? myUser = await _isar.user.where().findFirst();

//     User newUser = myUser!;
//     newUser.notes = list;
//     await _isar.writeTxn(() async {
//       await _isar.user.put(newUser);
//     });
//   }

//   // Classes ------------------------------------------------------------------

//   // Disciplines ------------

//   Future<List<Discipline>> fetchDisciplines() async {
//     await openDB();

//     List<Discipline> disciplineList = [];
//     await _isar.txn(() async {
//       disciplineList = await _isar.discipline.where().findAll();
//     });

//     // await _isar.close();
//     return disciplineList;
//   }

//   deleteDiscipline(Discipline discipline) async {
//     await openDB();

//     final user = await _isar.user.where().findFirst();

//     List<Classes> classes = await _isar.classes
//         .where()
//         .filter()
//         .discipline((q) => q.idEqualTo(discipline.id))
//         .findAll();
//     List<int> classesIds = [];
//     for (var element in classes) {
//       classesIds.add(element.id);
//     }

//     List<Student> students = await _isar.student
//         .where()
//         .filter()
//         .classes((c) => c.discipline((d) => d.nameEqualTo(discipline.name)))
//         .findAll();
//     List<int> studentsIds = [];

//     for (var element in students) {
//       studentsIds.add(element.id);
//     }
//     user?.discipline.remove(discipline);
//     user?.student.removeAll(students);

//     await _isar.writeTxn(() async {
//       await _isar.discipline.delete(discipline.id);
//       await _isar.classes.deleteAll(classesIds);
//       await _isar.student.deleteAll(studentsIds);
//       await user?.discipline.save();
//     });
//   }

//   clearDisciplines() async {
//     await openDB();
//     final user = await _isar.user.where().findFirst();
//     user?.discipline.clear();
//     await _isar.writeTxn(() async {
//       await _isar.discipline.clear();
//       await user?.discipline.save();
//     });
//   }

//   saveDiscipline(Discipline discipline) async {
//     await openDB();
//     final user = await _isar.user.where().findFirst();
//     user?.discipline.add(discipline);

//     await _isar.writeTxn(() async {
//       await _isar.discipline.put(discipline);
//       await _isar.user.put(user!);
//       await user.discipline.save();
//     });
//   }

//   // Class -------------------

//   Future<List<Classes>> fetchClasses() async {
//     await openDB();

//     List<Classes> classesList = [];
//     await _isar.txn(() async {
//       classesList = await _isar.classes.where().findAll();
//     });
//     classesList.isNotEmpty
//         ? classesList.sort(
//             (a, b) => a.name.compareTo(b.name),
//           )
//         : classesList = [];
//     return classesList;
//   }

//   clearClasses() async {
//     await openDB();
//     final classes = await _isar.classes.where().findAll();

//     for (Classes inClass in classes) {
//       await _isar.writeTxn(() async {
//         await _isar.classes.delete(inClass.id);
//       });
//     }
//   }

//   deleteClass(Classes classToDelete) async {
//     await openDB();

//     final user = await _isar.user.where().findFirst();

//     List<Student> students = await _isar.student
//         .where()
//         .filter()
//         .classes((c) => c.idEqualTo(classToDelete.id))
//         .findAll();
//     List<int> studentsIds = [];

//     for (var element in students) {
//       studentsIds.add(element.id);
//     }

//     user?.student.removeAll(students);

//     await _isar.writeTxn(() async {
//       await _isar.classes.delete(classToDelete.id);
//       await _isar.student.deleteAll(studentsIds);
//       await user?.discipline.save();
//     });
//   }

//   saveClass(Discipline discipline, Classes newClass) async {
//     await openDB();

//     Discipline? isarDiscipline = await _isar.discipline
//         .where()
//         .filter()
//         .nameEqualTo(discipline.name)
//         .findFirst();
//     isarDiscipline?.classes.add(newClass);
//     await _isar.writeTxn(() async {
//       await _isar.classes.put(newClass);
//       await isarDiscipline?.classes.save();
//     });
//   }

//   // Students -----------------

//   Future<List<Student>> fetchStudents() async {
//     await openDB();

//     List<Student> studentsList = [];
//     await _isar.txn(() async {
//       studentsList = await _isar.student.where().findAll();
//     });

//     return studentsList;
//   }

//   clearStudents() async {
//     await openDB();
//     final students = await _isar.student.where().findAll();

//     for (Student student in students) {
//       await _isar.writeTxn(() async {
//         await _isar.student.delete(student.id);
//       });
//     }
//   }

//   saveStudents(Classes saveInClass, Student newStudent) async {
//     await openDB();
//     final user = await _isar.user.where().findFirst();
//     newStudent.classes.value = saveInClass;
//     final isarClass = await _isar.classes
//         .where()
//         .filter()
//         .nameEqualTo(saveInClass.name)
//         .findFirst();
//     isarClass?.student.add(newStudent);
//     user?.student.add(newStudent);
//     await _isar.writeTxn(() async {
//       await _isar.student.put(newStudent);
//       await isarClass?.student.save();
//       await user?.student.save();
//     });
//   }

//   deleteStudent(int id) async {
//     await openDB();

//     final user = await _isar.user.where().findFirst();

//     await _isar.writeTxn(() async {
//       await _isar.student.delete(id);
//       await user?.student.save();
//     });
//   }

//   editStudent(Student student) async {
//     await openDB();

//     final user = await _isar.user.where().findFirst();

//     user?.student.add(student);
//     final isarClass = await _isar.classes
//         .where()
//         .filter()
//         .nameEqualTo(student.classes.value!.name)
//         .findFirst();

//     isarClass?.student.add(student);

//     await _isar.writeTxn(() async {
//       await _isar.student.put(student);
//       await user?.student.save();
//       isarClass?.student.save();
//     });
//   }
// }
