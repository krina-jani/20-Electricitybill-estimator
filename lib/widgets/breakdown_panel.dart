import 'package:flutter/material.dart';
import 'app_icons.dart';
import '../models/bill_calculation_input.dart';
import '../models/bill_calculation_result.dart';
import '../services/clipboard_service.dart';
import '../theme/app_theme.dart';

class BreakdownPanel extends StatelessWidget {
  final BillCalculationInput input;
  final BillCalculationResult result;
  final VoidCallback onCopySummary;

  const BreakdownPanel({
    super.key,
    required this.input,
    required this.result,
    required this.onCopySummary,
  });

  @override
  Widget build(BuildContext context) {
    final symbol = result.currencySymbol;

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with COST BREAKDOWN and selected period pill
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppIcons.pieChart(size: 16, color: AppTheme.primaryAccent),
                      const SizedBox(width: 6),
                      const Text(
                        'COST BREAKDOWN',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textSecondary,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 6),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.primaryAccent, AppTheme.primaryGradientEnd],
                    ),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryAccent.withValues(alpha: 0.25),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    input.billingPeriod.label,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Total Estimated Bill Banner Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFEFF6FF), Color(0xFFF0F9FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFBFDBFE), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Estimated Bill',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.badgeText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  NumberFormatUtil.formatAmount(result.totalEstimatedBill, symbol),
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Calculated based on your tariff rates & selected period.',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          const Divider(height: 1, color: AppTheme.borderColor),
          const SizedBox(height: 16),

          // Itemized list
          _buildRow('Energy Consumption:', NumberFormatUtil.formatKwh(result.normalizedUsageKwh)),
          const SizedBox(height: 10),
          _buildRow('Energy Charges:', NumberFormatUtil.formatAmount(result.energyCharges, symbol)),
          const SizedBox(height: 10),
          _buildRow('Standing Charges:', NumberFormatUtil.formatAmount(result.standingCharges, symbol)),
          const SizedBox(height: 10),
          _buildRow('Delivery / Network:', NumberFormatUtil.formatAmount(result.deliveryCharges, symbol)),
          const SizedBox(height: 10),
          _buildRow('Taxes / Surcharges:', NumberFormatUtil.formatAmount(result.taxCharges, symbol)),

          const SizedBox(height: 24),

          // RESULTS section
          Row(
            children: [
              AppIcons.chart(size: 16, color: AppTheme.primaryAccent),
              const SizedBox(width: 6),
              const Text(
                'RESULTS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textSecondary,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // 3 Small Cards (Daily, Monthly, Annual)
          Row(
            children: [
              Expanded(
                child: _buildResultCard(
                  'Daily (1d)',
                  NumberFormatUtil.formatAmount(result.dailyEstimate, symbol),
                  isCurrent: input.billingPeriod == BillingPeriod.daily,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildResultCard(
                  'Monthly (30d)',
                  NumberFormatUtil.formatAmount(result.monthlyEstimate, symbol),
                  isCurrent: input.billingPeriod == BillingPeriod.monthly,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildResultCard(
                  'Annual (365d)',
                  NumberFormatUtil.formatAmount(result.annualEstimate, symbol),
                  isCurrent: input.billingPeriod == BillingPeriod.annual,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Copy Summary Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onCopySummary,
              icon: AppIcons.copy(size: 16, color: AppTheme.primaryAccent),
              label: const Text(
                'Copy Summary',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: AppTheme.borderColor, width: 1),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              color: AppTheme.textSecondary,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
            fontFeatures: [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }

  Widget _buildResultCard(String title, String amount, {required bool isCurrent}) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isCurrent ? const Color(0xFFF0F9FF) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isCurrent ? const Color(0xFF93C5FD) : AppTheme.borderColor,
          width: isCurrent ? 1.5 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isCurrent ? AppTheme.primaryAccent : AppTheme.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              amount,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
