enum Currency {
  inr(symbol: '₹', code: 'INR', label: 'INR (₹)'),
  usd(symbol: r'$', code: 'USD', label: r'USD ($)');

  final String symbol;
  final String code;
  final String label;

  const Currency({
    required this.symbol,
    required this.code,
    required this.label,
  });
}

enum BillingPeriod {
  daily(label: 'Daily (1d)', shortLabel: 'Daily', days: 1),
  monthly(label: 'Monthly (30d)', shortLabel: 'Monthly', days: 30),
  annual(label: 'Annual (365d)', shortLabel: 'Annual', days: 365);

  final String label;
  final String shortLabel;
  final int days;

  const BillingPeriod({
    required this.label,
    required this.shortLabel,
    required this.days,
  });
}

enum TaxType {
  percentage(label: 'Percentage (%)'),
  fixed(label: 'Fixed Amount');

  final String label;

  const TaxType({required this.label});
}

class BillCalculationInput {
  final double usageKwh;
  final double ratePerKwh;
  final Currency currency;
  final BillingPeriod billingPeriod;
  final double standingCharge;
  final double deliveryCharge;
  final double taxValue;
  final TaxType taxType;

  const BillCalculationInput({
    required this.usageKwh,
    required this.ratePerKwh,
    this.currency = Currency.inr,
    this.billingPeriod = BillingPeriod.monthly,
    this.standingCharge = 0.0,
    this.deliveryCharge = 0.0,
    this.taxValue = 0.0,
    this.taxType = TaxType.percentage,
  });

  BillCalculationInput copyWith({
    double? usageKwh,
    double? ratePerKwh,
    Currency? currency,
    BillingPeriod? billingPeriod,
    double? standingCharge,
    double? deliveryCharge,
    double? taxValue,
    TaxType? taxType,
  }) {
    return BillCalculationInput(
      usageKwh: usageKwh ?? this.usageKwh,
      ratePerKwh: ratePerKwh ?? this.ratePerKwh,
      currency: currency ?? this.currency,
      billingPeriod: billingPeriod ?? this.billingPeriod,
      standingCharge: standingCharge ?? this.standingCharge,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      taxValue: taxValue ?? this.taxValue,
      taxType: taxType ?? this.taxType,
    );
  }
}
