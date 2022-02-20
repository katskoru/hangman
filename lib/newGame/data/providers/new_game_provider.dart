import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NewGameProvider extends ChangeNotifier {
  _init() {
    _fetchData();
  }

  Future _fetchData() async {}

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
