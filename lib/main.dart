import 'package:competition_software_frontend/api/i_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'home.dart';
import 'package:competition_software_frontend/api/mock_backend.dart';

void main(List<String> args) {
  MockBackend backend = MockBackend();
  runApp(CsFrontend(backend: backend));
  const initialSize = Size(1200, 700);
  appWindow.minSize = initialSize;
  appWindow.size = initialSize;
  appWindow.alignment = Alignment.center;
  appWindow.show();
}

class CsFrontend extends StatelessWidget {
  final IBackend _backend;
  const CsFrontend({Key? key, required IBackend backend})
      : _backend = backend,
        super(key: key);

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
            Home(backend: _backend),
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
