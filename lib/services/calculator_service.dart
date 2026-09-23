import '../models/bill_calculation_input.dart';
import '../models/bill_calculation_result.dart';

class CalculatorService {
  static BillCalculationResult calculate(BillCalculationInput input) {
    if (input.usageKwh <= 0 || input.ratePerKwh <= 0) {
      return BillCalculationResult.empty(currency: input.currency);
    }

    final double usage = input.usageKwh;
    final double rate = input.ratePerKwh;

    // Base energy cost for the selected billing period
    final double energyCharges = usage * rate;

    final double standing = input.standingCharge < 0 ? 0.0 : input.standingCharge;
    final double delivery = input.deliveryCharge < 0 ? 0.0 : input.deliveryCharge;

    final double subtotalBeforeTax = energyCharges + standing + delivery;

    double taxCharges = 0.0;
    if (input.taxValue > 0) {
      if (input.taxType == TaxType.percentage) {
        taxCharges = subtotalBeforeTax * (input.taxValue / 100.0);
      } else {
        taxCharges = input.taxValue;
      }
    }

    final double totalForSelectedPeriod = subtotalBeforeTax + taxCharges;
    final int periodDays = input.billingPeriod.days;

    // Daily estimate normalized
    final double dailyEstimate = totalForSelectedPeriod / periodDays;
    final double monthlyEstimate = dailyEstimate * 30.0;
    final double annualEstimate = dailyEstimate * 365.0;

    return BillCalculationResult(
      normalizedUsageKwh: usage,
      energyCharges: energyCharges,
      standingCharges: standing,
      deliveryCharges: delivery,
      taxCharges: taxCharges,
      totalEstimatedBill: totalForSelectedPeriod,
      dailyEstimate: dailyEstimate,
      monthlyEstimate: monthlyEstimate,
      annualEstimate: annualEstimate,
      currencySymbol: input.currency.symbol,
      currencyCode: input.currency.code,
      billingPeriod: input.billingPeriod,
    );
  }
}
