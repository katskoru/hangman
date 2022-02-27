import 'dart:async';
import 'package:flutter/foundation.dart';

class TimerProvider extends ChangeNotifier {
  init() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print(timer.tick);
      notifyListeners();
    });
  }

  Timer? _timer;

  Timer? get timer => _timer;
  set timer(Timer? newTime) {
    _timer = newTime;
    notifyListeners();
  }
}
