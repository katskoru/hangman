import 'dart:convert';

class RandomWords {
  List<String>? randomWords;

  RandomWords({
    this.randomWords,
  });
  RandomWords.fromJson(json) {
    randomWords = json;
  }
}
