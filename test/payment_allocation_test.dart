import 'package:flutter_test/flutter_test.dart';

import 'package:school_fee_management/data/repositories/payment_allocation_service.dart';

void main() {
  test('Rs. 5000 pays oldest dues first', () {
    final result = PaymentAllocationService.allocate(
      paymentAmount: 5000,
      monthlyFee: 1400,
      unpaidMonths: {
        'June': 1400,
        'July': 1400,
        'August': 1400,
        'September': 1400,
      },
    );

    expect(result.allocations.length, 4);

    expect(result.allocations[0].month, 'June');
    expect(result.allocations[0].amount, 1400);

    expect(result.allocations[1].month, 'July');
    expect(result.allocations[1].amount, 1400);

    expect(result.allocations[2].month, 'August');
    expect(result.allocations[2].amount, 1400);

    expect(result.allocations[3].month, 'September');
    expect(result.allocations[3].amount, 800);

    expect(result.advanceAmount, 0);
  });

  test('extra payment becomes advance', () {
    final result = PaymentAllocationService.allocate(
      paymentAmount: 6000,
      monthlyFee: 1400,
      unpaidMonths: {
        'June': 1400,
        'July': 1400,
        'August': 1400,
        'September': 1400,
      },
    );

    expect(result.advanceAmount, 400);
  });
}