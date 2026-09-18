import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        onPressed: () {
          _showAddStudentDialog(context);
        },
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Add Student'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        child: Column(
          children: [
            // Search box
            TextField(
              decoration: InputDecoration(
                hintText: 'Search by name or class',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.clear),
                ),
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
                Text(
                  '0 students',
                  style: AppTypography.small,
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.md),

            // Empty state
            const Expanded(
              child: Center(
                child: _EmptyStudents(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Add Student dialog
  void _showAddStudentDialog(BuildContext context) {
    final nameController = TextEditingController();
    final classController = TextEditingController();
    final feeController = TextEditingController();

    String category = 'Normal';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add Student'),

              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Student Name
                    TextField(
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: 'Student Name',
                        hintText: 'Enter student name',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // Class
                    TextField(
                      controller: classController,
                      decoration: const InputDecoration(
                        labelText: 'Class',
                        hintText: 'e.g. 8th',
                        prefixIcon: Icon(Icons.school_outlined),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // Monthly Fee
                    TextField(
                      controller: feeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Monthly Fee',
                        hintText: 'e.g. 1400',
                        prefixIcon: Icon(Icons.payments_outlined),
                        prefixText: 'Rs. ',
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // Category
                    DropdownButtonFormField<String>(
                      initialValue: category,
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        prefixIcon: Icon(Icons.category_outlined),
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
                        if (value != null) {
                          setState(() {
                            category = value;
                          });
                        }
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
                  onPressed: () {
                    final name = nameController.text.trim();
                    final studentClass = classController.text.trim();
                    final feeText = feeController.text.trim();

                    final fee = int.tryParse(feeText);

                    // Validation
                    if (name.isEmpty) {
                      _showError(context, 'Please enter student name.');
                      return;
                    }

                    if (studentClass.isEmpty) {
                      _showError(context, 'Please enter student class.');
                      return;
                    }

                    if (fee == null || fee < 0) {
                      _showError(
                        context,
                        'Please enter a valid fee. Fee can be 0.',
                      );
                      return;
                    }

                    // Temporary success message.
                    // Database will be connected later.
                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(context).showSnackBar(
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

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

class _EmptyStudents extends StatelessWidget {
  const _EmptyStudents();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.people_outline,
          size: 64,
          color: AppColors.notDue,
        ),

        const SizedBox(height: AppSpacing.md),

        const Text(
          'No students yet',
          style: AppTypography.sectionTitle,
        ),

        const SizedBox(height: AppSpacing.sm),

        const Text(
          'Add your first student to get started.',
          style: AppTypography.small,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}