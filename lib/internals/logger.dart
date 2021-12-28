import 'package:flutter/material.dart';

import 'package:another_flushbar/flushbar.dart';

class Logger {
  static void log(String logString) {
    DateTime now = DateTime.now();
    debugPrint("[${now.toString()}] " + logString);
  }

  static void logSnackbar(BuildContext context, String logString) {
    Flushbar(
      messageText: Text(
        logString,
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      flushbarStyle: FlushbarStyle.FLOATING,
      icon: const Icon(Icons.info_outline),
      maxWidth: 300,
      backgroundColor: Colors.grey.shade300,
    ).show(context);
  }
}
