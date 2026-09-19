import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'features/students/students_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: SchoolFeeApp(),
    ),
  );
}

class SchoolFeeApp extends StatelessWidget {
  const SchoolFeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'School Fee Management',
      theme: AppTheme.lightTheme,
      home: const StudentsScreen(),
    );
  }
}