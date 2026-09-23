import 'package:flutter_test/flutter_test.dart';
import 'package:powercalc/main.dart';

void main() {
  testWidgets('PowerCalc app launch test', (WidgetTester tester) async {
    await tester.pumpWidget(const PowerCalcApp());

    // Verify app title and calculator elements exist
    expect(find.text('Electricity Cost Calculator'), findsOneWidget);
    expect(find.text('Electricity Usage (kWh) *'), findsOneWidget);
    expect(find.textContaining('COST BREAKDOWN'), findsOneWidget);
  });
}
