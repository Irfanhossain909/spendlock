import 'package:flutter/foundation.dart';

class AppLogger {
  static void log(String message) {
    if (kDebugMode) {
      debugPrint('''
╔══════════════════════════════════════════════╗
║ 📌 SUBJECT : LOG                            ║
╠══════════════════════════════════════════════╣
║ 💬 MESSAGE                                  ║
║ $message
╚══════════════════════════════════════════════╝
''');
    }
  }

  static void api(String message) {
    if (kDebugMode) {
      debugPrint('''
╔══════════════════════════════════════════════╗
║ 🌐 SUBJECT : API RESPONSE                   ║
╠══════════════════════════════════════════════╣
║ 📦 CONTENT                                  ║
║ $message
╚══════════════════════════════════════════════╝
''');
    }
  }

  static void error(String message) {
    if (kDebugMode) {
      debugPrint('''
╔══════════════════════════════════════════════╗
║ 🚨 SUBJECT : ERROR                          ║
╠══════════════════════════════════════════════╣
║ ❌ MESSAGE                                  ║
║ $message
╚══════════════════════════════════════════════╝
''');
    }
  }
}