import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:memorizer/main.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows building and interacting
  // with widgets in the test environment.
  testWidgets('App can go forward and backward preserving functionality',
      (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(const MemorizationApp());

    await tester.enterText(find.byType(TextField),
        "Yeah, I'm gonna take my horse to the old town road.");
    await tester.tap(find.byType(ElevatedButton));

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.enterText(find.byType(TextField),
        "Hat is matte black. Got the boots that's black to match.");
    await tester.tap(find.byType(ElevatedButton));

    expect(find.text('Hat is matte black.'), findsOneWidget);
    expect(find.text("Got the boots that's black to match."), findsOneWidget);
  });
}
