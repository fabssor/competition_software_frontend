import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'home.dart';

void main(List<String> args) {
  runApp(const CsFrontend());
  doWhenWindowReady(() {
    const initialSize = Size(1000, 420);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
  });
}

class CsFrontend extends StatelessWidget {
  const CsFrontend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('de'),
      ],
      locale: const Locale('de'),
      home: Scaffold(
        body: Column(
          children: [
            WindowTitleBarBox(
              child: Row(
                children: [
                  Expanded(child: MoveWindow()),
                  const WindowButtons()
                ],
              ),
            ),
            const Home(),
          ],
        ),
      ),
    );
  }
}

final buttonColors = WindowButtonColors(
  iconNormal: Colors.black,
  mouseOver: Colors.blue,
  mouseDown: Colors.blue.shade200,
  iconMouseOver: Colors.black,
  iconMouseDown: Colors.black,
);

final closeButtonColors = WindowButtonColors(
  mouseOver: Colors.red,
  mouseDown: Colors.red.shade200,
  iconNormal: Colors.black,
  iconMouseOver: Colors.white,
  iconMouseDown: Colors.white,
);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
