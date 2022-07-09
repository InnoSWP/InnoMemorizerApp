import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:memorizer/main.dart';

Future<void> addDelay(int ms) async {
  await Future<void>.delayed(Duration(milliseconds: ms));
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('App can go forward and backward preserving functionality', () {
    testWidgets('Open settings page, change something and then return back',
        (tester) async {
      Key buttonKey = const Key("Upload text button");
      Key settingsKey = const Key("Settings button");
      final textInput = find.byType(TextField).first;

      await tester.pumpWidget(const MemorizationApp());

      await tester.showKeyboard(textInput);
      await tester.tap(textInput);
      await tester.enterText(
          textInput,
          "Yeah, I'm gonna take my horse to the old town road. "
          "I'm gonna ride 'til I can't no more. I'm gonna take"
          " my horse to the old town road. I'm gonna ride (Kio, Kio)"
          " 'til I can't no more. I got the horses in the back. Horse"
          " tack is attached. Hat is matte black. Got the boots that's"
          " black to match.");
      tester.printToConsole("Pasted the text in the text field");
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(buttonKey));
      await addDelay(6000);
      await tester.pumpAndSettle();

      tester.printToConsole("Switch to memorize screen");
      await addDelay(3000);

      await tester.tap(find.byKey(settingsKey));
      await addDelay(500);
      await tester.pumpAndSettle();
      tester.printToConsole("Switch to settings page");

      await tester.tap(find.byType(Switch).first);
      await tester.pumpAndSettle();
      tester.printToConsole("Tap on switch");

      await tester.tap(find.byIcon(Icons.arrow_back_rounded));
      await addDelay(500);
      await tester.pumpAndSettle();
      tester.printToConsole("Switch back to memorize screen");

      expect(find.text("Yeah, I'm gonna take my horse to the old town road. "),
          findsOneWidget);
      expect(
          find.text("I'm gonna ride 'til I can't no more. "), findsOneWidget);
      expect(find.text("I'm gonna take my horse to the old town road. "),
          findsOneWidget);
    });
  });
}
