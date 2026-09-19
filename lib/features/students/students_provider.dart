import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/student.dart';
import '../../data/repositories/student_repository.dart';

final studentsProvider =
    AsyncNotifierProvider<StudentsNotifier, List<Student>>(
  StudentsNotifier.new,
);

class StudentsNotifier extends AsyncNotifier<List<Student>> {
  final StudentRepository _repository =
      StudentRepository.instance;

  @override
  Future<List<Student>> build() async {
    return _repository.getStudents();
  }

  Future<void> refreshStudents() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () => _repository.getStudents(),
    );
  }

  Future<void> addStudent(Student student) async {
    await _repository.addStudent(student);

    state = await AsyncValue.guard(
      () => _repository.getStudents(),
    );
  }

  Future<void> deleteStudent(int id) async {
    await _repository.deleteStudent(id);

    state = await AsyncValue.guard(
      () => _repository.getStudents(),
    );
  }

  Future<void> searchStudents(String query) async {
    final searchQuery = query.trim();

    if (searchQuery.isEmpty) {
      await refreshStudents();
      return;
    }

    state = await AsyncValue.guard(
      () => _repository.searchStudents(searchQuery),
    );
  }
}