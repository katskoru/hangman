import 'dart:async';

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

  List<String>? _passedWords;
  List<String>? get passedWords => _passedWords;
  set passedWords(List<String>? newList) {
    _passedWords = newList;
    notifyListeners();
  }

  addPassedLetter(String letter) {
    _passedWords!.add(letter);
    notifyListeners();
  }

  // set passedWords(List<String>? newList) {
  //   _passedWords = newList;
  //   notifyListeners();
  // }
  bool? _loading;
  int? _mistakes;
  int? get mistakes => _mistakes;
  bool? get loading => _loading;

  set loading(bool? newLoad) {
    _loading = newLoad;
    notifyListeners();
  }

  bool? _moveToNextLevel;

  bool? get moveToNextLevel => _moveToNextLevel;

  set moveToNextLevel(bool? newLevel) {
    _moveToNextLevel = newLevel;
    notifyListeners();
  }

  init() {
    _randomWords = RandomWords(randomWords: [""]);
    _mistakes = 0;
    _passedWords = [];
    _currentWord = 0;
    _loading = true;
    _moveToNextLevel = false;
    _fetchData();
  }

  Future _fetchData() async {
    try {
      http.Response response = await http.get(
          Uri.parse("https://random-word-api.herokuapp.com/word?number=10"));
      _randomWords = RandomWords.fromJson(response.body);
      _loading = false;
      startTimer();
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  NewGameProvider() {
    // _init();
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

  int _time = 0;
  int get time => _time;

  set time(int newTime) {
    _time = newTime;
    notifyListeners();
  }

  Timer? _timer;

  Timer? get timer => _timer;
  set timer(Timer? newTimer) {
    _timer = newTimer;
    notifyListeners();
  }

  startTimer() {
    time = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _time = timer.tick;
      notifyListeners();
    });
  }

  endTimer() {
    timer!.cancel();
    timer = null;
  }
}
