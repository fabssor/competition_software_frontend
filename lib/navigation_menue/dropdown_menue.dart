import 'package:flutter/material.dart';

List<PopupMenuEntry<String>> dropDownMenueChoices = [
  const PopupMenuItem<String>(
    value: "newCompetition",
    child: Text("Neuer Wettkampf..."),
  ),
  const PopupMenuItem<String>(
    value: "openCompetition",
    child: Text("Wettkampf öffnen..."),
  ),
  const PopupMenuItem<String>(
    value: "closeCompetition",
    child: Text("Wettkampf schließen"),
  ),
  const PopupMenuItem<String>(
    value: "saveCompetition",
    child: Text("Wettkampf speichern..."),
  ),
  const PopupMenuItem<String>(
    value: "settings",
    child: Text("Einstellungen"),
  ),
  const PopupMenuItem<String>(
    value: "about",
    child: Text("Über..."),
  ),
];

void onDropDownSelected(String val, BuildContext context) async {
  switch (val) {
    case 'about':
      showAboutDialog(
          applicationName: "Competition Software",
          applicationVersion: "Version: 0.0.1 beta",
          applicationLegalese: "2022 \u00a9 Fabian Sorkalla",
          context: context);
      break;
    default:
  }
}
