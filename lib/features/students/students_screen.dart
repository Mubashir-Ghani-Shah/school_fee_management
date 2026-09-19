
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../data/models/student.dart';
import 'student_details_screen.dart';
import 'student_list_item.dart';
import 'students_provider.dart';

class StudentsScreen extends ConsumerStatefulWidget {
  const StudentsScreen({super.key});

  @override
  ConsumerState<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends ConsumerState<StudentsScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  Timer? _searchDebounce;

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  // Search with 300ms debounce.
  void _onSearchChanged(String query) {
    // Rebuild so the clear button appears/disappears.
    setState(() {});

    _searchDebounce?.cancel();

    _searchDebounce = Timer(
      const Duration(milliseconds: 300),
      () {
        ref
            .read(studentsProvider.notifier)
            .searchStudents(query);
      },
    );
  }

  // Clear search and show all students again.
  void _clearSearch() {
    _searchDebounce?.cancel();

    _searchController.clear();

    setState(() {});

    ref
        .read(studentsProvider.notifier)
        .searchStudents('');
  }

  @override
  Widget build(BuildContext context) {
    final studentsState = ref.watch(studentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list),
            tooltip: 'Filter',
          ),
        ],
      ),

      // Add Student button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddStudentDialog,
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Add Student'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(
          AppSpacing.screenPadding,
        ),
        child: Column(
          children: [
            // Search box
            TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search by name or class',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: _clearSearch,
                        icon: const Icon(Icons.clear),
                        tooltip: 'Clear search',
                      )
                    : null,
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // Student count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'All Students',
                  style: AppTypography.sectionTitle,
                ),
                studentsState.when(
                  loading: () => const Text(
                    'Loading...',
                    style: AppTypography.small,
                  ),
                  error: (_, _) => const Text(
                    'Error',
                    style: AppTypography.small,
                  ),
                  data: (students) => Text(
                    '${students.length} students',
                    style: AppTypography.small,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.md),

            // Student list
            Expanded(
              child: studentsState.when(
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },

                error: (error, stackTrace) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 48,
                          color: AppColors.unpaid,
                        ),
                        const SizedBox(
                          height: AppSpacing.md,
                        ),
                        const Text(
                          'Could not load students.',
                          style: AppTypography.sectionTitle,
                        ),
                        const SizedBox(
                          height: AppSpacing.sm,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ref
                                .read(studentsProvider.notifier)
                                .refreshStudents();
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                },

                data: (students) {
                  if (students.isEmpty) {
                    return const Center(
                      child: _EmptyStudents(),
                    );
                  }

                  return ListView.separated(
                    itemCount: students.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: AppSpacing.sm,
                      );
                    },
                    itemBuilder: (context, index) {
                      final student = students[index];

                     return StudentListItem(
  student: student,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentDetailsScreen(
          student: student,
        ),
      ),
    );
  },
);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Add Student dialog
  void _showAddStudentDialog() {
    final nameController = TextEditingController();
    final classController = TextEditingController();
    final feeController = TextEditingController();

    String category = 'Normal';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              title: const Text('Add Student'),

              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Student name
                    TextField(
                      controller: nameController,
                      textCapitalization:
                          TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: 'Student Name',
                        hintText: 'Enter student name',
                        prefixIcon: Icon(
                          Icons.person_outline,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: AppSpacing.md,
                    ),

                    // Class
                    TextField(
                      controller: classController,
                      decoration: const InputDecoration(
                        labelText: 'Class',
                        hintText: 'e.g. 8th',
                        prefixIcon: Icon(
                          Icons.school_outlined,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: AppSpacing.md,
                    ),

                    // Monthly fee
                    TextField(
                      controller: feeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Monthly Fee',
                        hintText: 'e.g. 1400',
                        prefixIcon: Icon(
                          Icons.payments_outlined,
                        ),
                        prefixText: 'Rs. ',
                      ),
                    ),

                    const SizedBox(
                      height: AppSpacing.md,
                    ),

                    // Category
                    DropdownButtonFormField<String>(
                      initialValue: category,
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        prefixIcon: Icon(
                          Icons.category_outlined,
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Normal',
                          child: Text('Normal'),
                        ),
                        DropdownMenuItem(
                          value: 'Teacher',
                          child: Text('Teacher'),
                        ),
                        DropdownMenuItem(
                          value: 'Orphan',
                          child: Text('Orphan'),
                        ),
                        DropdownMenuItem(
                          value: 'Special',
                          child: Text('Special'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value == null) return;

                        setDialogState(() {
                          category = value;
                        });
                      },
                    ),
                  ],
                ),
              ),

              actions: [
                // Cancel
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Cancel'),
                ),

                // Save
                ElevatedButton(
                  onPressed: () async {
                    final name =
                        nameController.text.trim();

                    final studentClass =
                        classController.text.trim();

                    final fee = int.tryParse(
                      feeController.text.trim(),
                    );

                    // Validate name
                    if (name.isEmpty) {
                      _showDialogError(
                        dialogContext,
                        'Please enter student name.',
                      );
                      return;
                    }

                    // Validate class
                    if (studentClass.isEmpty) {
                      _showDialogError(
                        dialogContext,
                        'Please enter student class.',
                      );
                      return;
                    }

                    // Validate fee.
                    // 0 is allowed.
                    if (fee == null || fee < 0) {
                      _showDialogError(
                        dialogContext,
                        'Please enter a valid fee. Fee can be 0.',
                      );
                      return;
                    }

                    final student = Student(
                      name: name,
                      studentClass: studentClass,
                      monthlyFee: fee,
                      category: category,
                    );

                    try {
                      await ref
                          .read(studentsProvider.notifier)
                          .addStudent(student);
                    } catch (e) {
                      if (!dialogContext.mounted) return;

                      Navigator.pop(dialogContext);

                      if (!mounted) return;

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        SnackBar(
                          content: Text(
                            'Could not save student: $e',
                          ),
                        ),
                      );

                      return;
                    }

                    if (!dialogContext.mounted) return;

                    Navigator.pop(dialogContext);

                    if (!mounted) return;

                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      SnackBar(
                        content: Text(
                          '$name added successfully.',
                        ),
                      ),
                    );
                  },
                  child: const Text('Save Student'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDialogError(
    BuildContext dialogContext,
    String message,
  ) {
    ScaffoldMessenger.of(dialogContext).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

// Empty student state
class _EmptyStudents extends StatelessWidget {
  const _EmptyStudents();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.people_outline,
          size: 64,
          color: AppColors.notDue,
        ),
        const SizedBox(
          height: AppSpacing.md,
        ),
        const Text(
          'No students found',
          style: AppTypography.sectionTitle,
        ),
        const SizedBox(
          height: AppSpacing.sm,
        ),
        const Text(
          'Try another name or class.',
          style: AppTypography.small,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}