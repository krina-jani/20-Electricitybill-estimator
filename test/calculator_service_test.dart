import 'package:flutter_test/flutter_test.dart';
import 'package:powercalc/models/bill_calculation_input.dart';
import 'package:powercalc/services/calculator_service.dart';

void main() {
  group('CalculatorService Tests', () {
    test('Scenario 1: Prompt Test Case (2500 kWh @ 0.168 INR Monthly)', () {
      const input = BillCalculationInput(
        usageKwh: 2500,
        ratePerKwh: 0.168,
        currency: Currency.inr,
        billingPeriod: BillingPeriod.monthly,
        standingCharge: 0,
        deliveryCharge: 0,
        taxValue: 0,
      );

      final result = CalculatorService.calculate(input);

      expect(result.energyCharges, closeTo(420.00, 0.001));
      expect(result.totalEstimatedBill, closeTo(420.00, 0.001));
      expect(result.dailyEstimate, closeTo(14.00, 0.001));
      expect(result.monthlyEstimate, closeTo(420.00, 0.001));
      expect(result.annualEstimate, closeTo(5110.00, 0.001));
      expect(result.currencySymbol, '₹');
    });

    test('Scenario 2: Usage 1000 kWh @ ₹8 rate', () {
      const input = BillCalculationInput(
        usageKwh: 1000,
        ratePerKwh: 8.0,
        currency: Currency.inr,
        billingPeriod: BillingPeriod.monthly,
      );

      final result = CalculatorService.calculate(input);

      expect(result.energyCharges, closeTo(8000.00, 0.001));
      expect(result.totalEstimatedBill, closeTo(8000.00, 0.001));
    });

    test('Scenario 3: USD Currency test', () {
      const input = BillCalculationInput(
        usageKwh: 500,
        ratePerKwh: 0.20,
        currency: Currency.usd,
        billingPeriod: BillingPeriod.monthly,
      );

      final result = CalculatorService.calculate(input);

      expect(result.energyCharges, closeTo(100.00, 0.001));
      expect(result.currencySymbol, r'$');
    });

    test('Scenario 4: Daily Billing Period test', () {
      const input = BillCalculationInput(
        usageKwh: 10,
        ratePerKwh: 0.20,
        billingPeriod: BillingPeriod.daily,
      );

      final result = CalculatorService.calculate(input);

      expect(result.energyCharges, closeTo(2.00, 0.001));
      expect(result.dailyEstimate, closeTo(2.00, 0.001));
      expect(result.monthlyEstimate, closeTo(60.00, 0.001)); // 2 * 30
      expect(result.annualEstimate, closeTo(730.00, 0.001)); // 2 * 365
    });

    test('Scenario 5: Annual Billing Period test', () {
      const input = BillCalculationInput(
        usageKwh: 3650,
        ratePerKwh: 0.10,
        billingPeriod: BillingPeriod.annual,
      );

      final result = CalculatorService.calculate(input);

      expect(result.totalEstimatedBill, closeTo(365.00, 0.001));
      expect(result.dailyEstimate, closeTo(1.00, 0.001));
      expect(result.monthlyEstimate, closeTo(30.00, 0.001));
      expect(result.annualEstimate, closeTo(365.00, 0.001));
    });

    test('Scenario 6: Extra Standing Charges & Tax Percentage', () {
      const input = BillCalculationInput(
        usageKwh: 1000,
        ratePerKwh: 0.50, // 500
        standingCharge: 50,
        deliveryCharge: 50, // Subtotal 600
        taxValue: 10, // 10% tax = 60
        taxType: TaxType.percentage,
        billingPeriod: BillingPeriod.monthly,
      );

      final result = CalculatorService.calculate(input);

      expect(result.energyCharges, closeTo(500.00, 0.001));
      expect(result.standingCharges, closeTo(50.00, 0.001));
      expect(result.deliveryCharges, closeTo(50.00, 0.001));
      expect(result.taxCharges, closeTo(60.00, 0.001));
      expect(result.totalEstimatedBill, closeTo(660.00, 0.001));
    });
  });
}
