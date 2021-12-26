import 'dart:io';

import 'package:competition_software_frontend/api/competitor.dart';
import 'package:flutter/foundation.dart';

class Logger {
  static void log(String logString) {
    DateTime now = DateTime.now();
    debugPrint("[${now.toString()}] " + logString);
  }
}
