import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_custom_combobox/custom_combobox.dart';

void main() {
  group('CustomComboBox', () {
    testWidgets('should display hint text when no value is selected', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: CustomComboBox<String>(
              items: const ['Option 1', 'Option 2'],
              itemToString: (item) => item,
              hintText: 'Select an option',
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Select an option'), findsOneWidget);
    });

    testWidgets('should display selected value', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: CustomComboBox<String>(
              items: const ['Option 1', 'Option 2'],
              itemToString: (item) => item,
              value: 'Option 1',
              hintText: 'Select an option',
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Option 1'), findsOneWidget);
    });

    testWidgets('should filter items based on input', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: CustomComboBox<String>(
              items: const ['Apple', 'Banana', 'Cherry'],
              itemToString: (item) => item,
              hintText: 'Select a fruit',
              onChanged: (_) {},
            ),
          ),
        ),
      );

      // Tap to open the dropdown
      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      // Enter text to filter
      await tester.enterText(find.byType(TextField), 'App');
      await tester.pump();

      // Verify only Apple is shown in the filtered list
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Banana'), findsNothing);
      expect(find.text('Cherry'), findsNothing);
    });
  });
}