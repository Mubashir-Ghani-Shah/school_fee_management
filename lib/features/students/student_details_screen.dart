import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../data/models/student.dart';

class StudentDetailsScreen extends StatelessWidget {
  final Student student;

  const StudentDetailsScreen({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
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
            // Student profile
            _buildProfileCard(),

            const SizedBox(
              height: AppSpacing.lg,
            ),

            // Fee information
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

            // Payment history
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

            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
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
              backgroundColor: AppColors.advanceBackground,
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

  String _firstLetter(String name) {
    final trimmedName = name.trim();

    if (trimmedName.isEmpty) {
      return '?';
    }

    return trimmedName[0].toUpperCase();
  }
}