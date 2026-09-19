import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../data/models/student.dart';
import 'students_provider.dart';

class StudentDetailsScreen extends ConsumerWidget {
  final Student student;

  const StudentDetailsScreen({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(
          AppSpacing.screenPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileCard(),

            const SizedBox(
              height: AppSpacing.lg,
            ),

            const Text(
              'Fee Information',
              style: AppTypography.sectionTitle,
            ),

            const SizedBox(
              height: AppSpacing.md,
            ),

            _buildFeeCard(),

            const SizedBox(
              height: AppSpacing.lg,
            ),

            const Text(
              'Payment History',
              style: AppTypography.sectionTitle,
            ),

            const SizedBox(
              height: AppSpacing.md,
            ),

            _buildEmptyPaymentHistory(),

            const SizedBox(
              height: AppSpacing.lg,
            ),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showEditStudentDialog(
                        context,
                        ref,
                      );
                    },
                    icon: const Icon(
                      Icons.edit_outlined,
                    ),
                    label: const Text('Edit'),
                  ),
                ),
                const SizedBox(
                  width: AppSpacing.md,
                ),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.payments_outlined,
                    ),
                    label: const Text('Payment'),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: AppSpacing.md,
            ),

            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.unpaid,
                ),
                icon: const Icon(
                  Icons.delete_outline,
                ),
                label: const Text('Delete Student'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(
          AppSpacing.cardPadding,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor:
                  AppColors.advanceBackground,
              child: Text(
                _firstLetter(student.name),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
              ),
            ),

            const SizedBox(
              width: AppSpacing.md,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    style: AppTypography.sectionTitle,
                  ),
                  const SizedBox(
                    height: AppSpacing.xs,
                  ),
                  Text(
                    'Class: ${student.studentClass}',
                    style: AppTypography.body,
                  ),
                  const SizedBox(
                    height: AppSpacing.xs,
                  ),
                  Text(
                    student.category,
                    style: AppTypography.small,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeeCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(
          AppSpacing.cardPadding,
        ),
        child: Column(
          children: [
            _buildFeeRow(
              'Monthly Fee',
              'Rs. ${student.monthlyFee}',
            ),

            const Divider(
              height: AppSpacing.lg,
            ),

            _buildFeeRow(
              'Advance Balance',
              'Rs. ${student.advanceBalance}',
              valueColor: AppColors.advance,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeeRow(
    String title,
    String value, {
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTypography.body,
        ),
        Text(
          value,
          style: AppTypography.bodyMedium.copyWith(
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyPaymentHistory() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(
          AppSpacing.lg,
        ),
        child: Center(
          child: Column(
            children: [
              const Icon(
                Icons.receipt_long_outlined,
                size: 48,
                color: AppColors.notDue,
              ),
              const SizedBox(
                height: AppSpacing.md,
              ),
              const Text(
                'No payments yet',
                style: AppTypography.cardTitle,
              ),
              const SizedBox(
                height: AppSpacing.xs,
              ),
              const Text(
                'Student payment history will appear here.',
                style: AppTypography.small,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditStudentDialog(
    BuildContext context,
    WidgetRef ref,
  ) {
    final nameController = TextEditingController(
      text: student.name,
    );

    final classController = TextEditingController(
      text: student.studentClass,
    );

    final feeController = TextEditingController(
      text: student.monthlyFee.toString(),
    );

    String category = student.category;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (
            dialogContext,
            setDialogState,
          ) {
            return AlertDialog(
              title: const Text('Edit Student'),

              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      textCapitalization:
                          TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: 'Student Name',
                        prefixIcon: Icon(
                          Icons.person_outline,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: AppSpacing.md,
                    ),

                    TextField(
                      controller: classController,
                      decoration: const InputDecoration(
                        labelText: 'Class',
                        prefixIcon: Icon(
                          Icons.school_outlined,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: AppSpacing.md,
                    ),

                    TextField(
                      controller: feeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Monthly Fee',
                        prefixIcon: Icon(
                          Icons.payments_outlined,
                        ),
                        prefixText: 'Rs. ',
                      ),
                    ),

                    const SizedBox(
                      height: AppSpacing.md,
                    ),

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
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Cancel'),
                ),

                ElevatedButton(
                  onPressed: () async {
                    final name =
                        nameController.text.trim();

                    final studentClass =
                        classController.text.trim();

                    final fee = int.tryParse(
                      feeController.text.trim(),
                    );

                    if (name.isEmpty) {
                      _showError(
                        dialogContext,
                        'Please enter student name.',
                      );
                      return;
                    }

                    if (studentClass.isEmpty) {
                      _showError(
                        dialogContext,
                        'Please enter student class.',
                      );
                      return;
                    }

                    if (fee == null || fee < 0) {
                      _showError(
                        dialogContext,
                        'Please enter a valid fee. Fee can be 0.',
                      );
                      return;
                    }

                    final updatedStudent = Student(
                      id: student.id,
                      name: name,
                      studentClass: studentClass,
                      monthlyFee: fee,
                      category: category,
                      advanceBalance:
                          student.advanceBalance,
                    );

                    try {
                      await ref
                          .read(
                            studentsProvider.notifier,
                          )
                          .updateStudent(
                            updatedStudent,
                          );
                    } catch (e) {
                      if (!dialogContext.mounted) {
                        return;
                      }

                      Navigator.pop(dialogContext);

                      if (!context.mounted) {
                        return;
                      }

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        SnackBar(
                          content: Text(
                            'Could not update student: $e',
                          ),
                        ),
                      );

                      return;
                    }

                    if (!dialogContext.mounted) {
                      return;
                    }

                    Navigator.pop(dialogContext);

                    if (!context.mounted) {
                      return;
                    }

                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Student updated successfully.',
                        ),
                      ),
                    );

                    // Refresh the details screen with
                    // the updated student data.
                    Navigator.pop(context);
                  },
                  child: const Text('Save Changes'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showError(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  String _firstLetter(String name) {
    final trimmedName = name.trim();

    if (trimmedName.isEmpty) {
      return '?';
    }

    return trimmedName[0].toUpperCase();
  }
}