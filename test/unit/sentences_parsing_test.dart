import 'package:flutter_test/flutter_test.dart';

import 'package:memorizer/utils/sentences_parser.dart';

void main() {
  test("Parsing sentences validator", () async {
    final sentences = await fetchSentences("Yeah, I'm gonna take my"
        " horse to the old town road. I'm gonna ride 'til I can't no more. "
        "I'm gonna take my horse to the old town road. I'm gonna ride (Kio, Kio)"
        " 'til I can't no more. I got the horses in the back. Horse tack is "
        "attached. Hat is matte black. Got the boots that's black to match.");
    expect(sentences, [
      "Yeah, I'm gonna take my horse to the old town road. ",
      "I'm gonna ride 'til I can't no more. ",
      "I'm gonna take my horse to the old town road. ",
      "I'm gonna ride ",
      "Kio, Kio",
      " 'til I can't no more. ",
      "I got the horses in the back. ",
      "Horse tack is attached. ",
      "Hat is matte black. ",
      "Got the boots that's black to match."
    ]);
  });
}
