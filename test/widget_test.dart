import 'package:flutter_test/flutter_test.dart';

import 'package:dojo_walker_registration/main.dart';

void main() {
  testWidgets(
    'Dojo Walker registration home screen loads',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const DojoWalkerRegistrationApp(),
      );

      expect(
        find.text('Become a Dojo Walker'),
        findsOneWidget,
      );

      expect(
        find.text('Start Registration'),
        findsOneWidget,
      );
    },
  );
}
