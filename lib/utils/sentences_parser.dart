import 'package:dio/dio.dart';

Future<List<String>> fetchSentences(String text) async {
  Response response;
  List<String> sentences = [];

  try {
    response = await Dio().post(
        "https://aqueous-anchorage-93443.herokuapp.com/sentences",
        data: {'text': text});
    response.data.forEach((json) {
      sentences.add(json["sentence"]);
    });
  } on DioError {
    sentences.addAll(
        fetchSentencesWhenMoofiyDecidesToTurnDownHerokuApplicationAndWhenWeLeastExpectIt(
            text));
  }
  return sentences;
}

Iterable<String>
    fetchSentencesWhenMoofiyDecidesToTurnDownHerokuApplicationAndWhenWeLeastExpectIt(
        String text) {
  List<String> sentences = [];
  RegExp re = RegExp(r"(\w|\s|,|')+[。.?!]*\s*");
  sentences.addAll(re.allMatches(text).map((m) => m.group(0).toString()));
  return sentences;
}
