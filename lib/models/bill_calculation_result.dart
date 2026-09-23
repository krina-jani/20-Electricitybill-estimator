import 'bill_calculation_input.dart';

class BillCalculationResult {
  final double normalizedUsageKwh;
  final double energyCharges;
  final double standingCharges;
  final double deliveryCharges;
  final double taxCharges;
  final double totalEstimatedBill;
  final double dailyEstimate;
  final double monthlyEstimate;
  final double annualEstimate;
  final String currencySymbol;
  final String currencyCode;
  final BillingPeriod billingPeriod;

  const BillCalculationResult({
    required this.normalizedUsageKwh,
    required this.energyCharges,
    required this.standingCharges,
    required this.deliveryCharges,
    required this.taxCharges,
    required this.totalEstimatedBill,
    required this.dailyEstimate,
    required this.monthlyEstimate,
    required this.annualEstimate,
    required this.currencySymbol,
    required this.currencyCode,
    required this.billingPeriod,
  });

  factory BillCalculationResult.empty({Currency currency = Currency.inr}) {
    return BillCalculationResult(
      normalizedUsageKwh: 0.0,
      energyCharges: 0.0,
      standingCharges: 0.0,
      deliveryCharges: 0.0,
      taxCharges: 0.0,
      totalEstimatedBill: 0.0,
      dailyEstimate: 0.0,
      monthlyEstimate: 0.0,
      annualEstimate: 0.0,
      currencySymbol: currency.symbol,
      currencyCode: currency.code,
      billingPeriod: BillingPeriod.monthly,
    );
  }
}
