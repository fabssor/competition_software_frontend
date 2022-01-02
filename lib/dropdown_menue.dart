import 'package:flutter/material.dart';

List<PopupMenuEntry<String>> dropDownMenueChoices = {
  'Neuer Wettkampf',
  'Wettkampf Schließen',
  'Einstellungen',
  'Über',
}.map((String choice) {
  return PopupMenuItem<String>(
    value: choice,
    child: Text(choice),
  );
}).toList();

void onDropDownSelected(String val) {}
