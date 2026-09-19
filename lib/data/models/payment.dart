class Payment {
  final int? id;
  final int studentId;
  final int amount;
  final String paymentDate;

  const Payment({
    this.id,
    required this.studentId,
    required this.amount,
    required this.paymentDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'student_id': studentId,
      'amount': amount,
      'payment_date': paymentDate,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'] as int?,
      studentId: map['student_id'] as int,
      amount: map['amount'] as int,
      paymentDate: map['payment_date'] as String,
    );
  }
}