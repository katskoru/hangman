import 'package:flutter/foundation.dart';
import 'package:hang/newGame/data/models/random_words.dart';
import 'package:http/http.dart' as http;

class NewGameProvider extends ChangeNotifier {
  RandomWords? _randomWords;
  RandomWords? get randomWords => _randomWords;
  int? _currentWord;
  int? get currentWord => _currentWord;
  set currentWord(int? newIndex) {
    _currentWord = newIndex;
    notifyListeners();
  }

  set mistakes(int? newMistake) {
    _mistakes = newMistake;
    notifyListeners();
  }

  int? _mistakes;
  int? get mistakes => _mistakes;
  _init() {
    _randomWords = RandomWords(randomWords: [""]);
    _mistakes = 0;
    _currentWord = 0;
    _fetchData();
  }

  Future _fetchData() async {
    try {
      http.Response response = await http.get(
          Uri.parse("https://random-word-api.herokuapp.com/word?number=10"));
      _randomWords = RandomWords.fromJson(response.body);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  NewGameProvider() {
    _init();
  }
  final List _alphabet = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];
  List get alphabet => _alphabet;
}
