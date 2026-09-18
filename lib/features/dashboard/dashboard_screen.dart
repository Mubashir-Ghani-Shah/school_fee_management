import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keystone Schooling System Bannu'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.cardPadding),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(
                  AppSpacing.radiusLarge,
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back!',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Keystone Schooling System Bannu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.sectionGap),

            // Financial Summary
            const Text(
              'Financial Summary',
              style: AppTypography.sectionTitle,
            ),

            const SizedBox(height: AppSpacing.md),

            Row(
              children: [
                Expanded(
                  child: _SummaryCard(
                    title: 'Collected',
                    amount: 'Rs. 0',
                    icon: Icons.payments_outlined,
                    color: AppColors.paid,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _SummaryCard(
                    title: 'Pending',
                    amount: 'Rs. 0',
                    icon: Icons.pending_actions_outlined,
                    color: AppColors.unpaid,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.md),

            Row(
              children: [
                Expanded(
                  child: _SummaryCard(
                    title: 'Students',
                    amount: '0',
                    icon: Icons.people_outline,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _SummaryCard(
                    title: 'Expenses',
                    amount: 'Rs. 0',
                    icon: Icons.receipt_long_outlined,
                    color: AppColors.partial,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.sectionGap),

            // Quick Actions
            const Text(
              'Quick Actions',
              style: AppTypography.sectionTitle,
            ),

            const SizedBox(height: AppSpacing.md),

            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    icon: Icons.person_add_alt_1,
                    label: 'Add Student',
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _ActionButton(
                    icon: Icons.add_card,
                    label: 'Collect Fee',
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.sectionGap),

            // Collection Trend
            const Text(
              'Collection Trend',
              style: AppTypography.sectionTitle,
            ),

            const SizedBox(height: AppSpacing.md),

            Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(
                  AppSpacing.radiusLarge,
                ),
              ),
              child: const Center(
                child: Text(
                  'Collection chart will appear here',
                  style: AppTypography.small,
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.sectionGap),

            // Recent Payments
            const Text(
              'Recent Payments',
              style: AppTypography.sectionTitle,
            ),

            const SizedBox(height: AppSpacing.md),

            _EmptyCard(
              icon: Icons.payments_outlined,
              text: 'No recent payments',
            ),

            const SizedBox(height: AppSpacing.sectionGap),

            // Pending Dues
            const Text(
              'Pending Dues',
              style: AppTypography.sectionTitle,
            ),

            const SizedBox(height: AppSpacing.md),

            _EmptyCard(
              icon: Icons.check_circle_outline,
              text: 'No pending dues',
            ),

            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.amount,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusLarge,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            title,
            style: AppTypography.small,
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: AppTypography.financialNumber,
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionButton({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon),
      label: Text(label),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  final IconData icon;
  final String text;

  const _EmptyCard({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusLarge,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 36,
            color: AppColors.notDue,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            text,
            style: AppTypography.body,
          ),
        ],
      ),
    );
  }
}