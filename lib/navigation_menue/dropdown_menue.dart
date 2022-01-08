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
    child: Text("Wettkampf speichern"),
  ),
  const PopupMenuItem<String>(
    value: "saveCompetitionAs",
    child: Text("Wettkampf speichern unter..."),
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

void onDropDownSelected({
  required String value,
  required BuildContext context,
  required Function onNewCompetition,
  required Function onOpenCompetition,
  required Function onCloseCompetition,
  required Function onSaveCompetition,
  required Function onSaveCompetitionAs,
  required Function onSettings,
}) async {
  switch (value) {
    case "newCompetition":
      onNewCompetition();
      break;
    case "openCompetition":
      onOpenCompetition();
      break;
    case "closeCompetition":
      onCloseCompetition();
      break;
    case "saveCompetition":
      onSaveCompetition();
      break;
    case "saveCompetitionAs":
      onSaveCompetitionAs();
      break;
    case "settings":
      onSettings();
      break;
    case "about":
      showAboutDialog(
          applicationName: "Competition Software",
          applicationVersion: "Version: 0.0.1 beta",
          applicationLegalese: "2022 \u00a9 Fabian Sorkalla",
          context: context);
      break;
    default:
  }
}
