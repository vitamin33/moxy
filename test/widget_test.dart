import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moxy/ui/screens/admin/pages/transactions/transactions_page.dart';

void main() {
  testWidgets('TransactionsPage Widget Test', (WidgetTester widgetTester) async {

    await widgetTester.pumpWidget(
     const MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr, 
          child: TransactionsPage(),
        ),
      ),
    );

    final textWidget = find.text('Transactions');

    expect(textWidget, findsOneWidget);
  });
}
