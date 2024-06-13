import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/my_classes/models/discipline.dart';
import 'package:class_manager_two/app/my_classes/models/student.dart';
import 'package:class_manager_two/app/notes/models/todomodel.dart';
import 'package:class_manager_two/app/user/user.dart';

abstract class IRepository {
  openDB();

  createUser(User newUser);

  Future<String?> fetchSchedules();
  saveSchedules(String path);
  deleteSchedules();

  Future<List<ToDoModel>> fetchNotes();
  saveNotes(List<ToDoModel> list);

  Future<List<Discipline>> fetchDisciplines();
  deleteDiscipline(Discipline discipline);
  clearDisciplines();
  saveDiscipline(Discipline discipline);

  Future<List<Classes>> fetchClasses();
  clearClasses();
  deleteClass(Classes classToDelete);
  saveClass(Discipline discipline, Classes newClass);

  Future<List<Student>> fetchStudents();
  clearStudents();
  saveStudents(Classes saveInClass, Student newStudent);
  deleteStudent(int id);
  editStudent(Student student);
}
