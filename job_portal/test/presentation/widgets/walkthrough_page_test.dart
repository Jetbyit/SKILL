import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_portal/src/presentation/widgets/walkthrough_page.dart';

void main() {
  group('WalkthroughPage', () {
    testWidgets('renders title and description', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: WalkthroughPage(
            e: null,
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
    });
  });
}
