import 'package:flutter/material.dart';
import 'app_icons.dart';
import '../models/bill_calculation_input.dart';
import '../theme/app_theme.dart';

class StandingChargesExpansion extends StatefulWidget {
  final Currency currency;
  final TextEditingController standingController;
  final TextEditingController deliveryController;
  final TextEditingController taxController;
  final TaxType selectedTaxType;
  final ValueChanged<TaxType> onTaxTypeChanged;
  final VoidCallback onChanged;

  const StandingChargesExpansion({
    super.key,
    required this.currency,
    required this.standingController,
    required this.deliveryController,
    required this.taxController,
    required this.selectedTaxType,
    required this.onTaxTypeChanged,
    required this.onChanged,
  });

  @override
  State<StandingChargesExpansion> createState() => _StandingChargesExpansionState();
}

class _StandingChargesExpansionState extends State<StandingChargesExpansion> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final symbol = widget.currency.symbol;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: _isExpanded ? const Color(0xFFF8FAFC) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isExpanded ? AppTheme.primaryAccent.withValues(alpha: 0.3) : AppTheme.borderColor,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryAccent.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: _isExpanded
                        ? AppIcons.remove(size: 16, color: AppTheme.primaryAccent)
                        : AppIcons.add(size: 16, color: AppTheme.primaryAccent),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Standing Charges & Taxes / Surcharges',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ),
                  _isExpanded
                      ? AppIcons.chevronUp(size: 20, color: AppTheme.textSecondary)
                      : AppIcons.chevronDown(size: 20, color: AppTheme.textSecondary),
                ],
              ),
            ),
          ),
          if (_isExpanded) ...[
            const Divider(height: 1, color: AppTheme.borderColor),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Standing / Fixed Charge
                  const Text(
                    'Standing / Fixed Charge',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: widget.standingController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (_) => widget.onChanged(),
                    decoration: InputDecoration(
                      hintText: '0.00',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          symbol,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primaryAccent,
                          ),
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Delivery / Network Charges
                  const Text(
                    'Delivery / Network Charges',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: widget.deliveryController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (_) => widget.onChanged(),
                    decoration: InputDecoration(
                      hintText: '0.00',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          symbol,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primaryAccent,
                          ),
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Tax / Surcharge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tax / Surcharge',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppTheme.borderColor, width: 1),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<TaxType>(
                            value: widget.selectedTaxType,
                            isDense: true,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryAccent,
                            ),
                            items: TaxType.values.map((t) {
                              return DropdownMenuItem<TaxType>(
                                value: t,
                                child: Text(t.label),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                widget.onTaxTypeChanged(val);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: widget.taxController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (_) => widget.onChanged(),
                    decoration: InputDecoration(
                      hintText: '0',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          widget.selectedTaxType == TaxType.percentage ? '%' : symbol,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ),
                      suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
