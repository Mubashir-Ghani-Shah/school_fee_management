class PaymentAllocation {
  final String month;
  final int amount;

  const PaymentAllocation({
    required this.month,
    required this.amount,
  });
}

class PaymentAllocationResult {
  final List<PaymentAllocation> allocations;
  final int advanceAmount;

  const PaymentAllocationResult({
    required this.allocations,
    required this.advanceAmount,
  });
}

class PaymentAllocationService {
  PaymentAllocationService._();

  static PaymentAllocationResult allocate({
    required int paymentAmount,
    required int monthlyFee,
    required Map<String, int> unpaidMonths,
    int advanceBalance = 0,
  }) {
    int remainingPayment = paymentAmount;
    final allocations = <PaymentAllocation>[];

    // Use existing advance first.
    if (advanceBalance > 0 && remainingPayment > 0) {
      final usedAdvance = advanceBalance < remainingPayment
          ? advanceBalance
          : remainingPayment;

      remainingPayment -= usedAdvance;
    }

    // Oldest unpaid/current month first.
    for (final entry in unpaidMonths.entries) {
      if (remainingPayment <= 0) {
        break;
      }

      final monthDue = entry.value;

      if (monthDue <= 0) {
        continue;
      }

      final amount = remainingPayment < monthDue
          ? remainingPayment
          : monthDue;

      allocations.add(
        PaymentAllocation(
          month: entry.key,
          amount: amount,
        ),
      );

      remainingPayment -= amount;
    }

    // Anything left becomes advance.
    return PaymentAllocationResult(
      allocations: allocations,
      advanceAmount: remainingPayment,
    );
  }
}