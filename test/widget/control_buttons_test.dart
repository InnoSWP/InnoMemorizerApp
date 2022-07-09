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
        "Yeah, I'm gonna take my"
        " horse to the old town road. I'm gonna ride 'til I can't no more. "
        "I'm gonna take my horse to the old town road. I'm gonna ride (Kio, Kio)"
        " 'til I can't no more. I got the horses in the back. Horse tack is "
        "attached. Hat is matte black. Got the boots that's black to match.");
    await tester.tap(find.byKey(buttonKey));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.skip_next_rounded));
    await tester.pumpAndSettle();

    expect(find.text("Yeah, I'm gonna take my horse to the old town road."),
        findsOneWidget);
    expect(find.text("I'm gonna ride 'til I can't no more."), findsOneWidget);
    expect(find.text("I'm gonna take my horse to the old town road."),
        findsOneWidget);
  });
}
