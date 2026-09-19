

import '../database/app_database.dart';
import '../models/payment.dart';
import 'payment_allocation_service.dart';

class PaymentRepository {
  PaymentRepository._();

  static final PaymentRepository instance = PaymentRepository._();

  Future<int> addPayment(Payment payment) async {
    final db = await AppDatabase.instance.database;

    return db.insert(
      'payments',
      payment.toMap(),
    );
  }

  Future<List<Payment>> getPayments() async {
    final db = await AppDatabase.instance.database;

    final maps = await db.query(
      'payments',
      orderBy: 'payment_date DESC',
    );

    return maps.map(Payment.fromMap).toList();
  }

  Future<List<Payment>> getStudentPayments(
    int studentId,
  ) async {
    final db = await AppDatabase.instance.database;

    final maps = await db.query(
      'payments',
      where: 'student_id = ?',
      whereArgs: [studentId],
      orderBy: 'payment_date DESC',
    );

    return maps.map(Payment.fromMap).toList();
  }

  Future<void> savePayment({
    required Payment payment,
    required PaymentAllocationResult allocationResult,
  }) async {
    final db = await AppDatabase.instance.database;

    await db.transaction((txn) async {
      // 1. Save payment
      final paymentId = await txn.insert(
        'payments',
        payment.toMap(),
      );

      // 2. Save each month allocation
      for (final allocation in allocationResult.allocations) {
        await txn.insert(
          'payment_allocations',
          {
            'payment_id': paymentId,
            'month': allocation.month,
            'amount': allocation.amount,
          },
        );
      }

      // 3. Update student's advance balance
      await txn.update(
        'students',
        {
          'advance_balance': allocationResult.advanceAmount,
        },
        where: 'id = ?',
        whereArgs: [payment.studentId],
      );
    });
  }
}