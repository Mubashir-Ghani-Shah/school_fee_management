class Student {
  final int? id;
  final String name;
  final String studentClass;
  final int monthlyFee;
  final String category;
  final int advanceBalance;

  const Student({
    this.id,
    required this.name,
    required this.studentClass,
    required this.monthlyFee,
    required this.category,
    this.advanceBalance = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'student_class': studentClass,
      'monthly_fee': monthlyFee,
      'category': category,
      'advance_balance': advanceBalance,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] as int?,
      name: map['name'] as String,
      studentClass: map['student_class'] as String,
      monthlyFee: map['monthly_fee'] as int,
      category: map['category'] as String,
      advanceBalance: map['advance_balance'] as int? ?? 0,
    );
  }
}