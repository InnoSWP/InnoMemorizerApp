import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<String> fetchSentences(String text) async {
  Response response;
  try {
    response = await Dio().post(
        "https://aqueous-anchorage-93443.herokuapp.com/sentences",
        data: {'text': text});
    return response.data;
  } catch (e) {
    return e.toString();
  }
}
