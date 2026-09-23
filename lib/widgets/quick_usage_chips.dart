import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class QuickUsageChips extends StatelessWidget {
  final Function(double value) onSelectKwh;

  const QuickUsageChips({
    super.key,
    required this.onSelectKwh,
  });

  static const List<double> presetValues = [100, 180, 250, 500, 1000];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Text(
          'Quick:',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppTheme.textSecondary,
          ),
        ),
        ...presetValues.map((val) {
          final labelStr = val == 1000 ? '1,000 kWh' : '${val.toInt()} kWh';
          return InkWell(
            onTap: () => onSelectKwh(val),
            borderRadius: BorderRadius.circular(20),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFBFDBFE), width: 1),
              ),
              child: Text(
                labelStr,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryAccent,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
