import 'package:flutter/material.dart';
import 'about_privacy_screen.dart';
import '../widgets/app_icons.dart';
import '../models/bill_calculation_input.dart';
import '../models/bill_calculation_result.dart';
import '../services/calculator_service.dart';
import '../services/clipboard_service.dart';
import '../theme/app_theme.dart';
import '../widgets/badge_status.dart';
import '../widgets/breakdown_panel.dart';
import '../widgets/quick_usage_chips.dart';
import '../widgets/standing_charges_expansion.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Text Controllers
  final TextEditingController _usageController = TextEditingController(text: '2500');
  final TextEditingController _rateController = TextEditingController(text: '0.168');
  final TextEditingController _standingController = TextEditingController();
  final TextEditingController _deliveryController = TextEditingController();
  final TextEditingController _taxController = TextEditingController();

  // Selected State
  Currency _selectedCurrency = Currency.inr;
  BillingPeriod _selectedBillingPeriod = BillingPeriod.monthly;
  TaxType _selectedTaxType = TaxType.percentage;

  // Validation message
  String? _usageError;
  String? _rateError;

  // Calculation Result
  late BillCalculationResult _result;

  @override
  void initState() {
    super.initState();
    _recalculate();
  }

  @override
  void dispose() {
    _usageController.dispose();
    _rateController.dispose();
    _standingController.dispose();
    _deliveryController.dispose();
    _taxController.dispose();
    super.dispose();
  }

  void _recalculate() {
    final usageText = _usageController.text.trim();
    final rateText = _rateController.text.trim();

    double? usage = double.tryParse(usageText);
    double? rate = double.tryParse(rateText);

    setState(() {
      if (usageText.isEmpty) {
        _usageError = 'Please enter electricity usage.';
      } else if (usage == null || usage <= 0) {
        _usageError = 'Electricity usage must be greater than 0.';
      } else {
        _usageError = null;
      }

      if (rateText.isEmpty) {
        _rateError = 'Please enter electricity rate.';
      } else if (rate == null || rate <= 0) {
        _rateError = 'Electricity rate must be greater than 0.';
      } else {
        _rateError = null;
      }
    });

    final double standing = double.tryParse(_standingController.text.trim()) ?? 0.0;
    final double delivery = double.tryParse(_deliveryController.text.trim()) ?? 0.0;
    final double tax = double.tryParse(_taxController.text.trim()) ?? 0.0;

    if (usage != null && usage > 0 && rate != null && rate > 0) {
      final input = BillCalculationInput(
        usageKwh: usage,
        ratePerKwh: rate,
        currency: _selectedCurrency,
        billingPeriod: _selectedBillingPeriod,
        standingCharge: standing,
        deliveryCharge: delivery,
        taxValue: tax,
        taxType: _selectedTaxType,
      );
      setState(() {
        _result = CalculatorService.calculate(input);
      });
    } else {
      setState(() {
        _result = BillCalculationResult.empty(currency: _selectedCurrency);
      });
    }
  }

  void _reset() {
    setState(() {
      _usageController.text = '2500';
      _rateController.text = '0.168';
      _standingController.clear();
      _deliveryController.clear();
      _taxController.clear();

      _selectedCurrency = Currency.inr;
      _selectedBillingPeriod = BillingPeriod.monthly;
      _selectedTaxType = TaxType.percentage;

      _usageError = null;
      _rateError = null;
    });
    _recalculate();
  }

  Future<void> _handleCopySummary() async {
    final usageText = _usageController.text.trim();
    final rateText = _rateController.text.trim();
    final double usage = double.tryParse(usageText) ?? 2500.0;
    final double rate = double.tryParse(rateText) ?? 0.168;

    final input = BillCalculationInput(
      usageKwh: usage,
      ratePerKwh: rate,
      currency: _selectedCurrency,
      billingPeriod: _selectedBillingPeriod,
      standingCharge: double.tryParse(_standingController.text.trim()) ?? 0.0,
      deliveryCharge: double.tryParse(_deliveryController.text.trim()) ?? 0.0,
      taxValue: double.tryParse(_taxController.text.trim()) ?? 0.0,
      taxType: _selectedTaxType,
    );

    await ClipboardService.copySummaryToClipboard(input, _result);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text('Summary copied'),
            ],
          ),
          backgroundColor: AppTheme.primaryAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                children: [
                  // Top Status Badge & Information Icon (ⓘ)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 44), // Spacer for balance
                      const Expanded(
                        child: Center(child: BadgeStatus()),
                      ),
                      IconButton(
                        icon: AppIcons.info(size: 24, color: AppTheme.textSecondary),
                        tooltip: 'About & Privacy',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const AboutPrivacyScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Main Heading with Electric Logo centered in the middle
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/logo.png',
                          width: 48,
                          height: 48,
                          errorBuilder: (context, error, stackTrace) => AppIcons.logo(size: 48),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Electricity Cost Calculator',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.textPrimary,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Subtitle
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "An electricity cost calculator estimates the cost of electricity from energy consumption and the user's electricity rate. An electricity bill estimator can additionally account for fixed charges, delivery/network charges, taxes, or other applicable charges.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Main Card Container with subtle shadow & crisp border
                  Card(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(22),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final isWide = constraints.maxWidth >= 800;

                          if (isWide) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 11,
                                  child: _buildInputSection(),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  flex: 9,
                                  child: BreakdownPanel(
                                    input: _getCurrentInput(),
                                    result: _result,
                                    onCopySummary: _handleCopySummary,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildInputSection(),
                                const SizedBox(height: 24),
                                BreakdownPanel(
                                  input: _getCurrentInput(),
                                  result: _result,
                                  onCopySummary: _handleCopySummary,
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BillCalculationInput _getCurrentInput() {
    return BillCalculationInput(
      usageKwh: double.tryParse(_usageController.text.trim()) ?? 0.0,
      ratePerKwh: double.tryParse(_rateController.text.trim()) ?? 0.0,
      currency: _selectedCurrency,
      billingPeriod: _selectedBillingPeriod,
      standingCharge: double.tryParse(_standingController.text.trim()) ?? 0.0,
      deliveryCharge: double.tryParse(_deliveryController.text.trim()) ?? 0.0,
      taxValue: double.tryParse(_taxController.text.trim()) ?? 0.0,
      taxType: _selectedTaxType,
    );
  }

  Widget _buildInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Usage Input Label Header with Adaptive Responsiveness
        LayoutBuilder(
          builder: (context, headerConstraints) {
            if (headerConstraints.maxWidth < 360) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Electricity Usage (kWh) *',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'From meter or utility statement',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Electricity Usage (kWh) *',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'From meter or utility statement',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 8),

        TextField(
          controller: _usageController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (_) => _recalculate(),
          decoration: InputDecoration(
            hintText: '2500',
            errorText: _usageError,
            suffixIcon: const Padding(
              padding: EdgeInsets.all(14),
              child: Text(
                'kWh',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryAccent,
                ),
              ),
            ),
            suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          ),
        ),
        const SizedBox(height: 10),

        // Quick buttons
        QuickUsageChips(
          onSelectKwh: (val) {
            _usageController.text = val == val.toInt() ? val.toInt().toString() : val.toString();
            _recalculate();
          },
        ),
        const SizedBox(height: 20),

        // Electricity Rate Input with Currency Selector
        const Text(
          'Electricity Rate (Cost per kWh) *',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Currency Selector Dropdown
            Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.borderColor, width: 1),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Currency>(
                  value: _selectedCurrency,
                  icon: const Icon(Icons.keyboard_arrow_down, color: AppTheme.primaryAccent, size: 20),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                  items: Currency.values.map((c) {
                    return DropdownMenuItem<Currency>(
                      value: c,
                      child: Text(c.label),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        _selectedCurrency = val;
                      });
                      _recalculate();
                    }
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),

            // Rate Numeric Input Field
            Expanded(
              child: TextField(
                controller: _rateController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) => _recalculate(),
                decoration: InputDecoration(
                  hintText: '0.168',
                  errorText: _rateError,
                  suffixIcon: const Padding(
                    padding: EdgeInsets.all(14),
                    child: Text(
                      '/kWh',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryAccent,
                      ),
                    ),
                  ),
                  suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),

        const Text(
          'Enter the rate from your electric bill. Currency selector updates display symbols only.',
          style: TextStyle(
            fontSize: 12,
            color: AppTheme.textSecondary,
          ),
        ),
        const SizedBox(height: 20),

        // Billing Period Segmented Control
        const Text(
          'Billing Period',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),

        Row(
          children: BillingPeriod.values.map((period) {
            final isSelected = _selectedBillingPeriod == period;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedBillingPeriod = period;
                    });
                    _recalculate();
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [AppTheme.primaryAccent, AppTheme.primaryGradientEnd],
                            )
                          : null,
                      color: isSelected ? null : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? AppTheme.primaryAccent : AppTheme.borderColor,
                        width: 1,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppTheme.primaryAccent.withValues(alpha: 0.25),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                      child: Text(
                        period.label,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : AppTheme.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),

        // Expandable Standing Charges & Taxes
        StandingChargesExpansion(
          currency: _selectedCurrency,
          standingController: _standingController,
          deliveryController: _deliveryController,
          taxController: _taxController,
          selectedTaxType: _selectedTaxType,
          onTaxTypeChanged: (type) {
            setState(() {
              _selectedTaxType = type;
            });
            _recalculate();
          },
          onChanged: _recalculate,
        ),
        const SizedBox(height: 24),

        // Action Buttons: Calculate and Reset (Equal 50%/50% Size)
        Row(
          children: [
            Expanded(
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.primaryAccent, AppTheme.primaryGradientEnd],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryAccent.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: _recalculate,
                  icon: AppIcons.bolt(size: 18, color: Colors.white),
                  label: const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Calculate',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: _reset,
                  icon: AppIcons.refresh(size: 16, color: AppTheme.textPrimary),
                  label: const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Reset',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textPrimary),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    side: const BorderSide(color: AppTheme.borderColor, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
