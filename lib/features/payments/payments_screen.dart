import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  final TextEditingController _studentController =
      TextEditingController();

  final TextEditingController _amountController =
      TextEditingController();

  @override
  void dispose() {
    _studentController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(
          AppSpacing.screenPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Record Payment',
              style: AppTypography.sectionTitle,
            ),

            const SizedBox(
              height: AppSpacing.md,
            ),

            TextField(
              controller: _studentController,
              decoration: const InputDecoration(
                labelText: 'Student',
                hintText: 'Search student by name or class',
                prefixIcon: Icon(
                  Icons.person_search_outlined,
                ),
              ),
            ),

            const SizedBox(
              height: AppSpacing.md,
            ),

            _buildStudentSummary(),

            const SizedBox(
              height: AppSpacing.lg,
            ),

            const Text(
              'Payment Amount',
              style: AppTypography.sectionTitle,
            ),

            const SizedBox(
              height: AppSpacing.md,
            ),

            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
                hintText: 'Enter payment amount',
                prefixIcon: Icon(
                  Icons.payments_outlined,
                ),
                prefixText: 'Rs. ',
              ),
            ),

            const SizedBox(
              height: AppSpacing.lg,
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.check_circle_outline,
                ),
                label: const Text('Record Payment'),
              ),
            ),

            const SizedBox(
              height: AppSpacing.xl,
            ),

            const Text(
              'Recent Payments',
              style: AppTypography.sectionTitle,
            ),

            const SizedBox(
              height: AppSpacing.md,
            ),

            _buildEmptyPayments(),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentSummary() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(
          AppSpacing.cardPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Student Summary',
              style: AppTypography.cardTitle,
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Monthly Fee',
                  style: AppTypography.body,
                ),
                Text(
                  'Rs. 0',
                  style: AppTypography.bodyMedium,
                ),
              ],
            ),
            const SizedBox(
              height: AppSpacing.sm,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Advance Balance',
                  style: AppTypography.body,
                ),
                Text(
                  'Rs. 0',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.advance,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyPayments() {
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
                'Recorded payments will appear here.',
                style: AppTypography.small,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}