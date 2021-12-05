import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'home.dart';

void main(List<String> args) {
  runApp(const CsFrontend());
}

class CsFrontend extends StatelessWidget {
  const CsFrontend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('de'),
      ],
      locale: Locale('de'),
      home: Home(),
    );
  }
}
