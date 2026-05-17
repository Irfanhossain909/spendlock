import 'package:flutter/foundation.dart';

class AppLogger {
  static void error(String message) {
    if (kDebugMode) debugPrint('[SpendLock ERROR] $message');
  }
}
