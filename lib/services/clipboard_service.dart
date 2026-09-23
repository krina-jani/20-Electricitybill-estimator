import 'package:flutter/services.dart';
import '../models/bill_calculation_input.dart';
import '../models/bill_calculation_result.dart';

class NumberFormatUtil {
  static String formatAmount(double value, String currencySymbol) {
    final isNegative = value < 0;
    final absVal = value.abs();
    final parts = absVal.toStringAsFixed(2).split('.');
    final integerPart = _addCommas(parts[0]);
    final decimalPart = parts[1];
    return '${isNegative ? '-' : ''}$currencySymbol$integerPart.$decimalPart';
  }

  static String formatKwh(double value) {
    final parts = value.toStringAsFixed(2).split('.');
    final integerPart = _addCommas(parts[0]);
    final decimalPart = parts[1];
    if (decimalPart == '00') {
      return '$integerPart kWh';
    }
    return '$integerPart.$decimalPart kWh';
  }

  static String _addCommas(String text) {
    final RegExp reg = RegExp(r'(\d+?)(?=(\d{3})+(?!\d))');
    return text.replaceAllMapped(reg, (Match m) => '${m[1]},');
  }
}

class ClipboardService {
  static String generateSummaryText(BillCalculationInput input, BillCalculationResult result) {
    final symbol = input.currency.symbol;
    final rateStr = '$symbol${input.ratePerKwh}/kWh';
    final usageStr = NumberFormatUtil.formatKwh(input.usageKwh);

    return '''PowerCalc - Electricity Cost Estimate

Electricity Usage:
$usageStr

Electricity Rate:
$rateStr

Billing Period:
${input.billingPeriod.label}

Energy Charges:
${NumberFormatUtil.formatAmount(result.energyCharges, symbol)}

Standing Charges:
${NumberFormatUtil.formatAmount(result.standingCharges, symbol)}

Delivery / Network Charges:
${NumberFormatUtil.formatAmount(result.deliveryCharges, symbol)}

Taxes / Surcharges:
${NumberFormatUtil.formatAmount(result.taxCharges, symbol)}

Total Estimated Bill:
${NumberFormatUtil.formatAmount(result.totalEstimatedBill, symbol)}

Daily Estimate:
${NumberFormatUtil.formatAmount(result.dailyEstimate, symbol)}

Monthly Estimate:
${NumberFormatUtil.formatAmount(result.monthlyEstimate, symbol)}

Annual Estimate:
${NumberFormatUtil.formatAmount(result.annualEstimate, symbol)}''';
  }

  static Future<void> copySummaryToClipboard(BillCalculationInput input, BillCalculationResult result) async {
    final text = generateSummaryText(input, result);
    await Clipboard.setData(ClipboardData(text: text));
  }
}
