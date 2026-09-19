import '../database/app_database.dart';
import '../models/student.dart';

class StudentRepository {
  StudentRepository._();

  static final StudentRepository instance = StudentRepository._();

  Future<int> addStudent(Student student) async {
    final db = await AppDatabase.instance.database;

    return db.insert(
      'students',
      student.toMap(),
    );
  }

  Future<List<Student>> getStudents() async {
    final db = await AppDatabase.instance.database;

    final maps = await db.query(
      'students',
      orderBy: 'name ASC',
    );

    return maps.map(Student.fromMap).toList();
  }

  Future<List<Student>> searchStudents(String query) async {
    final db = await AppDatabase.instance.database;

    final maps = await db.query(
      'students',
      where: 'name LIKE ? OR student_class LIKE ?',
      whereArgs: [
        '%$query%',
        '%$query%',
      ],
      orderBy: 'name ASC',
    );

    return maps.map(Student.fromMap).toList();
  }

  Future<int> updateStudent(Student student) async {
    final db = await AppDatabase.instance.database;

    return db.update(
      'students',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<int> deleteStudent(int id) async {
    final db = await AppDatabase.instance.database;

    return db.delete(
      'students',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}