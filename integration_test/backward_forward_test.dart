import 'package:flutter/services.dart';
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
  group('end-to-end test', () {
    testWidgets('Proceed to the memorize screen after inputting text',
        (tester) async {
      Key buttonKey = const Key("Upload text button");
      final textInput = find.byType(TextField).first;

      await tester.pumpWidget(const MemorizationApp());

      await tester.showKeyboard(textInput);
      await tester.tap(textInput);
      await tester.enterText(
          textInput,
          "Yeah, I'm gonna take my "
          "horse to the old town road.");
      tester.printToConsole("Pasted the text in the text field");
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(buttonKey));
      await addDelay(8000);
      await tester.pumpAndSettle();
      tester.printToConsole("Switched to memorize screen");

      await tester.tap(find.byIcon(Icons.arrow_back_rounded));
      tester.printToConsole("Returned back to main screen");
      await tester.pumpAndSettle();

      await tester.showKeyboard(textInput);
      await tester.tap(textInput);
      await tester.enterText(
          textInput,
          "Hat is matte black. Got "
          "the boots that's black to match.");
      tester.printToConsole("Pasted the text in the text field for the second time");
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(buttonKey));
      await addDelay(8000);
      await tester.pumpAndSettle();

      expect(find.text('Hat is matte black. '), findsOneWidget);
      expect(find.text("Got the boots that's black to match."), findsOneWidget);
    });
  });
}
