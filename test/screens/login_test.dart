// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:zoe/main.dart';

void main() {
  testWidgets('Invalid email address', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byKey(const Key("email")), "text");
    await tester.pump();

    expect(find.text('text'), findsOneWidget);
    expect(
        find.text("Bitte gebe eine gültige Email Adresse ein"), findsOneWidget);

    await tester.enterText(find.byKey(const Key("email")), "test@example");
    await tester.pump();

    expect(find.text('test@example'), findsOneWidget);
    expect(
        find.text("Bitte gebe eine gültige Email Adresse ein"), findsOneWidget);
  });

  testWidgets('Valid email address', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byKey(const Key("email")), "test@example.com");
    await tester.pump();

    expect(find.text('test@example.com'), findsOneWidget);
    expect(
        find.text("Bitte gebe eine gültige Email Adresse ein"), findsNothing);
  });

  testWidgets('Hidden password', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    expect(find.text('text'), findsNothing);
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    expect(find.byIcon(Icons.visibility), findsNothing);
    await tester.enterText(find.byKey(const Key("password")), "text");
    await tester.pump();
    final testField = find.descendant(
      // Key of TextFormField
      of: find.byKey(const Key('password')),
      matching: find.byType(TextField),
    );

    expect(tester.widget<TextField>(testField).obscureText, true);
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    expect(find.byIcon(Icons.visibility), findsNothing);
  });

  testWidgets('Display password', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    expect(find.text('text'), findsNothing);
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    expect(find.byIcon(Icons.visibility), findsNothing);
    await tester.enterText(find.byKey(const Key("password")), "text");
    await tester.pump();
    final testField = find.descendant(
      of: find.byKey(const Key('password')),
      matching: find.byType(TextField),
    );
    await tester.tap(find.byIcon(Icons.visibility_off));
    await tester.pump();
    expect(tester.widget<TextField>(testField).obscureText, false);
    expect(find.byIcon(Icons.visibility_off), findsNothing);
    expect(find.byIcon(Icons.visibility), findsOneWidget);
  });
}
