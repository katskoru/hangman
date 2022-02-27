import 'dart:async';
import 'package:flutter/foundation.dart';

class TimerProvider extends ChangeNotifier {
  TimerProvider() {
    _init();
  }

  _init() {}

  Timer? _timer;
}
