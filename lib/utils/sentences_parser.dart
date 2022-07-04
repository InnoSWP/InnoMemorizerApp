import 'package:dio/dio.dart';

Future<List<String>> fetchSentences(String text) async {
  Response response;
  List<String> sentences = [];

  try {
    var dio = Dio();
    //dio.options.baseUrl = 'https://aqueous-anchorage-93443.herokuapp.com/sentences';
    dio.options.connectTimeout = 2000;
    dio.options.receiveTimeout = 1000;
    //dio.options.method = 'POST';
    //dio.options.data = {'text': text};
    response = await dio.post(
        "https://aqueous-anchorage-93443.herokuapp.com/sentences",
        data: {'text': text}
    );

    response.data.forEach((json) {
      sentences.add(json["sentence"]);
    });
  } on DioError catch (e) {
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
