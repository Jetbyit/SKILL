import 'package:flutter_test/flutter_test.dart';
import 'package:job_portal/src/presentation/screens/walkthrough_screen.dart';

void main() {
  group('WalkthroughScreen', () {
    testWidgets('renders text', (WidgetTester tester) async {
      await tester.pumpWidget(WalkthroughScreen());

      expect(find.text('Walkthrough Screen'), findsOneWidget);
    });
  });
}
