import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hang/newGame/data/models/random_words.dart';
import 'package:http/http.dart' as http;

class NewGameProvider extends ChangeNotifier {
  RandomWords? _randomWords;
  List<String>? _passedWords;
  int? _currentWord;
  List<int>? _passedTimes;
  bool? _moveToNextLevel;
  bool? _loading;
  int? _mistakes;
  int _time = 0;
  Timer? _timer;
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

  init() {
    _randomWords = RandomWords(randomWords: [""]);
    _mistakes = 0;
    _passedWords = [];
    _currentWord = 0;
    _passedTimes = [];
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
      if (kDebugMode) {
        print(error);
      }
    }
  }

  RandomWords? get randomWords => _randomWords;
  int? get currentWord => _currentWord;
  List<String>? get passedWords => _passedWords;
  List<int>? get passedTimes => _passedTimes;
  int? get mistakes => _mistakes;
  bool? get loading => _loading;
  bool? get moveToNextLevel => _moveToNextLevel;
  List get alphabet => _alphabet;
  Timer? get timer => _timer;
  int get time => _time;

  set currentWord(int? newIndex) {
    _currentWord = newIndex;
    notifyListeners();
  }

  set mistakes(int? newMistake) {
    _mistakes = newMistake;
    notifyListeners();
  }

  set passedWords(List<String>? newList) {
    _passedWords = newList;
    notifyListeners();
  }

  set passedTimes(List<int>? newPass) {
    _passedTimes = newPass;
    notifyListeners();
  }

  addPassedTimes(int passtime) {
    _passedTimes!.add(passtime);
    notifyListeners();
  }

  addPassedLetter(String letter) {
    _passedWords!.add(letter);
    notifyListeners();
  }

  set loading(bool? newLoad) {
    _loading = newLoad;
    notifyListeners();
  }

  set moveToNextLevel(bool? newLevel) {
    _moveToNextLevel = newLevel;
    notifyListeners();
  }

  set time(int newTime) {
    _time = newTime;
    notifyListeners();
  }

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
