import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:memorizer/utils/sentences_parser.dart';
import 'package:memorizer/widgets/memorize.dart';

void main() {
  List<String> sentences = [];
  testWidgets('Control buttons', (tester) async {
    Key nextSentence = const Key("Next sentence");

    tester.printToConsole("Started fetching sentences");
    sentences.addAll(
        fetchSentencesWhenMoofiyDecidesToTurnDownHerokuApplicationAndWhenWeLeastExpectIt(
            "Yeah, I'm gonna take my"
            " horse to the old town road. I'm gonna ride 'til I can't no more. "
            "I'm gonna take my horse to the old town road. I'm gonna ride (Kio, Kio)"
            " 'til I can't no more. I got the horses in the back. Horse tack is "
            "attached. Hat is matte black. Got the boots that's black to match."));

    tester.printToConsole("Fetched sentences");
    Widget testWidget = MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
            home: MemorizeScreen(title: 'Memorize', sentences: sentences)));
    await tester.pumpWidget(testWidget);

    await tester.tap(find.byKey(nextSentence));
    await tester.pumpAndSettle();
    tester.printToConsole("Moved to the next sentence");

    expect(find.text("Yeah, I'm gonna take my horse to the old town road. "),
        findsOneWidget);
    expect(find.text("I'm gonna ride 'til I can't no more. "), findsOneWidget);
    expect(find.text("I'm gonna take my horse to the old town road. "),
        findsOneWidget);
  });
}
