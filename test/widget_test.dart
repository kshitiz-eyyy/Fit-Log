import 'package:fitlog/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitlog/exercise_details_screen.dart';

void main() {
  testWidgets('ExerciseDetailsScreen displays content correctly',
          (WidgetTester tester) async {
        // Build the ExerciseDetailsScreen
        await tester.pumpWidget(MaterialApp(home: LibraryScreen()));

        // Verify that the title and exercise name appear
        expect(find.text('Chest'), findsOneWidget);
        expect(find.text('Bench Press'), findsOneWidget);

        // Verify that instructions are visible
        expect(find.textContaining('shoulder blades'), findsOneWidget);
        expect(find.textContaining('elbows'), findsOneWidget);
        expect(find.textContaining('glute'), findsOneWidget);
        expect(find.textContaining('wrist'), findsOneWidget);
        expect(find.textContaining('Lower the bar'), findsOneWidget);
      });
}
