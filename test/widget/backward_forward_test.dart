import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:memorizer/main.dart';

void main() {
  testWidgets('App can go forward and backward preserving functionality',
      (tester) async {
    Key buttonKey = const Key("Upload text button");
    await tester.pumpWidget(const MemorizationApp());

    await tester.enterText(
        find.byType(TextField),
        "Yeah, I'm gonna take my "
        "horse to the old town road.");
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(buttonKey));
    await tester.pumpAndSettle();

    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byType(TextField),
        "Hat is matte black. Got "
        "the boots that's black to match.");
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(buttonKey));
    await tester.pumpAndSettle();

    expect(find.text('Hat is matte black.'), findsOneWidget);
    expect(find.text("Got the boots that's black to match."), findsOneWidget);
  });
}
