import 'package:flutter/material.dart';

Future<bool> acceptDialog(
    BuildContext context, String title, String content) async {
  bool? result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Abbrechen"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Bestätigen"),
            ),
          ],
        );
      });
  result ??= false;
  return result;
}
