import 'package:flutter/material.dart';

import 'package:another_flushbar/flushbar.dart';

class Logger {
  static void log(String logString) {
    DateTime now = DateTime.now();
    debugPrint("[${now.toString()}] " + logString);
  }

  static void logSnackbar(BuildContext context, String logString) {
    // SnackBar snackBar = SnackBar(
    //   content: Text(
    //     logString,
    //     textAlign: TextAlign.center,
    //   ),
    //   width: null,
    //   behavior: SnackBarBehavior.floating,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
    //   ),
    // );
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Flushbar(
      messageText: Text(
        logString,
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      flushbarStyle: FlushbarStyle.FLOATING,
      icon: const Icon(Icons.info_outline),
      maxWidth: 300,
      backgroundColor: Colors.grey.shade300,
    ).show(context);
  }
}
