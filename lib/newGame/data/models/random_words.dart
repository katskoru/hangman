import 'dart:convert';

class RandomWords {
  List? randomWords;

  RandomWords({
    this.randomWords,
  });
  RandomWords.fromJson(String json) {
    randomWords = jsonDecode(json);
  }
}
