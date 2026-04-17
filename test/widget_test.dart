// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_sample_app/main.dart';

void main() {
  testWidgets('App loads and shows main UI', (WidgetTester tester) async {
// Build the app
    await tester.pumpWidget(const PlaywireFlutterSampleApp());

// Let all initial frames/rendering complete
    await tester.pumpAndSettle();

// Verify that MaterialApp is present
    expect(find.byType(MaterialApp), findsWidgets);

// Verify that main screen (AdTypes) is rendered
    expect(find.byType(Scaffold), findsWidgets);
  });
}
