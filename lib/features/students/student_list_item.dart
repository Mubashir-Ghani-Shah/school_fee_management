import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../data/models/student.dart';

class StudentListItem extends StatelessWidget {
  final Student student;
  final VoidCallback? onTap;

  const StudentListItem({
    super.key,
    required this.student,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,

        leading: CircleAvatar(
          backgroundColor: AppColors.advanceBackground,
          child: Text(
            _firstLetter(student.name),
            style: const TextStyle(
              color: AppColors.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        title: Text(
          student.name,
          style: AppTypography.bodyMedium,
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(
            top: AppSpacing.xs,
          ),
          child: Text(
            '${student.studentClass} • ${student.category}',
            style: AppTypography.small,
          ),
        ),

        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Rs. ${student.monthlyFee}',
              style: AppTypography.bodyMedium,
            ),
            const SizedBox(height: 2),
            const Text(
              'Monthly',
              style: AppTypography.small,
            ),
          ],
        ),
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