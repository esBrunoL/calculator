// This is a basic Flutter widget test for the Calculator app.// This is a basic Flutter widget test.

//

import 'package:flutter/material.dart';// To perform an interaction with a widget in your test, use the WidgetTester

import 'package:flutter_test/flutter_test.dart';// utility in the flutter_test package. For example, you can send tap and scroll

// gestures. You can also use WidgetTester to find child widgets in the widget

import 'package:calculator_app/main.dart';// tree, read text, and verify that the values of widget properties are correct.



void main() {import 'package:flutter/material.dart';

  testWidgets('Calculator app launches and shows initial display', (WidgetTester tester) async {import 'package:flutter_test/flutter_test.dart';

    // Build our app and trigger a frame.

    await tester.pumpWidget(const CalculatorApp());import 'package:calculator_app/main.dart';



    // Verify that the calculator starts with 0 displayed.void main() {

    expect(find.text('0'), findsOneWidget);  testWidgets('Calculator app launches and shows initial display', (WidgetTester tester) async {

        // Build our app and trigger a frame.

    // Verify that calculator buttons are present    await tester.pumpWidget(const CalculatorApp());

    expect(find.text('1'), findsOneWidget);

    expect(find.text('2'), findsOneWidget);    // Verify that the calculator starts with 0 displayed.

    expect(find.text('+'), findsOneWidget);    expect(find.text('0'), findsOneWidget);

    expect(find.text('='), findsOneWidget);    

    expect(find.text('C'), findsOneWidget);    // Verify that calculator buttons are present

    expect(find.text('CE'), findsOneWidget);    expect(find.text('1'), findsOneWidget);

  });    expect(find.text('2'), findsOneWidget);

    expect(find.text('+'), findsOneWidget);

  testWidgets('Calculator performs basic addition', (WidgetTester tester) async {    expect(find.text('='), findsOneWidget);

    // Build our app and trigger a frame.    expect(find.text('C'), findsOneWidget);

    await tester.pumpWidget(const CalculatorApp());    expect(find.text('CE'), findsOneWidget);

  });

    // Tap '5' button

    await tester.tap(find.text('5'));  testWidgets('Calculator performs basic addition', (WidgetTester tester) async {

    await tester.pump();    // Build our app and trigger a frame.

    expect(find.text('5'), findsOneWidget);    await tester.pumpWidget(const CalculatorApp());



    // Tap '+' button    // Tap '5' button

    await tester.tap(find.text('+'));    await tester.tap(find.text('5'));

    await tester.pump();    await tester.pump();

    expect(find.text('5'), findsOneWidget);

    // Tap '3' button

    await tester.tap(find.text('3'));    // Tap '+' button

    await tester.pump();    await tester.tap(find.text('+'));

    expect(find.text('3'), findsOneWidget);    await tester.pump();



    // Tap '=' button    // Tap '3' button

    await tester.tap(find.text('='));    await tester.tap(find.text('3'));

    await tester.pump();    await tester.pump();

        expect(find.text('3'), findsOneWidget);

    // Check result

    expect(find.text('8'), findsOneWidget);    // Tap '=' button

  });    await tester.tap(find.text('='));

}    await tester.pump();
    
    // Check result
    expect(find.text('8'), findsOneWidget);
  });

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
