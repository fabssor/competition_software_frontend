import 'package:flutter/material.dart';
import 'package:competition_software_frontend/api/competitor.dart';
import 'package:competition_software_frontend/api/i_backend.dart';

Gender _gender = Gender.female;
DateTime _birthday = DateTime.now();

Widget _buildTextFormField(
    {required String labelText,
    TextEditingController? controller,
    bool readOnly = false,
    Icon? suffixIcon,
    Future<void> Function()? onTap}) {
  return TextFormField(
    controller: controller,
    readOnly: readOnly,
    decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        suffixIcon: suffixIcon),
    onTap: onTap,
  );
}

Widget _buildGenderRadioButton(
  String labelText,
  Gender value,
  StateSetter setState,
) {
  return Expanded(
    child: RadioListTile<Gender>(
      title: Text(labelText),
      value: value,
      groupValue: _gender,
      onChanged: (Gender? v) {
        setState(() => _gender = v!);
      },
    ),
  );
}

Future<DateTime?> getDate(BuildContext context) async {
  var now = DateTime.now();
  var date = await showDatePicker(
    context: context,
    initialDate: DateTime(
      now.year - 10,
      now.month,
      now.day,
    ),
    firstDate: DateTime(
      now.year - 100,
      now.month,
      now.day,
    ),
    lastDate: DateTime(
      now.year,
      now.month,
      now.day,
    ),
  );
  return date;
}

Future<void> addCompetitorDialog(
  BuildContext context,
  String dialogTitle,
  double spaceBetweenColumnItems,
  IBackend backend,
) async {
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController forenameController = TextEditingController();
  final TextEditingController surenameController = TextEditingController();
  return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(dialogTitle),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildTextFormField(
                  controller: surenameController,
                  labelText: "Nachname",
                ),
                SizedBox(height: spaceBetweenColumnItems),
                _buildTextFormField(
                  controller: forenameController,
                  labelText: "Vorname",
                ),
                SizedBox(height: spaceBetweenColumnItems),
                _buildTextFormField(
                  controller: birthdayController,
                  readOnly: true,
                  labelText: "Geburtsdatum",
                  suffixIcon: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final DateTime? dateTime = await getDate(context);
                    if (dateTime == null) {
                      return;
                    } else {
                      _birthday = dateTime;
                      birthdayController.text =
                          "${dateTime.day}.${dateTime.month}.${dateTime.year}";
                    }
                  },
                ),
                SizedBox(height: spaceBetweenColumnItems),
                Row(
                  children: [
                    _buildGenderRadioButton(
                      "männlich",
                      Gender.male,
                      setState,
                    ),
                    _buildGenderRadioButton(
                      "weiblich",
                      Gender.female,
                      setState,
                    )
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Abbrechen"),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Hinzufügen & Neu"),
              ),
              TextButton(
                onPressed: () {
                  Competitor competitor = Competitor(
                    forenameController.text,
                    surenameController.text,
                    _gender,
                    _birthday,
                  );
                  backend.createCompetitor(competitor);
                  Navigator.of(context).pop();
                },
                child: const Text("Hinzufügen"),
              ),
            ],
          );
        });
      });
}
